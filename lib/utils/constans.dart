import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soryor/models/altkonu.dart';
import 'package:soryor/ui/toplulukanasyf.dart';
import 'package:soryor/test.dart';
import 'package:soryor/ui/Addquestionscreen.dart';
import 'package:soryor/ui/kaydolekran.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:soryor/ui/otherporfileui.dart';
import 'package:soryor/ui/profileui.dart';
import 'package:soryor/ui/settingsui.dart';
import 'package:soryor/ui/toplulukui.dart';
import 'package:soryor/ui/trendscreen.dart';

Color primaryGreen = Color(0xff416d6d);
List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
];

List<Map> drawerItems = [
  {'icon': Icons.favorite, 'title': 'favori'.tr()},
  {'icon': Icons.mail, 'title': 'bildirim'.tr()},
  {'icon': FontAwesomeIcons.userAlt, 'title': 'profilim'},
];
List<Map> categories = [
  {'name': 'Gündem', 'iconPath': 'lib/assets/sorisa.jpg'},
  {'name': 'Genel Kültür', 'iconPath': 'lib/assets/logo.jpg'},
  {'name': 'Yazılım', 'iconPath': 'lib/assets/sorisa.jpg'},
  {'name': 'Spor', 'iconPath': 'lib/assets/logo.jpg'},
  {'name': 'Eğitim', 'iconPath': 'lib/assets/sorisa.jpg'},
  {'name': 'Alışveriş', 'iconPath': 'lib/assets/logo.jpg'},
  {'name': 'Sağlık', 'iconPath': 'lib/assets/sorisa.jpg'}
];
List<Widget> awidgets = <Widget>[
  HomePage(),
  Toplulukui(),
  Toplulukanasyf(),
  Profileui(),
  // Test(),
  SettingsPage(),
  OtherProfileui()
];
int kpid;
List<Altkonu> pro = [];
