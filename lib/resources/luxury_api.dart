import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:luharitrip/models/item_model.dart';
import 'package:luharitrip/models/location_model.dart';

class LuxuryApi {
  Client client = Client();
  final _baseUrl = 'http://95.216.166.205:8080';


  Future<ItemModel> fetchTravelList({String urlParams=''}) async {
    final response = await client.get('$_baseUrl/offers${urlParams??''}');
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(utf8.decode(response.bodyBytes).replaceAll('₽', 'р.')));
    } else {
      throw Exception('Failed to load trevels');
    }
  }

  Future<LocationModel> fetchDirections() async{
    final response = await client.get('$_baseUrl/locations');
    if (response.statusCode == 200) {
      return LocationModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
