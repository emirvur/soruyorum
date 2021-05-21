import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:soryor/models/altkonu.dart';
import 'package:soryor/models/altkonudto.dart';
import 'package:soryor/models/kullanici.dart';
import 'package:soryor/services/apiservices.dart';

class Deneme extends StatefulWidget {
  @override
  _DenemeState createState() => _DenemeState();
}

class _DenemeState extends State<Deneme> {
  TextEditingController cont;
  bool x = true;
  Color li = Colors.red;
  List<Altkonu> l = [
    // Altkonu(1, "q", 2),
    //Altkonu(1, "q", 2),
    //Altkonu(1, "q", 2)
  ];
  List<Kullanici> kul;

  Future<List<Altkonu>> arakana(String x) async {
    print("kontrolll");

    List<Altkonu> li = await APIServices.araaltonual(x);

    print("kontrol222");
    print(li.toString());
    l = li;
    print("soonnn");

    return li;
  }

  Future<List<Kullanici>> arakulla(String x) async {
    print("kontrolll");

    List<Kullanici> li = await APIServices.arakulla(x);

    print("kontrol222");
    print(li.toString());
    kul = li;
    print("soonnn");

    return li;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cont = TextEditingController();
  }

  @override
  void dispose() {
    cont.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                TextField(
                  textInputAction: TextInputAction.done,
                  controller: cont,
                  onChanged: (value) async {
                    if (cont.text.startsWith("#") == true) {
                      kul = await arakulla(value.substring(1));
                    } else {
                      l = await arakana(value);
                    }

                    setState(() {});
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: "Ara",
                    /*    labelStyle: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                    border: OutlineInputBorder(),*/
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true, //
              itemCount: l.length ?? 0,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(kul[i].kullaniciid.toString()),
                  onTap: () {
                    setState(() {
                      //    cont.text = l[i].adsoyad;
                      //  cari = l[i];

                      l = [];
                    });
                  },
                );
              }),
          SizedBox(
            height: 40,
          ),
          TextField(
            textInputAction: TextInputAction.done,
            controller: cont,
            onChanged: (value) async {
              l = await arakana(value);
              setState(() {});
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.people),
              labelText: "CARİ BUL",
              labelStyle: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
              border: OutlineInputBorder(),
            ),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true, //
              itemCount: l.length ?? 0,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(l[i].altkonu.toString()),
                  onTap: () {
                    setState(() {
                      //    cont.text = l[i].adsoyad;
                      //  cari = l[i];

                      l = [];
                    });
                  },
                );
              }),
        ],
      ),
      //    Text(categories[index]['name'])
    );
  }
}
