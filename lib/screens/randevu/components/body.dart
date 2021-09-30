import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanlas/constants.dart';
import 'package:tanlas/models/mysql.dart';
import 'package:tanlas/screens/header_icerik.dart';
import 'package:tanlas/screens/randevu/components/randevuBasarili.dart';

class Body extends StatefulWidget {
  String musteriid;
  String musteriad;

  Body(this.musteriid, this.musteriad);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var db = new Mysql();
  var bir = '09:00';
  var iki = '10:00';
  var uc = '11:00';
  var dort = '12:00';
  var bes = '13:00';
  var alti = '14:00';
  var yedi = '15:00';
  var sekiz = '16:00';
  var dokuz = '17:00';
  var on = '18:00';
  var dolu = 'DOLU';
  var kapali = 'KAPALI';
  var tarihKontrol;

  var rntarih = TextEditingController();
  var rnsaat = TextEditingController();
  var saat = "Seçiniz";

  List<String> lst = [
    "Tarih Seçin",
    "Tarih Seçin",
    "Tarih Seçin",
    "Tarih Seçin",
    "Tarih Seçin",
    "Tarih Seçin",
    "Tarih Seçin",
    "Tarih Seçin",
    "Tarih Seçin",
    "Tarih Seçin",
    "",
    ""
  ];
  int selectedIndex = 11;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Column(
      children: <Widget>[
        Header_icerik(size: size),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: kDefultPadding),
              child: Row(
                children: [
                  Text(
                    "Randevu Tarihi:",
                    style: TextStyle(
                        color: kTextColor_icerik,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: kDefultPadding),
                    child: SizedBox(
                      width: 150,
                      height: 30,
                      child: TextField(
                        controller: rntarih,
                        style: TextStyle(color: kTextColor_icerik),
                        onTap: () {
                          selectTimePicker(context);
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Tarih Seçiniz",
                            hintStyle: TextStyle(color: kTextColor_icerik),
                            prefixIcon:
                                Icon(Icons.date_range, 
                                color: Colors.))),
                        keyboardType: TextInputType.none,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(kDefultPadding),
                  child: Text(
                    "Randevu Saati: ",
                    style: TextStyle(
                        color: kTextColor_icerik,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text((saat), style: TextStyle(color: kTextColor_icerik))
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: kDefultPadding,
                bottom: kDefultPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(children: [
                    customRadio(lst[0], 0),
                    customRadio(lst[3], 3),
                    customRadio(lst[6], 6),
                  ]),
                  //
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: customRadio(lst[1], 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: customRadio(lst[4], 4),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: customRadio(lst[7], 7),
                    ),
                  ]),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: customRadio(lst[2], 2),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: customRadio(lst[5], 5),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: customRadio(lst[8], 8),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: customRadio(lst[9], 9),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (_hatakontrol), child: Text("Randevu Kaydet"))
              ],
            ),
          ],
        ),
      ],
    ));
  }

  void _getRandevu() {
    var randevuTarihi;
    if (date.month.toString().length == 1) {
      randevuTarihi =
          "${date.year.toString()}/0${date.month.toString()}/${date.day.toString()}";
    } else {
      randevuTarihi =
          "${date.year.toString()}/${date.month.toString()}/${date.day.toString()}";
    }

    db.getConnection().then((conn) {
      String sql = 'select *from tarih where tarih="${randevuTarihi}"';
      conn.query(sql).then((results) {
        if (results.isEmpty != true) {
          for (var row in results) {
            setState(() {
              if (row["bir"].toString() == "" ||
                  row["bir"].toString() == "null" ||
                  row["bir"].toString() == null) {
                //1
                lst[0] = bir;
              } else {
                lst[0] = dolu;
              }

              if (row["iki"].toString() == "" ||
                  row["iki"].toString() == "null" ||
                  row["iki"].toString() == null) {
                //2
                lst[1] = iki;
              } else {
                lst[1] = dolu;
              }

              if (row["uc"].toString() == "" ||
                  row["uc"].toString() == "null" ||
                  row["uc"].toString() == null) {
                //3
                lst[2] = uc;
              } else {
                lst[2] = dolu;
              }

              if (row["dort"].toString() == "" ||
                  row["dort"].toString() == "null" ||
                  row["dort"].toString() == null) {
                //4
                lst[3] = dort;
              } else {
                lst[3] = dolu;
              }

              if (row["bes"].toString() == "" ||
                  row["bes"].toString() == "null" ||
                  row["bes"].toString() == null) {
                //5
                lst[4] = bes;
              } else {
                lst[4] = dolu;
              }

              if (row["alti"].toString() == "" ||
                  row["alti"].toString() == "null" ||
                  row["alti"].toString() == null) {
                //6
                lst[5] = alti;
              } else {
                lst[5] = dolu;
              }

              if (row["yedi"].toString() == "" ||
                  row["yedi"].toString() == "null" ||
                  row["yedi"].toString() == null) {
                //7
                lst[6] = yedi;
              } else {
                lst[6] = dolu;
              }

              if (row["sekiz"].toString() == "" ||
                  row["sekiz"].toString() == "null" ||
                  row["sekiz"].toString() == null) {
                //8
                lst[7] = sekiz;
              } else {
                lst[7] = dolu;
              }

              if (row["dokuz"].toString() == "" ||
                  row["dokuz"].toString() == "null" ||
                  row["dokuz"].toString() == null) {
                //9
                lst[8] = dokuz;
              } else {
                lst[8] = dolu;
              }

              if (row["onn"].toString() == "" ||
                  row["onn"].toString() == "null" ||
                  row["onn"].toString() == null) {
                //10
                lst[9] = on;
              } else {
                lst[9] = dolu;
              }
            });
          }
        } else {
          if (date.weekday == 7) {
            // pazar günü kapalı ayarı
            setState(() {
              lst[0] = kapali;
              lst[1] = kapali;
              lst[2] = kapali;
              lst[3] = kapali;
              lst[4] = kapali;
              lst[5] = kapali;
              lst[6] = kapali;
              lst[7] = kapali;
              lst[8] = kapali;
              lst[9] = kapali;
            });
          } else {
            // açılmamış ise sıfırla
            setState(() {
              lst[0] = bir;
              lst[1] = iki;
              lst[2] = uc;
              lst[3] = dort;
              lst[4] = bes;
              lst[5] = alti;
              lst[6] = yedi;
              lst[7] = sekiz;
              lst[8] = dokuz;
              lst[9] = on;
            });
          }
        }
        //
      });
    });
  }

  void _randevuKaydet() {
    var tarih;
    if (date.month.toString().length == 1) {
      setState(() {
        tarih =
            "${date.year.toString()}/0${date.month.toString()}/${date.day.toString()}";
      });
    } else {
      setState(() {
        tarih =
            "${date.year.toString()}/${date.month.toString()}/${date.day.toString()}";
      });
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("RANDEVU ONAYI",
                style: TextStyle(color: kTextColor_icerik)),
            content: Text(
                "Randevu Tarihi: ${rntarih.value.text}\nRandevu Saati: ${saat.toString()}\n\nOnaylıyor musunuz?",
                style: TextStyle(color: kTextColor_icerik)),
            actions: [
              ElevatedButton(
                onPressed: () {
                  _setRandevu();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => randevuBasarili(
                              widget.musteriid,
                              widget.musteriad,
                              tarih,
                              saat)));
                },
                child: Text("ONAY"),
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
  }

  void _hatakontrol() {
    if (lst[selectedIndex] != "DOLU") {
      // Doluyu mu tıkladı veya başka müşteri mi aldı kontrolü
      if (lst[selectedIndex] != "KAPALI") {
        if (rntarih.value.text.toString() != "") {
          if (lst[selectedIndex] != "") {
// tatil günü kontrolü
            db.getConnection().then((conn) {
              // Müşterinin bekleyen randevuları var mı kontrolü
              String sqlKontrolR =
                  'select id from servis_hareketler where musteriid="${widget.musteriid}" and randevu=1';
              conn.query(sqlKontrolR).then((results) {
                if (results.isEmpty == true) {
                  // kontrolleri geçti şimdi randevu kaydedilebilir.
                  _randevuKaydet();
                } else {
                  //"Aktif randevusu bulunan müşteri randevu alamaz!";
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("HATA",
                              style: TextStyle(color: kTextColor_icerik)),
                          content: Text(
                              "Bir müşterinin yalnızca bir randevusu olabilir. Önceki randevunuz gelmeden veya iptal olmadan yeni randevu alamazsınız.!,",
                              style: TextStyle(color: kTextColor_icerik)),
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
                  _getRandevu();
                }
              }); // String sqlKontrolR =
            });
            _getRandevu();
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("HATA",
                        style: TextStyle(color: kTextColor_icerik)),
                    content: Text("Lütfen bir saat seçiniz!",
                        style: TextStyle(color: kTextColor_icerik)),
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
            _getRandevu();
          }
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title:
                      Text("HATA", style: TextStyle(color: kTextColor_icerik)),
                  content: Text("Lütfen bir tarih seçiniz!",
                      style: TextStyle(color: kTextColor_icerik)),
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
          _getRandevu();
        }
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("HATA", style: TextStyle(color: kTextColor_icerik)),
                content: Text(
                    "Seçtiğiniz tarihte hizmet vermemekteyiz. Lütfen başka bir saat deneyin!",
                    style: TextStyle(color: kTextColor_icerik)),
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
        _getRandevu();
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("HATA", style: TextStyle(color: kTextColor_icerik)),
              content: Text(
                  "Seçtiğiniz saate başka bir müşterimiz randevu almış. Lütfen başka bir tarih seçiniz!",
                  style: TextStyle(color: kTextColor_icerik)),
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
      _getRandevu();
    }
  }

  void _setRandevu() {
    DateTime simdi = DateTime.now();
    var randevuTarihi;
    var bugun;

    db.getConnection().then((conn) {
      if (date.month.toString().length == 1) {
        randevuTarihi =
            "${date.year.toString()}/0${date.month.toString()}/${date.day.toString()}";
      } else {
        randevuTarihi =
            "${date.year.toString()}/${date.month.toString()}/${date.day.toString()}";
      }

      if (simdi.month.toString().length == 1) {
        bugun =
            "${simdi.year.toString()}/0${simdi.month.toString()}/${simdi.day.toString()}";
      } else {
        bugun =
            "${simdi.year.toString()}/${simdi.month.toString()}/${simdi.day.toString()}";
      }

      String sqlKontrol =
          'select tarih from tarih where tarih="${randevuTarihi.toString()}";';
      conn.query(sqlKontrol).then((results) {
        if (results.isEmpty != true) {
          // daha önce bir randevu alınmış update işlemi yapılacak
          if ((selectedIndex + 1) == 1) {
            conn.query('update tarih set bir=? where tarih=?',
                [widget.musteriid, randevuTarihi]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          if ((selectedIndex + 1) == 2) {
            conn.query('update tarih set iki=? where tarih=?',
                [widget.musteriid, randevuTarihi]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          if ((selectedIndex + 1) == 3) {
            conn.query('update tarih set uc=? where tarih=?',
                [widget.musteriid, randevuTarihi]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          if ((selectedIndex + 1) == 4) {
            conn.query('update tarih set dort=? where tarih=?',
                [widget.musteriid, randevuTarihi]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          if ((selectedIndex + 1) == 5) {
            conn.query('update tarih set bes=? where tarih=?',
                [widget.musteriid, randevuTarihi]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          if ((selectedIndex + 1) == 6) {
            conn.query('update tarih set alti=? where tarih=?',
                [widget.musteriid, randevuTarihi]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          if ((selectedIndex + 1) == 7) {
            conn.query('update tarih set yedi=? where tarih=?',
                [widget.musteriid, randevuTarihi]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          if ((selectedIndex + 1) == 8) {
            conn.query('update tarih set sekiz=? where tarih=?',
                [widget.musteriid, randevuTarihi]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          if ((selectedIndex + 1) == 9) {
            conn.query('update tarih set dokuz=? where tarih=?',
                [widget.musteriid, randevuTarihi]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          if ((selectedIndex + 1) == 10) {
            conn.query('update tarih set onn=? where tarih=?',
                [widget.musteriid, randevuTarihi]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          _getRandevu();
        } // (results.isEmpty != true) {
        else {
          //yeni gün kaydı
          if ((selectedIndex + 1) == 1) {
            conn.query("insert into tarih (tarih,bir) values (?,?)",
                [randevuTarihi, widget.musteriid]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          if ((selectedIndex + 1) == 2) {
            conn.query("insert into tarih (tarih,iki) values (?,?)",
                [randevuTarihi, widget.musteriid]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          if ((selectedIndex + 1) == 3) {
            conn.query("insert into tarih (tarih,uc) values (?,?)",
                [randevuTarihi, widget.musteriid]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          if ((selectedIndex + 1) == 4) {
            conn.query("insert into tarih (tarih,dort) values (?,?)",
                [randevuTarihi, widget.musteriid]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          if ((selectedIndex + 1) == 5) {
            conn.query("insert into tarih (tarih,bes) values (?,?)",
                [randevuTarihi, widget.musteriid]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          if ((selectedIndex + 1) == 6) {
            conn.query("insert into tarih (tarih,alti) values (?,?)",
                [randevuTarihi, widget.musteriid]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          if ((selectedIndex + 1) == 7) {
            conn.query("insert into tarih (tarih,yedi) values (?,?)",
                [randevuTarihi, widget.musteriid]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          if ((selectedIndex + 1) == 8) {
            conn.query("insert into tarih (tarih,sekiz) values (?,?)",
                [randevuTarihi, widget.musteriid]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          if ((selectedIndex + 1) == 9) {
            conn.query("insert into tarih (tarih,dokuz) values (?,?)",
                [randevuTarihi, widget.musteriid]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          if ((selectedIndex + 1) == 10) {
            conn.query("insert into tarih (tarih,onn) values (?,?)",
                [randevuTarihi, widget.musteriid]);
            // randevu bilgileri kaydı
            conn.query(
                "insert into servis_hareketler (musteriid,musteriad,tarih,saat,iptal,randevu,gelmedi,altarih,alsaat) values (?,?,?,?,?,?,?,?,?)",
                [
                  widget.musteriid, //id
                  widget.musteriad, //ad
                  randevuTarihi, //tarih
                  lst[selectedIndex], //Saat
                  0, //iptal
                  1, //randevu
                  0, //gelmedi
                  bugun, // altarih
                  "${simdi.hour.toString()}:${simdi.minute.toString()}", //saat
                ]);
            //
            _getRandevu();
          }
          _getRandevu();
        }
        _getRandevu();
      });
    });
  }

  void changeIndex(int index) {
    //_setRezerve(); // tıklanan kısmı rezerve et.
    setState(() {
      selectedIndex = index;
      if (lst[selectedIndex] != "DOLU" &&
          lst[selectedIndex] != "KAPALI" &&
          lst[selectedIndex] != "Tarih Seçin") {
        saat = lst[selectedIndex];
      } else {
        saat = "";
      }
    });
  }

  Widget customRadio(String txt, int index) {
    if (txt != "DOLU" && txt != "KAPALI" && txt != "Tarih Seçin") {
      return OutlineButton(
        onPressed: () => changeIndex(index),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        borderSide: BorderSide(
            color: selectedIndex == index ? Colors.cyan : Colors.green),
        child: Text(
          txt,
          style: TextStyle(
              color: selectedIndex == index ? Colors.cyan : Colors.green),
        ),
      );
    } else {
      return OutlineButton(
        onPressed: () => changeIndex(index),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        borderSide:
            BorderSide(color: selectedIndex == index ? Colors.red : Colors.red),
        child: Text(
          txt,
          style: TextStyle(
              color: selectedIndex == index ? Colors.red : Colors.red),
        ),
      );
    }
  }

  DateTime date = DateTime.now();
  Future<Null> selectTimePicker(BuildContext context) async {
    var tarih;
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime.now(),
        lastDate: DateTime(2022),
        cancelText: "İPTAL",
        confirmText: "ONAYLA");
    Locale('tr', 'TR');
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
        print(date.toString());
        if (date.month.toString().length == 1) {
          setState(() {
            tarih =
                "${date.day.toString()}/0${date.month.toString()}/${date.year.toString()}";
          });
        } else {
          setState(() {
            tarih =
                "${date.day.toString()}/${date.month.toString()}/${date.year.toString()}";
          });
        }
        setState(() {
          rntarih.text = tarih;
        });
      });
    }
    _getRandevu(); // listeyi tazele
  }
}

class ButonYazi extends StatelessWidget {
  String date;

  ButonYazi(this.date);

  @override
  Widget build(BuildContext context) {
    if (date == null) {
      return Text(
        "Bir Tarih Seçin",
        style: TextStyle(color: kTextColor_icerik),
      );
    } else {
      return Text(
        "$date",
        style: TextStyle(color: kTextColor_icerik),
      );
    }
  }
}
