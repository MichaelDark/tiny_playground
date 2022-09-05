abstract class RegionType {
  const RegionType();

  Terrain get terrain;
  bool get walkable;
}

enum Terrain { barrier, road, parkPlace }

class StaticRegion extends RegionType {
  @override
  final Terrain terrain;
  @override
  final bool walkable;

  const StaticRegion.road()
      : terrain = Terrain.road,
        walkable = true;

  const StaticRegion.barrier()
      : terrain = Terrain.barrier,
        walkable = false;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StaticRegion &&
        other.terrain == terrain &&
        other.walkable == walkable;
  }

  @override
  int get hashCode => terrain.hashCode ^ walkable.hashCode;
}

class ParkPlaceRegion extends RegionType {
  final String code;
  final bool busy;

  const ParkPlaceRegion({required this.code, required this.busy});

  @override
  Terrain get terrain => Terrain.parkPlace;

  @override
  bool get walkable => !busy;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ParkPlaceRegion && other.code == code && other.busy == busy;
  }

  @override
  int get hashCode => code.hashCode ^ busy.hashCode;
}
