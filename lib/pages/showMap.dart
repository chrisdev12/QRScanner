import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:flutter_map/flutter_map.dart';

class ShowMapPage extends StatefulWidget {
  @override
  _ShowMapPageState createState() => _ShowMapPageState();
}

class _ShowMapPageState extends State<ShowMapPage> {
  final map = new MapController();

  String mapaType = 'streets';

  @override
  Widget build(BuildContext context) {
  final ScanModel scan = ModalRoute.of(context).settings.arguments;

  return Scaffold(
    appBar: AppBar(
      title: Text('Coordenadas QR'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.my_location),
          onPressed: () {
            map.move(scan.getLatLng(), 15);
          },
        )
      ],
    ),
    body: _renderMap(scan, mapaType),
    floatingActionButton: createButton(context));
  }

  Widget _renderMap(ScanModel scan, String mapaType) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken': 'pk.eyJ1IjoiY2hyaXNkZXYxMiIsImEiOiJjazlqZm5vdHYxanc2M2VvYjNiZ2xiM2tuIn0.zZ5Sv_6LK09TwXtUPnl9vA',
            'id':'mapbox.$mapaType', //streets, dark, light, outdoors, satellite
          },
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 50.0,
              height: 50.0,
              point: scan.getLatLng(),
              builder: (ctx) => Container(
                child:
                  Icon(Icons.location_on, size: 60.0, color: Colors.red)),
            ),
          ],
        ),
      ],
    );
  }

  createButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        String mapa;
        //streets, dark, light, outdoors, satellite
        if (mapaType == 'streets') {
          mapa = 'dark';
        } else if (mapaType == 'dark') {
          mapa = 'light';
        } else if (mapaType == 'light') {
          mapa = 'outdoors';
        } else if (mapaType == 'outdoors') {
          mapa = 'satellite';
        } else {
          mapa = 'streets';
        }

        setState(() => mapaType = mapa); //Inform to the Statefull widget that a property changes and the widget must be redrawed
      },
      backgroundColor: Colors.lightBlueAccent,
      child: Icon(Icons.map),
    );
  }
}
