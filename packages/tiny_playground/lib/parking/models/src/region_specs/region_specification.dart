enum Terrain { barrier, road, parkPlace }

abstract class RegionSpecification {
  const RegionSpecification();

  Terrain get terrain;
  bool get walkable;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegionSpecification &&
        other.terrain == terrain &&
        other.walkable == walkable;
  }

  @override
  int get hashCode => terrain.hashCode ^ walkable.hashCode;
}
