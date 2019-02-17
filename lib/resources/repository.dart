import 'dart:async';
import 'package:async/async.dart';
import 'package:luharitrip/models/item_model.dart';
import 'package:luharitrip/models/location_model.dart';

import 'luxury_api.dart';

class Repository {
  final luxuryApiProvider = LuxuryApi();
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  Future<ItemModel> fetchAllTravels() => luxuryApiProvider.fetchTravelList();

  Future fetchDirections() {
    return _memoizer.runOnce((){
      return luxuryApiProvider.fetchDirections();
    });
  }
}

final repository = Repository();
