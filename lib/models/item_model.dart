class ItemModel {
  final List<TravelItem> items;

  ItemModel(this.items);

  factory ItemModel.fromJson(dynamic json) {
    final items = (json as List)
        .cast<Map<String, Object>>()
        .map((Map<String, Object> item) {
      return TravelItem.fromJson(item);
    }).toList();

    return ItemModel(items);
  }

  bool get isPopulated => items.isNotEmpty;

  bool get isEmpty => items.isEmpty;
}

class TravelItem {
  final int id;
  final String title;
  final String link;
  final String provider;
  final DateTime date;
  bool isFavorite;
  final Map<String, dynamic> destination;

  TravelItem({
    this.id,
    this.title,
    this.link,
    this.provider,
    this.isFavorite,
    this.destination,
    this.date,
  });

  factory TravelItem.fromJson(Map json) {
    bool _hasDestination = json['destination'] != null;
    return TravelItem(
        id: json['id'],
        title: json['title'],
        link: json['link'],
        provider: json['provider'],
        destination: _hasDestination ? {'id': json['destination']['id']} : null,
        date: DateTime.parse(json['date']+'Z').toLocal(),
        isFavorite: false);
  }

  factory TravelItem.fromDb(Map map) {
    bool _hasDestination = map['destination_id'] != null;
    return TravelItem(
        id: map['id'],
        title: map['title'],
        link: map['link'],
        provider: map['provider'],
        destination: _hasDestination ? {'id': map['destination_id']} : null,
        date: DateTime.parse(map['date']).toLocal(),
        isFavorite: false);
  }

  Map toMap() {
    bool _hasDestination = destination != null;
    Map<String, dynamic> map = {
      "id": id,
      "title": title,
      "link": link,
      "provider": provider,
      "destination_id": _hasDestination ? destination['id'] : null,
      "date" : date.toUtc().toString()
    };
    return map;
  }
}