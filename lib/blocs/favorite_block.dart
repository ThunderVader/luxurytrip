import 'package:luharitrip/resources/database.dart';

import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';

class FavoriteBloc {
  final _db = TravelDatabase();
  final _dbTravelsFetcher = PublishSubject<ItemModelDB>();
  bool hasBdChanged = true;
  ItemModelDB itemModel;

  Observable<ItemModelDB> get allTravels => _dbTravelsFetcher.stream;

  fetchAllTravels() async {
    itemModel = await _db.getTravels();
    _dbTravelsFetcher.sink.add(itemModel);
    hasBdChanged=false;
  }

  addToFavorite(travelState){
    hasBdChanged = true;
    _db.addTravel(travelState);
  }

  removeFromFavorite(travelId){
    hasBdChanged = true;
    _db.deleteTravel(travelId);
  }

  dispose() {
    _dbTravelsFetcher.close();
  }
}

final favoriteBloc = FavoriteBloc();
