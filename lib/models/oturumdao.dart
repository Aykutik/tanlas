import 'package:flutter/cupertino.dart';
import 'package:tanlas/models/oturum.dart';
import 'package:tanlas/models/veritabaniYardimisi.dart';

class Oturumdao {
  Future<List<Oturum>> tumOturum() async {
    var db = await veritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT *from oturum");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Oturum(satir["musteriid"]);
    });
  }

  Future<void> oturumGuncelle(int musteriid, String oturum) async {
    var db = await veritabaniYardimcisi.veritabaniErisim();

    var bilgiler = Map<String, dynamic>();
    bilgiler["oturum"] = oturum;

    await db.update("oturum", bilgiler, where: "id=?", whereArgs: [musteriid]);
  }

  Future<void> oturumkAYDET(String musteriid) async {
    var db = await veritabaniYardimcisi.veritabaniErisim();

    var bilgiler = Map<String, dynamic>();
    bilgiler["musteriid"] = musteriid;

    await db.insert("oturum", bilgiler);
  }

  Future<void> oturumKapat(String musteriid) async {
    var db = await veritabaniYardimcisi.veritabaniErisim();
    await db.delete("oturum", where: "musteriid=?", whereArgs: [musteriid]);
  }
}
