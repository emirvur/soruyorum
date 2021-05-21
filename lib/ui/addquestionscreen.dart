import 'dart:async';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:soryor/models/altkonu.dart';
import 'package:soryor/models/soru.dart';
import 'package:soryor/models/soruwithkonu.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:provider/provider.dart';
import 'package:soryor/services/apiservices.dart';
import 'package:soryor/utils/colorloader.dart';
import 'package:easy_localization/easy_localization.dart';

class Addquestion extends StatefulWidget {
  @override
  AddquestionState createState() => AddquestionState();
}

class AddquestionState extends State<Addquestion>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController sorucont;
  TextEditingController toplcont;
  List<Altkonu> altlist;
  String selected;
  List<Altkonu> fake = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  /*Future<List<Altkonu>> list() async {
    print("kontrolll");
    //  List<Altkonu> lis = await APIServices.altonual();
    List<Altkonu> lis = await APIServices.altonual();
    print("kontrol222");
    //  print(lis.toString());
    altlist = lis;
    print("soonnn");

    return lis;
  }*/

  @override
  void initState() {
    // _loadList();
    super.initState();
    sorucont = TextEditingController();
    toplcont = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    sorucont.dispose();
    toplcont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(children: [
                SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextField(
                                textInputAction: TextInputAction.done,
                                controller: toplcont,
                                onChanged: (value) async {
                                  setState(() {
                                    APIServices.araaltonual(value)
                                        .then((value) {
                                      print(value);
                                      fake = value;
                                    });
                                  });
                                },
                                decoration: InputDecoration(
                                  prefixIcon: GestureDetector(
                                    child: Icon(Icons.people),
                                    onTap: () {
                                      print("dv");
                                      return showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return new AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              32.0))),
                                              contentPadding:
                                                  EdgeInsets.only(top: 10.0),
                                              content: new Container(
                                                width: 400.0,
                                                height: 450.0,
                                                decoration: new BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: const Color(0xFFFFFF),
                                                  borderRadius:
                                                      new BorderRadius.all(
                                                          new Radius.circular(
                                                              32.0)),
                                                ),
                                                child: new Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: <Widget>[
                                                    // dialog top
                                                    new Expanded(
                                                      child: new Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Center(
                                                              child: new Text(
                                                                'Merak ettiğini sor',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      18.0,
                                                                  //       fontFamily:
                                                                  //         'helvetica_neue_light',
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ),
                                                          IconButton(
                                                              icon: Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              })
                                                        ],
                                                      ),
                                                    ),

                                                    // dialog centre
                                                    new Expanded(
                                                        child: new Container(
                                                      //      height: 50,

                                                      child: TextFormField(
                                                        autofocus: true,
                                                        maxLines: 3,
                                                        maxLength: 100,
                                                        validator: (value) {
                                                          if (value.isEmpty) {
                                                            return 'Sormak istediğiniz soruyu girin ';
                                                          }
                                                          return null;
                                                        },
                                                        controller: sorucont,
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    'Soru'),
                                                      ),
                                                    )
                                                        /*new TextField(
                                                            decoration:
                                                                new InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              filled: false,
                                                              contentPadding:
                                                                  new EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10.0,
                                                                      top: 10.0,
                                                                      bottom:
                                                                          10.0,
                                                                      right:
                                                                          10.0),
                                                              hintText:
                                                                  ' Soru',
                                                              hintStyle:
                                                                  new TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade500,
                                                                fontSize: 12.0,
                                                                //     fontFamily:
                                                                //           'helvetica_neue_light',
                                                              ),
                                                            ),
                                                          )*/

                                                        //flex: 2,
                                                        ),
                                                    new Expanded(
                                                      child: new Container(
                                                        //      height: 50,
                                                        child: Column(
                                                          children: [
                                                            TextField(
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .done,
                                                              controller:
                                                                  toplcont,
                                                              onChanged:
                                                                  (value) async {
                                                                setState(() {
                                                                  APIServices.araaltonual(
                                                                          value)
                                                                      .then(
                                                                          (value) {
                                                                    print(
                                                                        value);
                                                                    fake =
                                                                        value;
                                                                  });
                                                                });
                                                              },
                                                              decoration:
                                                                  InputDecoration(
                                                                prefixIcon:
                                                                    Icon(Icons
                                                                        .people),
                                                                labelText:
                                                                    "Topluluk bul",
                                                                labelStyle: TextStyle(
                                                                    fontSize:
                                                                        24.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .blueAccent),
                                                                border:
                                                                    OutlineInputBorder(),
                                                              ),
                                                            ),
                                                            ListView.builder(
                                                                physics:
                                                                    NeverScrollableScrollPhysics(),
                                                                shrinkWrap:
                                                                    true, //
                                                                itemCount:
                                                                    fake.length,
                                                                itemBuilder:
                                                                    (context,
                                                                        i) {
                                                                  return ListTile(
                                                                    title: Text(
                                                                        fake[i]
                                                                            .altkonu),
                                                                    onTap: () {
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                  );
                                                                }),
                                                          ],
                                                        ),
                                                      ),
                                                      flex: 2,
                                                    ),

                                                    // dialog bottom
                                                    new Expanded(
                                                      child: new Container(
                                                        height: 50,
                                                        padding:
                                                            new EdgeInsets.all(
                                                                16.0),
                                                        decoration:
                                                            new BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          32.0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          32.0)),
                                                          color:
                                                              Colors.blueAccent,
                                                        ),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            //   if (_formKey
                                                            //  .currentState
                                                            //    .validate()) {
                                                            if (sorucont
                                                                .text.isEmpty) {
                                                              buildflush(
                                                                  "Soru kısmı boş olamaz");
                                                              return;
                                                            }
                                                            Soru sor = Soru(
                                                                sorucont.text,
                                                                //       context
                                                                //         .read<KullaniciProvider>()
                                                                //       .kullanici
                                                                //     .kullaniciid,
                                                                context
                                                                    .read<
                                                                        KullaniciProvider>()
                                                                    .kullanici
                                                                    .kullaniciid,
                                                                0,
                                                                0,
                                                                DateTime.now()
                                                                    .toString(),
                                                                15,
                                                                0,
                                                                0);
                                                            bool g =
                                                                await APIServices
                                                                    .gondersoru(
                                                                        sor);
                                                            print(g.toString());
                                                            //   }
                                                          },
                                                          child: new Text(
                                                            'sor',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18.0,
                                                              fontFamily:
                                                                  'helvetica_neue_light',
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ).tr(),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                  labelText: "toplulukbul".tr(),
                                  labelStyle: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
              ]),
            )
          ],
        ),
      ),
    );
  }

  Flushbar buildflush(String message) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
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
