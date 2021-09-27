import 'package:flutter/material.dart';
import 'package:tanlas/constants.dart';

class ReklamAlaniBolumleri extends StatelessWidget {
  const ReklamAlaniBolumleri({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ReklamAlani(
            image:
                "https://media-exp1.licdn.com/dms/image/C561BAQHIoIm3rA9Gpg/company-background_10000/0/1519796382581?e=2159024400&v=beta&t=agn6gOF1N-8O0Zu7uklR2j784BLl3zXc-v_9aoPv7HU",
            title: "kırıker metal",
            subtitle: "Kalite Kapıda Başlar",
            press: () {},
          ),
          ReklamAlani(
            image:
                "https://media-exp1.licdn.com/dms/image/C561BAQHIoIm3rA9Gpg/company-background_10000/0/1519796382581?e=2159024400&v=beta&t=agn6gOF1N-8O0Zu7uklR2j784BLl3zXc-v_9aoPv7HU",
            title: "kırıker metal2",
            subtitle: "Kalite Kapıda Başlar2",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class ReklamAlani extends StatelessWidget {
  const ReklamAlani({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.press,
  }) : super(key: key);

  final String image, title, subtitle;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.only(
              top: kDefultPadding / 2, bottom: kDefultPadding * 2.5),
          width: size.width * 0.90,
          child: Column(
            children: <Widget>[
              Image.network(image),
              Container(
                padding: EdgeInsets.all(kDefultPadding / 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Colors.black.withOpacity(0.23))
                    ],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Row(
                  children: <Widget>[
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "$title\n".toUpperCase(),
                        style: TextStyle(color: kPrimaryColor.withOpacity(0.5)),
                      ),
                      TextSpan(
                        text: "$subtitle",
                        style: TextStyle(color: Colors.black.withOpacity(0.5)),
                      )
                    ]))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
