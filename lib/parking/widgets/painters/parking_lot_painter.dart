import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../canvas_theme.dart';
import 'parking_lot_render_grid.dart';

class ParkingLotPainter extends CustomPainter {
  final ParkingLot parkingLot;
  final CanvasTheme theme;

  ParkingLotPainter(this.parkingLot) : theme = CanvasTheme();

  late ParkingLotRenderGrid grid;

  @override
  void paint(Canvas canvas, Size size) {
    if (kDebugMode) {
      print('[ParkingPainter] Printing!');
    }

    grid = ParkingLotRenderGrid(parkingLot, size);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      theme.dirtPaint,
    );

    for (final region in parkingLot.regions) {
      _drawArea(canvas, region);
    }
  }

  void _drawArea(Canvas canvas, Region region) {
    final rect = grid.getRectForRegion(region);

    switch (region.spec.terrain) {
      case Terrain.barrier:
        _drawRoadBarrier(canvas, rect);
        break;
      case Terrain.road:
        _drawRoad(canvas, rect, region.cast<RoadRegionSpec>());
        break;
      case Terrain.parkPlace:
        _drawParkPlace(canvas, rect, region.spec as ParkPlaceRegionSpec);
        break;
    }
  }

  void _drawRoadBarrier(Canvas canvas, Rect rect) {
    canvas.drawRect(rect, theme.barrierPaint);
  }

  void _drawRoad(Canvas canvas, Rect rect, Region<RoadRegionSpec> region) {
    final shortestSide = grid.shortestSide;
    final directions = region.spec.directions;

    for (int x = region.x; x < region.x + region.width; x++) {
      for (int y = region.y; y < region.y + region.height; y++) {
        final cellRect = grid.getRectForCell(x, y);
        canvas.drawRect(cellRect, theme.roadPaint);
        final center = cellRect.center;
        for (final direction in directions) {
          final offset = Offset(
            shortestSide / 2 * direction.x * 0.6,
            //reversing Y axis
            shortestSide / 2 * -direction.y * 0.6,
          );
          final vectorStart = center;
          final vectorEnd = center + offset;
          canvas.drawLine(vectorStart, vectorEnd, theme.roadArrowPaint);
          // canvas.drawCircle(vectorStart, shortestSide / 10, roadArrowPaint);
          canvas.drawCircle(vectorEnd, shortestSide / 20, theme.roadArrowPaint);
        }
      }
    }
  }

  void _drawParkPlace(Canvas canvas, Rect rect, ParkPlaceRegionSpec spec) {
    canvas.drawRect(
      rect,
      spec.busy ? theme.busyParkPlacePaint : theme.freeParkPlacePaint,
    );
    canvas.drawRect(rect, theme.parkPlaceBorderPaint);

    final painter = TextPainter(
      text: TextSpan(
        text: spec.code,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          decoration: spec.busy ? TextDecoration.lineThrough : null,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    painter.layout(minWidth: 0, maxWidth: rect.width);
    final halfTextOffset = Offset(painter.width / 2, painter.height / 2);
    painter.paint(canvas, rect.center - halfTextOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
  // oldDelegate is ParkingPainter && parkingLot != oldDelegate.parkingLot;
}
