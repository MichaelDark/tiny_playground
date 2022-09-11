import 'package:flutter/material.dart';

import '../models/models.dart';
import 'canvas_theme.dart';

class ParkingPainter extends CustomPainter {
  final ParkingLot parkingLot;

  ParkingPainter(this.parkingLot);

  late num xSize;
  late num ySize;

  @override
  void paint(Canvas canvas, Size size) {
    xSize = size.width / parkingLot.width;
    ySize = size.height / parkingLot.height;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      CanvasTheme().dirtPaint,
    );

    for (final region in parkingLot.regions) {
      _drawArea(canvas, region);
    }
  }

  void _drawArea(Canvas canvas, Region region) {
    final topX = region.x * xSize;
    final topY = region.y * ySize;
    final width = region.width * xSize;
    final height = region.height * ySize;
    final rect = Rect.fromLTWH(
      topX.toDouble(),
      topY.toDouble(),
      width.toDouble(),
      height.toDouble(),
    );

    switch (region.spec.terrain) {
      case Terrain.barrier:
        canvas.drawRect(rect, CanvasTheme().barrierPaint);
        break;
      case Terrain.road:
        final roadRegion = region.spec as RoadRegionSpec;
        for (int x = region.x; x < region.x + region.width; x++) {
          for (int y = region.y; y < region.y + region.height; y++) {
            final cellRect = Rect.fromLTWH(
              (x * xSize).toDouble(),
              (y * ySize).toDouble(),
              xSize.toDouble(),
              ySize.toDouble(),
            );
            canvas.drawRect(cellRect, CanvasTheme().roadPaint);
            final center = cellRect.center;
            final shortestSide = cellRect.shortestSide;
            for (final direction in roadRegion.directions) {
              final offset = Offset(
                shortestSide / 2 * direction.x * 0.6,
                //reversing Y axis
                shortestSide / 2 * -direction.y * 0.6,
              );
              final vectorStart = center;
              final vectorEnd = center + offset;
              canvas.drawLine(
                  vectorStart, vectorEnd, CanvasTheme().roadArrowPaint);
              // canvas.drawCircle(vectorStart, shortestSide / 10, roadArrowPaint);
              canvas.drawCircle(
                  vectorEnd, shortestSide / 20, CanvasTheme().roadArrowPaint);
            }
          }
        }

        break;
      case Terrain.parkPlace:
        final parkPlace = region.spec as ParkPlaceRegionSpec;
        final paint = parkPlace.busy
            ? CanvasTheme().busyParkPlacePaint
            : CanvasTheme().freeParkPlacePaint;
        canvas.drawRect(rect, paint);
        canvas.drawRect(rect, CanvasTheme().parkPlaceBorderPaint);

        final painter = TextPainter(
          text: TextSpan(
            text: parkPlace.code,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              decoration: parkPlace.busy ? TextDecoration.lineThrough : null,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        painter.layout(minWidth: 0, maxWidth: rect.width);
        final halfTextOffset = Offset(painter.width / 2, painter.height / 2);
        painter.paint(canvas, rect.center - halfTextOffset);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
  // oldDelegate is ParkingPainter && parkingLot != oldDelegate.parkingLot;
}
