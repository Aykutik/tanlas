import 'package:flutter/material.dart';
import 'package:tanlas/screens/ayarlar/ayarlar.dart';
import 'package:tanlas/screens/giris/girisEkrani.dart';

class ApplicationToolbar extends StatelessWidget with PreferredSizeWidget {
  String musteriid;
  String musteriad;

  ApplicationToolbar(this.musteriid, this.musteriad);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.person_pin),
        onPressed: () {
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
      ),
      leadingWidth: 20,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              giris(musteriid, musteriad),
            ],
          )
        ],
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
      return Text("Hoşgeldiniz, ${musteriad.toString()}");
    } else {
      return Text("Giriş yap / Kayıt ol");
    }
  }
}
