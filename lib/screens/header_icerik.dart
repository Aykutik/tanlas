import 'package:flutter/material.dart';
import 'package:tanlas/constants.dart';

class Header_icerik extends StatelessWidget {
  const Header_icerik({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefultPadding * 1.5),
      child: Container(
          height: size.height * 0.1,
          decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36)),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 11),
                    blurRadius: 6,
                    color: kPrimaryColor.withOpacity(0.5))
              ])),
    );
  }
}
