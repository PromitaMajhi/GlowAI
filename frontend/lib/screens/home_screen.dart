import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    void navigateToChat(String query) {
      if (query.trim().isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(initialQuery: query.trim()),
          ),
        );
      }
    }

    Widget buildSuggestionButton(String text) {
      return Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: ActionChip(
          label: Text(text),
          backgroundColor: AppTheme.secondaryBeige.withOpacity(0.5),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onPressed: () => navigateToChat(text),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        title: const Text('GlowAI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text(
                'Hello, Beautiful ✨',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'What\'s your skin concern today?',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.normal, color: AppTheme.textLight),
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryPink.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Ask your skin problem...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send_rounded, color: AppTheme.primaryPink),
                      onPressed: () => navigateToChat(controller.text),
                    ),
                    fillColor: AppTheme.white,
                  ),
                  onSubmitted: navigateToChat,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Quick Suggestions',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 12,
                children: [
                  buildSuggestionButton('Acne'),
                  buildSuggestionButton('Oily Skin'),
                  buildSuggestionButton('Dry Skin'),
                  buildSuggestionButton('Dark Spots'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
