import 'dart:convert';
import 'dart:math';

import '../models/models.dart';

class ParkingParser {
  ParkingParser();

  ParkingLot parse(String input) {
    final json = jsonDecode(input);

    final parking = ParkingLot(
      width: json["size"]["x"],
      height: json["size"]["y"],
    );

    final objects = (json["objects"] as List).cast<Map<String, dynamic>>();

    for (final object in objects) {
      final RegionSpecification type;
      switch (object["payload"]["type"]) {
        case 'road':
          final List directions = object["payload"]["directions"];
          type = RoadRegionSpec.fromVectors(
            directions
                .cast<List>()
                .map((e) => Point<num>(e.first, e.last))
                .toList(),
          );
          break;
        case 'barrier':
          type = const StaticRegionSpec.barrier();
          break;
        case 'park':
          type = ParkPlaceRegionSpec(
            code: object["payload"]["code"],
            busy: object["payload"]["busy"],
          );
          break;
        default:
          continue;
      }

      parking.addParkingRegion(
        Region.named(
          x: object["x"],
          y: object["y"],
          width: object["width"],
          height: object["height"],
          spec: type,
        ),
      );
    }

    return parking;
  }
}
