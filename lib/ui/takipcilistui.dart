import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soryor/models/dtokull.dart';
import 'package:soryor/models/favorilerim.dart';
import 'package:soryor/models/soru.dart';
import 'package:soryor/models/soruwithkonu.dart';
import 'package:soryor/models/takipettigim.dart';
import 'package:soryor/models/takipettiklerim.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:soryor/services/apiservices.dart';
import 'package:soryor/utils/colorloader.dart';
import 'package:soryor/utils/constans.dart';
import 'package:provider/provider.dart';
import 'package:soryor/provider/kullaniciprovider.dart';

class Takipcilist extends StatefulWidget {
  @override
  TakipcilistState createState() => TakipcilistState();
}

class TakipcilistState extends State<Takipcilist>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  Future<List<Dtokull>> list() async {
    print("takipci ilst girddii");
    int ku = context.watch<KullaniciProvider>().kullanici.kullaniciid;
    List<Dtokull> lis = await APIServices.takipcilistesi(ku);
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
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Center(
              child: Text(
            "Takipçi Listesi",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: FutureBuilder(
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
                        Dtokull project = projectSnap.data[index];

                        return buildListTile(project.userad, project.mavitik);
                      },
                    ),
                  )
                ]),
              );
            }));
  }

  Column buildListTile(String ad, int mavi) {
    return Column(
      children: [
        ListTile(
          title: Align(alignment: Alignment.topLeft, child: Text(ad)),
          trailing: FlatButton.icon(
              onPressed: () {},
              icon: mavi == 1
                  ? Icon(
                      Icons.follow_the_signs,
                      color: Colors.blue,
                    )
                  : Text(""),
              label: Text(
                "Takip et",
                style: TextStyle(color: Colors.blue),
              )),
        ),
        Divider(
          height: 18.0,
          color: Colors.black,
        )
      ],
    );
  }
}
