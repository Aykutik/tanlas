import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanlas/screens/giris/girisEkrani.dart';
import 'package:tanlas/screens/randevu/components/randevual.dart';
import '../../../constants.dart';

class Islemler extends StatelessWidget {
  String musteriid;
  String musteriad;

  Islemler(this.musteriid, this.musteriad);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Islemler_kutucuklar(
            icon: "assets/icon/ara.svg",
            text: "Ara",
            press: () {},
          ),
          Islemler_kutucuklar(
            icon: "assets/icon/randevu.svg",
            text: "Randevu Al",
            press: () {
              if (musteriid != "0") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RandevuAl(musteriid, musteriad)));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => girisEkrani()));
              }
            },
          ),
          Islemler_kutucuklar(
            icon: "assets/icon/iletisim.svg",
            text: "İletişim",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RandevuAl(musteriid, musteriad)));
            },
          ),
        ],
      ),
    );
  }
}

class Islemler_kutucuklar extends StatelessWidget {
  const Islemler_kutucuklar({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: islemGenislik,
        height: islemGenislik * 2,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(icon),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
