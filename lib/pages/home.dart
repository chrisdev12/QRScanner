import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_scanner/bloc/scan_bloc.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:qr_scanner/pages/directions.dart';
import 'package:qr_scanner/pages/maps.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:qr_scanner/utils/utils.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final scansBloc = ScansBloc();
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('QRScanner'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () {
                  scansBloc.deleteAll();
                })
          ],
        ),
        body: _callPage(currIndex),
        bottomNavigationBar: _navigationBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.filter_center_focus),
          onPressed: _scanQR,
        ));
  }

  Widget _navigationBar() {
    return BottomNavigationBar(
      currentIndex: currIndex,
      onTap: (index) {
        setState(() {
          currIndex = index;
        });
      },
      items: [
        _genBarItem(Icons.map, 'Mapas'),
        _genBarItem(Icons.brightness_5, "URl's"),
      ],
    );
  }

  BottomNavigationBarItem _genBarItem(IconData icon, String text) {
    return BottomNavigationBarItem(icon: Icon(icon), title: Text(text));
  }

  Widget _callPage(int currentPage) {
    switch (currentPage) {
      case 0:
        return MapsPage();
        break;
      default:
        return DirectionsPage();
        break;
    }
  }

  _scanQR() async {
    try {
      var result = await BarcodeScanner.scan();
      // print(result.type); // The result type (barcode, cancelled, failed)
      // print(result.rawContent); // The barcode content
      // print(result.format); // The barcode format (as enum)
      // print(result
      //     .formatNote); // If a unknown format was scanned this field contains a note
      if (result.rawContent != null && result.type != ResultType.Cancelled) {
        final scan = ScanModel(valor: result.rawContent);
        scansBloc.addScan(scan);

        if (Platform.isIOS) {
          //Bug on IOS
          Future.delayed(
              Duration(milliseconds: 750), () => openScan(scan, context));
        } else {
          openScan(scan, context);
        }
      }
    } catch (e) {
      Navigator.pushNamed(context, 'home');
    }
  }
}
