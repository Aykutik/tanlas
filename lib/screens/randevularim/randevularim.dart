import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanlas/screens/appBar.dart';
import 'package:tanlas/screens/randevularim/body.dart';

class Randevularim extends StatefulWidget {
  // This widget is the root of your application.
  String musteriid;
  String musteriad;
  Randevularim(this.musteriid, this.musteriad);

  @override
  _RandevularimState createState() => _RandevularimState();
}

class _RandevularimState extends State<Randevularim> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationToolbar(widget.musteriid, widget.musteriad),
      body: Body(widget.musteriid, widget.musteriad),
    );
  }
}
