import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class veritabaniYardimcisi {
  static final String veritabaniAdi = "veritabani.sqlite";

  static Future<Database> veritabaniErisim() async {
    String veritabaniyolu = join(await getDatabasesPath(), veritabaniAdi);

    if (await databaseExists(veritabaniyolu)) {
      print("Veri tabanı zaten var kopyalamaya gerek yok.");
      print("veritabanı kopyalandı");
    } else {
      ByteData data = await rootBundle.load("assets/veritabani/$veritabaniAdi");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(veritabaniyolu).writeAsBytes(bytes, flush: true);
      print("veritabanı kopyalandı");
    }
    return openDatabase(veritabaniyolu);
  }
}
