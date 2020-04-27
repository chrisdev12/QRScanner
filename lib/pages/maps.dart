import 'package:flutter/material.dart';
import 'package:qr_scanner/providers/db.dart';

class MapsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DB.dbSet.getAll(),
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
              onDismissed: (direction) => DB.dbSet.deleteScan(snapshot.data[i].id),
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
              ) ,
              child: ListTile(
                leading: Icon(Icons.cloud),
                title: Text(snapshot.data[i].valor),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
