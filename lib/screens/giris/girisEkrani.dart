import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanlas/constants.dart';
import 'package:tanlas/models/mysql.dart';
import 'package:tanlas/models/oturumdao.dart';
import 'package:tanlas/screens/appBar.dart';
import 'package:tanlas/screens/giris/kayitEkrani.dart';
import 'package:tanlas/screens/home/components/header.dart';
import 'package:tanlas/screens/home/components/home_screen.dart';

class girisEkrani extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _girisEkraniState createState() => _girisEkraniState();
}

class _girisEkraniState extends State<girisEkrani> {
  late TextEditingController telctrl, pasctrl;
  var db = new Mysql();
  bool parolaDurumu = true;

  void initState() {
    // TODO: implement initState
    super.initState();
    telctrl = new TextEditingController();
    pasctrl = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: ApplicationToolbar("0", ""),
      body: Column(
        children: [
          Header(size: size),
          //tel no
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: SizedBox(
              width: 300,
              child: TextField(
                controller: telctrl,
                style: TextStyle(color: kTextColor_icerik),
                obscureText: false,
                decoration: InputDecoration(
                    labelText: "Telefon Numaranız",
                    prefixIcon: Icon(Icons.contact_phone_outlined),
                    hintText: "0541564....",
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: SizedBox(
              width: 300,
              child: TextField(
                controller: pasctrl,
                style: TextStyle(color: kTextColor_icerik),
                obscureText: parolaDurumu,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.vpn_key_outlined),
                    hintText: "Parolanız...",
                    suffixIcon: IconButton(
                      icon: parolaDurumu
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () =>
                          setState(() => parolaDurumu = !parolaDurumu),
                    )),
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
          Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: 300,
                    child: GestureDetector(
                      child: Text(
                        "Hesabınız yoksa buradan kayıt olabilirsiniz!",
                        style: TextStyle(color: kTextColor_icerik),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => kayitEkrani()));
                      },
                    ),
                  ),
                ),
              ])
        ],
      ),
    );
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

  Future<void> oturumAc(musteriid) async {
    await Oturumdao().oturumkAYDET(musteriid);
  }
}
