import 'dart:convert';

import '../models/models.dart';

Map<String, dynamic> _areaToJson(Region area) {
  return {
    "x": area.x,
    "y": area.y,
    "width": area.width,
    "height": area.height,
    "payload": _typeToJson(area.spec),
  };
}

Map<String, dynamic>? _typeToJson(RegionSpecification type) {
  switch (type.terrain) {
    case Terrain.barrier:
      return {"type": "barrier"};
    case Terrain.road:
      type as RoadRegionSpec;
      return {
        "type": "road",
        "directions": type.directions.map((e) => [e.x, e.y]).toList()
      };
    case Terrain.parkPlace:
      type as ParkPlaceRegionSpec;
      return {"type": "park", "code": type.code, "busy": type.busy};
  }
}

String get staticParkingLotJson {
  Map<String, dynamic> json = {
    "size": {
      "x": 27,
      "y": 20,
    },
  };

  List<Region> objects = [
    Region(0, 3, 22, 2, RoadRegionSpec(RoadDirection.d270)),
    Region(22, 3, 2, 2, RoadRegionSpec(RoadDirection.d315)),
    Region(22, 5, 2, 10, RoadRegionSpec(RoadDirection.d0)),
    Region(22, 15, 2, 2, RoadRegionSpec(RoadDirection.d45)),
    Region(0, 15, 22, 2, RoadRegionSpec(RoadDirection.d90)),
    //
    Region(0, 5, 20, 2, RoadRegionSpec(RoadDirection.d90)),
    Region(20, 5, 2, 2, RoadRegionSpec(RoadDirection.d135)),
    Region(20, 7, 2, 6, RoadRegionSpec(RoadDirection.d180)),
    Region(20, 13, 2, 2, RoadRegionSpec(RoadDirection.d225)),
    Region(0, 13, 20, 2, RoadRegionSpec(RoadDirection.d270)),
    //

    const Region(0, 0, 2, 3, StaticRegionSpec.barrier()),
    const Region(0, 7, 2, 6, StaticRegionSpec.barrier()),
    const Region(0, 17, 2, 3, StaticRegionSpec.barrier()),
    const Region(24, 0, 3, 3, StaticRegionSpec.barrier()),
    const Region(18, 7, 2, 6, StaticRegionSpec.barrier()),
    const Region(24, 17, 3, 3, StaticRegionSpec.barrier()),
  ];

  for (int i = 0; i < 11; i++) {
    final regionA = ParkPlaceRegionSpec(code: 'A${i + 1}', busy: false);
    objects.add(Region(2 + i * 2, 0, 2, 3, regionA));

    final regionD = ParkPlaceRegionSpec(code: 'D${i + 1}', busy: false);
    objects.add(Region(2 + i * 2, 17, 2, 3, regionD));
  }
  for (int i = 0; i < 8; i++) {
    final regionB = ParkPlaceRegionSpec(code: 'B${i + 1}', busy: false);
    objects.add(Region(2 + i * 2, 7, 2, 3, regionB));

    final regionE = ParkPlaceRegionSpec(code: 'E${i + 1}', busy: false);
    objects.add(Region(2 + i * 2, 10, 2, 3, regionE));
  }
  for (int i = 0; i < 7; i++) {
    final regionC = ParkPlaceRegionSpec(code: 'C${i + 1}', busy: false);
    objects.add(Region(24, 3 + i * 2, 3, 2, regionC));
  }

  return jsonEncode({
    ...json,
    "objects": objects.map(_areaToJson).toList(),
  });
}
