import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanlas/constants.dart';
import 'package:tanlas/models/mysql.dart';
import 'package:tanlas/models/oturumdao.dart';
import 'package:tanlas/screens/ayarlar/ayarlar.dart';
import 'package:tanlas/screens/giris/girisEkrani.dart';
import 'package:tanlas/screens/home/components/body.dart';

class HomeScreen extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var db = new Mysql();
  var musteriad = "";
  String musteriid = "0";

  @override
  initState() {
    super.initState();
    oturumGoster();
    Future.delayed(Duration(milliseconds: 200), () {
      // Do something

      _getMusteriAd();
    });
  }

  Future<void> oturumGoster() async {
    var iterable = await Oturumdao().tumOturum();

    for (var k in iterable) {
      setState(() {
        musteriid = k.musteriid.toString();
      });
    }
  }

  void _getMusteriAd() {
    db.getConnection().then((conn) {
      conn
          .query('select *from musteri where id="${musteriid.toString()}"')
          .then((results) {
        for (var row2 in results) {
          setState(() {
            musteriad = row2["adsoyad"].toString();
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: Icon(Icons.person_pin),
          onPressed: () {
            if (musteriid != "0") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Ayarlar(musteriid, musteriad)));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => girisEkrani()));
            }
          },
        ),
        leadingWidth: 20,
        title: GestureDetector(
          onTap: () {
            if (musteriid != "0") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Ayarlar(musteriid, musteriad)));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => girisEkrani()));
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  giris(musteriid, musteriad),
                ],
              )
            ],
          ),
        ),
        elevation: 0,
      ),
      body: Body(musteriid, musteriad),
    );
  }
}

class giris extends StatelessWidget {
  String musteriid;
  String musteriad;

  giris(this.musteriid, this.musteriad);
  var db = new Mysql();

  @override
  Widget build(BuildContext context) {
    Future<void> oturumGoster() async {
      var iterable = await Oturumdao().tumOturum();

      for (var k in iterable) {
        setState(() {
          musteriid = k.musteriid.toString();
        });
      }
    }

    void _getMusteriAd() {
      db.getConnection().then((conn) {
        conn
            .query('select *from musteri where id="${musteriid.toString()}"')
            .then((results) {
          for (var row2 in results) {
            setState(() {
              musteriad = row2["adsoyad"].toString();
            });
          }
        });
      });
    }

    if (musteriid != "0") {
      oturumGoster();
      _getMusteriAd();
      return Text("Hoşgeldiniz, ${musteriad.toString()}");
    } else {
      return Text("Giriş yap / Kayıt ol");
    }
  }

  void setState(Null Function() param0) {}
}
