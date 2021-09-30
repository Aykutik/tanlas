import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanlas/constants.dart';
import 'package:tanlas/models/mysql.dart';
import 'package:tanlas/screens/appBar.dart';
import 'package:tanlas/screens/header_icerik.dart';
import 'package:tanlas/screens/home/components/header.dart';

class kayitEkrani extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _kayitEkraniState createState() => _kayitEkraniState();
}

class _kayitEkraniState extends State<kayitEkrani> {
  late TextEditingController adsoyad, telefon, eposta, parola;
  bool parolaDurumu = true;

  void initState() {
    // TODO: implement initState
    super.initState();
    adsoyad = new TextEditingController();
    telefon = new TextEditingController();
    eposta = new TextEditingController();
    parola = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: ApplicationToolbar("0", ""),
      body: Column(
        children: [
          Header_icerik(size: size),
          Column(
            children: [
              Column(
                children: [
                  Kutucuk(
                    adsoyad: adsoyad,
                    yazi: "Adınız Soyadınız",
                    gorsel: Icons.person,
                    yaziayari: TextInputType.name,
                  ),
                  Kutucuk(
                    adsoyad: telefon,
                    yazi: "Telefon Numaranız",
                    gorsel: Icons.tablet_mac_outlined,
                    yaziayari: TextInputType.phone,
                  ),
                  Kutucuk(
                    adsoyad: eposta,
                    yazi: "E-posta hesabınız",
                    gorsel: Icons.email,
                    yaziayari: TextInputType.emailAddress,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SizedBox(
                      width: 300,
                      child: TextField(
                        style: TextStyle(color: kTextColor_icerik),
                        controller: adsoyad,
                        decoration: InputDecoration(
                          labelText: "Parolanız",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: parolaDurumu
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () =>
                                setState(() => parolaDurumu = !parolaDurumu),
                          ),
                        ),
                        obscureText: parolaDurumu,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      child: Text("Kaydol"),
                      onPressed: () {
                        kayit(
                            adsoyad.value.text.toString(),
                            telefon.value.text.toString(),
                            eposta.value.text.toString());
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

void kayit(String adsoyad, String telefon, String eposta) {
  var db = new Mysql();
  db.getConnection().then((conn) {
    conn.query("insert into musteri (adsoyad,telefon,eposta) values (?,?,?)", [
      adsoyad, //adsoyad
      telefon, //telefon
      eposta, //eposta
    ]);
  });
}

class Kutucuk extends StatelessWidget {
  const Kutucuk({
    Key? key,
    required this.adsoyad,
    required this.yazi,
    required this.gorsel,
    required this.yaziayari,
  }) : super(key: key);

  final TextEditingController adsoyad;
  final String yazi;
  final IconData gorsel;
  final TextInputType yaziayari;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        width: 300,
        child: TextField(
          style: TextStyle(color: kTextColor_icerik),
          controller: adsoyad,
          decoration: InputDecoration(
            labelText: yazi,
            border: OutlineInputBorder(),
            prefixIcon: Icon(gorsel),
          ),
          keyboardType: yaziayari,
        ),
      ),
    );
  }
}
