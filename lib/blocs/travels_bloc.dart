import 'package:luharitrip/blocs/favorite_block.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';

class TravelBloc {
  final _travelsFetcher = PublishSubject<ItemModel>();
  final List<int> favoriteIds = List();

  Observable<ItemModel> get allTravels => _travelsFetcher.stream;

  fetchAllTravels() async {
    ItemModel itemModel = await repository.fetchAllTravels();
    if (favoriteBloc.hasBdChanged) {
      await favoriteBloc.fetchAllTravels();
      favoriteBloc.itemModel.items.forEach((t) {
        favoriteIds.add(t.id);
      });
    }

    itemModel.items.forEach((t) {
      if (favoriteIds.contains(t.id)) {
        t.isFavorite = true;
      }
    });

    _travelsFetcher.sink.add(itemModel);
  }

  dispose() {
    _travelsFetcher.close();
  }
}

final bloc = TravelBloc();
