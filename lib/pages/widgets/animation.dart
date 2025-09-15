import 'package:flutter/material.dart';

enum SlideFrom { bottom, top, left, right }

class SlideAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final SlideFrom from;
  final double offset;

  const SlideAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.from = SlideFrom.bottom,
    this.offset = 0.3,
  });

  @override
  _SlideAnimationState createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    Offset beginOffset;
    switch (widget.from) {
      case SlideFrom.top:
        beginOffset = Offset(0, -widget.offset);
        break;
      case SlideFrom.left:
        beginOffset = Offset(-widget.offset, 0);
        break;
      case SlideFrom.right:
        beginOffset = Offset(widget.offset, 0);
        break;
      case SlideFrom.bottom:
      default:
        beginOffset = Offset(0, widget.offset);
        break;
    }

    _animation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _animation, child: widget.child);
  }
}
