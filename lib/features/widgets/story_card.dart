import 'package:flutter/material.dart';
import 'package:mobile_app_developer_challenge_sakshi_tajane/core/constants/app_colors.dart';

class StoryCard extends StatelessWidget {
  final String title;
  final String story;

  const StoryCard({super.key, required this.title, required this.story});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.storyCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "STORY",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),

              Icon(
                Icons.menu_book_outlined,
                color: AppColors.cardBorder,
                size: 24,
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Story Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 16),

          /// Story Content
          Text(
            story,
            style: const TextStyle(
              fontSize: 18,
              height: 1.7,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
