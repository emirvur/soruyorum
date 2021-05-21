import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:soryor/provider/themeprovider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    ThemeNotifier prov = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blueAccent,
          ),
        ),
        title: Text(
          "ayarlar".tr(),
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color:
                  context.watch<ThemeNotifier>().getTheme() == ThemeData.dark()
                      ? Colors.white
                      : Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            //       SizedBox(  height: 40, ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.blueAccent,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "hesabim".tr(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(
                context, "dilsec".tr(), ["Türkçe", "İngilizce"]),
            buildAccountmodOptionRow(
                prov, context, "modsec".tr(), ["Koyu", "Açık"]),
            // buildAccountOptionRow(context, "Social"),
            //  buildAccountOptionRow(context, "Language"),
            //    buildAccountOptionRow(context, "Privacy and security"),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  color: Colors.blueAccent,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "ekstralar".tr(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildNotificationOptionRow("ekstrabildirim".tr(), true),
            //    buildNotificationOptionRow("Account activity", true),
            //      buildNotificationOptionRow("Opportunity", false),
            SizedBox(
              height: 50,
            ),
            Center(
              child: OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  //          Future.delayed(const Duration(milliseconds: 1000), () {
                  //  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  //  });
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: Text("cikis".tr(),
                    style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 2.2,
                        color: context.watch<ThemeNotifier>().getTheme() ==
                                ThemeData.dark()
                            ? Colors.white
                            : Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              //  fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }

  GestureDetector buildAccountmodOptionRow(
      ThemeNotifier pr, BuildContext context, String title, List<String> li) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text(title),
                /*   content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                        onTap: () {
                          pr.setTheme(ThemeData.dark());

                          Navigator.of(context).pop();
                        },
                        child: Text(li[0])),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          pr.setTheme(ThemeData.light());
                          Navigator.of(context).pop();
                        },
                        child: Text(li[1])),
                  ],
                ),*/
                actions: [
                  /*   FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close")),*/
                  CupertinoDialogAction(
                    child: Text('dark'.tr()),
                    onPressed: () {
                      pr.setTheme(ThemeData.dark());
                      Navigator.of(context).pop();
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text('light'.tr()),
                    onPressed: () {
                      pr.setTheme(ThemeData.light());
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                //        fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildAccountOptionRow(
      BuildContext context, String title, List<String> li) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text(title),
                /*   content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                        onTap: () {
                          context.locale = Locale("tr", "TR");
                          Navigator.of(context).pop();
                        },
                        child: Text(li[0])),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          context.locale = Locale("en", "EN");
                          Navigator.of(context).pop();
                        },
                        child: Text(li[1])),
                  ],
                ),*/
                actions: [
                  CupertinoDialogAction(
                    child: Text('turkish'.tr()),
                    onPressed: () {
                      context.locale = Locale("tr", "TR");
                      Navigator.of(context).pop();
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text('english'.tr()),
                    onPressed: () {
                      context.locale = Locale("en", "EN");
                      Navigator.of(context).pop();
                    },
                  ),
                  /* FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close")),*/
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                //   fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
