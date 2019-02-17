import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:luharitrip/resources/luxury_api.dart';
import 'package:luharitrip/ui/travel_list.dart';

final ThemeData kIOSTheme = new ThemeData(
    accentColor: Color(0xFFF66555),
    primaryColorBrightness: Brightness.light,
    canvasColor: Colors.transparent);

final ThemeData kDefaultTheme = new ThemeData(
    accentColor: Color(0xFFF66555), canvasColor: Colors.transparent);

void main(LuxuryApi api) {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(LuhariTripApp(api: LuxuryApi()));
}

class LuhariTripApp extends StatefulWidget{
  final LuxuryApi api;
  LuhariTripApp({Key key, this.api}) : super(key: key);

  @override
  _RxDartLuhariTripApp createState()=>_RxDartLuhariTripApp();
}

class _RxDartLuhariTripApp extends State<LuhariTripApp>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      home: TravelList(api: widget.api),
    );
  }

}