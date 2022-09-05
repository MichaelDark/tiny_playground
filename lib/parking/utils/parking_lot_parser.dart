import 'dart:convert';

import '../models/parking_lot.dart';
import '../models/region.dart';
import '../models/region_type.dart';

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
      final RegionType type;
      switch (object["payload"]["type"]) {
        case 'road':
          type = const StaticRegion.road();
          break;
        case 'barrier':
          type = const StaticRegion.barrier();
          break;
        case 'park':
          type = ParkPlaceRegion(
            code: object["payload"]["code"],
            busy: object["payload"]["busy"],
          );
          break;
        default:
          continue;
      }

      parking.addRegion(
        Region.named(
          x: object["x"],
          y: object["y"],
          width: object["width"],
          height: object["height"],
          type: type,
        ),
      );
    }

    return parking;
  }
}
