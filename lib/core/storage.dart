import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  final storage = const FlutterSecureStorage();

  saveUser({required String username, required int admin}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", username);
    await storage.write(key: "admin", value: admin.toString());
  }

  loadUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var username = prefs.getString("username");
    String? admin = await storage.read(key: "admin");

    if (username == null || admin == null) {
      return null;
    } else {
      return {"username": username, "admin": admin};
    }
  }

  clearUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("username");
    await storage.delete(key: "admin");
  }
}
