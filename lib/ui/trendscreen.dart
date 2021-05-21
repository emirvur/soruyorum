import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:soryor/models/altkonu.dart';
import 'package:soryor/models/favsorcevap.dart';
import 'package:soryor/models/konu.dart';
import 'package:soryor/models/putsoru.dart';
import 'package:soryor/provider/listprovider.dart';
import 'package:soryor/provider/themeprovider.dart';
import 'package:soryor/ui/home.dart';
import 'package:soryor/models/kullanici.dart';
import 'package:soryor/models/soru.dart';
import 'package:soryor/models/soruwithkonu.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:soryor/services/apiservices.dart';
import 'package:soryor/services/notificationhandler.dart';
import 'package:soryor/ui/otherporfileui.dart';
import 'package:soryor/ui/sorununcevabiui.dart';
import 'package:soryor/ui/toplulukanasyf.dart';
import 'package:soryor/utils/constans.dart';
import 'package:provider/provider.dart';
import 'yorumsoru.dart';
import 'drawerscreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [DrawerScreen(), TrendScreen()],
      ),
    );
  }
}
//todo  1.appbar sliverappbar olsun arama kutuucgu alta inilse bile görülebisin

class TrendScreen extends StatefulWidget {
  @override
  _TrendScreenState createState() => _TrendScreenState();
}

class _TrendScreenState extends State<TrendScreen>
    with AutomaticKeepAliveClientMixin {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  //List<Soru> hazir;
  List<Color> renk = [
    Colors.blue,
    Colors.yellow,
    Colors.red,
    Colors.purple,
    Colors.pink,
    Colors.orange,
    Colors.green,
    Colors.brown,
    Colors.teal,
    Colors.cyan
  ];
  bool isDrawerOpen = false;

  List<Konu> konu;
  bool konulusoru = false;
  bool pop = true;
  int x;
  TextEditingController cont;
  List<Altkonu> l = [
    // Altkonu(1, "q", 2),
    //Altkonu(1, "q", 2),
    //Altkonu(1, "q", 2)
  ];
  List<Kullanici> kul;
  var token;
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Future<List<Soruwithkonu>> list() async {
    print("kontrolll");

    List<Soruwithkonu> lis = await APIServices.sorual();
    konu = await APIServices.konual();
    print("kontrol222");
    print(lis.toString());

    print("soonnn");

    return lis;
  }

  Future<List<Soruwithkonu>> tarihlilist() async {
    print("kontrolll");

    List<Soruwithkonu> lis = await APIServices.tarihlisorual();
    //konu = await APIServices.konual();
    print("kontrol222");
    print(lis.toString());

    print("soonnn");

    return lis;
  }

  Future<List<Soruwithkonu>> poptopltrend() async {
    print("kontrolll");

    List<Soruwithkonu> lis = await APIServices.poptrendtoplsoru(x);

    print("kontrol222");
    print(lis.toString());

    print("soonnn");

    return lis;
  }

  Future<List<Soruwithkonu>> konulusorulist() async {
    print("kontrolll");

    List<Soruwithkonu> lis = await APIServices.konulusorualkull(x);

    print("kontrol222");
    print(lis.toString());

    print("soonnn");

    return lis;
  }

  Future<List<Altkonu>> arakana(String x) async {
    print("kontrolll");

    List<Altkonu> li = await APIServices.araaltonual(x);

    print("kontrol222");
    print(li.toString());
    l = li;
    print("soonnn");

    return li;
  }

  Future<List<Kullanici>> arakulla(String x) async {
    print("kontrolll");

    List<Kullanici> li = await APIServices.arakulla(x);

    print("kontrol222");
    print(li.toString());
    kul = li;
    print("soonnn");

    return li;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationHandler().initializeFCMNotification(context);
    /* FirebaseMessaging _fcm = FirebaseMessaging();
    _fcm.getToken().then((value) => token = value);
    print(token);*/
    cont = TextEditingController();
  }

  @override
  void dispose() {
    cont.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isDrawerOpen
                      ? IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              scaleFactor = 1;
                              isDrawerOpen = false;
                            });
                          },
                        )
                      : IconButton(
                          color: Colors.black,
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            setState(() {
                              xOffset = 230;
                              yOffset = 150;
                              scaleFactor = 0.6;
                              isDrawerOpen = true;
                            });
                          }),
                  Column(
                    children: [
                      Text(
                        context.watch<KullaniciProvider>().kullanici.userad,
                        style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontSize: 18.0),
                      ),
                      /*  Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: primaryGreen,
                          ),
                          Text('Ukraine'),
                        ],
                      ),*/
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        kpid = 1;
                        //   context.read<ThemeNotifier>().gg = 1;
                        //    HomeState.onItemTapped(6);
                      },
                      child: CircleAvatar())
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  //   color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  TextField(
                    textInputAction: TextInputAction.done,
                    controller: cont,
                    onChanged: (value) async {
                      if (cont.text == "#") {
                        return;
                      }
                      if (cont.text.startsWith("#") == true) {
                        kul = await arakulla(value.substring(1));
                      } else {
                        context.read<Listprovider>().ara(value);
                        //     l = await arakana(value);
                      }

                      //     setState(() {});
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: "ara".tr(),
                      labelStyle: TextStyle(
                          //    fontSize: 24.0,
                          //      fontWeight: FontWeight.bold,
                          color: Colors.black),
                      //   border: OutlineInputBorder()
                    ),
                  ),
                ],
              ),
            ),
            Consumer<Listprovider>(
              builder: (_, bar, __) => ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true, //
                  itemCount: pro.length ?? 0,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(pro[i].altkonu.toString()),
                      onTap: () {
                        print("calistıı ontap");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Toplulukanasyf(
                                    altid: pro[i].altkonuid,
                                  )),
                        );
                        /*     setState(() {
                       
                          l = [];
                        });*/
                      },
                    );
                  }),
            ),
            /*   ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true, //
                itemCount: pro.length ?? 0,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(pro[i].altkonu.toString()),
                
                    onTap: () {
                      setState(() {
                        //    cont.text = l[i].adsoyad;
                        //  cari = l[i];

                        l = [];
                      });
                    },
                  );
                }),*/
            /* Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: Icon(Icons.search), onPressed: () {}),
                  Text('ara').tr(),
                  //   Icon(Icons.settings)
                ],
              ),
            ),*/
            FutureBuilder(
                future: konulusoru == true
                    ? pop == true
                        ? poptopltrend()
                        : konulusorulist()
                    : pop == true
                        ? list()
                        : tarihlilist(),
                builder: (context, projectSnap) {
                  if (projectSnap.connectionState == ConnectionState.waiting) {
                    return Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(child: CircularProgressIndicator()));
                  } else if (projectSnap.hasError) {
                    return Text(
                        "hata var internet bağlantınızı kontrol ediniz");
                  } else if (projectSnap.data == null) {
                    return Text("data null");
                  } else if (projectSnap.hasData == null) {
                    return Text("hasdata null veri yok");
                  }
                  return Column(
                    children: [
                      Container(
                        height: 75,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: konu.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  x = konu[index].konuid;
                                  konulusoru = true;
                                });
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      padding: EdgeInsets.all(4),
                                      margin: EdgeInsets.only(left: 20),
                                      decoration: BoxDecoration(
                                          color: renk[index], //  Colors.blue,
                                          boxShadow: shadowList,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    //    Text(categories[index]['name'])
                                    Center(
                                        child: Text(
                                      konu[index].konular,
                                      style: TextStyle(color: Colors.black),
                                    ))
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "sorular".tr(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            )),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          //  decoration: BoxDecoration(
                          //      border: Border.all(), //color: Colors.black),
                          //      ),
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    pop = true;
                                  });
                                },
                                child: Chip(
                                  avatar: CircleAvatar(
                                    backgroundColor: Colors.grey.shade800,
                                    child: Icon(FontAwesomeIcons.hotjar),
                                  ),
                                  label: Text('trendler'.tr()),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    pop = false;
                                  });
                                },
                                child: Chip(
                                  avatar: CircleAvatar(
                                    backgroundColor: Colors.grey.shade800,
                                    child: Icon(Icons.new_releases),
                                  ),
                                  label: Text('newest'.tr()),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: projectSnap.data.length,
                          itemBuilder: (context, index) {
                            Soruwithkonu project = projectSnap.data[index];
                            return sorucard(
                                project.sorular,
                                project.soranid,
                                project.soranad,
                                project.tarih,
                                project.begenisayisi,
                                project.dislikesayisi,
                                project.mavitik,
                                project.cevapsayisi,
                                project.altkonusu,
                                project.soruid,
                                project.yorumsayisi,
                                project.altkonuid);
                          },
                        ),
                      ),
                    ],
                  );
                }),
            //SizedBox(
            //  height: 20,
            //  )
          ],
        ),
      ),
    );
  }

  Card sorucard(
      String cevaplar,
      int cvplynid,
      String cevaplayan,
      String tar,
      int begen,
      int disl,
      int mavitik,
      int cevapsayisi,
      String altk,
      int sid,
      int yorsayi,
      int aid) {
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
              padding: const EdgeInsets.all(1.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 7.0,
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
                                  kpid = cvplynid;
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
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Sorucevap(
                                    soru: Soruwithkonu(
                                        sid,
                                        cevaplar,
                                        mavitik,
                                        cevapsayisi,
                                        cvplynid,
                                        begen,
                                        disl,
                                        yorsayi,
                                        tar,
                                        altk,
                                        cevaplayan,
                                        aid),
                                  )),
                        );
                      },
                      child: Text(cevaplar))),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LikeButton(
                    onTap: (bool isLiked) async {
                      /// send your request here
                      // await Future.delayed(Duration(seconds: 1));
                      await APIServices.guncellesoru(
                          sid,
                          Putsoru(sid, cevaplar, cvplynid, begen + 1,
                              cevapsayisi, tar, 1, disl, yorsayi),
                          begen + 1);

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
                      //    await Future.delayed(Duration(seconds: 1));
                      await APIServices.gonderfav(Favsorucevap(
                          DateTime.now().toString(),
                          context
                              .read<KullaniciProvider>()
                              .kullanici
                              .kullaniciid,
                          soruid: sid));

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
                  Chip(label: Text(altk)),
                  //   Text("$cevapsayisi Cevap"),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      //  Navigator.push(
                      //      context,
                      //        MaterialPageRoute(builder: (context) => Test1(x: sid)),
                      //        );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.question_answer_outlined),
                        SizedBox(
                          width: 4,
                        ),
                        Text("$cevapsayisi "),
                      ],
                    )),
                SizedBox(
                  width: 30,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Yorumsoru(
                                  x: sid,
                                  sor: Soruwithkonu(
                                      sid,
                                      cevaplar,
                                      mavitik,
                                      cevapsayisi,
                                      cvplynid,
                                      begen,
                                      disl,
                                      yorsayi,
                                      tar,
                                      altk,
                                      cevaplayan,
                                      aid),
                                )),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.comment),
                        SizedBox(
                          width: 4,
                        ),
                        Text("$yorsayi "),
                      ],
                    )),
              ],
            )
          ],
        ));
    //  );
  }

  /* Card buildContainer(int begsayi, int cvp, String sor, String tar, String ad,
      int id, int mavitik, int soruid, String altk) {
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
              Text(begsayi.toString()),
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
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Sorucevap(
                                  soru: Soruwithkonu(soruid, sor, mavitik, cvp,
                                      id, begsayi, tar, altk, ad),
                                )),
                      );
                    },
                    child: Text(
                      sor,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Avenir',
                        //   fontWeight: FontWeight.w700,
                        //     color: Colors.black
                      ),
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
                        Text("$cvp Cevap"),
                        SizedBox(
                          width: 4.0,
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
                                        kullanicc: id,
                                      )),
                            );
                          },
                          child: Text(
                            ad,
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
  }*/
}
