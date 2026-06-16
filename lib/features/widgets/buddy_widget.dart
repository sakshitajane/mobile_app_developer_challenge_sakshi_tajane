import 'package:flutter/material.dart';
import 'package:mobile_app_developer_challenge_sakshi_tajane/core/constants/app_colors.dart';

class BuddyWidget extends StatelessWidget {
  final bool isHappy;

  const BuddyWidget({super.key, this.isHappy = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: 180,
      width: 180,
      decoration: BoxDecoration(
        color: isHappy ? AppColors.success : AppColors.buddyBlue,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          isHappy ? Icons.sentiment_very_satisfied : Icons.smart_toy,
          size: 90,
          color: Colors.white,
        ),
      ),
    );
  }
}
