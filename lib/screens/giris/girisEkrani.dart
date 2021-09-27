import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanlas/models/mysql.dart';
import 'package:tanlas/models/oturumdao.dart';
import 'package:tanlas/screens/appBar.dart';
import 'package:tanlas/screens/home/components/home_screen.dart';

class girisEkrani extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _girisEkraniState createState() => _girisEkraniState();
}

class _girisEkraniState extends State<girisEkrani> {
  late TextEditingController telctrl, pasctrl;
  var db = new Mysql();

  void initState() {
    // TODO: implement initState
    super.initState();
    telctrl = new TextEditingController();
    pasctrl = new TextEditingController();
  }

  Future<void> oturumAc(musteriid) async {
    await Oturumdao().oturumkAYDET(musteriid);
  }

  void _girisKontrol() {
    var musteriid;
    db.getConnection().then((conn) {
      String sql =
          "select *from musteri where telefon=${telctrl.value.text.toString()} and parola=${pasctrl.value.text.toString()}";
      conn.query(sql).then((results) {
        if (results.isEmpty != true) {
          for (var row in results) {
            // şifre doğru gerekeni yap....
            musteriid = row[5].toString();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
            oturumAc(musteriid);
          }
        } else {
          // şifre yanlış
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Şifre veya Telefon hatalı!"),
                  content: Text(
                      "Lütfen parolanızı ve telefon numaranızı kontrol edin!"),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Tamam"),
                    )
                  ],
                );
              });
        }
        //
      });
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationToolbar("0", ""),
      body: Column(
        children: [
          //tel no
          SizedBox(
            width: 300,
            child: TextField(
              controller: telctrl,
              obscureText: false,
              decoration: InputDecoration(
                icon: Icon(Icons.contact_phone_outlined),
                hintText: "0541564....",
              ),
            ),
          ),
          SizedBox(
            width: 300,
            child: TextField(
              controller: pasctrl,
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.vpn_key_outlined),
                hintText: "Parolanız...",
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: ElevatedButton(
              child: Text("Giriş"),
              onPressed: () {
                _girisKontrol();
                //_girisKontrol2();
              },
            ),
          ),
        ],
      ),
    );
  }
}
