import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../../models/login_data.dart';
import '../../models/user_data.dart';

abstract class IUserRepository {
  void onGetUser(UserData userData);
  void onCreateComplete(UserData userData);
  void onError(String error);
}

class UserRepository {
  late IUserRepository iUserRepository;
  late SharedPreferences prefs;
  UserRepository(this.iUserRepository) {
    getInstancePreference();
  }
  Future getInstancePreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  void createUser(UserData userData) {
    Map<String, String> headers = {
      'Content-Type': 'application/json;  charset=UTF-8'
    };

    Uri url = Uri.http("10.0.2.2:5000", "/usersArbelaez");

    final msg = jsonEncode(userData.toJson());

    http.post(url, body: msg, headers: headers).then((response) {
      if (response.statusCode == 200) {
        iUserRepository.onCreateComplete(userData);
      } else if (response.statusCode == 400) {
        String body = response.body;
        var map = json.decode(body);
        String error = map["error"];
        iUserRepository.onError(error);
      }
    }).catchError((error) {
      iUserRepository.onError(error);
    });
  }

  void login(LoginData loginData) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    Uri url = Uri.http("10.0.2.2:5000", "/login");

    final msg = jsonEncode(loginData.toJson());

    http.post(url, body: msg, headers: headers).then((response) {
      if (response.statusCode == 200) {
        String body = response.body;
        var jsonDecode = json.decode(body);
        iUserRepository.onGetUser(UserData.fromJson(jsonDecode));
      } else if (response.statusCode == 400) {
        String body = response.body;
        var map = json.decode(body);
        String error = map["error"];
        iUserRepository.onError(error);
      }
    }).catchError((error) {
      iUserRepository.onError(error);
    });
  }
}
