import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:tanlas/constants.dart';
import 'package:tanlas/models/mysql.dart';
import 'package:tanlas/screens/header_icerik.dart';

class BodyBasarili extends StatefulWidget {
  String musteriid;
  String musteriad;
  String randevuTarihi;
  String randevuSaati;

  BodyBasarili(
      this.musteriid, this.musteriad, this.randevuTarihi, this.randevuSaati);

  @override
  _BodyBasariliState createState() => _BodyBasariliState();
}

class _BodyBasariliState extends State<BodyBasarili> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 800), () {
      // Do something
      _getRandevuId();
    });
  }

  var db = new Mysql();
  var randevuId = "";
  var formatter = new DateFormat("dd.MM.yyyy");
  var randevuTarihGoster;

  void _getRandevuId() {
    db.getConnection().then((conn) {
      conn
          .query(
              'select *from servis_hareketler where tarih="${widget.randevuTarihi}" and musteriid="${widget.musteriid.toString()}"')
          .then((results) {
        for (var row in results) {
          setState(() {
            randevuId = row["id"].toString();
            randevuTarihGoster = formatter.format(row["tarih"]);
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
        Padding(
          padding: const EdgeInsets.all(kDefultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(kDefultPadding),
                child: Image.asset("assets/icon/checked2.png",
                    width: 130, height: 130.0),
              ),
              Padding(
                padding: const EdgeInsets.all(kDefultPadding),
                child: Text("Randevu Başarıyla Alındı.",
                    style: TextStyle(
                        color: kTextColor_icerik,
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    RichText(
                        text: TextSpan(
                            text: "Randevu Tarihi:  ",
                            style: TextStyle(
                                color: kTextColor_icerik,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                          TextSpan(
                              text: randevuTarihGoster.toString(),
                              style: TextStyle(
                                  color: kTextColor_icerik,
                                  fontWeight: FontWeight.normal))
                        ])),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    RichText(
                        text: TextSpan(
                            text: "Randevu Saati:  ",
                            style: TextStyle(
                                color: kTextColor_icerik,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                          TextSpan(
                              text: "${widget.randevuSaati}",
                              style: TextStyle(
                                  color: kTextColor_icerik,
                                  fontWeight: FontWeight.normal))
                        ])),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    RichText(
                        text: TextSpan(
                            text: "Randevu No:  ",
                            style: TextStyle(
                                color: kTextColor_icerik,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                          TextSpan(
                              text: "S${randevuId.toString()}",
                              style: TextStyle(
                                  color: kTextColor_icerik,
                                  fontWeight: FontWeight.normal))
                        ]))
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
