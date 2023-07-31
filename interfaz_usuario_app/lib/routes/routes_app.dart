import 'package:flutter/material.dart';

import '../Scena/home/screens/home_screen.dart';
import '../Scena/login/screens/login_screen.dart';
import '../Scena/register/screens/regsiter_sceren.dart';
import '../Scena/splash/splash_screen.dart';
import '../data/models/user_data.dart';

class RoutesApp {
  static UserData? USERDATA;
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    if (args is UserData) {
      USERDATA = args;
    }
    switch (settings.name) {
      case "/register":
        return MaterialPageRoute(builder: (_) => Register());
      case "/":
        return MaterialPageRoute(
            builder: (_) =>
                LoginScreen(USERDATA ?? UserData("", "", "", "", "")));
      case "/Register":
        return MaterialPageRoute(builder: (_) => Register());
      case "/Loby":
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case "/home":
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }

    return MaterialPageRoute(builder: (_) => SplashScreen());
  }
}
