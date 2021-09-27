import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanlas/screens/appBar.dart';
import 'package:tanlas/screens/ayarlar/body.dart';

class Ayarlar extends StatefulWidget {
  // This widget is the root of your application.
  String musteriid;
  String musteriad;
  Ayarlar(this.musteriid, this.musteriad);

  @override
  _AyarlarState createState() => _AyarlarState();
}

class _AyarlarState extends State<Ayarlar> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationToolbar(widget.musteriid, widget.musteriad),
      body: Body(widget.musteriid, widget.musteriad),
    );
  }
}
