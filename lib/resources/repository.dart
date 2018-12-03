import 'dart:async';
import 'package:luharitrip/models/item_model.dart';

import 'luxury_api.dart';

class Repository {
  final moviesApiProvider = LuxuryApi();

  Future<ItemModel> fetchAllTravels() => moviesApiProvider.fetchTravelList();

//  Future<TrailerModel> fetchTrailers(int movieId) => moviesApiProvider.fetchTrailer(movieId);
}
