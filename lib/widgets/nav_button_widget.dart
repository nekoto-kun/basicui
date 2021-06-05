import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool displayShadow;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const NavigationButton({
    Key? key,
    required this.child,
    required this.color,
    this.displayShadow = false,
    this.margin = const EdgeInsets.all(8),
    this.padding = const EdgeInsets.all(8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (_) => Container(
        width: 48,
        height: 48,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: displayShadow
              ? [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                  ),
                ]
              : null,
        ),
        child: child,
      ),
    );
  }
}
