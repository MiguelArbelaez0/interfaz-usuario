import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_data.dart';

class UserDefault {
  void saveMapData(String key, Map<String, dynamic> map) {
    SharedPreferences.getInstance().then((prefs) {
      final msg = jsonEncode(map);
      prefs.setString(key, msg);
    }).catchError((error) {
      print(error);
    });
  }

  void getMapData(String key, Function(Map<String, dynamic>) onGetMap) {
    SharedPreferences.getInstance().then((prefs) {
      String? action = prefs.getString(key);
      if (action != null) {
        var map = json.decode(action);
        onGetMap(map);
      }
    }).catchError((error) {
      print(error);
    });
  }

  // enfocados a guardar y traer la informacion de usuario
  void saveUser(UserData userData) {
    saveMapData("kUserData", userData.toJson());
  }

  void getUser(Function(UserData) onGetUser) {
    getMapData("kUserData", (map) {
      UserData userData = UserData.fromJson(map);
      onGetUser(userData);
    });
  }
}
