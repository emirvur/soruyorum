import 'package:like_button/like_button.dart';
import 'package:soryor/models/dtokull.dart';
import 'package:soryor/models/soruwithkonu.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:soryor/services/apiservices.dart';
import 'package:soryor/utils/colorloader.dart';

import 'otherporfileui.dart';
import 'package:flutter/material.dart';

class Tabuye extends StatefulWidget {
  final int deger;

  Tabuye({this.deger});
  @override
  TabuyeState createState() => TabuyeState();
}

class TabuyeState extends State<Tabuye> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  Future<List<Dtokull>> list() async {
    print("kontrolll");
    List<Dtokull> lis = await APIServices.uyetopluluk(widget.deger);
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
                    Dtokull project = projectSnap.data[index];

                    return kullainicicard(
                        project.kullaniciid, project.mavitik, project.userad);
                  },
                ),
              )
            ]),
          );
        });
  }

  Card kullainicicard(int kulid, int mavitik, String userad) {
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
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OtherProfileui(
                                              kullanicc: kulid,
                                            )),
                                  );
                                },
                                child: Text(
                                  userad,
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
          ],
        ));
    //  );
  }
}
