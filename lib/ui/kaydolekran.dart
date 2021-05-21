//import 'dart:html';

import 'dart:io' as io;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soryor/models/kullanici.dart';
import 'package:soryor/services/apiservices.dart';
import 'package:soryor/utils/colorloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

/*
todo  1.tasarım  3.loader gorunsn 
4.resim yükleme 5.token alma 6.diger catchi kontrol et 7.kullanım kosullarını kabul ettim ibaresi
8.valiadtionda karakter sınırını kontrol ettir
 */
class _NewUserState extends State<NewUser> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var storage = FirebaseStorage.instance;
//  StorageReference firebaseStorageRef = FirebaseStorage.instance.ref();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _biocont;
  TextEditingController _kullaniciadcont;
  bool load = false;
  PickedFile _profilFoto;
  String url;
  File file;
  final ImagePicker _picker = ImagePicker();
  firebase_storage.UploadTask uploadTask;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _biocont = TextEditingController();
    _kullaniciadcont = TextEditingController();
  }

  @override
  void dispose() {
    //! Widget kapatıldığında controllerları temizle
    _emailController.dispose();
    _passwordController.dispose();
    _biocont.dispose();
    _kullaniciadcont.dispose();
    super.dispose();
  }

  void _kameradanFotoCek() async {
    PickedFile _yeniResim =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 40);

    setState(() {
      _profilFoto = _yeniResim;
      Navigator.of(context).pop();
    });
  }

  void _galeridenResimSec() async {
    PickedFile _yeniResim =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _profilFoto = _yeniResim;
      debugPrint("galeriden!!!!!!!sıkınıt");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("kaydol builded");
    return Scaffold(
      body: load == true
          ? Center(
              child: ColorLoader3(),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blueGrey, Colors.lightBlueAccent]),
              ),
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Textkaydolwid(),
                          Textaciklawid(),
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 50, right: 50),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.mail), onPressed: null),
                                  Expanded(
                                    child: Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Lütfen emailinizi giriniz';
                                          }
                                          return null;
                                        },
                                        controller: _emailController,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                          //   border: InputBorder.none,
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
                                      icon: Icon(Icons.lock), onPressed: null),
                                  Expanded(
                                    child: Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      child: TextFormField(
                                        controller: _passwordController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Lütfen şifrenizi giriniz';
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          //     border: InputBorder.none,
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 50, right: 50),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.person),
                                      onPressed: null),
                                  Expanded(
                                    child: Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Lütfen kullanıcı adını giriniz';
                                          }
                                          return null;
                                        },
                                        controller: _kullaniciadcont,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          //   border: InputBorder.none,
                                          labelText: 'kullaniciadi'.tr(),
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
                            /*        Padding(
                              padding: const EdgeInsets.only(
                                  top: 50, left: 50, right: 50),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.history),
                                      onPressed: null),
                                  Expanded(
                                    child: Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Lütfen bionuzu giriniz';
                                          }
                                          return null;
                                        },
                                        controller: _biocont,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                          // border: InputBorder.none,
                                          fillColor: Colors.lightBlueAccent,
                                          labelText: 'bio'.tr(),
                                          labelStyle: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),*/
                            /*         ListTile(
                              leading: Icon(Icons.camera),
                              title: Text("Kameradan Çek"),
                              onTap: () {
                                _kameradanFotoCek();
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.image),
                              title: Text("Galeriden Seç"),
                              onTap: () {
                                _galeridenResimSec();
                              },
                            ),*/
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
                              borderRadius: BorderRadius.circular(30)),
                          child: FlatButton(
                            onPressed: () async {
                              //        Navigator.pop(context);
                              if (_formKey.currentState.validate()) {
                                _register();
                              }
                              /*   else {
                                if (_profilFoto == null) {
                                  debugPrint("olazzz dsoya bas00");
                                  return;
                                }
                                print("filea giriyor");
                                file = File(_profilFoto.path);
                                print(file.toString());
                                /*   if (file != null) {
                setState(() {
                  base64Encode(file.readAsBytesSync());
                  //print(base64Encode(file.readAsBytesSync()));
                });
              }*/
                                /* compress() async {
                    final t = await getTemporaryDirectory();
                    final p = t.path;
                  ImD.Image
                  }*/

                                firebase_storage.Reference _storageReference =
                                    storage.ref().child(
                                        '${DateTime.now().millisecondsSinceEpoch}');
                                print(_storageReference.fullPath.toString());
                                /*      final metadata =
                                    firebase_storage.SettableMetadata(
                                        contentType: 'image/jpeg',
                                        customMetadata: {
                                      'picked-file-path': file.path
                                    });
                                print(metadata.toString());*/
                                uploadTask = _storageReference
                                    .putFile(io.File(file.path));
                                await uploadTask.then((onval) async {
                                  print(uploadTask.storage.toString());
                                  url =
                                      await _storageReference.getDownloadURL();
                                  print(url);
                                });

                              
                              }*/
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'kaydol'.tr(),
                                  style: TextStyle(
                                    color: Colors.lightBlueAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.lightBlueAccent,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 30),
                        child: Container(
                          alignment: Alignment.topRight,
                          //color: Colors.red,
                          height: 20,
                          child: Row(
                            children: <Widget>[
                              Text(
                                'hesapvar'.tr(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                              FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, 'login');
                                },
                                child: Text(
                                  'giris',
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

  void _register() async {
    try {
      setState(() {
        load = true;
      });
      debugPrint("register girdi");
      bool varmi = await APIServices.kullanicivarmi(_kullaniciadcont.text);
      if (varmi == true) {
        debugPrint("varmı iicinde");
        setState(() {
          load = false;
        });
        buildflush(
            "Üzgünüz bu kullanıcı adı daha önce alınmış yeni bir kullanıcı adı seçiniz");
        return;
      }
      debugPrint("return konturoli");
      final User user = (await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      _auth.setLanguageCode("tr");
      //  user.sendEmailVerification();
      debugPrint("mail gondermede");
      Kullanici kullanici = Kullanici(0, "bio", 0, 0, 0, "res", "tok",
          _emailController.text, "loc", "ilgi", 0, 0, _kullaniciadcont.text);
      debugPrint("apiservi den hemen once");
      await APIServices.kullaniciekle(kullanici);
      print("apiserv i gectik");
      Navigator.pushReplacementNamed(context, 'login');
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      if (e.toString() ==
          "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
        print("dd");
        setState(() {
          load = false;
        });
        buildflush("Lütfen ..");
      }
    } catch (e) {
      setState(() {
        load = false;
      });
      debugPrint(e.toString());
      debugPrint("diğer pribttee");
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

class Textaciklawid extends StatelessWidget {
  const Textaciklawid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 10.0),
      child: Container(
        //color: Colors.green,
        height: 200,
        width: 200,
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
            ),
            Center(
              child: Text(
                'yelken',
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

class Textkaydolwid extends StatelessWidget {
  const Textkaydolwid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 10),
      child: RotatedBox(
          quarterTurns: -1,
          child: Text(
            'kaydol',
            style: TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.w900,
            ),
          ).tr()),
    );
  }
}
