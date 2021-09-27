import 'package:flutter/material.dart';
import 'package:tanlas/models/mysql.dart';
import 'package:tanlas/screens/ayarlar/ayarlar.dart';

class KullanicibilgileriDuzenle extends StatefulWidget {
  String musteriid;
  String musteriadsoyad;
  String musteritelefon;
  String musteriparola;

  KullanicibilgileriDuzenle(this.musteriid, this.musteriadsoyad,
      this.musteritelefon, this.musteriparola);

  @override
  _KullanicibilgileriDuzenleState createState() =>
      _KullanicibilgileriDuzenleState();
}

class _KullanicibilgileriDuzenleState extends State<KullanicibilgileriDuzenle> {
  late TextEditingController musteriadY, musteritelY;

  void initState() {
    // TODO: implement initState
    super.initState();
    // Do something
    musteriadY = new TextEditingController();
    musteritelY = new TextEditingController();
  }

  var db = new Mysql();

  var randevuTarih;
  var randevuSaat;

  void _setMusteri() {
    db.getConnection().then((conn) {
      conn.query('update musteri set adsoyad=? where id=?',
          [musteriadY.value.text, int.parse(widget.musteriid)]);

      conn.query('update musteri set telefon=? where id=?',
          [musteritelY.value.text, int.parse(widget.musteriid)]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter demo",
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Text(
                        "${widget.musteriadsoyad}",
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Ayarlar(widget.musteriid, "")));
                      },
                      icon: Icon(Icons.person_pin),
                      iconSize: 28,
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
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
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 200,
                              child: TextField(
                                controller: musteriadY,
                                decoration: InputDecoration(
                                  hintText: "${widget.musteriadsoyad}",
                                ),
                              ),
                            ),
                          ),
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
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 200,
                              child: TextField(
                                controller: musteritelY,
                                decoration: InputDecoration(
                                  hintText: "${widget.musteritelefon}",
                                ),
                              ),
                            ),
                          ),
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
                                _setMusteri();
                              })
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
