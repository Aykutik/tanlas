import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanlas/constants.dart';
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

  String marka;
  String seri;
  String model;
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
      this.mevsim,
      this.marka,
      this.seri,
      this.model);

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
    getTanimlar();
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
  }

  var db = new Mysql();
  bool parolaDurumu = true;
  var randevuTarih;
  var randevuSaat;
  var lastikMarka;
  var taban;
  var kesitorani;
  var hizKodu;
  var yuzendeks;
  var mevsim;

  List listLastikMarka = [];
  var _selectedValueMarka;
  List listLastikjantcap = [];
  var _selectedValueJantCap;
  List listLastiktaban = [];
  var _selectedValueTaban;
  List listLastikkesitorani = [];
  var _selectedValueKesit;
  List listLastikhizKodu = [];
  var _selectedValueHizkodu;
  List listLastikyuzendeks = [];
  var _selectedValueYuzEndeks;
  List listLastikmevsim = [];
  var _selectedValueMevsim;

  List listMarka = [];
  var _selectedMarka;
  List listSeri = [];
  var _selectedSeri;
  List listModel = [];
  var _selectedModel;

  void setMusteri() {
    db.getConnection().then((conn) {
      conn.query('update musteri set adsoyad=? where id=?',
          [tfAd.value.text, int.parse(widget.musteriid)]);

      conn.query('update musteri set telefon=? where id=?',
          [tfTel.value.text, int.parse(widget.musteriid)]);
    });
  }

  void getTanimlar() {
    db.getConnection().then((conn) {
      conn.query('select distinct marka from tanim_lastik').then((results) {
        for (var row3 in results) {
          setState(() {
            if (row3["marka"].toString() != "" &&
                row3["marka"].toString() != "null") {
              listLastikMarka.add(row3["marka"].toString());
            }
          });
        }
      });
      conn.query('select distinct jantcap from tanim_lastik').then((results) {
        for (var row3 in results) {
          setState(() {
            if (row3["jantcap"].toString() != "" &&
                row3["jantcap"].toString() != "null") {
              listLastikjantcap.add(row3["jantcap"].toString());
            }
          });
        }
      });
      conn
          .query('select distinct tabangenislik from tanim_lastik')
          .then((results) {
        for (var row3 in results) {
          setState(() {
            if (row3["tabangenislik"].toString() != "" &&
                row3["tabangenislik"].toString() != "null") {
              listLastiktaban.add(["tabangenislik"].toString());
            }
          });
        }
      });
      conn
          .query('select distinct kesitorani from tanim_lastik')
          .then((results) {
        for (var row3 in results) {
          setState(() {
            if (row3["kesitorani"].toString() != "" &&
                row3["kesitorani"].toString() != "null") {
              listLastikkesitorani.add(row3["kesitorani"].toString());
            }
          });
        }
      });
      conn.query('select distinct hizkodu from tanim_lastik').then((results) {
        for (var row3 in results) {
          setState(() {
            if (row3["hizkodu"].toString() != "" &&
                row3["hizkodu"].toString() != "null") {
              listLastikhizKodu.add(row3["hizkodu"].toString());
            }
          });
        }
      });
      conn.query('select distinct yuzendeks from tanim_lastik').then((results) {
        for (var row3 in results) {
          setState(() {
            if (row3["yuzendeks"].toString() != "" &&
                row3["yuzendeks"].toString() != "null") {
              listLastikyuzendeks.add(row3["yuzendeks"].toString());
            }
          });
        }
      });
      conn.query('select distinct mevsim from tanim_lastik').then((results) {
        for (var row3 in results) {
          setState(() {
            if (row3["mevsim"].toString() != "" &&
                row3["mevsim"].toString() != "null") {
              listLastikmevsim.add(row3["mevsim"].toString());
            }
          });
        }
      });

      //Arac bilgileri
      conn.query('select distinct marka from tanim_arac').then((results) {
        for (var row3 in results) {
          setState(() {
            if (row3["marka"].toString() != "" &&
                row3["marka"].toString() != "null") {
              listMarka.add(row3["marka"].toString());
            }
          });
        }
      });
      conn.query('select distinct seri from tanim_arac').then((results) {
        for (var row3 in results) {
          setState(() {
            if (row3["seri"].toString() != "" &&
                row3["seri"].toString() != "null") {
              listSeri.add(row3["seri"].toString());
            }
          });
        }
      });
      conn.query('select distinct model from tanim_arac').then((results) {
        for (var row3 in results) {
          setState(() {
            if (row3["model"].toString() != "" &&
                row3["model"].toString() != "null") {
              listModel.add(row3["model"].toString());
            }
          });
        }
      });
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

  Column tabLastikBilgileri() {
    var genislik = 155.0;
    var yukseklik = 40.0;
    var padding = 20.0;

    String markaYazi = "Marka                      :";
    String jantCapYazi = "Jant Çap Genişliği :";
    String tabanYazi = "Taban Genişliği      :";
    String kesitYazi = "Kesit Ölçüsü           :";
    String hizKoduYazi = "Hız Kodu                 :";
    String yuzEndeksYazi = "Yüz Endeks            :";
    String mevsimYazi = "Mevsim                   :";

    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
            padding: EdgeInsets.all(padding),
            child: Text(markaYazi,
                style: TextStyle(
                    color: kTextColor_icerik,
                    fontSize: 16,
                    fontWeight: FontWeight.bold))),
        Padding(
          padding: EdgeInsets.all(padding / 2),
          child: Column(
            children: [
              Container(
                width: genislik,
                height: yukseklik,
                padding: EdgeInsets.only(left: 16, right: 16), // ic ortalama
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: DropdownButton<String>(
                  hint: DefaultYazii(widget.lastikMarka),
                  value: _selectedValueMarka,
                  items: listLastikMarka
                      .map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        "$value",
                        style: TextStyle(color: kTextColor_icerik),
                      ),
                    );
                  }).toList(),
                  icon: Icon(Icons.arrow_drop_down),
                  onChanged: (dynamic secilenVeri) {
                    setState(() {
                      _selectedValueMarka = secilenVeri;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
            padding: EdgeInsets.all(padding),
            child: Text(jantCapYazi,
                style: TextStyle(
                    color: kTextColor_icerik,
                    fontSize: 16,
                    fontWeight: FontWeight.bold))),
        Padding(
          padding: EdgeInsets.all(padding / 2),
          child: Column(
            children: [
              Container(
                width: genislik,
                height: yukseklik,
                padding: EdgeInsets.only(left: 16, right: 16), // ic ortalama
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: DropdownButton<String>(
                  hint: DefaultYazii(widget.jantcap),
                  value: _selectedValueJantCap,
                  items: listLastikjantcap
                      .map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: kTextColor_icerik),
                      ),
                    );
                  }).toList(),
                  icon: Icon(Icons.arrow_drop_down),
                  onChanged: (dynamic secilenVeri) {
                    setState(() {
                      _selectedValueJantCap = secilenVeri;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
            padding: EdgeInsets.all(padding),
            child: Text(tabanYazi,
                style: TextStyle(
                    color: kTextColor_icerik,
                    fontSize: 16,
                    fontWeight: FontWeight.bold))),
        Padding(
          padding: EdgeInsets.all(padding / 2),
          child: Column(
            children: [
              Container(
                width: genislik,
                height: yukseklik,
                padding: EdgeInsets.only(left: 16, right: 16), // ic ortalama
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: DropdownButton<String>(
                  hint: DefaultYazii(widget.taban),
                  value: _selectedValueTaban,
                  items: listLastiktaban
                      .map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: kTextColor_icerik),
                      ),
                    );
                  }).toList(),
                  icon: Icon(Icons.arrow_drop_down),
                  onChanged: (dynamic secilenVeri) {
                    setState(() {
                      _selectedValueTaban = secilenVeri;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
            padding: EdgeInsets.all(padding),
            child: Text(kesitYazi,
                style: TextStyle(
                    color: kTextColor_icerik,
                    fontSize: 16,
                    fontWeight: FontWeight.bold))),
        Padding(
          padding: EdgeInsets.all(padding / 2),
          child: Column(
            children: [
              Container(
                width: genislik,
                height: yukseklik,
                padding: EdgeInsets.only(left: 16, right: 16), // ic ortalama
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: DropdownButton<String>(
                  hint: DefaultYazii(widget.kesitorani),
                  value: _selectedValueKesit,
                  items: listLastikkesitorani
                      .map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: kTextColor_icerik),
                      ),
                    );
                  }).toList(),
                  icon: Icon(Icons.arrow_drop_down),
                  onChanged: (dynamic secilenVeri) {
                    setState(() {
                      _selectedValueKesit = secilenVeri;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
            padding: EdgeInsets.all(padding),
            child: Text(hizKoduYazi,
                style: TextStyle(
                    color: kTextColor_icerik,
                    fontSize: 16,
                    fontWeight: FontWeight.bold))),
        Padding(
          padding: EdgeInsets.all(padding / 2),
          child: Column(
            children: [
              Container(
                width: genislik,
                height: yukseklik,
                padding: EdgeInsets.only(left: 16, right: 16), // ic ortalama
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: DropdownButton<String>(
                  hint: DefaultYazii(widget.hizKodu),
                  value: _selectedValueHizkodu,
                  items: listLastikhizKodu
                      .map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: kTextColor_icerik),
                      ),
                    );
                  }).toList(),
                  icon: Icon(Icons.arrow_drop_down),
                  onChanged: (dynamic secilenVeri) {
                    setState(() {
                      _selectedValueHizkodu = secilenVeri;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
            padding: EdgeInsets.all(padding),
            child: Text(yuzEndeksYazi,
                style: TextStyle(
                    color: kTextColor_icerik,
                    fontSize: 16,
                    fontWeight: FontWeight.bold))),
        Padding(
          padding: EdgeInsets.all(padding / 2),
          child: Column(
            children: [
              Container(
                width: genislik,
                height: yukseklik,
                padding: EdgeInsets.only(left: 16, right: 16), // ic ortalama
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: DropdownButton<String>(
                  hint: DefaultYazii(widget.yuzendeks),
                  value: _selectedValueYuzEndeks,
                  items: listLastikyuzendeks
                      .map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: kTextColor_icerik),
                      ),
                    );
                  }).toList(),
                  icon: Icon(Icons.arrow_drop_down),
                  onChanged: (dynamic secilenVeri) {
                    setState(() {
                      _selectedValueYuzEndeks = secilenVeri;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
            padding: EdgeInsets.all(padding),
            child: Text(mevsimYazi,
                style: TextStyle(
                    color: kTextColor_icerik,
                    fontSize: 16,
                    fontWeight: FontWeight.bold))),
        Padding(
          padding: EdgeInsets.all(padding / 2),
          child: Column(
            children: [
              Container(
                width: genislik,
                height: yukseklik,
                padding: EdgeInsets.only(left: 16, right: 16), // ic ortalama
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: DropdownButton<String>(
                  hint: DefaultYazii(widget.mevsim),
                  value: _selectedValueMevsim,
                  items: listLastikmevsim
                      .map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: kTextColor_icerik),
                      ),
                    );
                  }).toList(),
                  icon: Icon(Icons.arrow_drop_down),
                  onChanged: (dynamic secilenVeri) {
                    setState(() {
                      _selectedValueMevsim = secilenVeri;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
            onPressed: () {
              setLastikBilgileri();
            },
            child: Text("Değişiklikleri Kaydet",
                style: TextStyle(color: kTextColor_icerik)))
      ]),
    ]);
  }

  void setAracBilgileri() {
    db.getConnection().then((conn) {
      if (_selectedMarka != "" &&
          _selectedMarka != "null" &&
          _selectedMarka != null) {
        conn.query('update musteriarac set marka=? where musteriid=?',
            [_selectedMarka, int.parse(widget.musteriid)]);
      }

      if (_selectedModel != "" &&
          _selectedModel != "null" &&
          _selectedModel != null) {
        conn.query('update musteriarac set model=? where musteriid=?',
            [_selectedModel, int.parse(widget.musteriid)]);
      }

      if (_selectedSeri != "" &&
          _selectedSeri != "null" &&
          _selectedSeri != null) {
        conn.query('update musteriarac set seri=? where musteriid=?',
            [_selectedSeri, int.parse(widget.musteriid)]);
      }
    });
  }

  void setLastikBilgileri() {
    db.getConnection().then((conn) {
      if (_selectedValueMarka != "" &&
          _selectedValueMarka != "null" &&
          _selectedValueMarka != null) {
        conn.query(
            'update musteri_arac_lastik set lastikmarka=? where musteriid=?',
            [_selectedValueMarka, int.parse(widget.musteriid)]);
      }

      if (_selectedValueHizkodu != "" &&
          _selectedValueHizkodu != "null" &&
          _selectedValueHizkodu != null) {
        conn.query('update musteri_arac_lastik set hizkodu=? where musteriid=?',
            [_selectedValueHizkodu, int.parse(widget.musteriid)]);
      }

      if (_selectedValueJantCap != "" &&
          _selectedValueJantCap != "null" &&
          _selectedValueJantCap != null) {
        conn.query('update musteri_arac_lastik set jantcap=? where musteriid=?',
            [_selectedValueJantCap, int.parse(widget.musteriid)]);
      }

      if (_selectedValueTaban != "" &&
          _selectedValueTaban != "null" &&
          _selectedValueTaban != null) {
        conn.query(
            'update musteri_arac_lastik set tabangenislik=? where musteriid=?',
            [_selectedValueTaban, int.parse(widget.musteriid)]);
      }

      if (_selectedValueKesit != "" &&
          _selectedValueKesit != "null" &&
          _selectedValueKesit != null) {
        conn.query(
            'update musteri_arac_lastik set kesitoran=? where musteriid=?',
            [_selectedValueKesit, int.parse(widget.musteriid)]);
      }

      if (_selectedValueYuzEndeks != "" &&
          _selectedValueYuzEndeks != "null" &&
          _selectedValueYuzEndeks != null) {
        conn.query(
            'update musteri_arac_lastik set yuzendeks=? where musteriid=?',
            [_selectedValueYuzEndeks, int.parse(widget.musteriid)]);
      }

      if (_selectedValueMevsim != "" &&
          _selectedValueMevsim != "null" &&
          _selectedValueMevsim != null) {
        conn.query('update musteri_arac_lastik set mevsim=? where musteriid=?',
            [_selectedValueMevsim, int.parse(widget.musteriid)]);
      }
    });
  }

  Column tabAracBilgileri() {
    var genislik = 155.0;
    var yukseklik = 40.0;
    var padding = 20.0;

    String markaYazi = "Marka   :";
    String seriYazi = "Seri       :";
    String modelYazi = "Model   :";

    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
            padding: EdgeInsets.all(padding),
            child: Text(markaYazi,
                style: TextStyle(
                    color: kTextColor_icerik,
                    fontSize: 16,
                    fontWeight: FontWeight.bold))),
        Padding(
          padding: EdgeInsets.all(padding / 2),
          child: Column(
            children: [
              Container(
                width: genislik,
                height: yukseklik,
                padding: EdgeInsets.only(left: 16, right: 16), // ic ortalama
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: DropdownButton<String>(
                  hint: DefaultYazii(widget.marka),
                  value: _selectedMarka,
                  items:
                      listMarka.map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        "$value",
                        style: TextStyle(color: kTextColor_icerik),
                      ),
                    );
                  }).toList(),
                  icon: Icon(Icons.arrow_drop_down),
                  onChanged: (dynamic secilenVeri) {
                    setState(() {
                      _selectedMarka = secilenVeri;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
            padding: EdgeInsets.all(padding),
            child: Text(seriYazi,
                style: TextStyle(
                    color: kTextColor_icerik,
                    fontSize: 16,
                    fontWeight: FontWeight.bold))),
        Padding(
          padding: EdgeInsets.all(padding / 2),
          child: Column(
            children: [
              Container(
                width: genislik,
                height: yukseklik,
                padding: EdgeInsets.only(left: 16, right: 16), // ic ortalama
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: DropdownButton<String>(
                  hint: DefaultYazii(widget.seri),
                  value: _selectedSeri,
                  items:
                      listSeri.map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: kTextColor_icerik),
                      ),
                    );
                  }).toList(),
                  icon: Icon(Icons.arrow_drop_down),
                  onChanged: (dynamic secilenVeri) {
                    setState(() {
                      _selectedSeri = secilenVeri;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
            padding: EdgeInsets.all(padding),
            child: Text(modelYazi,
                style: TextStyle(
                    color: kTextColor_icerik,
                    fontSize: 16,
                    fontWeight: FontWeight.bold))),
        Padding(
          padding: EdgeInsets.all(padding / 2),
          child: Column(
            children: [
              Container(
                width: genislik,
                height: yukseklik,
                padding: EdgeInsets.only(left: 16, right: 16), // ic ortalama
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: DropdownButton<String>(
                  hint: DefaultYazii(widget.model),
                  value: _selectedModel,
                  items:
                      listModel.map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: kTextColor_icerik),
                      ),
                    );
                  }).toList(),
                  icon: Icon(Icons.arrow_drop_down),
                  onChanged: (dynamic secilenVeri) {
                    setState(() {
                      _selectedModel = secilenVeri;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
      Row(
        children: [
          ElevatedButton(
              onPressed: () {
                setAracBilgileri();
              },
              child: Text(
                "Değişiklikleri Kaydet",
                style: TextStyle(color: kTextColor_icerik),
              ))
        ],
      )
    ]);
  }

  Column tabKullaniciBilgileri() {
    return Column(
      children: [
        field(
          controller: tfTel,
          hint: widget.musteritelefon,
          icon: Icon(Icons.phone_android_outlined),
          klavye: TextInputType.number,
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

class field extends StatelessWidget {
  const field({
    Key? key,
    required this.controller,
    required this.hint,
    required this.icon,
    required this.klavye,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final Icon icon;
  final TextInputType klavye;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
      child: SizedBox(
        width: 300,
        height: 45,
        child: TextField(
          controller: controller,
          style: TextStyle(color: kTextColor_icerik),
          obscureText: false,
          decoration: InputDecoration(
              prefixIcon: icon, hintText: hint, border: OutlineInputBorder()),
          keyboardType: klavye,
          textInputAction: TextInputAction.done,
        ),
      ),
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

class DefaultYazii extends StatelessWidget {
  String gelenveri;

  DefaultYazii(this.gelenveri);

  @override
  Widget build(BuildContext context) {
    if (gelenveri == "" || gelenveri == "null") {
      return Text(
        "Seçilmemiş",
        style: TextStyle(color: kTextColor_icerik),
      );
    } else {
      return Text(
        (gelenveri.toString()),
        style: TextStyle(color: kTextColor_icerik),
      );
    }
  }
}

class Drop extends StatelessWidget {
  const Drop({
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
