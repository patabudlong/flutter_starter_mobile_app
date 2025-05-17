import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showProfilePicture;

  const CustomHeader({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.showProfilePicture = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (showProfilePicture)
              GestureDetector(
                onTap: () {
                  // Navigate to profile
                  Navigator.pushNamed(context, '/profile');
                },
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
            if (showProfilePicture) const SizedBox(width: 12),
            if (leading != null) leading!,
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }
} 