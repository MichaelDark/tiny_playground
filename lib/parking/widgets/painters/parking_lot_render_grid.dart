import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/models.dart';

class ParkingLotRenderGrid {
  final ParkingLot parkingLot;
  final num xSide;
  final num ySide;
  final num shortestSide;

  ParkingLotRenderGrid(this.parkingLot, Size size)
      : xSide = size.width / parkingLot.width,
        ySide = size.height / parkingLot.height,
        shortestSide =
            min(size.width / parkingLot.width, size.height / parkingLot.height);

  Rect getRectForRegion(Region region) {
    final rect = Rect.fromLTWH(
      (region.x * xSide).toDouble(),
      (region.y * ySide).toDouble(),
      (region.width * xSide).toDouble(),
      (region.height * ySide).toDouble(),
    );
    return rect;
  }

  Rect getRectForCell(int x, int y) {
    final rect = Rect.fromLTWH(
      (x * xSide).toDouble(),
      (y * ySide).toDouble(),
      xSide.toDouble(),
      ySide.toDouble(),
    );
    return rect;
  }
}
