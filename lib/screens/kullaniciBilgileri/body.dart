import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanlas/constants.dart';
import 'package:tanlas/kullanicibilgileriDuzenle.dart';
import 'package:tanlas/models/mysql.dart';
import 'package:tanlas/screens/header_icerik.dart';

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

  musteriGetir(this.musteriadsoyad, this.musteritelefon, this.musteriparola,
      this.musteriid);

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
                                builder: (context) => KullanicibilgileriDuzenle(
                                    musteriid,
                                    musteriadsoyad,
                                    musteritelefon,
                                    musteriparola)));
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
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            musteriGetir(
                widget.musteriad, musteritel, musteriparola, widget.musteriid),
          ],
        ),
      ],
    ));
  }
}
