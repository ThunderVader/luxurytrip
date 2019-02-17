class LocationModel {
  final List<Location> items;

  LocationModel(this.items);

  factory LocationModel.fromJson(dynamic json) {
    final items = (json['destinations'] as List)
        .cast<Map<String, Object>>()
        .map((Map<String, Object> item) {
      return Location.fromJson(item);
    }).toList();

    return LocationModel(items);
  }

  bool get isPopulated => items.isNotEmpty;

  bool get isEmpty => items.isEmpty;
}

class Location {
  final String name;
  final String code;
  bool isSelected;

  Location({this.name, this.code, this.isSelected});

  @override
  String toString() {
    return code;
  }

  static Location fromJson(Map json) {
    return Location(name: json['name'], code: json['code'], isSelected: false);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Location &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              code == other.code;

  @override
  int get hashCode =>
      name.hashCode ^
      code.hashCode;

}
