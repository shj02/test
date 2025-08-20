import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'main_page.dart';
import 'login_page.dart';
import 'ad_creation_page.dart';
import 'revenue_analysis_page.dart';
import 'ai_chat_page.dart';
import 'inquiry_page.dart';
import 'withdraw_page.dart';
import 'signup_page.dart';
import 'edit_profile_page.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 프로필 섹션
                    _buildProfileSection(),
                    
                    const SizedBox(height: 24),
                    
                    // 내 정보 섹션
                    _buildMyInfoSection(),
                    
                    const SizedBox(height: 24),
                    
                    // 가게 정보 섹션
                    _buildStoreInfoSection(),
                    
                    const SizedBox(height: 24),
                    
                    // 기타 섹션
                    _buildOtherSection(),
                    
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

  

  Widget _buildHeader() {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Center(
            child: const Text(
              '마이페이지',
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

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // 프로필 이미지
          GestureDetector(
            onTap: () => _launchSmartPlace(),
            child: Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(42),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(42),
                child: Image.asset(
                  'assets/images/user.png',
                  width: 84,
                  height: 84,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(42),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 20),
          
          // 프로필 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                                 Text(
                   '${UserData.name}님',
                   style: GoogleFonts.inter(
                     fontSize: 20,
                     fontWeight: FontWeight.w700,
                     color: const Color(0xFF333333),
                   ),
                 ),
                 const SizedBox(height: 4),
                 Text(
                   'Tel. ${UserData.phone}',
                   style: GoogleFonts.inter(
                     fontSize: 16,
                     fontWeight: FontWeight.w400,
                     color: const Color(0xFF999999),
                   ),
                 ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyInfoSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '내 정보',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 20),
                                          _buildInfoRow('이름', UserData.name),
            _buildInfoRow('생년월일', UserData.birthDate),
            _buildInfoRow('전화번호', UserData.phone),
            _buildInfoRow('이메일', UserData.email),
        ],
      ),
    );
  }

  Widget _buildStoreInfoSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '가게 정보',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoRow('가게명', UserData.businessName),
          _buildInfoRow('업종', UserData.businessType),
          _buildInfoRow('사업자번호', UserData.businessNumber),
          _buildInfoRow('주소', UserData.address),
          _buildInfoRow('번호', UserData.businessPhone),
        ],
      ),
    );
  }

  Widget _buildOtherSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '기타',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 20),
                     _buildMenuRow('정보 수정하기', () async {
             // 정보 수정 페이지로 이동
             final result = await Navigator.push(
               context,
               PageRouteBuilder(
                 pageBuilder: (context, animation, secondaryAnimation) => const EditProfilePage(),
                 transitionDuration: Duration.zero,
                 reverseTransitionDuration: Duration.zero,
               ),
             );
             
             // 정보가 수정되었으면 마이페이지 새로고침
             if (result == true) {
               setState(() {
                 // setState를 호출하여 UI를 새로고침
               });
             }
           }),
          _buildMenuRow('문의사항', () {
            // 문의사항 페이지로 이동
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const InquiryPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          }),
          _buildMenuRow('로그아웃', () {
            // 로그아웃 처리
            _showLogoutDialog();
          }),
          _buildMenuRow('탈퇴하기', () {
            // 탈퇴 처리
            _showWithdrawDialog();
          }),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF999999),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF666666),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuRow(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: title == '탈퇴하기' ? const Color(0xFFEE4335) : const Color(0xFF999999),
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF999999),
            ),
          ],
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
              _buildNavItem('assets/images/menuAnalysis.png', '분석', false),
              const SizedBox(width: 5),
              _buildNavItem('assets/images/menuMypage.png', '마이페이지', true),
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

  // 로그아웃 다이얼로그 표시
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 6),
                Text(
                  '로그아웃 하시겠습니까?',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                        },
                                                 child: Container(
                           height: 43,
                           decoration: BoxDecoration(
                             color: Colors.white,
                             border: Border.all(
                               color: const Color(0xFFE5E5E5),
                               width: 1,
                             ),
                             borderRadius: BorderRadius.circular(5),
                           ),
                          child: Center(
                            child: Text(
                              '취소',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF00C2FD),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                          // 로그아웃 처리 후 로그인 페이지로 이동
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                        },
                        child: Container(
                          height: 43,
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
                              '확인',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  // 탈퇴 다이얼로그 표시
  void _showWithdrawDialog() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const WithdrawPage(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  // 스마트플레이스 앱 실행 또는 웹 브라우저 열기
  Future<void> _launchSmartPlace() async {
    try {
      // 스마트플레이스 앱 URL 스킴
      const String appUrlScheme = 'naversearchapp://';
      // 웹 URL (앱이 설치되지 않은 경우)
      const String webUrl = 'https://smartplace.naver.com/';
      
      // 웹 환경인지 확인
      if (kIsWeb) {
        // 웹에서는 새 탭으로 열기
        final Uri webUri = Uri.parse(webUrl);
        if (await canLaunchUrl(webUri)) {
          await launchUrl(
            webUri,
            webOnlyWindowName: '_blank',
          );
        } else {
          _showErrorSnackBar('스마트플레이스를 열 수 없습니다.');
        }
        return;
      }
      
      // 모바일 환경에서 앱 실행 시도
      if (Platform.isAndroid || Platform.isIOS) {
        try {
          // 먼저 앱 실행 시도
          final Uri appUri = Uri.parse(appUrlScheme);
          if (await canLaunchUrl(appUri)) {
            await launchUrl(appUri, mode: LaunchMode.externalApplication);
          } else {
            // 앱이 설치되지 않은 경우 웹 브라우저로 열기
            final Uri webUri = Uri.parse(webUrl);
            if (await canLaunchUrl(webUri)) {
              await launchUrl(webUri, mode: LaunchMode.externalApplication);
            } else {
              _showErrorSnackBar('스마트플레이스를 열 수 없습니다.');
            }
          }
        } catch (e) {
          // 앱 실행 실패 시 웹 브라우저로 열기
          try {
            final Uri webUri = Uri.parse(webUrl);
            if (await canLaunchUrl(webUri)) {
              await launchUrl(webUri, mode: LaunchMode.externalApplication);
            } else {
              _showErrorSnackBar('스마트플레이스를 열 수 없습니다.');
            }
          } catch (e2) {
            _showErrorSnackBar('오류가 발생했습니다: $e2');
          }
        }
      } else {
        // 데스크톱 환경에서는 웹 브라우저로 열기
        final Uri webUri = Uri.parse(webUrl);
        if (await canLaunchUrl(webUri)) {
          await launchUrl(webUri, mode: LaunchMode.externalApplication);
        } else {
          _showErrorSnackBar('스마트플레이스를 열 수 없습니다.');
        }
      }
    } catch (e) {
      _showErrorSnackBar('오류가 발생했습니다: $e');
    }
  }

  // 에러 메시지 표시
  void _showErrorSnackBar(String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
} 