import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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

class _BodyState extends State<Body> {
  void initState() {
    // TODO: implement initState
    super.initState();
    // Do something
    Future.delayed(Duration(milliseconds: 50), () {
      // Do something
      _getKullanici();
    });
  }

  var db = new Mysql();
  var musteritel;
  var musteriparola;
  var lastikMarka = "";
  var jantcap = "";
  var taban = "";
  var kesitorani = "";
  var hizKodu = "";
  var yuzendeks = "";
  var mevsim = "";

  var arac = "";
  var marka = "";
  var seri = "";
  var model = "";

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

      conn
          .query(
              'select *from musteriarac where musteriid="${widget.musteriid.toString()}"')
          .then((results) {
        for (var row2 in results) {
          setState(() {
            arac = row2["arac"].toString();
            marka = row2["marka"].toString();
            seri = row2["seri"].toString();
            model = row2["model"].toString();
          });
        }
      });

      conn
          .query(
              'select *from musteri_arac_lastik where musteriid="${widget.musteriid.toString()}"')
          .then((results) {
        for (var row3 in results) {
          setState(() {
            lastikMarka = row3["lastikmarka"].toString();
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
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            baslik(
              yazi: "Kişisel Bilgileriniz",
            ),
            Padding(
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
                              " ${widget.musteriad.toString()}",
                              style: TextStyle(
                                  fontSize: 18, color: kTextColor_icerik),
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
                              " ${musteritel.toString()}",
                              style: TextStyle(
                                  fontSize: 18, color: kTextColor_icerik),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            baslik(
              yazi: "Aracınızın Bilgileri",
            ),
            AracBil(data: marka, yazi: "Marka        : "),
            AracBil(data: seri, yazi: "Seri            : "),
            AracBil(data: model, yazi: "Model        : "),
            baslik(
              yazi: "Lastiğinizin Bilgileri",
            ),
            LastikBil(data: lastikMarka, yazi: "Marka                      : "),
            LastikBil(data: jantcap, yazi: "Jant Çapı                : "),
            LastikBil(data: taban, yazi: "Taban Genişliği     : "),
            LastikBil(data: kesitorani, yazi: "Kesit Oranı             : "),
            LastikBil(data: hizKodu, yazi: "Hız Kodu                 : "),
            LastikBil(data: yuzendeks, yazi: "Yüz Endeks            : "),
            LastikBil(data: mevsim, yazi: "Mevsim                   : "),
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
                                  widget.musteriid,
                                  widget.musteriad,
                                  musteritel,
                                  musteriparola,
                                  lastikMarka,
                                  jantcap,
                                  taban,
                                  kesitorani,
                                  hizKodu,
                                  yuzendeks,
                                  mevsim,
                                  marka,
                                  seri,
                                  model)));
                    })
              ],
            )
          ],
        )
      ],
    ));
  }
}

class LastikBil extends StatelessWidget {
  const LastikBil({
    Key? key,
    required this.data,
    required this.yazi,
  }) : super(key: key);

  final String data;
  final String yazi;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: kDefultPadding, bottom: kDefultPadding / 2),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                yazi,
                style: TextStyle(
                    color: kTextColor_icerik,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )
            ],
          ),
          Column(
            children: [
              Text(
                data,
                style: TextStyle(color: kTextColor_icerik, fontSize: 16),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class AracBil extends StatelessWidget {
  const AracBil({
    Key? key,
    required this.data,
    required this.yazi,
  }) : super(key: key);

  final String data;
  final String yazi;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: kDefultPadding, bottom: kDefultPadding / 2),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                yazi,
                style: TextStyle(
                    color: kTextColor_icerik,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )
            ],
          ),
          Column(
            children: [
              Text(
                data,
                style: TextStyle(color: kTextColor_icerik, fontSize: 16),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class baslik extends StatelessWidget {
  const baslik({
    Key? key,
    required this.yazi,
  }) : super(key: key);

  final String yazi;

  @override
  Widget build(BuildContext context) {
    return Text(
      yazi,
      style: TextStyle(
          color: kTextColor_icerik, fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}
