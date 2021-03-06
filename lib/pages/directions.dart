import 'package:flutter/material.dart';
import 'package:qr_scanner/bloc/scan_bloc.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:qr_scanner/utils/utils.dart';

class DirectionsPage extends StatelessWidget {

  final scansBloc = new ScansBloc();
  @override
  Widget build(BuildContext context) {
    return renderAddreses();
  }

  Widget renderAddreses() {
    scansBloc.getScans(); //Force to .sink data again to build it
    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStreamHttp,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (snapshot.hasData) {
          print(snapshot.hasData);
          if (snapshot.data.length == 0) {
            return Center(
              child: Text('Nothing'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) => Dismissible(
              onDismissed: (direction) =>
                  scansBloc.deleteScanById(snapshot.data[i].id),
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
              ),
              child: ListTile(
                leading: Icon(Icons.cloud),
                title: Text(snapshot.data[i].valor),
                trailing: Icon(Icons.arrow_right),
                onTap: (){
                  openScan(snapshot.data[i], context);
                },
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}


