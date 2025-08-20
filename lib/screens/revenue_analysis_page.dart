import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_page.dart';
import 'ad_creation_page.dart';
import 'mypage.dart';
import 'review_analysis_page.dart';
import 'ai_chat_page.dart';

class RevenueAnalysisPage extends StatefulWidget {
  const RevenueAnalysisPage({super.key});

  @override
  State<RevenueAnalysisPage> createState() => _RevenueAnalysisPageState();
}

class _RevenueAnalysisPageState extends State<RevenueAnalysisPage> {
  String _selectedYear = '2025';
  String _selectedMonth = '9';
  
  final List<String> _years = ['2024', '2025'];
  final List<String> _months = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];
  
  @override
  void initState() {
    super.initState();
    // 현재 년월로 기본값 설정
    final now = DateTime.now();
    _selectedYear = now.year.toString();
    _selectedMonth = now.month.toString();
  }
  
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
                    
                    // 매출 차트 섹션
                    _buildRevenueChartSection(),
                    
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
                // 이미 매출분석 페이지에 있으므로 아무것도 하지 않음
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
                    '매출 분석',
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
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => const ReviewAnalysisPage(),
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
                    '리뷰 분석',
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
        ],
      ),
    );
  }

  Widget _buildRevenueChartSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFEFE),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: const Color(0xFFFCFCFD)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목과 매출 정보
          Text(
            '$_selectedYear년 $_selectedMonth월 매출',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 1),
          Row(
            children: [
              Text(
                '3,250,000원',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF333333),
                ),
              ),
              const Spacer(),
              Text(
                '지난달 대비+28%',
                style: GoogleFonts.inter(
                  fontSize: 13.3,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF999999),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // 차트 영역
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '매출 차트',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // 주차 라벨
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('1주차', style: _getWeekLabelStyle(0.8)),
              Text('2주차', style: _getWeekLabelStyle(0.8)),
              Text('3주차', style: _getWeekLabelStyle(0.8)),
              Text('4주차', style: _getWeekLabelStyle(0.8)),
              Text('5주차', style: _getWeekLabelStyle(0.8)),
              Text('6주차', style: _getWeekLabelStyle(0.8)),
            ],
          ),
          const SizedBox(height: 16),
          
          // 기간 선택 드롭다운들
          Row(
            children: [
              Expanded(
                child: _buildYearDropdown(),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMonthDropdown(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextStyle _getWeekLabelStyle(double opacity) {
    return GoogleFonts.inter(
      fontSize: 12.9,
      fontWeight: FontWeight.w400,
      color: const Color(0xFFC5C5C5).withOpacity(opacity),
    );
  }

  Widget _buildYearDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedYear,
      decoration: InputDecoration(
        hintText: '연도 선택',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.5),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.5),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.5),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
        ),
        filled: true,
        fillColor: const Color(0xFFFEFEFE),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      items: _years.map((String year) {
        return DropdownMenuItem<String>(
          value: year,
          child: Text('${year}년'),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedYear = newValue!;
        });
      },
      style: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: const Color(0xFFB6B6BB),
      ),
    );
  }

  Widget _buildMonthDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedMonth,
      decoration: InputDecoration(
        hintText: '월 선택',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.5),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.5),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.5),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
        ),
        filled: true,
        fillColor: const Color(0xFFFEFEFE),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      items: _months.map((String month) {
        return DropdownMenuItem<String>(
          value: month,
          child: Text('${month}월'),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedMonth = newValue!;
        });
      },
      style: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: const Color(0xFFB6B6BB),
      ),
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