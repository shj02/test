import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUploadService {
  static const String baseUrl = 'https://your-api-endpoint.com'; // 실제 API 엔드포인트로 변경
  static const int maxImageSize = 10 * 1024 * 1024; // 10MB
  static const int maxImageCount = 5;
  static const List<String> allowedFormats = ['jpg', 'jpeg', 'png', 'webp'];

  final Dio _dio = Dio();

  // 갤러리 권한 요청
  Future<bool> requestGalleryPermission() async {
    final status = await Permission.photos.request();
    return status.isGranted;
  }

  // 이미지 형식 검사
  bool isValidImageFormat(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    return allowedFormats.contains(extension);
  }

  // 이미지 크기 검사
  bool isValidImageSize(File file) {
    return file.lengthSync() <= maxImageSize;
  }

  // 이미지 압축
  Future<File> compressImage(File file, {int quality = 85}) async {
    try {
      final bytes = await file.readAsBytes();
      final image = img.decodeImage(bytes);
      
      if (image == null) throw Exception('이미지를 디코딩할 수 없습니다.');

      // 이미지 크기가 큰 경우 리사이즈
      img.Image resizedImage = image;
      if (image.width > 1920 || image.height > 1920) {
        resizedImage = img.copyResize(
          image,
          width: image.width > image.height ? 1920 : null,
          height: image.height > image.width ? 1920 : null,
        );
      }

      // JPEG로 압축
      final compressedBytes = img.encodeJpg(resizedImage, quality: quality);
      
      // 임시 파일에 저장
      final tempDir = await getTemporaryDirectory();
      final compressedFile = File('${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg');
      await compressedFile.writeAsBytes(compressedBytes);
      
      return compressedFile;
    } catch (e) {
      throw Exception('이미지 압축 중 오류가 발생했습니다: $e');
    }
  }

  // 다중 이미지 업로드
  Future<Map<String, dynamic>> uploadImages(List<File> images) async {
    try {
      // 이미지 개수 검사
      if (images.length > maxImageCount) {
        throw Exception('최대 $maxImageCount장까지 선택 가능합니다.');
      }

      // 각 이미지 검사 및 압축
      List<File> processedImages = [];
      for (int i = 0; i < images.length; i++) {
        final file = images[i];
        
        // 형식 검사
        if (!isValidImageFormat(file.path)) {
          throw Exception('지원하지 않는 이미지 형식입니다. (JPG, PNG, WEBP만 지원)');
        }
        
        // 크기 검사
        if (!isValidImageSize(file)) {
          // 크기가 큰 경우 압축 시도
          try {
            final compressedFile = await compressImage(file);
            processedImages.add(compressedFile);
          } catch (e) {
            throw Exception('이미지 압축에 실패했습니다: $e');
          }
        } else {
          processedImages.add(file);
        }
      }

      // FormData 생성
      final formData = FormData();
      for (int i = 0; i < processedImages.length; i++) {
        formData.files.add(
          MapEntry(
            'images',
            await MultipartFile.fromFile(
              processedImages[i].path,
              filename: 'image_$i.jpg',
            ),
          ),
        );
      }

      // API 호출
      final response = await _dio.post(
        '$baseUrl/analyze',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      return response.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('서버 연결 시간이 초과되었습니다.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('서버 응답 시간이 초과되었습니다.');
      } else if (e.response?.statusCode == 413) {
        throw Exception('업로드할 이미지가 너무 큽니다.');
      } else if (e.response?.statusCode == 400) {
        throw Exception('잘못된 요청입니다: ${e.response?.data['message'] ?? ''}');
      } else if (e.response?.statusCode == 500) {
        throw Exception('서버 오류가 발생했습니다.');
      } else {
        throw Exception('업로드 중 오류가 발생했습니다: ${e.message}');
      }
    } catch (e) {
      throw Exception('알 수 없는 오류가 발생했습니다: $e');
    }
  }

  // 업로드 진행률 콜백을 포함한 업로드
  Future<Map<String, dynamic>> uploadImagesWithProgress(
    List<File> images,
    Function(double progress) onProgress,
  ) async {
    try {
      // 이미지 개수 검사
      if (images.length > maxImageCount) {
        throw Exception('최대 $maxImageCount장까지 선택 가능합니다.');
      }

      // 각 이미지 검사 및 압축
      List<File> processedImages = [];
      for (int i = 0; i < images.length; i++) {
        final file = images[i];
        
        // 진행률 업데이트 (전처리 단계)
        onProgress((i / images.length) * 0.3);
        
        // 형식 검사
        if (!isValidImageFormat(file.path)) {
          throw Exception('지원하지 않는 이미지 형식입니다. (JPG, PNG, WEBP만 지원)');
        }
        
        // 크기 검사
        if (!isValidImageSize(file)) {
          // 크기가 큰 경우 압축 시도
          try {
            final compressedFile = await compressImage(file);
            processedImages.add(compressedFile);
          } catch (e) {
            throw Exception('이미지 압축에 실패했습니다: $e');
          }
        } else {
          processedImages.add(file);
        }
      }

      // FormData 생성
      final formData = FormData();
      for (int i = 0; i < processedImages.length; i++) {
        formData.files.add(
          MapEntry(
            'images',
            await MultipartFile.fromFile(
              processedImages[i].path,
              filename: 'image_$i.jpg',
            ),
          ),
        );
      }

      // API 호출 (진행률 포함)
      final response = await _dio.post(
        '$baseUrl/analyze',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
        onSendProgress: (int sent, int total) {
          // 업로드 진행률 (30% ~ 90%)
          final progress = 0.3 + (sent / total) * 0.6;
          onProgress(progress);
        },
      );

      // 완료 (100%)
      onProgress(1.0);

      return response.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('서버 연결 시간이 초과되었습니다.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('서버 응답 시간이 초과되었습니다.');
      } else if (e.response?.statusCode == 413) {
        throw Exception('업로드할 이미지가 너무 큽니다.');
      } else if (e.response?.statusCode == 400) {
        throw Exception('잘못된 요청입니다: ${e.response?.data['message'] ?? ''}');
      } else if (e.response?.statusCode == 500) {
        throw Exception('서버 오류가 발생했습니다.');
      } else {
        throw Exception('업로드 중 오류가 발생했습니다: ${e.message}');
      }
    } catch (e) {
      throw Exception('알 수 없는 오류가 발생했습니다: $e');
    }
  }
}
