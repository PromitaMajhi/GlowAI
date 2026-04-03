import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'product_card.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final Map<String, dynamic>? aiData;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isUser,
    this.aiData,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUser ? AppTheme.primaryPink : AppTheme.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isUser ? 20 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isUser)
              Text(
                text,
                style: const TextStyle(color: AppTheme.textDark, fontSize: 16),
              ),
            if (!isUser && aiData != null) ...[
              if (aiData!['analysis'] != null) ...[
                Text('Skin Analysis', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryPink.withRed(200))),
                Text(aiData!['analysis']),
                const SizedBox(height: 12),
              ],
              if (aiData!['routine'] != null) ...[
                Text('Routine', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryPink.withRed(200))),
                if (aiData!['routine']['morning'] != null) Text('☀️ Morning: ${aiData!['routine']['morning']}'),
                if (aiData!['routine']['night'] != null) Text('🌙 Night: ${aiData!['routine']['night']}'),
                const SizedBox(height: 12),
              ],
              if (aiData!['tips'] != null) ...[
                Text('Tips', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryPink.withRed(200))),
                ...(aiData!['tips'] as List).map((tip) => Text('• $tip')).toList(),
                const SizedBox(height: 12),
              ],
              if (aiData!['products'] != null) ...[
                Text('Recommended Products', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryPink.withRed(200))),
                const SizedBox(height: 8),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (aiData!['products'] as List).length,
                    itemBuilder: (context, index) {
                      final product = aiData!['products'][index];
                      return ProductCard(product: product);
                    },
                  ),
                )
              ]
            ],
            if (!isUser && aiData == null)
              Text(text, style: const TextStyle(color: AppTheme.textDark, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
