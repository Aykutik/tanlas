import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanlas/screens/appBar.dart';
import 'package:tanlas/screens/kullaniciBilgileri/body.dart';

class KullaniciBilgileri extends StatefulWidget {
  // This widget is the root of your application.
  String musteriid;
  String musteriad;
  KullaniciBilgileri(this.musteriid, this.musteriad);

  @override
  _KullaniciBilgileriState createState() => _KullaniciBilgileriState();
}

class _KullaniciBilgileriState extends State<KullaniciBilgileri> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationToolbar(widget.musteriid, widget.musteriad),
      body: Body(widget.musteriid, widget.musteriad),
    );
  }
}
