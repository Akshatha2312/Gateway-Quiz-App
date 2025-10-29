import 'dart:io';

class ApiConfig {
  static const String port = "5000";

  // Replace with your PC IP for real devices
  static const String localIp = "192.168.29.5";

  static String get baseUrl {
    if (Platform.isAndroid) return "http://10.0.2.2:$port";
    if (Platform.isIOS) return "http://localhost:$port";
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) return "http://localhost:$port";
    return "http://$localIp:$port"; // fallback for web or other devices
  }
}
