import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanlas/screens/appBar.dart';
import 'package:tanlas/screens/randevu/components/body.dart';

class RandevuAl extends StatefulWidget {
  // This widget is the root of your application.
  String musteriid;
  String musteriad;
  RandevuAl(this.musteriid, this.musteriad);

  @override
  _RandevuAlState createState() => _RandevuAlState();
}

class _RandevuAlState extends State<RandevuAl> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationToolbar(
        widget.musteriid,
        widget.musteriad,
      ),
      body: Body(widget.musteriid, widget.musteriad),
    );
  }
}
