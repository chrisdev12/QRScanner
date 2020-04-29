import 'dart:async';
import 'package:qr_scanner/bloc/scan_bloc.dart';
import 'package:qr_scanner/models/scan_model.dart';

class Validators{

  final scan = new ScansBloc();
  final geoValidate = StreamTransformer<List<ScanModel>,List<ScanModel>>.fromHandlers(
    handleData: (scans,sink){
      final geoScans = scans.where((s) => s.tipo == 'geo').toList();
      sink.add(geoScans);
    }
  );

  final httpValidate = StreamTransformer<List<ScanModel>,List<ScanModel>>.fromHandlers(
    handleData: (scans,sink){
      final geoScans = scans.where((s) => s.tipo == 'http').toList();
      sink.add(geoScans);
    }
  );
}
