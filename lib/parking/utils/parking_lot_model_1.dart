import 'dart:convert';

import '../models/region.dart';
import '../models/region_type.dart';

String get parkingLotModel1 {
  Map<String, dynamic> json = {
    "size": {
      "x": 16,
      "y": 16,
    },
  };

  const List<Region> objects = [
    Region(0, 3, 13, 3, StaticRegion.road()),
    Region(0, 13, 13, 3, StaticRegion.road()),
    Region(10, 3, 3, 13, StaticRegion.road()),
    Region(0, 9, 10, 1, StaticRegion.barrier()),
    Region(13, 9, 3, 1, StaticRegion.barrier()),
    Region(12, 0, 4, 3, StaticRegion.barrier()),
    Region(0, 0, 2, 3, ParkPlaceRegion(code: 'C1', busy: false)),
    Region(2, 0, 2, 3, ParkPlaceRegion(code: 'C2', busy: true)),
    Region(4, 0, 2, 3, ParkPlaceRegion(code: 'C3', busy: false)),
    Region(6, 0, 2, 3, ParkPlaceRegion(code: 'C4', busy: false)),
    Region(8, 0, 2, 3, ParkPlaceRegion(code: 'C5', busy: false)),
    Region(10, 0, 2, 3, ParkPlaceRegion(code: 'C6', busy: false)),
    Region(13, 3, 3, 2, ParkPlaceRegion(code: 'C7', busy: true)),
    Region(13, 5, 3, 2, ParkPlaceRegion(code: 'C8', busy: false)),
    Region(13, 7, 3, 2, ParkPlaceRegion(code: 'C9', busy: false)),
    Region(0, 6, 2, 3, ParkPlaceRegion(code: 'C10', busy: false)),
    Region(2, 6, 2, 3, ParkPlaceRegion(code: 'C11', busy: true)),
    Region(4, 6, 2, 3, ParkPlaceRegion(code: 'C12', busy: false)),
    Region(6, 6, 2, 3, ParkPlaceRegion(code: 'C13', busy: false)),
    Region(8, 6, 2, 3, ParkPlaceRegion(code: 'C14', busy: false)),
    Region(13, 10, 3, 2, ParkPlaceRegion(code: 'C15', busy: false)),
    Region(13, 12, 3, 2, ParkPlaceRegion(code: 'C16', busy: true)),
    Region(13, 14, 3, 2, ParkPlaceRegion(code: 'C17', busy: false)),
    Region(8, 10, 2, 3, ParkPlaceRegion(code: 'C18', busy: false)),
    Region(6, 10, 2, 3, ParkPlaceRegion(code: 'C19', busy: false)),
    Region(4, 10, 2, 3, ParkPlaceRegion(code: 'C20', busy: false)),
    Region(2, 10, 2, 3, ParkPlaceRegion(code: 'C21', busy: true)),
    Region(0, 10, 2, 3, ParkPlaceRegion(code: 'C22', busy: false)),
  ];

  return jsonEncode({
    ...json,
    "objects": objects.map(_areaToJson).toList(),
  });
}

Map<String, dynamic> _areaToJson(Region area) {
  return {
    "x": area.x,
    "y": area.y,
    "width": area.width,
    "height": area.height,
    "payload": _typeToJson(area.type),
  };
}

Map<String, dynamic>? _typeToJson(RegionType type) {
  switch (type.terrain) {
    case Terrain.barrier:
      return {"type": "barrier"};
    case Terrain.road:
      return {"type": "road"};
    case Terrain.parkPlace:
      final parkPlace = type as ParkPlaceRegion;
      return {"type": "park", "code": parkPlace.code, "busy": parkPlace.busy};
  }
}
