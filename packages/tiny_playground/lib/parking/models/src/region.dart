import 'region_specs/region_specification.dart';

class Region<T extends RegionSpecification> {
  final int x;
  final int y;
  final int width;
  final int height;
  final T spec;

  const Region(this.x, this.y, this.width, this.height, this.spec);

  const Region.named({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.spec,
  });

  Region<RegionSpecType> cast<RegionSpecType extends RegionSpecification>() {
    return Region<RegionSpecType>(x, y, width, height, spec as RegionSpecType);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Region<T> &&
        other.x == x &&
        other.y == y &&
        other.width == width &&
        other.height == height &&
        other.spec == spec;
  }

  @override
  int get hashCode {
    return x.hashCode ^
        y.hashCode ^
        width.hashCode ^
        height.hashCode ^
        spec.hashCode;
  }
}
