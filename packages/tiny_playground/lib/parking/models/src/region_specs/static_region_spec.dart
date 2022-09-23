import 'region_specification.dart';

class StaticRegionSpec extends RegionSpecification {
  @override
  final Terrain terrain;
  @override
  final bool walkable;

  const StaticRegionSpec.barrier()
      : terrain = Terrain.barrier,
        walkable = false;
}
