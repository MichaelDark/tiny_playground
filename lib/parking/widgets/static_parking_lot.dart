import 'package:flutter/material.dart';

import '../models/parking_lot.dart';
import '../models/region.dart';
import '../models/region_type.dart';

class StaticParkingLot extends StatelessWidget {
  final ParkingLot parkingLot;

  const StaticParkingLot(this.parkingLot, {super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: parkingLot.width / parkingLot.height,
      child: CustomPaint(
        painter: ParkingPainter(parkingLot),
      ),
    );
  }
}

class ParkingPainter extends CustomPainter {
  final ParkingLot parkingLot;

  ParkingPainter(this.parkingLot);

  final dirtPaint = Paint()..color = Colors.brown[400]!;
  final roadPaint = Paint()..color = Colors.grey[400]!;
  final barrierPaint = Paint()..color = Colors.grey[800]!;
  final busyParkPlacePaint = Paint()..color = Colors.blue[900]!;
  final freeParkPlacePaint = Paint()..color = Colors.blue[600]!;
  final parkPlaceBorderPaint = Paint()
    ..color = Colors.grey[600]!
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Size size) {
    final xSize = size.width / parkingLot.width;
    final ySize = size.height / parkingLot.height;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), dirtPaint);

    for (final area in parkingLot.regions) {
      final topX = area.x * xSize;
      final topY = area.y * ySize;
      final width = area.width * xSize;
      final height = area.height * ySize;
      final rect = Rect.fromLTWH(topX, topY, width, height);

      _drawArea(canvas, rect, area);
    }
  }

  void _drawArea(Canvas canvas, Rect rect, Region region) {
    switch (region.type.terrain) {
      case Terrain.barrier:
        canvas.drawRect(rect, barrierPaint);
        break;
      case Terrain.road:
        canvas.drawRect(rect, roadPaint);
        break;
      case Terrain.parkPlace:
        final parkPlace = region.type as ParkPlaceRegion;
        final paint = parkPlace.busy ? busyParkPlacePaint : freeParkPlacePaint;
        canvas.drawRect(rect, paint);
        canvas.drawRect(rect, parkPlaceBorderPaint);

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
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is ParkingPainter && parkingLot != oldDelegate.parkingLot;
}
