import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/firebase.messaging',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/userinfo.email',
    ];

    // Replace with your actual service account credentials
    final credentialsJson = {
      "type": "service_account",
      "project_id": "fcm-demo-a07bd",
      "private_key_id": "e75d59a48d229d1b998e3ba118607f2ef09dedb0",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDBgNuqaSfeN6Fk\nbDvRz6BVHd7lbbXWWwKFGl0vKe0Pedf5zrTIzz443yEAyghGQJT72RCjtTa31Qe9\n7id6CwZ/hVKdipajNx4MnKKWdsYdsYmxr2sdpri86nMCh7+AzipIC0lFLwjbTB2D\nDmF7H/I54rTXcB1zg6ReZVBUyUvpi8veGDnzEl7+RiMVE9wBk5CRgGW+KT3KwW2n\nusQB0tw9WKPknFR8nAJ76nu6mfDRs1TsA6ZT4UObYT9ZwZ5AOjxWE2C1yM3NqFVR\nSLW3of1+NINembDOlQIWz5GUDpVfi/z70s/nFUWeF+k/wxOwztR/M973Xb+1HnpH\n4231L6fZAgMBAAECggEADykYDM3tqwy+FFl2hlsMu3PPrDdgRnRy9MK6sktH9i0c\nWBzIhUMsziqNMhFM0f7qrUtgcQhtn7w3vbsUVLeFwXqh8miSoiRbXQRDU3k9ecNt\n1QINaRFQQAeOYzsHggFPxr07obQBrvd+XcTuq5rhJi/g7frWvooogqIlcmnNt3Ud\nkyDg0UqbS+N8LasSz/Q1d375K3LWUL8ajBS1AOumt2EOhPBvg9BUktz81Z9Qp0EW\nHY8/oAFvyUIwK/Fa8c9+GsRf0ggDWZX/ehcTccqRWK1ev3Z+A1lsHWs13BlQk345\nKOKKNBq9/DCkEny/GtWeKy60tuIoIawg7+wMUeKSQQKBgQDnsEv0vQd9nGoNBV/+\nGg3fIxpqI4dsMXWi2eCZfNDaE8CaIgYW+J0Vj1/2hmrsiz8Zyn9wFaSLmUDtCKRG\nNHMavU4zDn/63TUQf+EXfDzJjxQc5ULSGU443HbyFcLSatKTUXY/Aa2Lnw29Zezw\npOk+7o4wmujTBUECdv3yITl4pQKBgQDVztBlAvNzknK3zpfbOjN1JuoauiQ5QYsL\n28ht6Wu5SVB7RLukzqgFj3aGq003ZnmuIscpLzoi95dPJxeMq5kiSCTXcmCvwpS4\nSGckiYmbvbtzmEFkGcAQv2YWUiFh7UW2KFlapxHeNmqdgJWkXRhBbsRl9K1YdBcK\nD6rW797YJQKBgQDTRrYNKO+SwTcIRrWBr1qk94rX7SxKIlQmvE6PSP3fUBHbvFkX\nS4FbrtIQqgUJTfWt3DYYDPRvBMLrJG1BRAUPBkAwWPGl32DLegHWe8mm+B2cOAiW\nNNNbENg67FMrtJPwGWIeFLagUtuhsje+PnQgmkP52NmlzO26hK4QxfF1rQKBgGpN\nUT9noDMt9Ot+Q/IzlbIBjxOKyMfO1psmwxginfSZhvJC0ii2tsNM+NksAlAxGv6B\nPBQ17unDv+8SuJqwFor845RawcehLuAQ33dDCq/sPW7TnG9wfhXVk6Q1YXOWzLos\nhYCU4EVjOM7mR4BY6N5ffDZU2HrJ/Up7T61dxaYhAoGBAJhdAhInHy7UbPtsFEqO\nusODPRk+/ZhcM7hXEzMEb+p8udQvQm9v5+L8dsBwfaKv9dHScut7dlUXPAjc41qi\nmAsCjfAj7v0/GRf+CHa7jtmyIJCAp4wQdJAmRD+3iSqnIw92bLNgDlto6TZjY+A9\nILdQwLLilA8ujuVhXeRbJMOa\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-m1br9@fcm-demo-a07bd.iam.gserviceaccount.com",
      "client_id": "107170495583776693092",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-m1br9%40fcm-demo-a07bd.iam.gserviceaccount.com",
    };

    // Authenticate using the service account
    try {
      final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(credentialsJson),
        scopes,
      );

      // Extract the access token from the client
      final accessServerKey = client.credentials.accessToken.data;
      //print("Access Token: $accessServerKey");

      return accessServerKey;
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
}
