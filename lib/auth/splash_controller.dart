import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../utils/shared_preferences.keys.dart';
import 'splash_sate.dart';

class SplashController {
  // ignore: prefer_typing_uninitialized_variables
  var user;
  late final SharedPreferences prefs;
  SplashController() {
    init();
  }

  Future<void> init() async {

    prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(SharedPreferencesKeys.currentUser);
    if (userString != null && userString.isNotEmpty) {

      var userJson = jsonDecode(userString);
      user = UserModel.fromJson(userJson);
    }
  }

  Future<SplashState> isAuthenticated() async {

    if (user.runtimeType == UserModel) {

      return SplashStateAuthenticated();
    }

    return SplashStateUnauthenticated();
  }
}