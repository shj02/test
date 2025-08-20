import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_page.dart';
import 'ad_creation_page.dart';
import 'revenue_analysis_page.dart';
import 'mypage.dart';
import 'ai_chat_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../services/image_upload_service.dart';
import 'capture_tutorial_page.dart';

class ReviewAnalysisPage extends StatefulWidget {
  const ReviewAnalysisPage({super.key});

  @override
  State<ReviewAnalysisPage> createState() => _ReviewAnalysisPageState();
}

class _ReviewAnalysisPageState extends State<ReviewAnalysisPage> {
  final ImageUploadService _uploadService = ImageUploadService();
  List<File> _selectedImages = [];
  bool _isUploading = false;
  double _uploadProgress = 0.0;
  String? _uploadError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5FA),
      body: SafeArea(
        child: Column(
          children: [
            
            // 앱바
            _buildAppBar(),
            
            // 메인 콘텐츠
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 분석 타입 선택 버튼
                    _buildAnalysisTypeButtons(),
                    
                    const SizedBox(height: 24),
                    
                    // 고객 만족도 분석
                    _buildCustomerSatisfactionAnalysis(),
                    
                    const SizedBox(height: 24),
                    
                    // 이미지 업로드 섹션
                    _buildImageUploadSection(),
                    
                    const SizedBox(height: 24),
                    
                    // 이런 점이 좋아요!
                    _buildPositivePoints(),
                    
                    const SizedBox(height: 24),
                    
                    // 이런 점이 아쉬워요!
                    _buildNegativePoints(),
                    
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            
            // 하단 네비게이션
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  

  Widget _buildAppBar() {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Center(
            child: const Text(
              '분석',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Color(0xFF333333),
              ),
            ),
          ),
          Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const MainPage(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
          ),
        ),
              child: Container(
                width: 8,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: Color(0xFF333333),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisTypeButtons() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFFEFEFE),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => const RevenueAnalysisPage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    '매출 분석',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF999999),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // 이미 리뷰분석 페이지에 있으므로 아무것도 하지 않음
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF98E0F8), Color(0xFF9CCEFF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(7.5),
                ),
                child: Center(
                  child: Text(
                    '리뷰 분석',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFE9F4FD),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerSatisfactionAnalysis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '고객 만족도 분석',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 115,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                                 // 차트 영역
                 Container(
                   height: 30,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(8),
                   ),
                                       child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        _selectedImages.isNotEmpty ? 'assets/images/afterChart.png' : 'assets/images/beforeChart.png',
                        width: double.infinity,
                        height: 30,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                '차트 이미지',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                 ),
                const SizedBox(height: 16),
                // 범례
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                                         _buildLegendItem('긍정 (${_selectedImages.isNotEmpty ? '75' : '0'}%)', const Color(0xFFC2E1FF)),
                     _buildLegendItem('보통 (${_selectedImages.isNotEmpty ? '15' : '0'}%)', const Color(0xFFFFCB9B)),
                     _buildLegendItem('부정 (${_selectedImages.isNotEmpty ? '10' : '0'}%)', const Color(0xFFFFBCB7)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10.2,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }



  Widget _buildPositivePoints() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFEFE),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '이런 점이 좋아요!',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF333333),
            ),
          ),
                     const SizedBox(height: 20),
                      if (_selectedImages.isNotEmpty) ...[
              _buildPointItem('친절한 서비스', 92),
             const SizedBox(height: 8),
             _buildPointItem('신선한 재료', 81),
             const SizedBox(height: 8),
             _buildPointItem('넓고 쾌적한 공간', 87),
           ] else ...[
             SizedBox(
               height: 120,
               child: Center(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Icon(
                       Icons.image,
                       size: 48,
                       color: Colors.grey[400],
                     ),
                     const SizedBox(height: 16),
                     Text(
                       '리뷰 이미지를 업로드하여\n분석을 확인하세요!',
                       textAlign: TextAlign.center,
                       style: GoogleFonts.inter(
                         fontSize: 14,
                         color: Colors.grey[600],
                         height: 1.4,
                       ),
                     ),
                   ],
                 ),
               ),
             ),
           ],
        ],
      ),
    );
  }

  Widget _buildNegativePoints() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '이런 점이 아쉬워요!',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF333333),
            ),
          ),
                     const SizedBox(height: 20),
                      if (_selectedImages.isNotEmpty) ...[
              _buildPointItem('부족한 주차공간', 23),
             const SizedBox(height: 8),
             _buildPointItem('적은 음식양', 19),
             const SizedBox(height: 8),
             _buildPointItem('긴 대기시간', 12),
           ] else ...[
             SizedBox(
               height: 120,
               child: Center(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Icon(
                       Icons.image,
                       size: 48,
                       color: Colors.grey[400],
                     ),
                     const SizedBox(height: 16),
                     Text(
                       '리뷰 이미지를 업로드하여\n분석을 확인하세요!',
                       textAlign: TextAlign.center,
                       style: GoogleFonts.inter(
                         fontSize: 14,
                         color: Colors.grey[600],
                         height: 1.4,
                       ),
                     ),
                   ],
                 ),
               ),
             ),
           ],
        ],
      ),
    );
  }

  Widget _buildPointItem(String label, int percentage) {
    return Container(
      height: 33,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(7.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$label ($percentage%)',
              style: GoogleFonts.inter(
                fontSize: 10.1,
                color: const Color(0xFF666666),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '리뷰 분석에 사용할 이미지를 선택하세요',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF333333),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _showGuideImage,
              child: Image.asset(
                'assets/images/exclamation.png',
                width: 16,
                height: 16,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // 이미지 미리보기 영역
        if (_selectedImages.isNotEmpty) ...[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              children: [
                // 이미지 그리드
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: _selectedImages.length + (_selectedImages.length < 5 ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _selectedImages.length) {
                      // 추가 버튼
                      return GestureDetector(
                        onTap: _pickImages,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!, style: BorderStyle.solid),
                          ),
                          child: const Icon(
                            Icons.add_photo_alternate,
                            color: Colors.grey,
                            size: 24,
                          ),
                        ),
                      );
                    }
                    
                    // 이미지 미리보기
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              _selectedImages[index],
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // 삭제 버튼
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () => _removeImage(index),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                
                // 업로드 버튼
                if (_selectedImages.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: _isUploading ? null : _uploadImages,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5999FF),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: _isUploading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '업로드 중... ${(_uploadProgress * 100).toInt()}%',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              '리뷰 분석 시작',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        ] else ...[
          // 이미지 선택 영역
          GestureDetector(
            onTap: _pickImages,
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFF98E0F8).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.add_photo_alternate,
                      color: Color(0xFF98E0F8),
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '이미지를 선택하세요',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '최대 5장까지 선택 가능',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        
        // 오류 메시지
        if (_uploadError != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red[600], size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _uploadError!,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.red[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _pickImages() async {
    try {
      // 갤러리 권한 요청
      final hasPermission = await _uploadService.requestGalleryPermission();
      if (!hasPermission) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('갤러리 접근 권한이 필요합니다.'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      // 이미지 선택
      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage();
      
      if (images.isNotEmpty) {
        // 최대 5장 제한 확인
        if (_selectedImages.length + images.length > 5) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('최대 5장까지 선택 가능합니다.'),
              backgroundColor: Colors.orange,
            ),
          );
          return;
        }

        // 이미지 검사 및 추가
        List<File> validImages = [];
        for (final image in images) {
          final file = File(image.path);
          
          // 형식 검사
          if (!_uploadService.isValidImageFormat(file.path)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('지원하지 않는 이미지 형식입니다. (JPG, PNG, WEBP만 지원)'),
                backgroundColor: Colors.red,
              ),
            );
            continue;
          }
          
          // 크기 검사
          if (!_uploadService.isValidImageSize(file)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('이미지 크기가 너무 큽니다. (최대 10MB)'),
                backgroundColor: Colors.red,
              ),
            );
            continue;
          }
          
          validImages.add(file);
        }

        setState(() {
          _selectedImages.addAll(validImages);
          _uploadError = null; // 오류 메시지 초기화
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('이미지 선택 중 오류가 발생했습니다: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  Future<void> _uploadImages() async {
    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('업로드할 이미지를 선택해주세요.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
      _uploadError = null;
    });

    try {
      final result = await _uploadService.uploadImagesWithProgress(
        _selectedImages,
        (progress) {
          setState(() {
            _uploadProgress = progress;
          });
        },
      );

      // 업로드 성공
      setState(() {
        _isUploading = false;
        _uploadProgress = 1.0;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('리뷰 분석이 완료되었습니다!'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );

      // 분석 결과 처리 (예: 결과 페이지로 이동)
      _showAnalysisResult(result);
      
    } catch (e) {
      setState(() {
        _isUploading = false;
        _uploadError = e.toString();
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('업로드 실패: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showAnalysisResult(Map<String, dynamic> result) {
    // 분석 결과를 보여주는 다이얼로그 또는 페이지로 이동
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '리뷰 분석 완료',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Color(0xFF4CAF50),
                size: 60,
              ),
              const SizedBox(height: 16),
              Text(
                '리뷰 분석이 성공적으로 완료되었습니다.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                '확인',
                style: GoogleFonts.inter(
                  color: const Color(0xFF5999FF),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showGuideImage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '리뷰 분석 가이드',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                                     child: ClipRRect(
                     borderRadius: BorderRadius.circular(12),
                     child: Image.asset(
                       'assets/images/naverplaceReview.png',
                       fit: BoxFit.contain,
                     ),
                   ),
                ),
                const SizedBox(height: 16),
                Text(
                  '네이버 플레이스 리뷰 이미지를 업로드하면\nAI가 자동으로 분석해드립니다.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CaptureTutorialPage(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF5999FF)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          '캡처 방법 보기',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF5999FF),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5999FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          '확인',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 116,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(width: 5),
              _buildNavItem('assets/images/menuHome.png', '홈', false),
              const SizedBox(width: 5),
              _buildNavItem('assets/images/menuAD.png', '광고 생성', false),
              const SizedBox(width: 5),
              _buildMicButton(),
              const SizedBox(width: 5),
              _buildNavItem('assets/images/menuAnalysis.png', '분석', true),
              const SizedBox(width: 5),
              _buildNavItem('assets/images/menuMypage.png', '마이페이지', false),
              const SizedBox(width: 5),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String imagePath, String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        if (label == '홈') {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const MainPage(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        } else if (label == '광고 생성') {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const AdCreationPage(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        } else if (label == '분석') {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const RevenueAnalysisPage(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        } else if (label == '마이페이지') {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const MyPage(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? const Color(0xFF20A6FE) : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMicButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const AiChatPage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ));
      },
      child: Container(
        width: 60,
        height: 60,
        child: Center(
          child: Image.asset(
            'assets/images/navMic.png',
            width: 60,
            height: 60,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}