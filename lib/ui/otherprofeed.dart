import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:like_button/like_button.dart';
import 'package:soryor/models/favorilerim.dart';
import 'package:soryor/models/feeds.dart';
import 'package:soryor/models/soru.dart';
import 'package:soryor/models/soruwithkonu.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:soryor/services/apiservices.dart';
import 'package:soryor/utils/colorloader.dart';
import 'package:soryor/utils/constans.dart';
import 'package:provider/provider.dart';
import 'package:soryor/provider/kullaniciprovider.dart';

class Otherfeed extends StatefulWidget {
  int id;
  Otherfeed(this.id);
  @override
  OtherfeedState createState() => OtherfeedState();
}

class OtherfeedState extends State<Otherfeed>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  Future<List<Feeds>> list() async {
    print("feed ilst girddii");

    List<Feeds> lis = await APIServices.feed(widget.id);
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
                        Feeds project = projectSnap.data[index];

                        return Column(
                          children: <Widget>[
                            ListTile(
                              leading: project.soruid != -1
                                  ? Icon(Icons.question_answer)
                                  : project.cevapid != -1
                                      ? Icon(Icons.question_answer_sharp)
                                      : Icon(Icons.follow_the_signs),
                              title: project.soruid == -1
                                  ? project.cevapid == -1
                                      ? Text(
                                          "${project.takma} takip etmeye başladı")
                                      : Text("Cevap")
                                  : Text("Soru"),
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
