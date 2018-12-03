import 'dart:async';
import 'package:flutter/services.dart';

const MethodChannel methodChannel =
const MethodChannel('ru.luharitrip.luharitrip/nativeInteraction');

Future<Null> openWebView(String url) async {
  Completer<Null> completer = Completer<Null>();

  try {
    methodChannel.invokeMethod('openWebView', url).then((_)=>completer.complete());
  } on PlatformException {
    print("fail to open webWiew");
  }
}

Future<Null> showShareDialog({String sharingTitle, String sharingURL}) async{
  Completer<Null> completer = Completer<Null>();
  try {
   methodChannel.invokeMethod('shareTrip', [sharingTitle, sharingURL]).then((_)=>completer.complete());
  } on PlatformException {
    print("fail to share url");
  }
}