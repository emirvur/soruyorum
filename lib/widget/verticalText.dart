import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

class VerticalText extends StatefulWidget {
  @override
  _VerticalTextState createState() => _VerticalTextState();
}

// todo 1. griis yazızı ortala
class _VerticalTextState extends State<VerticalText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 10),
      child: RotatedBox(
          quarterTurns: -1,
          child: Center(
              child: Text(
            'giriş'.tr(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.w900,
            ),
          ).tr())),
    );
  }
}
