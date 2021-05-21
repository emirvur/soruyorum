import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:like_button/like_button.dart';
import 'package:soryor/models/favorilerim.dart';
import 'package:soryor/models/soru.dart';
import 'package:soryor/models/soruwithkonu.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:soryor/services/apiservices.dart';
import 'package:soryor/ui/otherporfileui.dart';
import 'package:soryor/utils/colorloader.dart';
import 'package:soryor/utils/constans.dart';
import 'package:provider/provider.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:easy_localization/easy_localization.dart';

class Favui extends StatefulWidget {
  @override
  FavuiState createState() => FavuiState();
}

class FavuiState extends State<Favui> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  Future<List<Favorilerim>> list() async {
    print("fav ilst girddii");
    int ku = context.watch<KullaniciProvider>().kullanici.kullaniciid;
    List<Favorilerim> lis = await APIServices.favsorcev(ku);
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
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          // centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "favori".tr(),
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
          ),
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
                        Favorilerim project = projectSnap.data[index];
                        print(project.cevaptarih);
                        print("favdaa");

                        return buildColoredCard(
                            project.cevaplayan == "-1"
                                ? project.sorular
                                : project.cevaplar,
                            project.cevaplayan == "-1"
                                ? project.soran
                                : project.cevaplayan,
                            project.cevaplayan == "-1"
                                ? project.soranid
                                : project.cevaplayanid,
                            project.cevaplayan == "-1"
                                ? project.sorutarih
                                : project.cevaptarih,
                            project.cevaplayan == "-1"
                                ? project.sorubegenisayisi
                                : project.cevapbegenisayisi,
                            project.mavitik);
                      },
                    ),
                  )
                ]),
              );
            }));
  }

  Widget buildColoredCard(String sorucev, String kulla, int kulid, String tar,
      int begensayisi, int mavitik) {
    var saat = DateFormat.jm('tr_TR').format(DateTime.parse(tar));
    var yil = DateFormat.yMMMEd('tr_TR').format(DateTime.parse(tar));
    var tarih = yil + "-" + saat;
    return Card(
      shadowColor: Colors.red,
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.all(16),
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
                                    kulla,
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
                    alignment: Alignment.bottomLeft, child: Text(sorucev)),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // SizedBox(width: 8),
                    LikeButton(
                      /*  onTap: (bool isLiked) async {
                          /// send your request here
                          await Future.delayed(Duration(seconds: 1));

                          /// if failed, you can do nothing
                          // return success? !isLiked:isLiked;
                          return !isLiked;
                        },*/
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
                          color: Colors.pink,
                          size: 25.0,
                        );
                      },
                      //   likeCount: begensayisi,
                    ),
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
              )
            ],
          )

          /*Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  soru,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: Colors.redAccent,
                        ),
                        Text("15 Beğeni")
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: [
                        Text(
                          kulla,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          tar,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),*/
          ),
    );
  }
}
