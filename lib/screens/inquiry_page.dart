import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_page.dart';
import 'ad_creation_page.dart';
import 'revenue_analysis_page.dart';
import 'review_analysis_page.dart';
import 'government_policy_page.dart';
import 'mypage.dart';
import 'ai_chat_page.dart';

class InquiryPage extends StatefulWidget {
  const InquiryPage({super.key});

  @override
  State<InquiryPage> createState() => _InquiryPageState();
}

class _InquiryPageState extends State<InquiryPage> {
  bool _isInquiryHistory = true; // true: 문의내역, false: 문의하기
  String _selectedInquiryType = '선택'; // 선택된 문의 종류
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  
  final List<String> _inquiryTypes = ['선택', '개인정보 문의', '이용 문의', '불만/불평사항 문의', '기타'];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const MyPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F5FA),
        body: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTabButtons(),
                      const SizedBox(height: 24),
                      _isInquiryHistory ? _buildInquiryHistory() : _buildInquiryForm(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              _buildBottomNavigation(),
            ],
          ),
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
          const Center(
            child: Text(
              '문의사항',
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
                  pageBuilder: (context, animation, secondaryAnimation) => const MyPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              ),
              child: Container(
                width: 8,
                height: 16,
                decoration: const BoxDecoration(
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

  Widget _buildTabButtons() {
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
                setState(() {
                  _isInquiryHistory = true;
                });
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: _isInquiryHistory ? null : Colors.transparent,
                  gradient: _isInquiryHistory
                      ? const LinearGradient(
                          colors: [Color(0xFF98E0F8), Color(0xFF9CCEFF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(7.5),
                ),
                child: Center(
                  child: Text(
                    '문의 내역',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: _isInquiryHistory
                          ? const Color(0xFFFFFFFF)
                          : const Color(0xFF999999),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isInquiryHistory = false;
                });
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: !_isInquiryHistory ? null : Colors.transparent,
                  gradient: !_isInquiryHistory
                      ? const LinearGradient(
                          colors: [Color(0xFF98E0F8), Color(0xFF9CCEFF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(7.5),
                ),
                child: Center(
                  child: Text(
                    '문의하기',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: !_isInquiryHistory
                          ? const Color(0xFFFFFFFF)
                          : const Color(0xFF999999),
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

  Widget _buildInquiryHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        _buildInquiryItem('업종 변경 문의', '답변 대기', false),
        const SizedBox(height: 12),
        _buildInquiryItem('계정 삭제 문의', '답변 완료', true),
      ],
    );
  }

  Widget _buildInquiryItem(String title, String status, bool isCompleted) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E5E5)),
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFFFFFFFF),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: isCompleted ? const Color(0xFF2D6EFF) : const Color(0xFF848484),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInquiryForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [        
        // 문의 종류 선택
        Text(
          '문의 종류',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE5E5E5)),
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedInquiryType,
              isExpanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              items: _inquiryTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(
                    type,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF333333),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedInquiryType = newValue!;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 24),
        //문의 제목
        Text(
          '문의 제목',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE5E5E5)),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: '문의 제목을 적어주세요.',
              hintStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFF999999),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // 문의 내용
        Text(
          '문의 내용',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE5E5E5)),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            controller: _contentController,
            maxLines: null,
            expands: true,
            decoration: const InputDecoration(
              hintText: '문의 내용을 적어주세요.',
              hintStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFF999999),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        ),
        const SizedBox(height: 15),
        
        // 안내 문구
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            '문의사항을 남겨주시면 빠른 시일 내 확인 후 답장드리겠습니다.',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 5),
        
        // 버튼들
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // 문의취소 로직
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => const InquiryPage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      '문의취소',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF000000),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // 문의등록 로직
                  // 여기에 실제 문의등록 로직을 추가하세요
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF98E0F8), Color(0xFF9CCEFF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      '문의등록',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
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

  Widget _buildNavItem(String iconPath, String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        Widget targetPage;
        switch (label) {
          case '홈':
            targetPage = const MainPage();
            break;
          case '광고 생성':
            targetPage = const AdCreationPage();
            break;
          case '분석':
            targetPage = const RevenueAnalysisPage();
            break;
          case '마이페이지':
            targetPage = const MyPage();
            break;
          default:
            return;
        }
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => targetPage,
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 31,
            height: 29,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9.6,
              fontWeight: FontWeight.w400,
              color: Color(0xFFC6C6CA),
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
