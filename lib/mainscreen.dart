import 'package:flutter/material.dart';
import 'package:qr_scan_generate_flutter_app/services/fcm_service.dart';
import 'package:qr_scan_generate_flutter_app/services/get_server_key.dart';
import 'package:qr_scan_generate_flutter_app/services/notification_service.dart';
import 'package:qr_scan_generate_flutter_app/services/sendNotification_service.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    // TODO: implement initState

    notificationService.requestNotificationPermission();
    notificationService.getDeviceToken();
    notificationService.firebaseInit(context);
    notificationService.setupInteractMessage(context);
    FcmService.firebaseInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    GetServerKey getServerKey = GetServerKey();
                    String accessToken = await getServerKey.getServerKeyToken();
                    print(accessToken);
                  },
                  child: Text('Get Server Key')),
              ElevatedButton(
                  onPressed: () async {
                    await SendnotificationService.sendNotificationUsingApi(
                        token: 'ekOsc3KSTC-M_jGOCsNUSX:APA91bGvSnhdONOKX7Iy27u--6obSEnWuM5EdQMfG7TUWh_jn77ZSoI1JQFBmKf9Wl60-dEjihu8M1-nR94ftE4TToaHxrrE3cstrwM53kWxtAuF04Z9Cj8',
                         title: 'Notification Title',
                          body: 'Notification body', 
                          data: {
                            "screen" : "main Screen ",
                          });
                  },
                  child: Text('Hit Api')),
            ],
          ),
        ),
      ),
    );
  }
}
