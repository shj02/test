import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_page.dart';
import 'ad_creation_page.dart';
import 'revenue_analysis_page.dart';
import 'mypage.dart';

class ReviewAnalysisPage extends StatefulWidget {
  const ReviewAnalysisPage({super.key});

  @override
  State<ReviewAnalysisPage> createState() => _ReviewAnalysisPageState();
}

class _ReviewAnalysisPageState extends State<ReviewAnalysisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5FA),
      body: SafeArea(
        child: Column(
          children: [
            // 상단 상태바
            _buildStatusBar(),
            
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
                    
                    // 최근 등록된 리뷰
                    _buildRecentReviews(),
                    
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

  Widget _buildStatusBar() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Text(
            '9:41',
            style: TextStyle(
              fontSize: 18.9,
              fontWeight: FontWeight.w700,
              color: Color(0xFF444347),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Image.asset(
                'assets/images/1.png',
                width: 22,
                height: 14,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 4),
              Image.asset(
                'assets/images/2.png',
                width: 23,
                height: 16,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 4),
              Image.asset(
                'assets/images/3.png',
                width: 22,
                height: 10,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ],
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
                  MaterialPageRoute(
                    builder: (context) => const RevenueAnalysisPage(),
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
                       'assets/images/chart1.png',
                       width: double.infinity,
                       height: 30,
                       fit: BoxFit.contain,
                     ),
                   ),
                 ),
                const SizedBox(height: 16),
                // 범례
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildLegendItem('긍정 (75%)', const Color(0xFFC2E1FF)),
                    _buildLegendItem('보통 (15%)', const Color(0xFFFFCB9B)),
                    _buildLegendItem('부정 (10%)', const Color(0xFFFFBCB7)),
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

  Widget _buildRecentReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '최근 등록된 리뷰',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF333333),
              ),
            ),
            const Spacer(),
            Text(
              '네이버',
              style: GoogleFonts.inter(
                fontSize: 10.2,
                color: const Color(0xFF666666),
              ),
            ),
            Container(
              width: 1,
              height: 12,
              color: const Color(0xFF666666),
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),
            Text(
              '카카오',
              style: GoogleFonts.inter(
                fontSize: 10.3,
                color: const Color(0xFF999999),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildReviewCard('사용자1', '맛있고 친절함', '음식도 맛있고 사장님이 정말 친절해요!', '7.27'),
        const SizedBox(height: 12),
        _buildReviewCard('사용자2', '집밥', '집밥같은 느낌이라 좋았습니다.', '7.27'),
        const SizedBox(height: 12),
        _buildReviewCard('사용자3', '양은 적지만 맛있음', '양이 조금 적은 것 같아요. 그래도 맛있어요!', '7.27'),
      ],
    );
  }

  Widget _buildReviewCard(String author, String tag, String content, String date) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
                             Text(
                 author,
                 style: GoogleFonts.inter(
                   fontSize: 12.7,
                   fontWeight: FontWeight.w700,
                   color: const Color(0xFF333333),
                 ),
               ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(8.75),
                ),
                child: Text(
                  tag,
                  style: GoogleFonts.inter(
                    fontSize: 10.6,
                    color: const Color(0xFF999999).withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.inter(
              fontSize: 12.4,
              color: const Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '방문일:$date',
              style: GoogleFonts.inter(
                fontSize: 10,
                color: const Color(0xFF999999),
              ),
            ),
          ),
        ],
      ),
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
          _buildPointItem('친절한 서비스', 92),
          const SizedBox(height: 8),
          _buildPointItem('신선한 재료', 81),
          const SizedBox(height: 8),
          _buildPointItem('넓고 쾌적한 공간', 87),
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
          _buildPointItem('부족한 주차공간', 23),
          const SizedBox(height: 8),
          _buildPointItem('적은 음식양', 19),
          const SizedBox(height: 8),
          _buildPointItem('긴 대기시간', 12),
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
    return Container(
      width: 60,
      height: 60,
      child: Center(
        child: Image.asset(
          'assets/images/mic.png',
          width: 60,
          height: 60,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}