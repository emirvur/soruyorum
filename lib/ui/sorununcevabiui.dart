import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:like_button/like_button.dart';
import 'package:soryor/models/cevap.dart';
import 'package:soryor/models/cevapwithkull.dart';
import 'package:soryor/models/soru.dart';
import 'package:soryor/models/soruwithkonu.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:soryor/services/apiservices.dart';
import 'package:soryor/ui/otherporfileui.dart';
import 'package:soryor/ui/yorumcevap.dart';
import 'package:soryor/utils/colorloader.dart';
import 'package:soryor/utils/constans.dart';
import 'package:provider/provider.dart';
import 'package:soryor/provider/kullaniciprovider.dart';

class Sorucevap extends StatefulWidget {
  final Soruwithkonu soru;

  Sorucevap({this.soru});
  @override
  SorucevapState createState() => SorucevapState();
}

class SorucevapState extends State<Sorucevap>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController cont;
  // final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  Future<List<Cevapwithkull>> list() async {
    print("1111");
    print(widget.soru.soruid);
    print("qqq");
    List<Cevapwithkull> lis =
        await APIServices.sorununcevabial(widget.soru.soruid);
    print("gopppppp");
    // print(lis[0].begenisayisi.toString());

    print("soonnn");

    return lis;
  }

  @override
  void initState() {
    // _loadList();
    super.initState();
    cont = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Column(
                  children: [
                    ListTile(
                      title: Text("vfgffh"),
                    )
                  ],
                );
              });
        },
        child: Icon(FontAwesomeIcons.plus),
      ),*/
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            //   Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blueAccent,
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: list(),
            builder: (context, projectSnap) {
              if (projectSnap.connectionState == ConnectionState.waiting) {
                return Center(child: ColorLoader3());
              } else if (projectSnap.hasError) {
                return Text("hata var internet bağlantınızı kontrol ediniz");
              } else if (projectSnap.data == null) {
                return Text("data null");
              } else if (projectSnap.hasData == null) {
                return Text("hasdata null veri yok");
              }
              return SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(children: [
                  sorucard(
                      widget.soru.sorular,
                      widget.soru.soranid,
                      widget.soru.soranad,
                      widget.soru.tarih,
                      widget.soru.begenisayisi,
                      widget.soru.cevapsayisi,
                      widget.soru.mavitik,
                      widget.soru.cevapsayisi,
                      widget.soru.yorumsayisi),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    height: 8,
                    color: Colors.black,
                  ),
                  Text(
                    "${projectSnap.data.length} Cevap",
                    style: TextStyle(fontSize: 16),
                  ),
                  SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: projectSnap.data.length,
                      itemBuilder: (context, index) {
                        Cevapwithkull project = projectSnap.data[index];

                        return cevapcard(
                            project.cevapid,
                            project.cevaplar,
                            project.cevaplayanid,
                            project.cevaplayan,
                            project.tarih,
                            project.begenisayisi,
                            project.dislikesayisi,
                            project.mavitik,
                            project.yorumsayisi);
                      },
                    ),
                  ),
                  Container(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Lütfen cevabınızı giriniz';
                                  }
                                  return null;
                                },
                                controller: cont,
                                style: TextStyle(
                                  //fontSize: 22.0,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.blue,
                                    ),
                                    onTap: () async {
                                      if (_formKey.currentState.validate()) {
                                        int cid = context
                                            .read<KullaniciProvider>()
                                            .kullanici
                                            .kullaniciid;
                                        bool c = await APIServices.cevapekle(
                                            Cevap(
                                                cont.text,
                                                cid,
                                                0,
                                                0,
                                                DateTime.now().toString(),
                                                widget.soru.soruid,
                                                0,
                                                0));
                                        //    await APIServices.guncellesorununcvpsayi(1, Soru())
                                        if (c == true) {
                                          setState(() {
                                            cont.clear();
                                          });
                                        }
                                      }
                                    },
                                  ),
                                  hintText: 'Cevap yaz',
                                  labelText: 'Cevap yaz',
                                  border: OutlineInputBorder(),
                                ),
                                onSaved: (String girilen) {
                                  //  comment = girilen;
                                },
                              ),
                            ),
                          ],
                        )),
                  )
                ]),
              );
            }),
      ),
    );
  }

  Card cevapcard(int cid, String cevaplar, int cvplynid, String cevaplayan,
      String tar, int begen, int disl, int mavitik, int yid) {
    var saat = DateFormat.jm('tr_TR').format(DateTime.parse(tar));
    var yil = DateFormat.yMMMEd('tr_TR').format(DateTime.parse(tar));
    var tarih = yil + "-" + saat;
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            side: BorderSide(width: 1, color: Colors.black)),
        elevation: 0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 10.0,
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                  Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OtherProfileui(
                                              kullanicc: cvplynid,
                                            )),
                                  );
                                },
                                child: Text(
                                  cevaplayan,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              mavitik == 1
                                  ? Icon(
                                      Icons.verified_user,
                                      color: Colors.blue,
                                      size: 18,
                                    )
                                  : Text("")
                            ],
                          )),
                      // Align(
                      //      alignment: Alignment.topLeft,
                      //        child: Text("21 Mayıs'ta cevaplandı"))
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child:
                  Align(alignment: Alignment.bottomLeft, child: Text(cevaplar)),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LikeButton(
                    onTap: (bool isLiked) async {
                      /// send your request here
                      await Future.delayed(Duration(seconds: 1));

                      /// if failed, you can do nothing
                      // return success? !isLiked:isLiked;

                      return !isLiked;
                    },
                    size: 25.0,
                    circleColor: CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.arrow_upward_rounded,
                        color: isLiked ? Colors.green : Colors.grey,
                        size: 25.0,
                      );
                    },
                    likeCount: begen,
                  ),
                  LikeButton(
                    onTap: (bool isLiked) async {
                      /// send your request here
                      await Future.delayed(Duration(seconds: 1));

                      /// if failed, you can do nothing
                      // return success? !isLiked:isLiked;

                      return !isLiked;
                    },
                    size: 25.0,
                    circleColor: CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.arrow_downward_rounded,
                        color: isLiked ? Colors.red : Colors.grey,
                        size: 25.0,
                      );
                    },
                    likeCount: disl,
                  ),
                  SizedBox(width: 8),
                  LikeButton(
                    onTap: (bool isLiked) async {
                      /// send your request here
                      await Future.delayed(Duration(seconds: 1));

                      /// if failed, you can do nothing
                      // return success? !isLiked:isLiked;
                      return !isLiked;
                    },
                    size: 25.0,
                    circleColor: CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.favorite,
                        color: isLiked ? Colors.pink : Colors.grey,
                        size: 25.0,
                      );
                    },
                    //likeCount: 13,
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      tarih,
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 10,
              color: Colors.black,
            ),
            Center(
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Yorumcevap(
                                x: cid,
                                cvp: Cevapwithkull(
                                    cid,
                                    cevaplar,
                                    cvplynid,
                                    mavitik,
                                    disl,
                                    cevaplayan,
                                    begen,
                                    yid,
                                    tar,
                                    0,
                                    ""),
                              )),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.comment),
                      SizedBox(
                        width: 4,
                      ),
                      Text("$yid "),
                    ],
                  )),
            )
          ],
        ));
    //  );
  }

  Card sorucard(String cevaplar, int cvplynid, String cevaplayan, String tar,
      int begen, int disl, int mavitik, int cevapsayisi, int y) {
    var saat = DateFormat.jm('tr_TR').format(DateTime.parse(tar));
    var yil = DateFormat.yMMMEd('tr_TR').format(DateTime.parse(tar));
    var tarih = yil + "-" + saat;
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            side: BorderSide(width: 1, color: Colors.black)),
        elevation: 0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 10.0,
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                  Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OtherProfileui(
                                              kullanicc: cvplynid,
                                            )),
                                  );
                                },
                                child: Text(
                                  cevaplayan,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              mavitik == 1
                                  ? Icon(
                                      Icons.verified_user,
                                      color: Colors.blue,
                                      size: 18,
                                    )
                                  : Text("")
                            ],
                          )),
                      // Align(
                      //      alignment: Alignment.topLeft,
                      //        child: Text("21 Mayıs'ta cevaplandı"))
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child:
                  Align(alignment: Alignment.bottomLeft, child: Text(cevaplar)),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LikeButton(
                    onTap: (bool isLiked) async {
                      /// send your request here
                      await Future.delayed(Duration(seconds: 1));

                      /// if failed, you can do nothing
                      // return success? !isLiked:isLiked;

                      return !isLiked;
                    },
                    size: 25.0,
                    circleColor: CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.arrow_upward_rounded,
                        color: isLiked ? Colors.green : Colors.grey,
                        size: 25.0,
                      );
                    },
                    likeCount: begen,
                  ),
                  LikeButton(
                    onTap: (bool isLiked) async {
                      /// send your request here
                      await Future.delayed(Duration(seconds: 1));

                      /// if failed, you can do nothing
                      // return success? !isLiked:isLiked;

                      return !isLiked;
                    },
                    size: 25.0,
                    circleColor: CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.arrow_downward_rounded,
                        color: isLiked ? Colors.red : Colors.grey,
                        size: 25.0,
                      );
                    },
                    likeCount: disl,
                  ),
                  SizedBox(width: 8),
                  LikeButton(
                    onTap: (bool isLiked) async {
                      /// send your request here
                      await Future.delayed(Duration(seconds: 1));

                      /// if failed, you can do nothing
                      // return success? !isLiked:isLiked;
                      return !isLiked;
                    },
                    size: 25.0,
                    circleColor: CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.favorite,
                        color: isLiked ? Colors.pink : Colors.grey,
                        size: 25.0,
                      );
                    },
                    //likeCount: 13,
                  ),
                  //  Text("$cevapsayisi Cevap"),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      tarih,
                      style: TextStyle(fontSize: 12.0),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 10,
              color: Colors.black,
            ),
            Center(
              child: InkWell(
                  /* onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Yorumcevap(
                                x: cid,
                                cvp: Cevapwithkull(
                                    cid,
                                    cevaplar,
                                    cvplynid,
                                    mavitik,
                                    disl,
                                    cevaplayan,
                                    begen,
                                    yid,
                                    tar,
                                    0,
                                    ""),
                              )),
                    );
                  },*/
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.comment),
                  SizedBox(
                    width: 4,
                  ),
                  Text("$y "),
                ],
              )),
            )
          ],
        ));
    //  );
  }

  Card buildContainer(String cevaplar, int cvplynid, String cevaplayan,
      String tar, int begen, int disl, int mavitik) {
    return /* Container(
      height: 150,
      //      margin: EdgeInsets.only(top: 15, bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          //  boxShadow: shadowList,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
      child:*/
        Card(
      // elevation: 10,
      child: Row(
        children: [
          Column(
            children: [
              LikeButton(
                onTap: (bool isLiked) async {
                  /// send your request here
                  await Future.delayed(Duration(seconds: 1));

                  /// if failed, you can do nothing
                  // return success? !isLiked:isLiked;

                  return !isLiked;
                },
                size: 25.0,
                circleColor: CircleColor(
                    start: Color(0xff00ddff), end: Color(0xff0099cc)),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: Color(0xff33b5e5),
                  dotSecondaryColor: Color(0xff0099cc),
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.arrow_upward,
                    color: isLiked ? Colors.green : Colors.grey,
                    size: 25.0,
                  );
                },
                //   likeCount: 665,
                countBuilder: (int count, bool isLiked, String text) {
                  var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                  Widget result;
                  if (count == 0) {
                    result = Text(
                      "love",
                      style: TextStyle(color: color),
                    );
                  } else
                    result = Text(
                      text,
                      style: TextStyle(color: color),
                    );
                  return result;
                },
              ),
              Text(begen.toString()),
              LikeButton(
                onTap: (bool isLiked) async {
                  /// send your request here
                  await Future.delayed(Duration(seconds: 1));

                  /// if failed, you can do nothing
                  // return success? !isLiked:isLiked;

                  return !isLiked;
                },
                size: 25.0,
                circleColor: CircleColor(
                    start: Color(0xff00ddff), end: Color(0xff0099cc)),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: Color(0xff33b5e5),
                  dotSecondaryColor: Color(0xff0099cc),
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.arrow_downward,
                    color: isLiked ? Colors.red : Colors.grey,
                    size: 25.0,
                  );
                },
                // likeCount: 665,
                countBuilder: (int count, bool isLiked, String text) {
                  var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                  Widget result;
                  if (count == 0) {
                    result = Text(
                      "love",
                      style: TextStyle(color: color),
                    );
                  } else
                    result = Text(
                      text,
                      style: TextStyle(color: color),
                    );
                  return result;
                },
              ),
            ],
          ),
          SizedBox(
            width: 6.0,
          ),
          Expanded(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    cevaplar,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Avenir',
                      //   fontWeight: FontWeight.w700,
                      //     color: Colors.black
                    ),
                  ),
                ),
                Divider(
                  height: 6.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        //      Text("$cvp Cevap"),
                        //   SizedBox(
                        //   width: 4.0,
                        //),
                        LikeButton(
                          onTap: (bool isLiked) async {
                            /// send your request here
                            await Future.delayed(Duration(seconds: 1));

                            /// if failed, you can do nothing
                            // return success? !isLiked:isLiked;

                            return !isLiked;
                          },
                          size: 25.0,
                          circleColor: CircleColor(
                              start: Color(0xff00ddff), end: Color(0xff0099cc)),
                          bubblesColor: BubblesColor(
                            dotPrimaryColor: Color(0xff33b5e5),
                            dotSecondaryColor: Color(0xff0099cc),
                          ),
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              Icons.favorite,
                              color: isLiked ? Colors.red : Colors.grey,
                              size: 25.0,
                            );
                          },
                          likeCount: 665,
                          countBuilder: (int count, bool isLiked, String text) {
                            var color =
                                isLiked ? Colors.deepPurpleAccent : Colors.grey;
                            Widget result;
                            if (count == 0) {
                              result = Text(
                                "love",
                                style: TextStyle(color: color),
                              );
                            } else
                              result = Text(
                                text,
                                style: TextStyle(color: color),
                              );
                            return result;
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(tar),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OtherProfileui(
                                        kullanicc: cvplynid,
                                      )),
                            );
                          },
                          child: Text(
                            cevaplayan,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16.0,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    //  );
  }
}
