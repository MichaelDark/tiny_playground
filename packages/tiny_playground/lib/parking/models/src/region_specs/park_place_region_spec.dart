import 'region_specification.dart';

class ParkPlaceRegionSpec extends RegionSpecification {
  final String code;
  final bool busy;

  const ParkPlaceRegionSpec({required this.code, required this.busy});

  @override
  Terrain get terrain => Terrain.parkPlace;

  @override
  bool get walkable => !busy;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ParkPlaceRegionSpec &&
        other.code == code &&
        other.busy == busy;
  }

  @override
  int get hashCode => code.hashCode ^ busy.hashCode;
}
