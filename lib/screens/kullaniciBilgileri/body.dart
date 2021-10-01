import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:tanlas/constants.dart';
import 'package:tanlas/models/mysql.dart';
import 'package:tanlas/screens/header_icerik.dart';
import 'package:tanlas/screens/kullaniciBilgileri/kullaniciBilgileriDuzenle.dart';

class Body extends StatefulWidget {
  String musteriid;
  String musteriad;

  Body(this.musteriid, this.musteriad);

  @override
  _BodyState createState() => _BodyState();
}

class musteriGetir extends StatelessWidget {
  var db = new Mysql();
  var musteriadsoyad;
  var musteritelefon;
  var musteriparola;
  var musteriid;
  var lastikMarka;
  var jantcap;
  var taban;
  var kesitorani;
  var hizKodu;
  var yuzendeks;
  var mevsim;

  musteriGetir(
      this.musteriadsoyad,
      this.musteritelefon,
      this.musteriparola,
      this.musteriid,
      this.lastikMarka,
      this.jantcap,
      this.taban,
      this.kesitorani,
      this.hizKodu,
      this.yuzendeks,
      this.mevsim);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Ad Soyad :",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kTextColor_icerik),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      " ${musteriadsoyad.toString()}",
                      style: TextStyle(fontSize: 18, color: kTextColor_icerik),
                    ),
                  )
                ],
              )
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Telefon :",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kTextColor_icerik),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      " ${musteritelefon.toString()}",
                      style: TextStyle(fontSize: 18, color: kTextColor_icerik),
                    ),
                  )
                ],
              )
            ],
          ),
          Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                      child: Text("Bilgileri Düzenle"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => KullaniciBilgileriDuzenle(
                                    musteriid,
                                    musteriadsoyad,
                                    musteritelefon,
                                    musteriparola,
                                    lastikMarka,
                                    jantcap,
                                    taban,
                                    kesitorani,
                                    hizKodu,
                                    yuzendeks,
                                    mevsim)));
                      })
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _BodyState extends State<Body> {
  void initState() {
    // TODO: implement initState
    super.initState();
    // Do something
    Future.delayed(Duration(milliseconds: 225), () {
      // Do something
      _getKullanici();
    });
  }

  var db = new Mysql();
  var musteriad;
  var musteritel;
  var musteriparola;
  var lastikMarka;
  var jantcap;
  var taban;
  var kesitorani;
  var hizKodu;
  var yuzendeks;
  var mevsim;
  var hasan;

  var randevuDurum = "5";
  var randevuTarih;
  var randevuSaat;

  void _getKullanici() {
    db.getConnection().then((conn) {
      conn
          .query(
              'select *from musteri where id="${widget.musteriid.toString()}"')
          .then((results) {
        for (var row2 in results) {
          setState(() {
            musteritel = row2["telefon"].toString();
            musteriparola = row2["parola"].toString();
          });
        }
      });

      conn.query("SELECT jantcap from tanim_lastik").then((results) {
        List<Map<String, dynamic>> maps = results as List<Map<String, dynamic>>;
        List.generate(maps.length, (i) {
          var satir = maps[i];
          setState(() {
            hasan = satir[1].toString();
          });
        });
      });

      conn
          .query(
              'select *from musteri_arac_lastik where lastikno="1" and musteriid="${widget.musteriid.toString()}"')
          .then((results) {
        for (var row3 in results) {
          setState(() {
            lastikMarka = row3["marka"].toString();
            jantcap = row3["jantcap"].toString();
            taban = row3["tabangenislik"].toString();
            kesitorani = row3["kesitoran"].toString();
            hizKodu = row3["hizkodu"].toString();
            yuzendeks = row3["yuzendeks"].toString();
            mevsim = row3["mevsim"].toString();
          });
        }
      });
    });
  }

  void getRandevuSil() {
    db.getConnection().then((conn) {
      conn.query(
          'update servis_hareketler set iptal="2" where randevu="1" and musteriid="${widget.musteriid.toString()}"');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Column(
      children: <Widget>[
        Header_icerik(size: size),
        ListTile(
          title: hasan,
            : kTextColor_icerik,
        ),
        Text(
          hasan.toString(),
          style: TextStyle(color: kTextColor_icerik),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            musteriGetir(
                widget.musteriad,
                musteritel,
                musteriparola,
                widget.musteriid,
                lastikMarka,
                jantcap,
                taban,
                kesitorani,
                hizKodu,
                yuzendeks,
                mevsim),
          ],
        ),
      ],
    ));
  }
}
