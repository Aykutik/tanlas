import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanlas/screens/home/components/header.dart';
import 'package:tanlas/screens/home/components/reklamalanlari.dart';
import 'islemler.dart';

class Body extends StatelessWidget {
  String musteriid;
  String musteriad;

  Body(this.musteriid, this.musteriad);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: <Widget>[
          Header(size: size),
          ReklamAlaniBolumleri(),
          Islemler(musteriid, musteriad),
        ],
      ),
    );
  }
}
