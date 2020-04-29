import 'dart:async';
import 'package:qr_scanner/bloc/validator.dart';
import 'package:qr_scanner/providers/db.dart';

class ScansBloc with Validators {
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    //Get Scan from DB
    this.getScans();
  }

  final _scanController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scanController.stream.transform(geoValidate);
  Stream<List<ScanModel>> get scansStreamHttp => _scanController.stream.transform(httpValidate);


  dispose() {
    _scanController.close();
  }

  getScans() async {
    _scanController.sink.add(await DB.dbSet.getAll());
  }

  addScan(ScanModel scan) async {
    await DB.dbSet.newScanData(scan);
    this.getScans();
  }

  deleteScanById(int id) async {
    await DB.dbSet.deleteScan(id);
    this.getScans(); //Inyect the updated dat on the stream
  }

  deleteAll() async {
    await DB.dbSet.deleteAllScan();
    this.getScans(); //Inyect the updated dat on the stream
  }
}
