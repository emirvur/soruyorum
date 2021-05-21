import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:soryor/models/cevapwithkull.dart';
import 'package:soryor/models/soru.dart';
import 'package:soryor/models/soruwithkonu.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:soryor/services/apiservices.dart';
import 'package:soryor/utils/colorloader.dart';
import 'package:soryor/utils/constans.dart';
import 'package:provider/provider.dart';
import 'package:soryor/provider/kullaniciprovider.dart';

class Othertabcevap extends StatefulWidget {
  final int id;
  Othertabcevap(this.id);
  @override
  OthertabcevapState createState() => OthertabcevapState();
}

class OthertabcevapState extends State<Othertabcevap>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  Future<List<Cevapwithkull>> list() async {
    print("kontrolll");

    List<Cevapwithkull> lis = await APIServices.cevapalkul(widget.id);
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
                    Cevapwithkull project = projectSnap.data[index];
                    var saat = DateFormat.jm('tr_TR')
                        .format(DateTime.parse(project.tarih));
                    var yil = DateFormat.yMMMEd('tr_TR')
                        .format(DateTime.parse(project.tarih));
                    var tarih = yil + "-" + saat;
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(project.cevaplar.toString()),
                          subtitle: Text(tarih),
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
