import 'package:flutter/material.dart';

import '../models/models.dart';
import 'animated_progress_widget.dart';
import 'painters/moving_target_painter.dart';
import 'painters/parking_lot_painter.dart';
import 'painters/parking_lot_render_grid.dart';

class ParkingLotPlayground extends StatefulWidget {
  final ParkingLot parkingLot;

  const ParkingLotPlayground({required this.parkingLot, super.key});

  @override
  State<ParkingLotPlayground> createState() => _ParkingLotPlaygroundState();
}

class _ParkingLotPlaygroundState extends State<ParkingLotPlayground>
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

    const curve = Curves.easeOutCubic;
    // const curve = Curves.easeInOutQuint;
    // const curve = Curves.bounceOut;
    _animation = CurvedAnimation(parent: _controller, curve: curve);
    // _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateTo(Offset offset) {
    setState(() {
      lastPosition = Offset.lerp(
        lastPosition,
        currentTargetPosition,
        _animation.value,
      )!;
      currentTargetPosition = offset;
      _controller.reset();
      _controller.forward();
    });
  }

  void _onTapDown(TapDownDetails details) {
    tappedDown = details.localPosition;
  }

  void _onTapUp(TapUpDetails details) {
    final tappedUp = details.localPosition;
    final tappedUpX = tappedUp.dx ~/ grid!.xSide;
    final tappedUpY = tappedUp.dy ~/ grid!.ySide;
    final tappedUpCell = widget.parkingLot.getCell(tappedUpX, tappedUpY);
    if (tappedUpCell.region?.spec.terrain == Terrain.barrier) return;

    final distance = (tappedDown! - details.localPosition).distance;
    if (distance < 5) {
      _navigateTo(tappedDown!);
    }
  }

  ParkingLotRenderGrid? grid;
  void initGrid(BoxConstraints constraints) {
    if (grid == null || grid?.parkingLot != widget.parkingLot) {
      grid = ParkingLotRenderGrid(widget.parkingLot, constraints.biggest);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.parkingLot.width / widget.parkingLot.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          initGrid(constraints);

          return GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            child: AnimatedProgressWidget(
              controller: _animation,
              builder: (_, value, child) {
                return CustomPaint(
                  foregroundPainter: MovingTargetPainter(
                    grid: grid!,
                    startPosition: lastPosition,
                    targetPosition: currentTargetPosition,
                    value: value,
                  ),
                  child: child,
                );
              },
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: ParkingLotPainter(widget.parkingLot),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
