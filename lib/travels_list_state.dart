import 'package:luharitrip/models/travel_list.dart';

class TravelsLoadingState {}

class TravelsLoading extends TravelsLoadingState {}

class TravelsLoadingError extends TravelsLoadingState {}

class TravelsNoFilters extends TravelsLoadingState {}

class TravelsListPopulated extends TravelsLoadingState {
  final TravelList result;

  TravelsListPopulated(this.result);
}

class TravelsLoadingEmpty extends TravelsLoadingState {}