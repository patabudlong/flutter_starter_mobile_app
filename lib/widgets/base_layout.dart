import 'package:flutter/material.dart';
import 'package:flutter_starter_mobile_app/widgets/custom_header.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool showAppBar;
  final bool showCustomHeader;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const BaseLayout({
    super.key,
    required this.child,
    this.title,
    this.showAppBar = false,
    this.showCustomHeader = false,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar && title != null
          ? AppBar(
              title: Text(title!),
              actions: actions,
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            if (showCustomHeader && title != null)
              CustomHeader(
                title: title!,
                actions: actions,
              ),
            Expanded(child: child),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
} 