//import 'package:luharitrip/resources/luxury_api.dart';
//import 'package:luharitrip/travels_list_state.dart';
//import 'package:rxdart/rxdart.dart';
//import 'dart:async';
//
//class FilterBloc{
//  final Sink<String> onFiltersApplied;
//  final Stream<TravelsLoadingState> state;
//
//  factory FilterBloc(LuxuryApi api) {
//    final onFiltersApplied = PublishSubject<String>();
//
//    final state = onFiltersApplied
//    // If the text has not changed, do not perform a new search
//        .distinct()
//    // Wait for the user to stop typing for 250ms before running a search
//        .debounce(const Duration(milliseconds: 250))
//    // Call the Github api with the given search term and convert it to a
//    // State. If another search term is entered, flatMapLatest will ensure
//    // the previous search is discarded so we don't deliver stale results
//    // to the View.
//        .switchMap<TravelsLoadingState>((String term) => _search(term, api))
//    // The initial state to deliver to the screen.
//        .startWith(TravelsLoading());
//
//    return FilterBloc._(onFiltersApplied, state);
//  }
//
//  FilterBloc._(this.onFiltersApplied, this.state);
//
//  void dispose() {
//    onFiltersApplied.close();
//  }
//
//  static Stream<TravelsLoadingState> _search(String term, LuxuryApi api) async* {
//  yield TravelsLoading();
//
//      try {
//        final result = await api.getTravels(params: term);
//
//        if (result.isEmpty) {
//          yield TravelsLoadingEmpty();
//        } else {
//          yield TravelsListPopulated(result);
//        }
//      } catch (e) {
//        yield TravelsLoadingError();
//      }
//  }
//}a