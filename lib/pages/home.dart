import 'package:flutter/material.dart';
import 'package:qr_scanner/pages/directions.dart';
import 'package:qr_scanner/pages/maps.dart';
import 'package:barcode_scan/barcode_scan.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QRScanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (){}
          )
        ],
      ),
      body: _callPage(currIndex),
      bottomNavigationBar: _navigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
      )
    );
  }

  Widget _navigationBar(){
    return BottomNavigationBar(
      currentIndex: currIndex,
      onTap: (index){
        setState(() {
          currIndex = index;
        });
      },
      items: [
        _genBarItem(Icons.map,'Mapas'),
        _genBarItem(Icons.brightness_5,'Direcciones'),
      ] ,
    );
  }

  BottomNavigationBarItem _genBarItem(IconData icon, String text) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      title: Text(text)
    );
  }

  Widget _callPage(int currentPage) {
    switch (currentPage) {
      case 0 : return MapsPage();
        break;
      default: return DirectionsPage();
        break;
    }
  }

  _scanQR() async {

    try {
      var result = await BarcodeScanner.scan();
  
      print(result.type); // The result type (barcode, cancelled, failed)
      print(result.rawContent); // The barcode content
      print(result.format); // The barcode format (as enum)
      print(result.formatNote); // If a unknown format was scanned this field contains a note

        
    } catch (e) {
      print(e);
    }
  }
}
    
