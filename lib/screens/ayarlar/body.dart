import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanlas/models/mysql.dart';
import 'package:tanlas/models/oturumdao.dart';
import 'package:tanlas/screens/header_icerik.dart';
import 'package:tanlas/screens/home/components/home_screen.dart';
import 'package:tanlas/screens/kullaniciBilgileri/kullaniciBilgileri.dart';
import 'package:tanlas/screens/randevularim/randevularim.dart';

class Body extends StatefulWidget {
  String musteriid;
  String musteriad;

  Body(this.musteriid, this.musteriad);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // void _getRandevuId() {
  //   db.getConnection().then((conn) {
  //     conn
  //         .query(
  //             'select *from musteri where id="${widget.musteriid.toString()}"')
  //         .then((results) {
  //       for (var row2 in results) {
  //         setState(() {
  //           musteriad = row2["adsoyad"].toString();
  //         });
  //       }
  //     });
  //   });
  // }

  Future<void> oturumuKapat(musteriid) async {
    await Oturumdao().oturumKapat(musteriid);
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    //Future.delayed(Duration(milliseconds: 100), () {
    // Do something
    //_getRandevuId();
    //});
  }

  var db = new Mysql();
  var musteriad;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Column(
      children: <Widget>[
        Header_icerik(size: size),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
                child: Text("Randevularım"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Randevularim(
                              widget.musteriid, widget.musteriad)));
                }),
            ElevatedButton(
                child: Text("Kullanıcı Bilgilerim"),
                onPressed: () {
                  // kullanıcı bilgileri
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => KullaniciBilgileri(
                              widget.musteriid, widget.musteriad)));
                }),
            ElevatedButton(
                child: Text("ÇIKIŞ"),
                onPressed: () {
                  // kullanıcı bilgileri
                  oturumuKapat(widget.musteriid);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
            ElevatedButton(
                child: Text("Ana sayfa"),
                onPressed: () {
                  // kullanıcı bilgileri
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                })
          ],
        ),
      ],
    ));
  }
}
