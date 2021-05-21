import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
//import 'package:login_minimalist/pages/login.page.dart';

class UserOld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 30),
      child: Container(
        alignment: Alignment.topRight,
        //color: Colors.red,
        height: 20,
        child: Row(
          children: <Widget>[
            Text(
              'hesapvar',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ).tr(),
            FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'login');
              },
              child: Text(
                'giriş',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
                textAlign: TextAlign.right,
              ).tr(),
            ),
          ],
        ),
      ),
    );
  }
}
