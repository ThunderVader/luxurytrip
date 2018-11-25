class Location {
  final String name;
  final String code;

  Location({this.name, this.code});

  factory Location.fromJson(Map json) {
    return Location(name: json['name'], code: json['code']);
  }
}