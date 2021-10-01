import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:tanlas/constants.dart';
import 'package:tanlas/models/Oturum.dart';
import 'package:tanlas/models/mysql.dart';
import 'package:tanlas/screens/ayarlar/ayarlar.dart';
import 'package:tanlas/screens/giris/girisEkrani.dart';
import 'package:tanlas/screens/header_icerik.dart';

class KullaniciBilgileriDuzenle extends StatefulWidget {
  // This widget is the root of your application.
  String musteriid;
  String musteriad;
  String musteritelefon;
  String musteriparola;
  String lastikMarka;
  String jantcap;
  String taban;
  String kesitorani;
  String hizKodu;
  String yuzendeks;
  String mevsim;
  KullaniciBilgileriDuzenle(
      this.musteriid,
      this.musteriad,
      this.musteritelefon,
      this.musteriparola,
      this.lastikMarka,
      this.jantcap,
      this.taban,
      this.kesitorani,
      this.hizKodu,
      this.yuzendeks,
      this.mevsim);

  @override
  _KullaniciBilgileriDuzenleState createState() =>
      _KullaniciBilgileriDuzenleState();
}

class _KullaniciBilgileriDuzenleState extends State<KullaniciBilgileriDuzenle> {
  late TextEditingController tfTel,
      tfAd,
      tfParola,
      tfParolaY,
      tfParolaYT,
      tflastikMarka,
      tfJantcap,
      tfTaban,
      tfKesitorani,
      tfHizKodu,
      tfYuzendeks,
      tfMevsim;

  void initState() {
    // TODO: implement initState
    super.initState();
    // Do something
    tfTel = new TextEditingController();
    tfAd = new TextEditingController();
    tfParola = new TextEditingController();
    tfParolaY = new TextEditingController();
    tfParolaYT = new TextEditingController();
    tflastikMarka = new TextEditingController();
    tfJantcap = new TextEditingController();
    tfTaban = new TextEditingController();
    tfKesitorani = new TextEditingController();
    tfHizKodu = new TextEditingController();
    tfYuzendeks = new TextEditingController();
    tfMevsim = new TextEditingController();
    _getjant();
  }

  var db = new Mysql();
  bool parolaDurumu = true;
  var randevuTarih;
  var randevuSaat;
  var _selectedValue;
  var _categories;

  void setMusteri() {
    db.getConnection().then((conn) {
      conn.query('update musteri set adsoyad=? where id=?',
          [tfAd.value.text, int.parse(widget.musteriid)]);

      conn.query('update musteri set telefon=? where id=?',
          [tfTel.value.text, int.parse(widget.musteriid)]);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      tabKullaniciBilgileri(),
      tabAracBilgileri(),
      tabLastikBilgileri(),
    ];
    final _kTabs = <Tab>[
      const Tab(
        text: "Kullanıcı Bilgileri",
      ),
      Tab(
        text: "Araç Bilgileri",
      ),
      Tab(
        text: "Lastik Bilgileri",
      )
    ];
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
        length: _kTabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: GestureDetector(
              onTap: () {
                if (widget.musteriid != "0") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Ayarlar(widget.musteriid, widget.musteriad)));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => girisEkrani()));
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      giris(widget.musteriid, widget.musteriad),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.person_pin),
                        onPressed: () {
                          if (widget.musteriid != "0") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Ayarlar(
                                        widget.musteriid, widget.musteriad)));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => girisEkrani()));
                          }
                        },
                      ),
                    ],
                  ),
                  Header_icerik(size: size),
                ],
              ),
            ),
            backgroundColor: Colors.red,
            bottom: TabBar(
              tabs: _kTabs,
            ),
          ),
          body: TabBarView(children: _kTabPages),
        ));
  }

  void _getjant() {
    db.getConnection().then((conn) {
      conn.query("SELECT *from tanim_lastik").then((results) {
        List<Map<String, dynamic>> maps = results as List<Map<String, dynamic>>;
        List.generate(maps.length, (i) {
          var satir = maps[i];
        });
      });
    });
  }

  Column tabLastikBilgileri() {
    return Column(children: [
      Padding(
        //marka
        padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
        child: SizedBox(
          width: 300,
          height: 45,
          child: TextField(
            controller: tflastikMarka,
            style: TextStyle(color: kTextColor_icerik),
            obscureText: false,
            decoration: InputDecoration(
                labelText: "Marka : ${widget.lastikMarka}",
                prefixIcon: Icon(Icons.auto_awesome),
                hintText: widget.lastikMarka,
                border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
          ),
        ),
      ),
      Padding(
        //Cap
        padding: const EdgeInsets.only(bottom: 10.0),
        child: SizedBox(
          width: 300,
          height: 45,
          child: TextField(
            controller: tfJantcap,
            style: TextStyle(color: kTextColor_icerik),
            obscureText: false,
            decoration: InputDecoration(
                labelText: "Jant Çapı : ${widget.jantcap}",
                prefixIcon: Icon(Icons.architecture_rounded),
                hintText: "${widget.jantcap}",
                hintStyle: TextStyle(color: kTextColor_icerik),
                border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
          ),
        ),
      ),
      Padding(
        //Cap
        padding: const EdgeInsets.only(bottom: 10.0),
        child: SizedBox(
          width: 300,
          height: 45,
          child: TextField(
            controller: tfTaban,
            style: TextStyle(color: kTextColor_icerik),
            obscureText: false,
            decoration: InputDecoration(
                labelText: "Taban Geişliği : ${widget.taban}",
                prefixIcon: Icon(Icons.architecture_rounded),
                hintText: "${widget.taban}",
                hintStyle: TextStyle(color: kTextColor_icerik),
                border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
          ),
        ),
      ),
      Padding(
        //Cap
        padding: const EdgeInsets.only(bottom: 10.0),
        child: SizedBox(
          width: 300,
          height: 45,
          child: TextField(
            controller: tfKesitorani,
            style: TextStyle(color: kTextColor_icerik),
            obscureText: false,
            decoration: InputDecoration(
                labelText: "Kesit Oranı : ${widget.kesitorani}",
                prefixIcon: Icon(Icons.architecture_rounded),
                hintText: "${widget.kesitorani}",
                hintStyle: TextStyle(color: kTextColor_icerik),
                border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
          ),
        ),
      ),
      Padding(
        //Cap
        padding: const EdgeInsets.only(bottom: 10.0),
        child: SizedBox(width: 300, height: 45, child: Text("sd")),
      ),
      Padding(
        //Cap
        padding: const EdgeInsets.only(bottom: 10.0),
        child: SizedBox(
          width: 300,
          height: 45,
          child: TextField(
            controller: tfYuzendeks,
            style: TextStyle(color: kTextColor_icerik),
            obscureText: false,
            decoration: InputDecoration(
                labelText: "Yüz Endeks : ${widget.yuzendeks}",
                prefixIcon: Icon(Icons.architecture_rounded),
                hintText: "${widget.yuzendeks}",
                hintStyle: TextStyle(color: kTextColor_icerik),
                border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
          ),
        ),
      ),
      Padding(
        //Cap
        padding: const EdgeInsets.only(bottom: 10.0),
        child: SizedBox(
          width: 300,
          height: 45,
          child: TextField(
            controller: tfMevsim,
            style: TextStyle(color: kTextColor_icerik),
            obscureText: false,
            decoration: InputDecoration(
                labelText: "Mevsim : ${widget.mevsim}",
                prefixIcon: Icon(Icons.architecture_rounded),
                hintText: "${widget.mevsim}",
                hintStyle: TextStyle(color: kTextColor_icerik),
                border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
          ),
        ),
      ),
    ]);
  }

  Center tabAracBilgileri() {
    return const Center(
      child: Text(
        "2",
        style: TextStyle(color: kTextColor_icerik),
      ),
    );
  }

  Column tabKullaniciBilgileri() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
          child: SizedBox(
            width: 300,
            height: 45,
            child: TextField(
              controller: tfTel,
              style: TextStyle(color: kTextColor_icerik),
              obscureText: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.contact_phone_outlined),
                  hintText: widget.musteritelefon,
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
              controller: tfParola,
              style: TextStyle(color: kTextColor_icerik),
              obscureText: parolaDurumu,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.vpn_key_outlined),
                  hintText: "Guncel Parolanız",
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
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: SizedBox(
            width: 300,
            child: TextField(
              controller: tfParolaY,
              style: TextStyle(color: kTextColor_icerik),
              obscureText: parolaDurumu,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.vpn_key_outlined),
                  hintText: "Yeni Parolanız",
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
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: SizedBox(
            width: 300,
            child: TextField(
              controller: tfParolaYT,
              style: TextStyle(color: kTextColor_icerik),
              obscureText: parolaDurumu,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.vpn_key_outlined),
                  hintText: "Yeni Parolanız Tekrar",
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
      ],
    );
  }
}

class giris extends StatelessWidget {
  String musteriid;
  String musteriad;

  giris(this.musteriid, this.musteriad);

  @override
  Widget build(BuildContext context) {
    if (musteriid != "0") {
      return Text("Hoşgeldiniz, ${musteriad.toString()}");
    } else {
      return Text("Giriş yap / Kayıt ol");
    }
  }
}
