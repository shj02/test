import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'revenue_analysis_page.dart';
import 'mypage.dart';
import 'ai_chat_page.dart';
import '../services/image_upload_service.dart';

class AdCreationPage extends StatefulWidget {
  const AdCreationPage({super.key});

  @override
  State<AdCreationPage> createState() => _AdCreationPageState();
}

class _AdCreationPageState extends State<AdCreationPage> {
  final _requestController = TextEditingController();
  final ImageUploadService _uploadService = ImageUploadService();
  List<File> _selectedImages = [];
  bool _isGenerating = false;
  bool _isUploading = false;
  double _uploadProgress = 0.0;
  String? _uploadError;

  @override
  void dispose() {
    _requestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5FA),
      body: SafeArea(
        child: Column(
          children: [
            
            // 헤더
            _buildHeader(),
            
            // 메인 콘텐츠
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    
                    const SizedBox(height: 8),
                    
                    Text(
                      '이미지와 요청사항을 입력하면 AI가 맞춤형 광고를 생성합니다',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    // 이미지 업로드 섹션
                    _buildImageUploadSection(),
                    
                    const SizedBox(height: 24),
                    
                    // 요청사항 입력 섹션
                    _buildRequestSection(),
                    
                    const SizedBox(height: 32),
                    
                    // 생성 버튼
                    _buildGenerateButton(),
                    
                    const SizedBox(height: 24),
                    
                    // 생성된 광고 미리보기 (예시)
                    if (_isGenerating) _buildLoadingSection(),
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

  

  Widget _buildHeader() {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Center(
            child: const Text(
              'AI 광고 생성',
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

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '광고에 사용할 이미지를 선택하세요',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
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
        
        const SizedBox(height: 12),
        
        // 이미지 미리보기 영역
        if (_selectedImages.isNotEmpty) ...[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
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
                borderRadius: BorderRadius.circular(16),
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
                      color: const Color(0xFF667EEA).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.add_photo_alternate,
                      color: Color(0xFF667EEA),
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

  Widget _buildRequestSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '광고 요청사항',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        
        const SizedBox(height: 12),
        
        TextField(
          controller: _requestController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: '예: 신메뉴 출시를 알리는 밝고 활기찬 분위기의 광고를 만들어주세요. 젊은 층을 타겟으로 하고, 제품의 맛을 강조해주세요.',
            hintStyle: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[400],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF667EEA)),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
        
        const SizedBox(height: 8),
        
        Text(
          '구체적으로 요청할수록 더 정확한 광고가 생성됩니다!',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildGenerateButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF98E0F8), Color(0xFF9CCEFF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667EEA).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isGenerating ? null : _generateAd,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isGenerating) ...[
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                ] else ...[
                  const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  _isGenerating ? '광고 생성 중...' : 'AI로 광고 생성하기',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '광고 생성 중...',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          const LinearProgressIndicator(
            backgroundColor: Color(0xFFE0E0E0),
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF667EEA)),
          ),
          const SizedBox(height: 12),
          Text(
            'AI가 요청사항을 분석하여 최적의 광고를 생성하고 있습니다',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
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

  void _showGuideImage() {
    int currentPage = 0;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                      'AI 광고 생성 가이드',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: PageView(
                          onPageChanged: (index) {
                            setState(() {
                              currentPage = index;
                            });
                          },
                          children: [
                            Image.asset(
                              'assets/images/aiAdBefore.png',
                              fit: BoxFit.contain,
                            ),
                            Image.asset(
                              'assets/images/aiAdAfter.png',
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // 페이지 인디케이터
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF5999FF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${currentPage + 1}/2',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF5999FF),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '광고 이미지를 업로드하면 AI가 자동으로\n최적화된 광고를 생성해드립니다.\n\n최대 5장까지 선택 가능합니다.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
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
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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
              _buildNavItem('assets/images/menuAD.png', '광고 생성', true),
              const SizedBox(width: 5),
              _buildMicButton(),
              const SizedBox(width: 5),
              _buildNavItem('assets/images/menuAnalysis.png', '분석', false),
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

  void _generateAd() {
    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이미지를 선택해주세요'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (_requestController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('광고 요청사항을 입력해주세요'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isGenerating = true;
    });

    // AI 광고 생성 시뮬레이션
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isGenerating = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('광고가 성공적으로 생성되었습니다!'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
      
      // 여기서 생성된 광고 결과를 보여주는 다이얼로그나 새 페이지로 이동
      _showGeneratedAdDialog();
    });
  }

  void _showGeneratedAdDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '광고 생성 완료!',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFF667EEA).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.image,
                  size: 60,
                  color: Color(0xFF667EEA),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '요청하신 광고가 성공적으로 생성되었습니다.',
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
                  color: const Color(0xFF667EEA),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
} 