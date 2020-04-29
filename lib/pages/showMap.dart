import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:flutter_map/flutter_map.dart';

class ShowMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text('Coordenadas QR'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {},
            )
          ],
        ),
        body: _renderMap(scan));
  }

  Widget _renderMap(ScanModel scan) {
    return FlutterMap(
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken':
                'pk.eyJ1IjoiY2hyaXNkZXYxMiIsImEiOiJjazlqZm5vdHYxanc2M2VvYjNiZ2xiM2tuIn0.zZ5Sv_6LK09TwXtUPnl9vA',
            'id': 'mapbox.satellite', //streets, dark, light, outdoors, satellite
          },
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: scan.getLatLng(),
              builder: (ctx) => Container(
                child: Icon(Icons.location_on),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LatLng {}
