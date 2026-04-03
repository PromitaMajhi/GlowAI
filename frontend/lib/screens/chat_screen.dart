import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/typing_indicator.dart';
import '../services/api_service.dart';

class ChatScreen extends StatefulWidget {
  final String initialQuery;
  const ChatScreen({super.key, required this.initialQuery});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  final List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialQuery.isNotEmpty) {
      _sendMessage(widget.initialQuery);
    }
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

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({'isUser': true, 'text': text});
      _isTyping = true;
    });
    
    _controller.clear();
    _scrollToBottom();

    try {
      final reply = await ApiService.askSkinProblem(text);
      setState(() {
        _messages.add({
          'isUser': false,
          'text': '',
          'aiData': reply
        });
        _isTyping = false;
      });
      _scrollToBottom();
    } catch (e) {
      setState(() {
        _messages.add({
          'isUser': false,
          'text': 'Sorry, I am having trouble connecting to the server. Please try again.',
        });
        _isTyping = false;
      });
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondaryBeige.withOpacity(0.2),
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              backgroundColor: AppTheme.primaryPink,
              child: Icon(Icons.face_retouching_natural, color: AppTheme.white),
            ),
            SizedBox(width: 12),
            Text('GlowAI Expert'),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length) {
                    return const Align(
                      alignment: Alignment.centerLeft,
                      child: TypingIndicator(),
                    );
                  }
                  final msg = _messages[index];
                  return ChatBubble(
                    text: msg['text'],
                    isUser: msg['isUser'],
                    aiData: msg['aiData'],
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  )
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: _sendMessage,
                    ),
                  ),
                  const SizedBox(width: 12),
                  CircleAvatar(
                    backgroundColor: AppTheme.primaryPink,
                    radius: 24,
                    child: IconButton(
                      icon: const Icon(Icons.send_rounded, color: AppTheme.textDark),
                      onPressed: () => _sendMessage(_controller.text),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
