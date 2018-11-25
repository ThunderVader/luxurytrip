import 'package:luharitrip/models/travel_item.dart';

class TravelList {
  final List<TravelItem> items;

  TravelList(this.items);

  factory TravelList.fromJson(dynamic json) {
    final items = (json as List)
        .cast<Map<String, Object>>()
        .map((Map<String, Object> item) {
      return TravelItem.fromJson(item);
    }).toList();

    return TravelList(items);
  }

  bool get isPopulated => items.isNotEmpty;

  bool get isEmpty => items.isEmpty;
}