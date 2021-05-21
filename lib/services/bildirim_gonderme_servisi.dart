import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class BildirimGondermeServis {
  Future<bool> bildirimGonder(double gonderilecekBildirim, String token) async {
    String endURL = "https://fcm.googleapis.com/fcm/send";
    String firebaseKey =
        "AAAA8cwnZks:APA91bGDea4-uiCV4WOX0nLZUfvPFcJXJcEcBtvHH3QrlMsaNZ1ggK3-s94XY8GiZUad_SduyuvLhy5mYVoOXj1XluqO-PrVmFYfEAKqTbCmAVRu3xM0dx4nn6NNoWA8Xqk9-KhpdSre";
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "key=$firebaseKey"
    };

    // String json =
    //   '{ "to" : "$token", "data" : { "message" : "${gonderilecekBildirim.sutlitre}", "title": "${gonderilecekBildirim.kullaniciAdi}"  } }';

    String json =
        '{ "to" : "$token", "data" : { "message" : "${gonderilecekBildirim}"  } }';

    http.Response response =
        await http.post(endURL, headers: headers, body: json);

    if (response.statusCode == 200) {
      debugPrint("işlem basarılı");
      return true;
    } else {
      debugPrint("işlem basarısız:" + response.statusCode.toString());
      print("jsonumuz:" + json);
      return false;
    }
  }
}
