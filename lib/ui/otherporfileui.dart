import 'package:flutter/material.dart';
import 'package:soryor/models/kullanici.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:soryor/provider/otherprofilprov.dart';
import 'package:soryor/services/apiservices.dart';
import 'package:soryor/ui/editprofileui.dart';
import 'package:soryor/ui/othercevtab.dart';
import 'package:soryor/ui/otherprofeed.dart';
import 'package:soryor/ui/otherproftabsor.dart';
import 'package:soryor/ui/tabcevap.dart';
import 'package:soryor/ui/tabsoru.dart';
import 'package:provider/provider.dart';
import 'package:soryor/utils/colorloader.dart';
import 'package:soryor/utils/constans.dart';
import 'package:soryor/widget/fitem.dart';
import 'package:easy_localization/easy_localization.dart';

import 'feedui.dart';

class OtherProfileui extends StatefulWidget {
  final int kullanicc;

  OtherProfileui({this.kullanicc});

  @override
  _OtherProfileuiState createState() => _OtherProfileuiState();
}

/*
too list  1. takip et butonu  2. ceaplanan soru sayisi ekrnaa ynasıt 
 */

class _OtherProfileuiState extends State<OtherProfileui>
    with AutomaticKeepAliveClientMixin {
  bool takip;
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Future<Kullanici> list(int kullan) async {
    print("otherda listtesin baslıyor");

    print("qqq");
    // String ku = context.watch<KullaniciProvider>().kullanici.kullaniciid;
    int ku = context.watch<KullaniciProvider>().kullanici.kullaniciid;

    print("sss");
    print(ku);
    print("ddd");
    print(kullan.toString());
    Kullanici kul = await APIServices.bakkullanici(kullan);
    print("sssgg");
    print(kul.takipcisayisi.toString());
    print("rr");
    takip = await APIServices.adtakipmi(ku, kullan);
    // context.watch()<Otherprofprov>().takipcisayi = kul.takipcisayisi;
    context.read<Otherprofprov>().ekle(kul.takipcisayisi, takip);
    //Provider.of<Otherprofprov>(context, listen: false).takipcisayi =
    //      kul.takipcisayisi;
    print("ff");

    print("gopppppp");
    // print(lis[0].begenisayisi.toString());

    print("soonnn");

    return kul;
  }

  @override
  Widget build(BuildContext context) {
    print("otherprf buşildede");
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      /*  appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              //   color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('editprofil');
            },
          ),
          //    InkWell(onTap: ,child: Icon(Icons.edit))
        ],
      ),*/
      body: FutureBuilder<Kullanici>(
          future: list(widget.kullanicc),
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.waiting) {
              return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator()));
            } else if (projectSnap.hasError) {
              return Text("hata var internet bağlantınızı kontrol ediniz");
            } else if (projectSnap.data == null) {
              return Text("data null");
            } else if (projectSnap.hasData == null) {
              return Text("hasdata null veri yok");
            }
            return SafeArea(
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.transparent,
                    /*  decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/soryor-bedb2.appspot.com/o/1608387029505?alt=media&token=0aab1aba-d4a3-4fee-936e-f71cf6ba90d0"), //NetworkImage("https://picsum.photos/200"),
                    fit: BoxFit.cover,
                  ),
                ),*/
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Stack(
                      children: <Widget>[
                        Container(
                            //    color: Colors.black38,
                            ),
                        Row(
                          children: [
                            Align(
                              alignment: Alignment(0, -0.7),
                              child: SafeArea(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            CircleAvatar(
                                              maxRadius: 50.0,
                                              backgroundImage: NetworkImage(
                                                  "https://picsum.photos/200"),
                                            ),
                                            SizedBox(height: 8.0),
                                            Text(
                                              projectSnap.data.userad,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 18.0),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.info,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              projectSnap.data.bio,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 4.0),
                                    /*   Text(
                                  "@neecoder_pro",
                                  style: TextStyle(
                                    color: Colors.white30,
                                    fontSize: 12.0,
                                  ),
                                ),*/
                                  ],
                                ),
                              ),
                            ),
                            /*  SizedBox(
                          width: 20,
                        ),
                         Align(
                          alignment: Alignment.center,
                          child: Text(
                            context
                                .watch<KullaniciProvider>()
                                .kullanici
                                .bio
                                .toString(),
                          ),
                        )*/
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: Colors.black45,
                            padding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Fitem(
                                  subtitle:
                                      projectSnap.data.takipsayi.toString(),
                                  title: "takip".tr(),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed("takiplist");
                                  },
                                  child: Fitem(
                                    subtitle: projectSnap.data.takipcisayisi
                                        .toString(),
                                    title: "takipçi".tr(),
                                  ),
                                ),
                                Fitem(
                                  subtitle:
                                      projectSnap.data.sorulansayi.toString(),
                                  title: "sorulansoru".tr(),
                                ),
                                Fitem(
                                  subtitle: projectSnap.data.cevaplanansayi
                                      .toString(),
                                  title: "verilencevap".tr(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                            onPressed: () {},
                            child: takip
                                ? FlatButton(
                                    color: Colors.blueAccent,
                                    textColor: Colors.white,
                                    onPressed: () {},
                                    child: Text("Takipten çık"))
                                : FlatButton(
                                    color: Colors.blueAccent,
                                    textColor: Colors.white,
                                    onPressed: () {},
                                    child: Text("Takip et")))
                      ],
                    ),
                  ),
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
                                  "etkilesim".tr(),
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
                                  "cevaplar".tr(),
                                  style: TextStyle(
                                      fontSize: 20.0, fontFamily: "avenir"),
                                  //  style: TextStyle(color: Colors.black),
                                )),
                                Tab(
                                  //       Icons.question_answer,
                                  //         color: Colors.black,
                                  //         ),
                                  child: Text(
                                    "sorular".tr(),
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
                            Otherfeed(widget.kullanicc),
                            Othertabcevap(widget.kullanicc),
                            OtherTabs(widget.kullanicc)
                          ],
                        ),
                      ),
                    ),
                  )
                  /*   Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    padding: EdgeInsets.all(0.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.03,
                    ),
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage("https://picsum.photos/200"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      margin: EdgeInsets.all(4.0),
                    ),
                  ),
                ),
              ),*/
                ],
              ),
            );
          }),
    );
  }
}
