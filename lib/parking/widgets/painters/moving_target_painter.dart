import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../canvas_theme.dart';
import 'parking_lot_render_grid.dart';

class MovingTargetPainter extends CustomPainter {
  final ParkingLotRenderGrid grid;
  final Offset startPosition;
  final Offset? targetPosition;
  final double value;

  MovingTargetPainter({
    required this.grid,
    required this.startPosition,
    required this.targetPosition,
    required this.value,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (targetPosition != null) {
      canvas.drawCircle(targetPosition!, 5, CanvasTheme().targetPositionPaint);

      final currentOffset = Offset.lerp(startPosition, targetPosition, value);
      if (currentOffset != null) {
        final x = currentOffset.dx ~/ grid.xSide;
        final y = currentOffset.dy ~/ grid.ySide;
        final cell = grid.parkingLot.getCell(x, y);

        canvas.drawCircle(
          currentOffset,
          5,
          cell.region?.spec.terrain == Terrain.barrier
              ? CanvasTheme().currentPositionBlockedPaint
              : CanvasTheme().currentPositionPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is MovingTargetPainter &&
      (startPosition != oldDelegate.startPosition ||
          targetPosition != oldDelegate.targetPosition ||
          value != oldDelegate.value);
}
