import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:soryor/models/kullanici.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:soryor/provider/themeprovider.dart';
import 'package:soryor/services/apiservices.dart';
import 'package:soryor/utils/changetheme.dart';
import 'package:soryor/utils/colorloader.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

/*todo   1. sifreyi isterse görsün 2.şifremi unuttum kısmı 3.daha önce loginse direkt yonlednir 
4.tasarım guzel degil 5.loaderda arkaya logo ekleyebilrisn 6..diger catchi kontrol et
*/
class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  bool load = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<Kullanici> list(int kullan) async {
    print("liatte");
    Kullanici x = await APIServices.testkulla();
    print("vdv");

    return x;
  }

  Future<Kullanici> list2(int kullan) async {
    print("bak kullanici  baslıyr");
    /*HttpClient client = new HttpClient();
    var request =
      await client.getUrl(Uri.parse("10.0.3.2:44314/api/kullanicis"));
    print(request.toString());
    var response1 = request.close();*/

    /*  bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = new IOClient(httpClient);
    print("hf");
    http.Response res =
        await ioClient.get("http://10.0.2.2:44314/api/kullanicis");*/
    print("sss");

    http.Response res =
        await http.get("https://192.168.1.111:45455/api/kullanicis");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    Kullanici kullani = Kullanici.fromMap(re);
    print(kullani.toString());
  }

  @override
  Widget build(BuildContext context) {
    print("login buildde");
    list2(2).then((value) {
      var y = value;
      print(y.toString());
    });
    return Scaffold(
      body: load == true
          ? Center(child: ColorLoader3())
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: context.watch<ThemeNotifier>().getTheme() ==
                            ThemeData.dark()
                        ? [
                            //      Colors.blueGrey, Colors.lightBlueAccent
                            Colors.redAccent, Colors.orangeAccent
                          ]
                        : [Colors.blueGrey, Colors.lightBlueAccent]),
              ),
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(children: <Widget>[
                        Textgiriswid(),
                        Textloginwid(),
                      ]),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 50, left: 50, right: 50),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.mail), onPressed: () {}),
                                  Expanded(
                                    child: Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Lütfen emalinizi giriniz ';
                                          }
                                          return null;
                                        },
                                        controller: _emailController,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                          //    border: InputBorder.none,
                                          fillColor: Colors.lightBlueAccent,
                                          labelText: 'mail'.tr(),
                                          labelStyle: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 50, right: 50),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.lock), onPressed: () {}),
                                  Expanded(
                                    child: Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Lütfen şifrenizi giriniz';
                                          }
                                          return null;
                                        },
                                        controller: _passwordController,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          //      border: InputBorder.none,
                                          labelText: 'sifre'.tr(),
                                          labelStyle: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 40, right: 50, left: 50),
                        child: Container(
                          alignment: Alignment.bottomRight,
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue[300],
                                blurRadius:
                                    10.0, // has the effect of softening the shadow
                                spreadRadius:
                                    1.0, // has the effect of extending the shadow
                                offset: Offset(
                                  5.0, // horizontal, move right 10
                                  5.0, // vertical, move down 10
                                ),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: FlatButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _signInWithEmailAndPassword();
                              } else {
                                //           FirebaseMessaging _fcm1 = FirebaseMessaging();
                                //         String token = await _fcm1.getToken();
                                //       print(token);
                                //     print("token bu");
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'giris',
                                  style: TextStyle(
                                    color: Colors.lightBlueAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ).tr(),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.lightBlueAccent,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 30),
                        child: Container(
                          alignment: Alignment.topRight,
                          //color: Colors.red,
                          height: 20,
                          child: Row(
                            children: <Widget>[
                              Text(
                                'yenimisin',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ).tr(),
                              FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  Navigator.pushNamed(context, 'kaydol');
                                },
                                child: Text(
                                  'kaydol',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.right,
                                ).tr(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  void _signInWithEmailAndPassword() async {
    try {
      setState(() {
        load = true;
      });
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      bool x = true; //user.emailVerified;
      if (x == true) {
        Kullanici kul = await APIServices.alkullanici(_emailController.text);
        context.read<KullaniciProvider>().kullaniciyukle(kul);

        FirebaseMessaging _fcm1 = FirebaseMessaging();
        String token = await _fcm1.getToken();
        print(token);
        print("token bu");

        Navigator.pushReplacementNamed(context, 'anasayfa');
        /*setState(() {
          load = false;
        });*/
        debugPrint("verified edildi");
      } else {
        setState(() {
          load = false;
        });
        debugPrint("verified falseee");
        buildflush("Emailiniz henüz doğrulanmamıştır giriş için doğrulayınız");
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      if (e.toString() ==
          "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
        print("dd");
        setState(() {
          load = false;
        });
        buildflush("Lütfen giriş yapmadan önce kaydolmayı deneyin");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Flushbar buildflush(String message) {
    return Flushbar(
      duration: Duration(seconds: 2),
      title: "Hey sen",
      message: message,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      backgroundGradient: LinearGradient(colors: [Colors.blue, Colors.teal]),
      backgroundColor: Colors.red,
      boxShadows: [
        BoxShadow(
          color: Colors.blue[800],
          offset: Offset(0.0, 2.0),
          blurRadius: 3.0,
        )
      ],
    )..show(context);
  }
}

class Textgiriswid extends StatelessWidget {
  const Textgiriswid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 10),
      child: RotatedBox(
          quarterTurns: -1,
          child: Center(
            child: Text(
              'giris',
              style: TextStyle(
                color: Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.w900,
              ),
            ).tr(),
          )),
    );
  }
}

class Textloginwid extends StatelessWidget {
  const Textloginwid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 10.0),
      child: Container(
        //color: Colors.green,
        height: 150,
        width: 300,
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
            ),
            Center(
              child: Text(
                'kesif', //   'kesif',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ).tr(),
            ),
          ],
        ),
      ),
    );
  }
}
