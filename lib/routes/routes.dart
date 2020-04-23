import 'package:flutter/material.dart';
import 'package:qr_scanner/pages/home.dart';

Map<String, Widget Function(BuildContext)> routes(BuildContext context){

  return {
    'home': (context) => Home(),
  };
}

