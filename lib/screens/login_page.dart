import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 150),
              
              // 로고
              Center(
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF00AEFF), Color(0xFF0084FF)],
                  ).createShader(bounds),
                  child: Text(
                    'MyBiz',
                    style: GoogleFonts.inter(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 5),
              
              // 부제목
              Text(
                '소상공인의 비즈니스 성장을 위한 AI 비서',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              
              const Spacer(),
              
              Text(
                '소셜로그인',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '로그인을 통해 다양한 서비스를 이용하세요!',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),

              // 소셜 로그인 버튼들
              _buildSocialLoginButton(
                context,
                '카카오로 계속하기',
                'assets/images/kakao.png',
                const Color(0xFFFEE500),
                Colors.black87,
                () => _handleKakaoLogin(context),
              ),
              
              const SizedBox(height: 10),
              
              _buildSocialLoginButton(
                context,
                '네이버로 계속하기',
                'assets/images/naver.png',
                const Color(0xFF03C75A),
                Colors.white,
                () => _handleNaverLogin(context),
              ),
                         
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton(
    BuildContext context,
    String text,
    String iconPath,
    Color backgroundColor,
    Color textColor,
    VoidCallback onPressed,
  ) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 아이콘
              Image.asset(
                iconPath,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleKakaoLogin(BuildContext context) {
    // Kakao 로그인 로직 (시뮬레이션)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('카카오 로그인 처리 중...')),
    );
    
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/signup');
    });
  }

  void _handleNaverLogin(BuildContext context) {
    // Naver 로그인 로직 (시뮬레이션)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('네이버 로그인 처리 중...')),
    );
    
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/signup');
    });
  }
} 