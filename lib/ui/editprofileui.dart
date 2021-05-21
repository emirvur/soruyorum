import 'dart:io' as io;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soryor/models/kullanici.dart';
import 'package:soryor/models/putkullanici.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:soryor/services/apiservices.dart';
import 'package:soryor/utils/colorloader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
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

  Future<void> _handleClickMe() async {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          //   title: Text('Favorite Dessert'),
          message: Text('Profil fotoğrafını nereden seçeceksiniz?'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text(
                  //  leading: Icon(Icons.camera),
                  "Kameradan Çek"
                  //    onTap: () {
                  //    _kameradanFotoCek();
                  //},
                  ),
              onPressed: () {
                _kameradanFotoCek();
                //    Navigator.of(context).pop();
              },
            ),
            CupertinoActionSheetAction(
              child:
                  //    leading: Icon(Icons.image),
                  Text("Galeriden Seç"),
              //    onTap: () {
              //    _galeridenResimSec();
              //},

              onPressed: () {
                _galeridenResimSec();
                //    Navigator.of(context).pop();
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            child: Text('İptal'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(context.watch<KullaniciProvider>().kullanici.resimurl);
    print("buidled");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blueAccent,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.blueAccent,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('settings');
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "profilduzenle".tr(),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "${context.watch<KullaniciProvider>().kullanici.resimurl}",
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.blueAccent,
                          ),
                          child: InkWell(
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onTap: () async {
                              await _handleClickMe();

                              //     Navigator.of(context).pop();
                            },
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("Kullanıcı adı",
                  context.watch<KullaniciProvider>().kullanici.userad),
              buildTextField(
                  "E-mail", context.watch<KullaniciProvider>().kullanici.email),
              //    buildTextField("Password", "********", true),
              biobuildTextField(
                  "Bio", context.watch<KullaniciProvider>().kullanici.bio),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("iptal".tr(),
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      debugPrint("kaydetteee");
                      if (_profilFoto == null) {
                        debugPrint("olazzz dsoya bas00");
                        Kullanici x =
                            context.read<KullaniciProvider>().kullanici;
                        await APIServices.guncelleuser(
                            x.kullaniciid,
                            Putkullanici(
                                x.kullaniciid,
                                x.mavitik,
                                _biocont.text,
                                x.cevaplanansayi,
                                x.sorulansayi,
                                x.takipcisayisi,
                                x.resimurl,
                                x.tokenid,
                                x.email,
                                x.location,
                                x.ilgi,
                                x.takipsayi,
                                x.userseviye,
                                x.userad));
                        //      context.read<KullaniciProvider>().kullanici.bio =
                        //        _biocont.text;
                        context
                            .read<KullaniciProvider>()
                            .kullanicibiodegistir(_biocont.text);
                        //   _biocont.clear();
                        Navigator.of(context).pop();
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

                      firebase_storage.Reference _storageReference = storage
                          .ref()
                          .child('${DateTime.now().millisecondsSinceEpoch}');
                      print(_storageReference.fullPath.toString());
                      /*      final metadata =
                                    firebase_storage.SettableMetadata(
                                        contentType: 'image/jpeg',
                                        customMetadata: {
                                      'picked-file-path': file.path
                                    });
                                print(metadata.toString());*/
                      uploadTask =
                          _storageReference.putFile(io.File(file.path));
                      await uploadTask.then((onval) async {
                        print(uploadTask.storage.toString());
                        url = await _storageReference.getDownloadURL();
                        print(url);
                        //      context.read<KullaniciProvider>().kullanici.resimurl =
                        //        url;
                        Kullanici x =
                            context.read<KullaniciProvider>().kullanici;
                        bool y = await APIServices.guncelleuser(
                            x.kullaniciid,
                            Putkullanici(
                                x.kullaniciid,
                                x.mavitik,
                                _biocont.text,
                                x.cevaplanansayi,
                                x.sorulansayi,
                                x.takipcisayisi,
                                url,
                                x.tokenid,
                                x.email,
                                x.location,
                                x.ilgi,
                                x.takipsayi,
                                x.userseviye,
                                x.userad));
                        context
                            .read<KullaniciProvider>()
                            .kullanicifotodegistir(_biocont.text, url);
                        // if (y == true) {
                        //     x.bio = _biocont.text;
                        //     }
                        Navigator.of(context).pop();
                      });
                    },
                    color: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "kaydet".tr(),
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        readOnly: true,
        // obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget biobuildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: _biocont,
        // obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: IconButton(icon: Icon(Icons.edit), onPressed: () {}),
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
