import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soryor/models/favorilerim.dart';
import 'package:soryor/models/soru.dart';
import 'package:soryor/models/soruwithkonu.dart';
import 'package:soryor/models/takipettigim.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:soryor/services/apiservices.dart';
import 'package:soryor/utils/colorloader.dart';
import 'package:soryor/utils/constans.dart';
import 'package:provider/provider.dart';
import 'package:soryor/provider/kullaniciprovider.dart';

class Takipui extends StatefulWidget {
  @override
  TakipuiState createState() => TakipuiState();
}

class TakipuiState extends State<Takipui> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  Future<List<Takip>> list() async {
    print("takip ilst girddii");
    //  String ku = context.watch<KullaniciProvider>().kullanici.kullaniciid;
    List<Takip> lis = await APIServices.takip(1);
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
                      Takip project = projectSnap.data[index];

                      return Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(project.takipad.toString()),
                            subtitle: Text(project.altkonu),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ]),
            );
          }),
    );
  }
}
