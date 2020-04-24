import 'package:flutter/material.dart';
import 'package:qr_scanner/routes/routes.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRScanner',
      initialRoute: 'home',
      routes: routes(context),
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
        floatingActionButtonTheme: FloatingActionButtonThemeData (
          backgroundColor: Colors.deepOrangeAccent
        )
      )
    );
  }
}