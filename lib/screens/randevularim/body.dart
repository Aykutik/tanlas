import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tanlas/constants.dart';
import 'package:tanlas/models/mysql.dart';
import 'package:tanlas/screens/header_icerik.dart';
import 'package:tanlas/screens/randevularim/randevularim.dart';

class Body extends StatefulWidget {
  String musteriid;
  String musteriad;

  Body(this.musteriid, this.musteriad);

  @override
  _BodyState createState() => _BodyState();
}

class randevuKontrol extends StatelessWidget {
  var db = new Mysql();
  var randevuVar = "1";
  var randevuDurum = "5";
  var randevuTarih = "";
  var randevuTarihGoster = "";
  var randevuSaat = "";
  var musteriidR = "";
  var musteriadR = "";

  randevuKontrol(this.randevuDurum, this.randevuTarih, this.randevuTarihGoster,
      this.randevuSaat, this.musteriidR, this.musteriadR);

  @override
  Widget build(BuildContext context) {
    if (randevuDurum == "5") {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 20.0),
            child: Text("Aktif randevunuz bulunmamaktadır.",
                style: TextStyle(color: kTextColor_icerik)),
          ),
          ElevatedButton(onPressed: () {}, child: Text("Ana Sayfa")),
          ElevatedButton(onPressed: () {}, child: Text("Randevu Al")),
        ],
      );
    } else {
      if (randevuDurum == "1") {
        return ListTile(
          leading: Icon(Icons.more_time),
          title: Text("Randevu Tarihi: ${randevuTarihGoster.toString()}",
              style: TextStyle(
                  color: kTextColor_icerik, fontWeight: FontWeight.bold)),
          subtitle: Text("Saat: ${randevuSaat.toString().substring(0, 5)}",
              style: TextStyle(color: kTextColor_icerik)),
          trailing: ElevatedButton(
            child: Text("İptal et"),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Randevu Sil",
                          style: TextStyle(color: kTextColor_icerik)),
                      content: Text(
                          "Randevu silinecek, bu işlem geri alınamaz! Onaylıyor musunuz?",
                          style: TextStyle(color: kTextColor_icerik)),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            // sil
                            db.getConnection().then((conn) {
                              conn.query(
                                  'update servis_hareketler set randevu="2" where randevu="1" and musteriid="${musteriidR.toString()}"');

                              for (var i = 1; i < 11; i++) {
                                if (i == 1) {
                                  conn.query(
                                      'update tarih set bir="" where tarih="${randevuTarih.toString()}" and bir="${musteriidR.toString()}"');
                                }
                                if (i == 2) {
                                  conn.query(
                                      'update tarih set iki="" where tarih="${randevuTarih.toString()}" and iki="${musteriidR.toString()}"');
                                }
                                if (i == 3) {
                                  conn.query(
                                      'update tarih set uc="" where tarih="${randevuTarih.toString()}" and uc="${musteriidR.toString()}"');
                                }
                                if (i == 4) {
                                  conn.query(
                                      'update tarih set dort="" where tarih="${randevuTarih.toString()}" and dort="${musteriidR.toString()}"');
                                }
                                if (i == 5) {
                                  conn.query(
                                      'update tarih set bes="" where tarih="${randevuTarih.toString()}" and bes="${musteriidR.toString()}"');
                                }
                                if (i == 6) {
                                  conn.query(
                                      'update tarih set alti="" where tarih="${randevuTarih.toString()}" and alti="${musteriidR.toString()}"');
                                }
                                if (i == 7) {
                                  conn.query(
                                      'update tarih set yedi="" where tarih="${randevuTarih.toString()}" and yedi="${musteriidR.toString()}"');
                                }
                                if (i == 8) {
                                  conn.query(
                                      'update tarih set sekiz="" where tarih="${randevuTarih.toString()}" and sekiz="${musteriidR.toString()}"');
                                }
                                if (i == 9) {
                                  conn.query(
                                      'update tarih set dokuz="" where tarih="${randevuTarih.toString()}" and dokuz="${musteriidR.toString()}"');
                                }
                                if (i == 10) {
                                  conn.query(
                                      'update tarih set onn="" where tarih="${randevuTarih.toString()}" and onn="${musteriidR.toString()}"');
                                }
                              }
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Randevularim(musteriidR, musteriadR)));
                          },
                          child: Text("Randevuyu Sil"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("İptal"),
                        ),
                      ],
                    );
                  });
            },
          ),
          onLongPress: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Randevu Sil",
                        style: TextStyle(color: kTextColor_icerik)),
                    content: Text(
                        "Randevu silinecek, bu işlem geri alınamaz! Onaylıyor musunuz?",
                        style: TextStyle(color: kTextColor_icerik)),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          // sil
                          db.getConnection().then((conn) {
                            conn.query(
                                'update servis_hareketler set randevu="2" where randevu="1" and musteriid="${musteriidR.toString()}"');

                            for (var i = 1; i < 11; i++) {
                              if (i == 1) {
                                conn.query(
                                    'update tarih set bir="" where tarih="${randevuTarih.toString()}" and bir="${musteriidR.toString()}"');
                              }
                              if (i == 2) {
                                conn.query(
                                    'update tarih set iki="" where tarih="${randevuTarih.toString()}" and iki="${musteriidR.toString()}"');
                              }
                              if (i == 3) {
                                conn.query(
                                    'update tarih set uc="" where tarih="${randevuTarih.toString()}" and uc="${musteriidR.toString()}"');
                              }
                              if (i == 4) {
                                conn.query(
                                    'update tarih set dort="" where tarih="${randevuTarih.toString()}" and dort="${musteriidR.toString()}"');
                              }
                              if (i == 5) {
                                conn.query(
                                    'update tarih set bes="" where tarih="${randevuTarih.toString()}" and bes="${musteriidR.toString()}"');
                              }
                              if (i == 6) {
                                conn.query(
                                    'update tarih set alti="" where tarih="${randevuTarih.toString()}" and alti="${musteriidR.toString()}"');
                              }
                              if (i == 7) {
                                conn.query(
                                    'update tarih set yedi="" where tarih="${randevuTarih.toString()}" and yedi="${musteriidR.toString()}"');
                              }
                              if (i == 8) {
                                conn.query(
                                    'update tarih set sekiz="" where tarih="${randevuTarih.toString()}" and sekiz="${musteriidR.toString()}"');
                              }
                              if (i == 9) {
                                conn.query(
                                    'update tarih set dokuz="" where tarih="${randevuTarih.toString()}" and dokuz="${musteriidR.toString()}"');
                              }
                              if (i == 10) {
                                conn.query(
                                    'update tarih set onn="" where tarih="${randevuTarih.toString()}" and onn="${musteriidR.toString()}"');
                              }
                            }
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Randevularim(musteriidR, musteriadR)));
                        },
                        child: Text("Randevuyu Sil"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("İptal"),
                      ),
                    ],
                  );
                });
          },
        );
      } else {
        return Center();
      }
    }
  }
}

class _BodyState extends State<Body> {
  void initState() {
    // TODO: implement initState
    super.initState();
    // Do something
    //Future.delayed(Duration(milliseconds: 100), () {
    // Do something
    //_getRandevuId();
    _getRandevu();
    //});
  }

  var db = new Mysql();
  var musteriad = "";
  var randevuDurum = "5";
  var randevuTarih = "";
  var randevuTarihGoster = "";
  var randevuSaat = "";
  var formatter = new DateFormat("dd.MM.yyyy");

  void _getRandevuId() {
    db.getConnection().then((conn) {
      conn
          .query(
              'select *from musteri where id="${widget.musteriid.toString()}"')
          .then((results) {
        for (var row2 in results) {
          setState(() {
            musteriad = row2["adsoyad"].toString();
          });
        }
      });
    });
  }

  void _getRandevu() {
    db.getConnection().then((conn) {
      conn
          .query(
              'select *from servis_hareketler where randevu="1" and musteriid="${widget.musteriid.toString()}"')
          .then((results) {
        for (var row in results) {
          setState(() {
            randevuDurum = row["randevu"].toString();
            randevuTarihGoster = formatter.format(row["tarih"]);
            randevuTarih = row["tarih"].toString();
            randevuSaat = row["saat"].toString();
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Column(
      children: <Widget>[
        Header_icerik(size: size),
        randevuKontrol(randevuDurum, randevuTarih, randevuTarihGoster,
            randevuSaat, widget.musteriid, widget.musteriad),
      ],
    ));
  }
}
