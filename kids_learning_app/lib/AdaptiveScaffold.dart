import 'package:flutter/material.dart';

class AdaptiveScaffold extends StatelessWidget {
  final Widget child;
  final bool scrollable;

  const AdaptiveScaffold({required this.child, this.scrollable = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 600;

            final content = Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 48 : 16,
                vertical: 24,
              ),
              child: child,
            );

            return scrollable
                ? SingleChildScrollView(child: content)
                : content;
          },
        ),
      ),
    );
  }
}
