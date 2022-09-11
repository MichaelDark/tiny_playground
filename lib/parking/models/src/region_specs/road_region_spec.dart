import 'dart:math' show Point;

import 'package:flutter/foundation.dart' show listEquals;

import 'region_specification.dart';

class RoadRegionSpec extends RegionSpecification {
  final List<Point> directions;

  RoadRegionSpec(RoadDirection direction) : directions = direction.vectors;

  RoadRegionSpec.all()
      : directions = [...RoadDirection.values.map((d) => d.vector)];

  RoadRegionSpec.fromVectors(this.directions);

  @override
  Terrain get terrain => Terrain.road;

  @override
  bool get walkable => true;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoadRegionSpec && listEquals(other.directions, directions);
  }

  @override
  int get hashCode => directions.hashCode;
}

enum RoadDirection {
  d0(Point(0, 1)),
  d45(Point(1, 1)),
  d90(Point(1, 0)),
  d135(Point(1, -1)),
  d180(Point(0, -1)),
  d225(Point(-1, -1)),
  d270(Point(-1, 0)),
  d315(Point(-1, 1));

  final Point vector;

  const RoadDirection(this.vector);

  List<Point> get vectors {
    return _oneDirectionVectors;
    // ignore: dead_code
    return _oneDirectionVectorsExcludingBack;
  }

  List<Point> get _oneDirectionVectors => [vector];

  List<Point> get _oneDirectionVectorsExcludingBack {
    final oddIndexes = [
      (index + 8 + 4).abs() % 8,
      (index + 8 + 3).abs() % 8,
      (index + 8 - 3).abs() % 8,
    ];

    final valuesList = RoadDirection.values.toList();
    final directions = <Point>[];
    for (int i = 0; i < valuesList.length; i++) {
      if (oddIndexes.contains(i)) continue;
      directions.add(valuesList[i].vector);
    }

    return directions;
  }
}
