import 'package:flutter/material.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({Key? key}) : super(key: key);

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isKeyboardVisible = false;
  final FocusNode _focusNode = FocusNode();
  bool _hasText = false; // 텍스트 입력 상태를 추적

  @override
  void initState() {
    super.initState();
    // 초기 AI 메시지 추가
    _messages.add(ChatMessage(
      text: "안녕하세요.\nAI비서 MyBiz입니다. 무엇을 도와드릴까요?",
      isUser: false,
      timestamp: DateTime.now(),
    ));
    
    // 키보드 상태 감지
    _focusNode.addListener(() {
      setState(() {
        _isKeyboardVisible = _focusNode.hasFocus;
      });
    });
    
    // 텍스트 입력 상태 감지
    _messageController.addListener(() {
      setState(() {
        _hasText = _messageController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: _messageController.text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
    });

    _messageController.clear();
    _scrollToBottom();

    // AI 응답 시뮬레이션 (실제로는 API 호출)
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add(ChatMessage(
          text: "죄송합니다. 현재 AI 응답 기능은 개발 중입니다. 곧 서비스를 이용하실 수 있습니다.",
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 상단 헤더
            _buildHeader(),
            // 채팅 메시지 영역
            Expanded(
              child: _buildChatArea(),
            ),
            // 하단 입력 영역
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1),
        ),
      ),
      child: Row(
        children: [
          // 뒤로가기 버튼
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 24,
              height: 24,
              child: Image.asset(
                'assets/images/arrow.png',
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // 타이틀
          const Text(
            'MyBiz',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatArea() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(20),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMessageBubble(message),
            // AI의 첫 번째 메시지인 경우에만 예시 질문 버튼들 표시
            if (!message.isUser && index == 0) ...[
              _buildExampleQuestions(),
            ],
          ],
        );
      },
    );
  }

  Widget _buildExampleQuestions() {
    final List<String> questions = [
      "이번달 매출",
      "지난 6개월 매출",
      "이벤트 추천",
      "이번 분기 정부 정책",
      "회원정보 변경",
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: questions.map((question) => _buildQuestionButton(question)).toList(),
      ),
    );
  }

  Widget _buildQuestionButton(String question) {
    return GestureDetector(
      onTap: () {
        // 버튼을 누르면 해당 질문을 채팅에 자동 입력
        _messageController.text = question;
        _sendMessage();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0x0D000000), // opacity 0.05
          borderRadius: BorderRadius.circular(9.5),
        ),
        child: Text(
          question,
          style: const TextStyle(
            fontSize: 13.1,
            fontWeight: FontWeight.w400,
            color: Color(0xFF999999),
            letterSpacing: -0.655,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: message.isUser 
            ? CrossAxisAlignment.end 
            : CrossAxisAlignment.start,
        children: [
          // AI 이름 표시 (AI 메시지인 경우)
          if (!message.isUser) ...[
            Row(
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D6EFF),
                    borderRadius: BorderRadius.circular(3.5),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'MyBiz AI',
                  style: TextStyle(
                    fontSize: 14.9,
                    color: Color(0xFF999999),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          // 메시지 버블
          Align(
            alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser 
                    ? Colors.white 
                    : const Color(0xFF2D6EFF),
                border: message.isUser 
                    ? Border.all(color: const Color(0xFFE5E5E5))
                    : null,
                borderRadius: BorderRadius.circular(19),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  fontSize: 15,
                  color: message.isUser 
                      ? const Color(0xFF767478)
                      : Colors.white,
                  height: 1.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE5E5E5), width: 1),
        ),
      ),
      child: Row(
        children: [
          // 입력창
          Expanded(
            flex: 9, // 기본값은 1이므로 8로 설정하여 길이를 줄임
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFE5E5E5)),
                borderRadius: BorderRadius.circular(19),
              ),
              child: TextField(
                controller: _messageController,
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  hintText: '무엇이 궁금하신가요?',
                  hintStyle: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.9,
                  ),
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // 전송/마이크 버튼
          GestureDetector(
            onTap: () {
              if (_hasText) {
                // 텍스트가 있으면 전송
                _sendMessage();
              } else {
                // 텍스트가 없으면 음성 입력
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('음성 입력 기능은 개발 중입니다.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: Container(
              width: 29,
              height: 29,
              child: Image.asset(
                _hasText ? 'assets/images/submitChat.png' : 'assets/images/chatMic.png',
                width: 29,
                height: 29,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}
