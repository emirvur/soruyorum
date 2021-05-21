import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:soryor/deneme.dart';
import 'package:soryor/provider/listprovider.dart';
import 'package:soryor/ui/bildirimui.dart';
import 'package:soryor/ui/toplulukanasyf.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:soryor/provider/themeprovider.dart';
import 'package:soryor/provider/otherprofilprov.dart';
import 'package:soryor/test.dart';
import 'package:soryor/ui/yorumsoru.dart';
import 'package:soryor/ui/addquestionscreen.dart';
import 'package:soryor/ui/editprofileui.dart';
import 'package:soryor/ui/favsorcevui.dart';
import 'package:soryor/ui/feedui.dart';
import 'package:soryor/ui/home.dart';

import 'package:soryor/ui/kaydolekran.dart';
import 'package:soryor/ui/loginscreen.dart';
import 'package:soryor/ui/otherporfileui.dart';
import 'package:soryor/ui/settingsui.dart';

import 'package:soryor/ui/loginscreen.dart';

import 'package:soryor/ui/sorununcevabiui.dart';
import 'package:soryor/ui/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:soryor/ui/takipcilistui.dart';
import 'package:soryor/ui/takipui.dart';
import 'package:soryor/ui/trendscreen.dart';
import 'package:soryor/utils/changetheme.dart';
import 'package:soryor/utils/colorloader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = new MyHttpOverrides();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KullaniciProvider()),
        ChangeNotifierProvider(create: (_) => Otherprofprov()),
        ChangeNotifierProvider(create: (_) => Listprovider()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier(ThemeData.light())),
      ],
      child: EasyLocalization(
          //  fallbackLocale: Locale('tr', 'TR'),
          supportedLocales: [Locale('en', 'EN'), Locale('tr', 'TR')],
          path: 'lib/utils/langs',
          // fallbackLocale: Locale('en', 'US'),
          child: MyApp()),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("materail app buildde");
    ThemeNotifier prov = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      theme: prov.getTheme(),
      initialRoute: 'login',
      routes: {
        'anasayfa': (context) => Home(),
        'Splash': (context) => Splash(),
        'loader': (context) => ColorLoader3(),
        'login': (context) => LoginPage(),
        'kaydol': (context) => NewUser(),
        'editprofil': (context) => EditProfilePage(),
        'settings': (context) => SettingsPage(),
        'addquestion': (context) => Addquestion(),
        'sorucevap': (context) => Sorucevap(),
        'favori': (context) => Favui(),
        'takip': (context) => Takipui(),
        'feed': (context) => Feedui(),
        'takiplist': (context) => Takipcilist(),
        'otherprof': (context) => OtherProfileui(),
        'bildirim': (context) => Notificationui(),
        'test': (context) => Test(),
        'deneme': (context) => Deneme(),
      },
      //  home: LoginPage(),
    );
  }
}
