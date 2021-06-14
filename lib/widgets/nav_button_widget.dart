import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class NavigationButton extends StatefulWidget {
  final Widget child;
  final Color color;
  final bool displayShadow;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final void Function()? onTap;

  const NavigationButton({
    Key? key,
    required this.child,
    required this.color,
    this.displayShadow = false,
    this.margin = const EdgeInsets.all(8),
    this.padding = const EdgeInsets.all(8),
    this.onTap,
  }) : super(key: key);

  @override
  _NavigationButtonState createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton>
    with AnimationMixin {
  late Animation<double> _scaleModifier;

  @override
  void initState() {
    _scaleModifier = .0.tweenTo(.0875).animate(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => controller.play(duration: 0.seconds),
      onTapUp: (_) => controller.playReverse(duration: 0.seconds),
      onTap: widget.onTap,
      child: Transform.scale(
        scale: 1 - _scaleModifier.value,
        child: Container(
          width: 48,
          height: 48,
          margin: widget.margin,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(16),
            boxShadow: widget.displayShadow
                ? [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                    ),
                  ]
                : null,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
