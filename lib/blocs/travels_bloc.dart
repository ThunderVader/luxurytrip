import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';

class TravelBloc {
  final _repository = Repository();
  final _travelsFetcher = PublishSubject<ItemModel>();

  Observable<ItemModel> get allMovies => _travelsFetcher.stream;

  fetchAllTravels() async {
    ItemModel itemModel = await _repository.fetchAllTravels();
    _travelsFetcher.sink.add(itemModel);
  }



  dispose() {
    _travelsFetcher.close();
  }
}

final bloc = TravelBloc();
