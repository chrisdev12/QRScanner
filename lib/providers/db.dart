//Database managment
import 'dart:io';
import 'package:qr_scanner/models/scan_model.dart';
export 'package:qr_scanner/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

//Should be implmented through Singleton Pattern
class DB {
  static Database _dataBase;

  static final DB dbSet = new DB._();

  //Private constructor
  DB._();

  Future<Database> get database async {
    if (_dataBase != null) return _dataBase;

    _dataBase = await initDB();

    return _dataBase;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'SacansDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Scans('
          ' id INTEGER PRIMARY KEY,'
          ' tipo TEXT,'
          ' valor TEXT'
          ')');
    });
  }

  //Create register
  newScanData(ScanModel newScan) async {
    final db = await database;

    // Old/Atypic way
    // final res = await db.rawInsert('INSERT Into Scans (id,tipo,valor) '
    //   'VALUES (${newScan.id}, ${newScan.tipo}, ${newScan.valor}'
    // );

    // Optimal way
    final res = await db.insert('Scans', newScan.toJson());
    return res;
  }

  //Select - Get info

  Future<ScanModel> getScanId(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAll() async {
    final db = await database;
    final res = await db.query('Scans');

    // Fast way to generate a list from a
    List<ScanModel> list =
        res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];

    return list;
  }

  Future<List<ScanModel>> getByKind(String kind) async {
    final db = await database;
    final res = await db.rawQuery('SELECT * FROM Scans where tipo ="$kind"');

    // Fast way to generate a list from a
    List<ScanModel> list =
        res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];

    return list;
  }

  // Await update registers
  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.update('Scans', newScan.toJson(),
        where: 'id = ?', whereArgs: [newScan.id]);

    return res;
  }

  //Delete register by id
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  // Delete all
  Future<int> deleteAllScan() async {
    final db = await database;
    final res = await db.delete('Scans');

    return res;
  }
}
