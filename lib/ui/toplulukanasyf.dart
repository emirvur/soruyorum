import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:soryor/models/altkonudto.dart';
import 'package:soryor/models/soru.dart';
import 'package:soryor/models/takipettiklerim.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:soryor/services/apiservices.dart';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:soryor/ui/settingsui.dart';
import 'package:soryor/ui/splashscreen.dart';
import 'package:soryor/ui/tabpopsorutopl.dart';
import 'package:soryor/ui/tabsoru.dart';
import 'package:soryor/ui/tabtoplsoru.dart';
import 'package:soryor/ui/tabuyelist.dart';
import 'package:soryor/utils/colorloader.dart';
import 'package:soryor/utils/constans.dart';
import 'package:soryor/widget/fitem.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Toplulukanasyf extends StatefulWidget {
  final int altid;
  Toplulukanasyf({this.altid});
  @override
  _ToplulukanasyfState createState() => _ToplulukanasyfState();
}

class _ToplulukanasyfState extends State<Toplulukanasyf> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController cont;
  int altkonuid;
  String altkonu;
  bool flag;
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

  Future<Dtoaltkonu> list() async {
    print("1111");

    print("qqq");
    Dtoaltkonu lis = await APIServices.altkonuidlial(widget.altid);
    await topltakipmi();
    altkonuid = lis.altkonuid;
    altkonu = lis.altkonu;
    print("gopppppp");
    // print(lis[0].begenisayisi.toString());

    print("soonnn");

    return lis;
  }

  Future topltakipmi() async {
    print("1111");
    var kulid = context.read<KullaniciProvider>().kullanici.kullaniciid;
    print(kulid.toString());
    print(widget.altid.toString());
    print("qqq");
    bool g = await APIServices.topluluktakipmi(kulid, widget.altid);
    flag = g;
    print(flag.toString());
    print("gopppppp");
    // print(lis[0].begenisayisi.toString());

    print("soonnn");
    return g;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              //    useRootNavigator: true,
              context: context,
              builder: (context) {
                return Container(
                  color: Color(0xFF737373),
                  height: 180,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20),
                            topRight: const Radius.circular(20))),
                    child: buildContainer(altkonu),
                  ),
                );
              });
        },
        child: Icon(FontAwesomeIcons.plus),
      ),
      //appBar: AppBar(
      //  title: Column(
      //      children: [Text("fff"), Text("fvvv")],),),
      backgroundColor: Color(0xfff4f4f4),
      body: SafeArea(
        child: FutureBuilder<Dtoaltkonu>(
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
              var saat = DateFormat.jm('tr_TR')
                  .format(DateTime.parse(projectSnap.data.tarih));
              var yil = DateFormat.yMMMEd('tr_TR')
                  .format(DateTime.parse(projectSnap.data.tarih));
              projectSnap.data.tarih = yil + "-" + saat;
              return NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        backgroundColor: Colors.transparent,
                        bottom: PreferredSize(
                            // Add this code
                            preferredSize:
                                Size.fromHeight(275.0), // Add this code
                            child: Column(children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://picsum.photos/200"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 8.0, 10.0, 4.0),
                                child: Row(
                                  children: [
                                    Text(
                                      projectSnap.data.altkonu,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Container(
                                      decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        gradient: new LinearGradient(
                                          colors: [
                                            Colors.blue,
                                            Colors.red,
                                          ],
                                          begin: FractionalOffset.topCenter,
                                          end: FractionalOffset.bottomCenter,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          new FlatButton(
                                              child: new Text(flag == true
                                                  ? "Kanaldan ayrıl"
                                                  : "Katıl"),
                                              onPressed: () async {
                                                setState(() {
                                                  APIServices.takipciekle(
                                                          Takipettiklerim(
                                                              context
                                                                  .read<
                                                                      KullaniciProvider>()
                                                                  .kullanici
                                                                  .kullaniciid,
                                                              projectSnap.data
                                                                  .altkonuid))
                                                      .then((v) {
                                                    flag = v;
                                                    print(v.toString());
                                                  });
                                                });
                                              }),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          new FlatButton(
                                              child: new Text(
                                                'Telegrama git',
                                              ),
                                              onPressed: () async {
                                                const url =
                                                    'https://t.me/kuantummekanik';
                                                if (await canLaunch(url)) {
                                                  await launch(url);
                                                } else {
                                                  throw 'Could not launch $url';
                                                }
                                              }),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    gradient: LinearGradient(
                                        colors: [
                                          Color(0xff6DC8F3),
                                          Color(0xff73A1F9)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xff73A1F9),
                                        blurRadius: 12,
                                        offset: Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 6.0, top: 6.0),
                                          child: Text(
                                            projectSnap.data.grupaciklama,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6.0, bottom: 6.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "${projectSnap.data.uyesayisi.toString()} Üye",
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            // Spacer(),
                                            Text(
                                                "${projectSnap.data.tarih} oluşturuldu",
                                                style: TextStyle(
                                                    fontStyle:
                                                        FontStyle.italic))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]) // Add this code
                            ),
                        //   backgroundColor: this.color,
                        /*  flexibleSpace: FlexibleSpaceBar(
                title: Text("Yopluluk"),
                /*  title: Container(
                /*  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/200"),
                      fit: BoxFit.cover,
                    ),*/

                height: 300, //MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: [
                    Text("fgfdgdgfdg"),
                    Text("fgfdgdgfdg"),
                    Text("fgfdgdgfdg"),
                    Text("fgfdgdgfdg"),
                  ],
                ),
              )*/
              ),*/
                      ),
                    ];
                  },
                  body: Expanded(
                    child: DefaultTabController(
                      length: 3,
                      child: Scaffold(
                        appBar: PreferredSize(
                          preferredSize: Size.fromHeight(50),
                          child: AppBar(
                            backgroundColor: //Colors.blue,
                                Theme.of(context).scaffoldBackgroundColor,
                            //  elevation: 1,
                            bottom: TabBar(
                              labelColor: Colors.blue,
                              unselectedLabelColor: Colors.blue,
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorWeight: 2.0,
                              indicatorPadding: EdgeInsets.zero,
                              indicatorColor: Colors.red,
                              /*    indicator: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)))*/
                              tabs: [
                                Tab(
                                    //    icon: Icon(
                                    //        Icons.device_unknown,
                                    //       color: Colors.black,
                                    //    ),
                                    child: Text(
                                  "Popüler Sorular",
                                  style: TextStyle(
                                      fontSize: 20.0, fontFamily: "avenir"),
                                  //  style: TextStyle(color: Colors.black),
                                )),
                                Tab(
                                    //    icon: Icon(
                                    //        Icons.device_unknown,
                                    //       color: Colors.black,
                                    //    ),
                                    child: Text(
                                  "Son Sorular",
                                  style: TextStyle(
                                      fontSize: 20.0, fontFamily: "avenir"),
                                  //  style: TextStyle(color: Colors.black),
                                )),
                                Tab(
                                  //       Icons.question_answer,
                                  //         color: Colors.black,
                                  //         ),
                                  child: Text(
                                    "Üyeler",
                                    style: TextStyle(
                                        fontSize: 20.0, fontFamily: "avenir"),
                                    //    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        body: TabBarView(
                          children: [
                            Tabpopsoru(deger: widget.altid),
                            Tabtoplsoru(deger: widget.altid),
                            Tabuye(deger: widget.altid)
                          ],
                        ),
                      ),
                    ),
                  ));

              //  );
            }),
      ),
    );
  }

  Container buildContainer(String ad) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "$ad ' soru sor",
              style: TextStyle(fontSize: 18),
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
                                  bool c = await APIServices.soruekle(Soru(
                                      cont.text,
                                      cid,
                                      0,
                                      0,
                                      DateTime.now().toString(),
                                      altkonuid,
                                      0,
                                      0));
                                  if (c == true) {}
                                  Navigator.of(context).pop();
                                }
                              }),
                          hintText: 'Soruyu sor',
                          labelText: 'Soruyu sor',
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
        ],
      ),
    );
  }

  Card test() {
    return Card(
        elevation: 10,
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
                              Text(
                                "Emirhan Vural",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                              Icon(
                                Icons.verified_user,
                                color: Colors.blue,
                                size: 18,
                              )
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
              child: Text(
                  "bu sorunun önemi öok buyuk bakalım biz başarabilecek miyiz diyorum sen ne dersin acaba hemfikir miyiz bu konuda yo yo buna biz rap diyoruz"),
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
                    likeCount: 90,
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
                    likeCount: 687,
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
                        Icons.favorite,
                        color: isLiked ? Colors.pink : Colors.grey,
                        size: 25.0,
                      );
                    },
                    likeCount: 13,
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "13 Nisan 2021 15:02",
                      style: TextStyle(fontSize: 12.0),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

/*import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:soryor/models/altkonudto.dart';
import 'package:soryor/models/soru.dart';
import 'package:soryor/models/takipettiklerim.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:soryor/services/apiservices.dart';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:soryor/ui/settingsui.dart';
import 'package:soryor/ui/splashscreen.dart';
import 'package:soryor/ui/tabpopsorutopl.dart';
import 'package:soryor/ui/tabsoru.dart';
import 'package:soryor/ui/tabtoplsoru.dart';
import 'package:soryor/ui/tabuyelist.dart';
import 'package:soryor/utils/colorloader.dart';
import 'package:soryor/utils/constans.dart';
import 'package:soryor/widget/fitem.dart';
import 'package:provider/provider.dart';

class As extends StatefulWidget {
  final int altid;
  As({this.altid});
  @override
  _AsState createState() => _AsState();
}

class _AsState extends State<As> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController cont;
  int altkonuid;
  String altkonu;

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

  Future<Dtoaltkonu> list() async {
    print("1111");

    print("qqq");
    Dtoaltkonu lis = await APIServices.altkonuidlial(widget.altid);
    altkonuid = lis.altkonuid;
    altkonu = lis.altkonu;
    print("gopppppp");
    // print(lis[0].begenisayisi.toString());

    print("soonnn");

    return lis;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              //    useRootNavigator: true,
              context: context,
              builder: (context) {
                return Container(
                  color: Color(0xFF737373),
                  height: 180,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20),
                            topRight: const Radius.circular(20))),
                    child: buildContainer(altkonu),
                  ),
                );
              });
        },
        child: Icon(Icons.plus_one),
      ),
      //appBar: AppBar(
      //  title: Column(
      //      children: [Text("fff"), Text("fvvv")],),),
      backgroundColor: Color(0xfff4f4f4),
      body: SafeArea(
        child: FutureBuilder<Dtoaltkonu>(
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
              return
                  //  SingleChildScrollView(
                  //  physics: ScrollPhysics(),
                  //  child:
                  Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://picsum.photos/200"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 10.0, 4.0),
                    child: Row(
                      children: [
                        Text(
                          projectSnap.data.altkonu,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: new LinearGradient(
                              colors: [
                                Colors.blue,
                                Colors.red,
                              ],
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                            ),
                          ),
                          child: new FlatButton(
                              child: new Text(
                                'Katıl',
                              ),
                              onPressed: () {
                                //   print('Clicked');
                              }),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                            colors: [Color(0xff6DC8F3), Color(0xff73A1F9)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff73A1F9),
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 6.0, top: 6.0),
                              child: Text(
                                projectSnap.data.grupaciklama,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 6.0, bottom: 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  projectSnap.data.uyesayisi.toString(),
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                                // Spacer(),
                                Text(projectSnap.data.tarih,
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  /*    Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.home),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.photo),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.phone),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),*/
                  Expanded(
                    child: DefaultTabController(
                      length: 3,
                      child: Scaffold(
                        appBar: PreferredSize(
                          preferredSize: Size.fromHeight(50),
                          child: AppBar(
                            backgroundColor: //Colors.blue,
                                Theme.of(context).scaffoldBackgroundColor,
                            //  elevation: 1,
                            bottom: TabBar(
                              labelColor: Colors.blue,
                              unselectedLabelColor: Colors.blue,
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorWeight: 2.0,
                              indicatorPadding: EdgeInsets.zero,
                              indicatorColor: Colors.red,
                              /*    indicator: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)))*/
                              tabs: [
                                Tab(
                                    //    icon: Icon(
                                    //        Icons.device_unknown,
                                    //       color: Colors.black,
                                    //    ),
                                    child: Text(
                                  "Popüler Sorular",
                                  style: TextStyle(
                                      fontSize: 20.0, fontFamily: "avenir"),
                                  //  style: TextStyle(color: Colors.black),
                                )),
                                Tab(
                                    //    icon: Icon(
                                    //        Icons.device_unknown,
                                    //       color: Colors.black,
                                    //    ),
                                    child: Text(
                                  "Son Sorular",
                                  style: TextStyle(
                                      fontSize: 20.0, fontFamily: "avenir"),
                                  //  style: TextStyle(color: Colors.black),
                                )),
                                Tab(
                                  //       Icons.question_answer,
                                  //         color: Colors.black,
                                  //         ),
                                  child: Text(
                                    "Üyeler",
                                    style: TextStyle(
                                        fontSize: 20.0, fontFamily: "avenir"),
                                    //    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        body: TabBarView(
                          children: [
                            Tabpopsoru(deger: widget.altid),
                            Tabtoplsoru(deger: widget.altid),
                            Tabuye(deger: widget.altid)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
              //  );
            }),
      ),
    );
  }

  Container buildContainer(String ad) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("$ad 'a soru soru"),
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
                                  bool c = await APIServices.soruekle(Soru(
                                      cont.text,
                                      cid,
                                      0,
                                      0,
                                      DateTime.now().toString(),
                                      altkonuid,
                                      0,
                                      0));
                                  if (c == true) {}
                                  Navigator.of(context).pop();
                                }
                              }),
                          hintText: 'Soruyu sor',
                          labelText: 'Soruyu sor',
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
        ],
      ),
    );
  }

  Card test() {
    return Card(
        elevation: 10,
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
                              Text(
                                "Emirhan Vural",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                              Icon(
                                Icons.verified_user,
                                color: Colors.blue,
                                size: 18,
                              )
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
              child: Text(
                  "bu sorunun önemi öok buyuk bakalım biz başarabilecek miyiz diyorum sen ne dersin acaba hemfikir miyiz bu konuda yo yo buna biz rap diyoruz"),
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
                    likeCount: 90,
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
                    likeCount: 687,
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
                        Icons.favorite,
                        color: isLiked ? Colors.pink : Colors.grey,
                        size: 25.0,
                      );
                    },
                    likeCount: 13,
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "13 Nisan 2021 15:02",
                      style: TextStyle(fontSize: 12.0),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
*/
