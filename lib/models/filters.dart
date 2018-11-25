import 'package:luharitrip/models/location.dart';

class Filters {
  final Map<Location, bool> origins;
  final Map<Location, bool> destinations;

  Filters({this.destinations, this.origins});

  factory Filters.fromJson(Map json) {
    Map<Location, bool> origins = Map();
    Map<Location, bool> destinations = Map();
    (json['origins'] as List)
        .forEach((l) => origins[Location.fromJson(l)] = false);
    (json['destinations'] as List)
        .forEach((l) => destinations[Location.fromJson(l)] = false);
    return Filters(
      origins: origins,
      destinations: destinations,);
  }

  bool get isOriginsPopulated => origins.isNotEmpty;
  bool get isDestinationsPopulated => destinations.isNotEmpty;

  bool get isOriginsEmpty => origins.isEmpty;
  bool get isDestinationsEmpty => origins.isEmpty;
}