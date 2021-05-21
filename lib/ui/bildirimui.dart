import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:like_button/like_button.dart';
import 'package:soryor/models/dtobildirim.dart';
import 'package:soryor/models/favorilerim.dart';
import 'package:soryor/models/feeds.dart';
import 'package:soryor/models/soru.dart';
import 'package:soryor/models/soruwithkonu.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:soryor/services/apiservices.dart';
import 'package:soryor/ui/otherporfileui.dart';
import 'package:soryor/utils/colorloader.dart';
import 'package:soryor/utils/constans.dart';
import 'package:provider/provider.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:flutter/gestures.dart';
import 'package:easy_localization/easy_localization.dart';

class Notificationui extends StatefulWidget {
  @override
  NotificationuiState createState() => NotificationuiState();
}

class NotificationuiState extends State<Notificationui>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  Future<List<Dtobildirimhaber>> list() async {
    print("feed ilst girddii");
    int ku = context.watch<KullaniciProvider>().kullanici.kullaniciid;
    List<Dtobildirimhaber> lis = await APIServices.bildirimal(ku);
    print("kontrol222");
    print(lis.toString());

    print("soonnn");

    return lis;
  }

  @override
  void initState() {
    // _loadList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "bildirim".tr(),
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
            ),
            /*    Divider(
              height: 3,
              color: Colors.black,
            )*/
          ],
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
                  SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: projectSnap.data.length,
                      itemBuilder: (context, index) {
                        Dtobildirimhaber project = projectSnap.data[index];

                        return Column(
                          children: <Widget>[
                            ListTile(
                              leading: project.soruid == -1
                                  ? project.cevapid == -1
                                      ? Icon(FontAwesomeIcons.eye,
                                          color: Colors.blue)
                                      : Icon(
                                          Icons.favorite,
                                          color: Colors.pink,
                                        )
                                  : Icon(Icons.favorite, color: Colors.pink),
                              title: project.soruid == -1
                                  ? project.cevapid == -1
                                      ? RichText(
                                          text: TextSpan(
                                            //  style: TextStyle(color: Colors.black, fontSize: 18),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      OtherProfileui(
                                                                        kullanicc:
                                                                            project.digkulid,
                                                                      )));
                                                        },
                                                  text: '${project.digkul} ',
                                                  style: TextStyle(
                                                      color: Colors.blue)),
                                              TextSpan(
                                                  text: "takibebasladi".tr(),
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              //    TextSpan(text: 'com', style: TextStyle(decoration: TextDecoration.underline))
                                            ],
                                          ),
                                        ) //Text("${project.digkul} seni takip etmeye başladı")
                                      : RichText(
                                          text: TextSpan(
                                            //  style: TextStyle(color: Colors.black, fontSize: 18),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      OtherProfileui(
                                                                        kullanicc:
                                                                            project.digkulid,
                                                                      )));
                                                        },
                                                  text: '${project.digkul} ',
                                                  style: TextStyle(
                                                      color: Colors.blue)),
                                              TextSpan(
                                                  text: 'cevapbeg '.tr(),
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              //    TextSpan(text: 'com', style: TextStyle(decoration: TextDecoration.underline))
                                            ],
                                          ),
                                        ) //Text("${project.digkul} cevabını favladı")
                                  : RichText(
                                      text: TextSpan(
                                        //  style: TextStyle(color: Colors.black, fontSize: 18),
                                        children: <TextSpan>[
                                          TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              OtherProfileui(
                                                                kullanicc: project
                                                                    .digkulid,
                                                              )));
                                                },
                                              text: '${project.digkul} ',
                                              style: TextStyle(
                                                  color: Colors.blue)),
                                          TextSpan(
                                              text: 'sorubeg'.tr(),
                                              style: TextStyle(
                                                  color: Colors.black)),
                                          //    TextSpan(text: 'com', style: TextStyle(decoration: TextDecoration.underline))
                                        ],
                                      ),
                                    ), //Text("${project.digkul} sorunu favladı"),
                              subtitle: project.soruid == -1
                                  ? project.cevapid == -1
                                      ? Text("")
                                      : project.cevap
                                  : Text(project.soru),
                            ),
                            Divider(
                              height: 3,
                            )
                          ],
                        );
                      },
                    ),
                  )
                ]),
              );
            }),
      ),
    );
  }
}
