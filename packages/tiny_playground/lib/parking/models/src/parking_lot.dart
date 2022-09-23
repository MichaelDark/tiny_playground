import 'package:flutter/foundation.dart' show listEquals;
import 'package:tiny_playground/parking/models/models.dart';

class ParkingLot {
  final int width;
  final int height;
  final List<Region> regions;
  final List<List<ParkingCell>> matrix;

  ParkingLot({required this.width, required this.height})
      : matrix = [],
        regions = [] {
    for (int i = 0; i < width; i++) {
      matrix.add(List.generate(height, (_) => ParkingCell(), growable: false));
    }
  }

  int getCellCount() => width * height;

  void addParkingRegion<T extends RegionSpecification>(Region<T> region) {
    assert(region.x >= 0 && region.x + region.width <= width);
    assert(region.y >= 0 && region.y + region.height <= height);

    regions.add(region);

    for (int currX = region.x; currX < region.x + region.width; currX++) {
      for (int currY = region.y; currY < region.y + region.height; currY++) {
        matrix[currX][currY].region = region;
      }
    }
  }

  ParkingCell getCell(int x, int y) {
    assert(x >= 0 && x < width);
    assert(y >= 0 && y < height);
    return matrix[x][y];
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ParkingLot &&
        other.width == width &&
        other.height == height &&
        listEquals(other.regions, regions) &&
        listEquals(other.matrix, matrix);
  }

  @override
  int get hashCode {
    return width.hashCode ^
        height.hashCode ^
        regions.hashCode ^
        matrix.hashCode;
  }
}
