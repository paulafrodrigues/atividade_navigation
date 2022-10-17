import 'dart:convert';
import 'package:atividade_navigation/login/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../utils/shared_preferences.keys.dart';

class LoginController {
  LoginState state = LoginStateEmpty();
  Future<LoginState> login({
    required UserModel user,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    await prefs.setBool(SharedPreferencesKeys.hasUser, true);
    await prefs.setString(SharedPreferencesKeys.currentUser, jsonEncode(user));
    return LoginStateSuccess();
  }
}
