import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:qr_scan_generate_flutter_app/services/get_server_key.dart';
import 'package:http/http.dart' as http;

class SendnotificationService {
  static Future<void> sendNotificationUsingApi({
    required String? token,
    required String? title,
    required String? body,
    required Map<String, dynamic>? data,
  }) async {
    String serverKey = await GetServerKey().getServerKeyToken();
    String url =
        'POST https://fcm.googleapis.com/v1/projects/myproject-b5ae1/messages:send';

    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey'
    };

    //message
    Map<String, dynamic> message = {
      "message": {
        //"token": token,
        "topic" : "all",
        "notification": {"body": body, "title": title},
        "data": data,
      }
    };

    //Hit API

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: message,
    );

    if (response.statusCode == 200) {
      // ignore: avoid_print
      print("Notification send sucessfully!!");
    } else {
      print("Notification not send.");
    }
  }
}
