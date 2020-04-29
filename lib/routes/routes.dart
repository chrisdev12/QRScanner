import 'package:flutter/material.dart';
import 'package:qr_scanner/pages/directions.dart';
import 'package:qr_scanner/pages/home.dart';
import 'package:qr_scanner/pages/maps.dart';
import 'package:qr_scanner/pages/showMap.dart';

Map<String, Widget Function(BuildContext)> routes(BuildContext context){

  return {
    'home': (context) => Home(),
    'directions' : (context) => DirectionsPage(),
    'maps' : (context) => MapsPage(),
    'showmaps' : (context) => ShowMapPage(),
  };
}

