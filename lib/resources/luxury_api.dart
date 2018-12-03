import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' show Client;
import 'package:luharitrip/models/item_model.dart';

class LuxuryApi {
  Client client = Client();
  final _baseUrl = 'http://95.216.166.205:8080';


  Future<ItemModel> fetchTravelList({String urlParams=''}) async {
    final response = await client.get('$_baseUrl/offers${urlParams??''}');
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body.replaceAll('₽', 'р.')));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
