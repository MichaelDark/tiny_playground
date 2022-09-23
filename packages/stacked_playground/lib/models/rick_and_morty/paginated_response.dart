import 'package:json_annotation/json_annotation.dart';

part 'paginated_response.g.dart';

class PaginatedResponse<T> {
  final PaginationInfo info;
  final List<T> results;

  const PaginatedResponse({
    required this.info,
    required this.results,
  });
}

@JsonSerializable()
class PaginationInfo {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  const PaginationInfo({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) =>
      _$PaginationInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationInfoToJson(this);
}
