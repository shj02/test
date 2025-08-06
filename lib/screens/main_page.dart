import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5FA),
      body: SafeArea(
        child: Column(
          children: [
            // 고정 영역 (Fix 그룹)
            _buildStatusBar(),
            _buildLogoSection(),
            
            // 스크롤 가능한 영역
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 배너 섹션
                    _buildBannerSection(),
                    
                    // 메뉴 카드들
                    _buildMenuCards(),
                    
                    // 매출 분석 섹션
                    _buildRevenueSection(),
                    
                    // 매출 카드들
                    _buildRevenueCards(),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            
            // 고정된 하단 네비게이션
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

  Widget _buildLogoSection() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/MyBiz.svg',
            height: 30,
            fit: BoxFit.contain,
          ),
          const Spacer(),
          Image.asset(
            'assets/images/menu.png',
            width: 25,
            height: 19,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildBannerSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFF5999FF),
        borderRadius: BorderRadius.circular(21),
      ),
      child: Stack(
        children: [
          // 배너 이미지 (플레이스홀더)
          // 배너 텍스트
          Positioned(
            left: 20,
            top: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'MyBiz\n당신의 AI 비서!',
                  style: TextStyle(
                    fontSize: 24.4,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFFFFFF),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'by Bebiz',
                    style: TextStyle(
                      fontSize: 5.9,
                      color: Color(0xFFA08C93),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCards() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildMenuCard(
                  '광고생성',
                  'AI를 통한 광고 생성',
                  Icons.create,
                  const Color(0xFF333333),
                  imagePath: 'assets/images/adIcon.png',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMenuCard(
                  '매출분석',
                  'AI를 통한 매출분석',
                  Icons.trending_up,
                  const Color(0xFF333333),
                  imagePath: 'assets/images/revenueIcon.png',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMenuCard(
                  '리뷰분석',
                  'AI를 통한 리뷰 분석',
                  Icons.rate_review,
                  const Color(0xFF333333),
                  imagePath: 'assets/images/reviewIcon.png',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMenuCard(
                  '정부정책',
                  '정부정책 확인',
                  Icons.policy,
                  const Color(0xFF333333),
                  imagePath: 'assets/images/governmentIcon.png',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(String title, String subtitle, IconData icon, Color color, {String? imagePath}) {
    return GestureDetector(
      onTap: () {
        if (title == '광고생성') {
          Navigator.pushNamed(context, '/ad_creation');
        } else if (title == '매출분석') {
          Navigator.pushNamed(context, '/revenue_analysis');
        } else if (title == '리뷰분석') {
          Navigator.pushNamed(context, '/review_analysis');
        } else if (title == '정부정책') {
          Navigator.pushNamed(context, '/government_policy');
        }
      },
      child: Container(
        height: 154,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(21),
          border: Border.all(color: const Color(0xFFFCFCFD)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF999999),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: imagePath != null
                    ? Image.asset(
                        imagePath,
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                      )
                    : Icon(
                        icon,
                        size: 48,
                        color: color.withOpacity(0.3),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRevenueSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF12131F),
        borderRadius: BorderRadius.circular(21),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '이번달 총 매출',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xCCFFFFFF),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  SizedBox(
                    height: 25,
                    child: Icon(
                      Icons.trending_up,
                      color: const Color(0xFFB1FFCE),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    height: 20,
                    child: const Text(
                      '+40.2%',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFB1FFCE),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 1),
          const Text(
            '52,003,000원',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 2,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4.5),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildRevenueItem('총주문', '423'),
              _buildRevenueItem('방문인원', '232'),
              _buildRevenueItem('리뷰', '4.95'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color(0xCCFFFFFF),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildRevenueCards() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: _buildRevenueCard('오늘 매출', '+ 8.2%', 'assets/images/todayup.png', const Color(0xFF4CAF50)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildRevenueCard('이번주 매출', '+ 4.2%', 'assets/images/monthup.png', const Color(0xFF0092FF)),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueCard(String title, String percentage, String imagePath, Color iconColor) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 0),
          Row(
            children: [
              Text(
                percentage,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF999999),
                ),
              ),
              const SizedBox(width: 100, height: 0),
              Icon(
                Icons.trending_up,
                size: 35,
                color: iconColor,
              ),
            ],
          ),
        ],
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
              _buildNavItem('assets/images/menuHome.png', '홈', true),
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

  Widget _buildNavItem(String imagePath, String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        if (label == '광고 생성') {
          Navigator.pushNamed(context, '/ad_creation');
        } else if (label == '분석') {
          Navigator.pushNamed(context, '/revenue_analysis');
        } else if (label == '마이페이지') {
          Navigator.pushNamed(context, '/mypage');
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