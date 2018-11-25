import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:luharitrip/models/filters.dart';
import 'package:luharitrip/models/travel_list.dart';

class LuxuryApi {
  final String baseUrl;
  final Map<String, TravelList> cache;
  final http.Client client;

  LuxuryApi({
    HttpClient client,
    Map<String, TravelList> cache,
    this.baseUrl = "http://95.216.166.205:8080",
  })  : this.client = client ?? http.Client(),
        this.cache = cache ?? <String, TravelList>{};

  Future<TravelList> getTravels({String params=''}) async {
      final result = await _fetchTravels(params);
      return result;
  }

  Future<TravelList> _fetchTravels(String params) async {
    final response = await client.get(Uri.parse("$baseUrl/offers$params"));
    final results = json.decode(response.body);

    return TravelList.fromJson(results);
  }

  Future<Filters> getLocations() async{
    final response = await client.get(Uri.parse("$baseUrl/locations"));
    final results = json.decode(response.body);

    final locationList = Filters.fromJson(results);
    return locationList;
  }
}
