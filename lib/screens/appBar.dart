import 'package:flutter/material.dart';
import 'package:tanlas/constants.dart';
import 'package:tanlas/screens/ayarlar/ayarlar.dart';
import 'package:tanlas/screens/giris/girisEkrani.dart';

class ApplicationToolbar extends StatelessWidget with PreferredSizeWidget {
  String musteriid;
  String musteriad;

  ApplicationToolbar(this.musteriid, this.musteriad);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: GestureDetector(
        onTap: () {
          if (musteriid != "0") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Ayarlar(musteriid, musteriad)));
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
              children: [],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                giris(musteriid, musteriad),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.person_pin),
                  onPressed: () {
                    if (musteriid != "0") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Ayarlar(musteriid, musteriad)));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => girisEkrani()));
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class giris extends StatelessWidget {
  String musteriid;
  String musteriad;

  giris(this.musteriid, this.musteriad);

  @override
  Widget build(BuildContext context) {
    if (musteriid != "0") {
      return Text("Ho??geldiniz, ${musteriad.toString()}");
    } else {
      return Text("Giri?? yap / Kay??t ol");
    }
  }
}
