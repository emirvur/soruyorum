import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soryor/provider/themeprovider.dart';
import 'package:soryor/ui/toplulukanasyf.dart';
import 'package:soryor/models/altkonu.dart';
import 'package:soryor/models/altkonudto.dart';
import 'package:soryor/models/cevapwithkull.dart';
import 'package:soryor/models/konu.dart';
import 'package:soryor/models/soru.dart';
import 'package:soryor/models/soruwithkonu.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'package:soryor/services/apiservices.dart';
import 'package:soryor/utils/colorloader.dart';
import 'package:soryor/utils/constans.dart';
import 'package:provider/provider.dart';
import 'package:soryor/provider/kullaniciprovider.dart';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';

class Toplulukui extends StatefulWidget {
  @override
  ToplulukuiState createState() => ToplulukuiState();
}

class ToplulukuiState extends State<Toplulukui>
    with AutomaticKeepAliveClientMixin {
  List<Konu> konu;
  int x;
  bool konulusoru = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController cont;
  List<Color> renk = [
    Colors.blue,
    Colors.yellow,
    Colors.red,
    Colors.purple,
    Colors.pink,
    Colors.orange,
    Colors.green,
    Colors.brown,
    Colors.cyan
  ];
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  Future<List<Dtoaltkonu>> list() async {
    print("alrtkonu listt");

    List<Dtoaltkonu> lis = await APIServices.altonual();
    konu = await APIServices.konual();
    print("kontrol222");
    print(lis.toString());

    print("soonnn");

    return lis;
  }

  Future<List<Dtoaltkonu>> konulutopluluklist() async {
    print("kontrolll");

    List<Dtoaltkonu> lis = await APIServices.konudanalt(x);

    print("kontrol222");
    print(lis.toString());

    print("soonnn");

    return lis;
  }

  @override
  void initState() {
    // _loadList();
    super.initState();
    cont = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cont.dispose();
    super.dispose();
  }

  final double _borderRadius = 24;

  var items = [
    PlaceInfo('Dubai Mall Food Court', Color(0xff6DC8F3), Color(0xff73A1F9),
        4.4, 'Dubai · In The Dubai Mall', 'Cosy · Casual · Good for kids'),
    PlaceInfo('Hamriyah Food Court', Color(0xffFFB157), Color(0xffFFA057), 3.7,
        'Sharjah', 'All you can eat · Casual · Groups'),
    PlaceInfo('Gate of Food Court', Color(0xffFF5B95), Color(0xffF8556D), 4.5,
        'Dubai · Near Dubai Aquarium', 'Casual · Groups'),
    PlaceInfo('Express Food Court', Color(0xffD76EF5), Color(0xff8F7AFE), 4.1,
        'Dubai', 'Casual · Good for kids · Delivery'),
    PlaceInfo('BurJuman Food Court', Color(0xff42E695), Color(0xff3BB2B8), 4.2,
        'Dubai · In BurJuman', '...'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                //    useRootNavigator: true,
                context: context,
                builder: (context) {
                  return Container(
                    color: Color(0xFF737373),
                    height: 400,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(20),
                                topRight: const Radius.circular(20))),
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Yeni kanal işlemi"),
                              ),
                              Container(
                                child: Form(
                                    key: formKey,
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Lütfen kanal adını giriniz';
                                              }
                                              return null;
                                            },
                                            controller: cont,
                                            style: TextStyle(
                                              //fontSize: 22.0,
                                              color: Colors.black,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: 'Yeni kanal ekle',
                                              labelText: 'Yeni kanal ekle',
                                              border: OutlineInputBorder(),
                                            ),
                                            onSaved: (String girilen) {
                                              //  comment = girilen;
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Lütfen kanal açıklamasını giriniz';
                                              }
                                              return null;
                                            },
                                            controller: cont,
                                            style: TextStyle(
                                              //fontSize: 22.0,
                                              color: Colors.black,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: 'Kanal açıklaması ekle',
                                              labelText:
                                                  'Kanal açıklaması ekle',
                                              border: OutlineInputBorder(),
                                            ),
                                            onSaved: (String girilen) {
                                              //  comment = girilen;
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            /*  validator: (value) {
                        if (value.isEmpty) {
                          return 'Lütfen  giriniz';
                        }
                        return null;
                      },*/
                                            controller: cont,
                                            style: TextStyle(
                                              //fontSize: 22.0,
                                              color: Colors.black,
                                            ),
                                            decoration: InputDecoration(
                                              hintText:
                                                  'Telegram linki ekle (opsiyonel sonra eklenebilir)',
                                              labelText: 'Telegram linki ekle',
                                              border: OutlineInputBorder(),
                                            ),
                                            onSaved: (String girilen) {
                                              //  comment = girilen;
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Lütfen kanal açıklamasını giriniz';
                                              }
                                              return null;
                                            },
                                            controller: cont,
                                            style: TextStyle(
                                              //fontSize: 22.0,
                                              color: Colors.black,
                                            ),
                                            decoration: InputDecoration(
                                              hintText:
                                                  'Kanal fotoğrafı seç (opsiyonel daha sonra eklenebilir)',
                                              labelText: 'Kanal fotoğrafı seç ',
                                              border: OutlineInputBorder(),
                                            ),
                                            onSaved: (String girilen) {
                                              //  comment = girilen;
                                            },
                                          ),
                                        ),
                                        Center(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.send,
                                              color: Colors.blue,
                                            ),
                                            onPressed: () {
                                              /*   if (formKey.currentState.validate()) {
                                int cid = context
                                    .read<KullaniciProvider>()
                                    .kullanici
                                    .kullaniciid;
                                bool c = await APIServices.eklekanal(Altkonu(
                                    0,
                                    cont.text,
                                    0,
                                    0,
                                    DateTime.now().toString(),
                                    cid));
                                if (c == true) {}
                                Navigator.of(context).pop();
                              }*/
                                            },
                                          ),
                                        )
                                      ],
                                    )),
                              )
                            ],
                          ),
                        )),
                  );
                });
          },
          child: Icon(FontAwesomeIcons.plus),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
            child: Text(
              "popcom".tr(),
              style: TextStyle(
                  color: context.watch<ThemeNotifier>().getTheme() ==
                          ThemeData.dark()
                      ? Colors.white
                      : Colors.black,
                  fontFamily: 'Avenir',
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: FutureBuilder<List<Dtoaltkonu>>(
              future: konulusoru == true ? konulutopluluklist() : list(),
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
                                konulusoru = true;
                                x = konu[index].konuid;
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
                                        color: renk[index],
                                        boxShadow: shadowList,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  //    Text(categories[index]['name'])
                                  Text(konu[index].konular)
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: projectSnap.data.length,
                        itemBuilder: (context, index) {
                          int renk = projectSnap.data.length % (index + 1);
                          return Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Toplulukanasyf(
                                            altid: projectSnap
                                                .data[index].altkonuid,
                                          )),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 75,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            _borderRadius),
                                        gradient: LinearGradient(
                                            colors: [
                                              items[renk].startColor,
                                              items[renk].endColor
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight),
                                        boxShadow: [
                                          BoxShadow(
                                            color: items[renk].endColor,
                                            blurRadius: 12,
                                            offset: Offset(0, 6),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      top: 0,
                                      child: CustomPaint(
                                        size: Size(100, 150),
                                        painter: CustomCardShapePainter(
                                            _borderRadius,
                                            items[renk].startColor,
                                            items[renk].endColor),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 4,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    projectSnap
                                                        .data[index].altkonu,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Avenir',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Text(
                                                    projectSnap
                                                        .data[index].konular
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontFamily: 'Avenir',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Column(
                                                  children: [
                                                    Text(
                                                      "uyesayi".tr(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Avenir',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    Text(
                                                      projectSnap
                                                          .data[index].uyesayisi
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Avenir',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );

                /*SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(children: [
                    SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: projectSnap.data.length,
                        itemBuilder: (context, index) {
                          Altkonu project = projectSnap.data[index];

                          return Column(
                            children: <Widget>[
                              ListTile(
                                subtitle: Text(project.konuid.toString()),
                                title: Text(project.altkonu),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ]),
                );*/
              }),
        ));
  }
}

/*Container buildContainer(BuildContext context) {
  return Container(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("a soru soru"),
        ),
        Container(
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Lütfen cevabınızı giriniz';
                        }
                        return null;
                      },
                      controller: cont,
                      style: TextStyle(
                        //fontSize: 22.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            child: Icon(
                              Icons.send,
                              color: Colors.blue,
                            ),
                            onTap: () async {
                              if (formKey.currentState.validate()) {
                                int cid = context
                                    .read<KullaniciProvider>()
                                    .kullanici
                                    .kullaniciid;
                                bool c = await APIServices.eklekanal(Altkonu(
                                    0,
                                    cont.text,
                                    0,
                                    0,
                                    DateTime.now().toString(),
                                    cid));
                                if (c == true) {}
                                Navigator.of(context).pop();
                              }
                            }),
                        hintText: 'Yeni kanal ekle',
                        labelText: 'Yeni kanal ekle',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (String girilen) {
                        //  comment = girilen;
                      },
                    ),
                  ),
                ],
              )),
        )
      ],
    ),
  );
}*/

class PlaceInfo {
  final String name;
  final String category;
  final String location;
  final double rating;
  final Color startColor;
  final Color endColor;

  PlaceInfo(this.name, this.startColor, this.endColor, this.rating,
      this.location, this.category);
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
