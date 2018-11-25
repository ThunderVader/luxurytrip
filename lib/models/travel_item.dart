class TravelItem {
  final int id;
  final String title;
  final String link;
  final String provider;
  final DateTime date;
  final bool isFavorite;
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
}