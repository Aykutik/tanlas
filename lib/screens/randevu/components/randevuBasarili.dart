import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanlas/screens/appBar.dart';
import 'package:tanlas/screens/randevu/components/bodyBasarili.dart';

class randevuBasarili extends StatefulWidget {
  // This widget is the root of your application.
  String musteriid;
  String musteriad;
  String randeuTarihi;
  String randevuSaati;
  randevuBasarili(
      this.musteriid, this.musteriad, this.randeuTarihi, this.randevuSaati);

  @override
  _randevuBasariliState createState() => _randevuBasariliState();
}

class _randevuBasariliState extends State<randevuBasarili> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationToolbar(widget.musteriid, widget.musteriad),
      body: BodyBasarili(
        widget.musteriid,
        widget.musteriad,
        widget.randeuTarihi,
        widget.randevuSaati,
      ),
    );
  }
}
