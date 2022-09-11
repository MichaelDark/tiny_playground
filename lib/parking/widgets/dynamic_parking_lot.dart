import 'package:flutter/material.dart';

import '../models/models.dart';
import 'canvas_theme.dart';
import 'parking_painter.dart';

class DynamicParkingLot extends StatefulWidget {
  final ParkingLot parkingLot;

  const DynamicParkingLot({required this.parkingLot, super.key});

  @override
  State<DynamicParkingLot> createState() => _DynamicParkingLotState();
}

class _DynamicParkingLotState extends State<DynamicParkingLot>
    with SingleTickerProviderStateMixin {
  Offset? tappedDown;
  Offset? currentTargetPosition = Offset.zero;
  Offset lastPosition = Offset.zero;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    super.initState();
    // _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    // CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuint);
    // _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.parkingLot.width / widget.parkingLot.height,
      child: GestureDetector(
        onTapDown: (details) {
          tappedDown = details.localPosition;
        },
        onTapUp: (details) {
          final distance = (tappedDown! - details.localPosition).distance;
          if (distance < 5) {
            setState(() {
              lastPosition = Offset.lerp(
                lastPosition,
                currentTargetPosition,
                _animation.value,
              )!;
              currentTargetPosition = tappedDown;
              _controller.reset();
              _controller.forward();
            });
          }
        },
        child: AnimatedProgressWidget(
          controller: _animation,
          builder: (_, value, child) {
            return CustomPaint(
              foregroundPainter: MovingTargetPainter(
                startPosition: lastPosition,
                targetPosition: currentTargetPosition,
                value: value,
              ),
              child: child,
            );
          },
          child: RepaintBoundary(
            child: CustomPaint(
              painter: ParkingPainter(widget.parkingLot),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedProgressWidget extends AnimatedWidget {
  final Widget Function(BuildContext, double progress, Widget? child) builder;
  final Widget? child;

  const AnimatedProgressWidget({
    super.key,
    required Listenable controller,
    required this.builder,
    this.child,
  }) : super(listenable: controller);

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) =>
      builder(context, _progress.value, child);
}

class MovingTargetPainter extends CustomPainter {
  final Offset startPosition;
  final Offset? targetPosition;
  final double value;

  MovingTargetPainter({
    required this.startPosition,
    required this.targetPosition,
    required this.value,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (targetPosition == null) return;
    canvas.drawCircle(targetPosition!, 5, CanvasTheme().targetPositionPaint);

    final currentOffset = Offset.lerp(startPosition, targetPosition, value);
    if (currentOffset == null) return;
    canvas.drawCircle(currentOffset, 5, CanvasTheme().currentPositionPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is MovingTargetPainter &&
      (startPosition != oldDelegate.startPosition ||
          targetPosition != oldDelegate.targetPosition ||
          value != oldDelegate.value);
}
