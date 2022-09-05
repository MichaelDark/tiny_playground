import 'region_type.dart';

class Region {
  final int x;
  final int y;
  final int width;
  final int height;
  final RegionType type;

  const Region(this.x, this.y, this.width, this.height, this.type);

  const Region.named({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.type,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Region &&
        other.x == x &&
        other.y == y &&
        other.width == width &&
        other.height == height &&
        other.type == type;
  }

  @override
  int get hashCode {
    return x.hashCode ^
        y.hashCode ^
        width.hashCode ^
        height.hashCode ^
        type.hashCode;
  }
}
