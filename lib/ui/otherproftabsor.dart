import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soryor/models/soru.dart';
import 'package:soryor/models/soruwithkonu.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:soryor/services/apiservices.dart';
import 'package:soryor/utils/colorloader.dart';
import 'package:soryor/utils/constans.dart';
import 'package:provider/provider.dart';
import 'package:soryor/provider/kullaniciprovider.dart';

class OtherTabs extends StatefulWidget {
  final int id;
  OtherTabs(this.id);
  @override
  OtherTabsState createState() => OtherTabsState();
}

class OtherTabsState extends State<OtherTabs>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  Future<List<Soruwithkonu>> list() async {
    print("kontrolll");

    List<Soruwithkonu> lis = await APIServices.sorualkull(widget.id);
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
    return FutureBuilder(
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
                    Soruwithkonu project = projectSnap.data[index];
                    var saat = DateFormat.jm('tr_TR')
                        .format(DateTime.parse(project.tarih));
                    var yil = DateFormat.yMMMEd('tr_TR')
                        .format(DateTime.parse(project.tarih));
                    var tari = yil + "-" + saat;
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(project.sorular.toString()),
                          subtitle: Text(tari),
                        ),
                      ],
                    );
                  },
                ),
              )
            ]),
          );
        });
  }
}
