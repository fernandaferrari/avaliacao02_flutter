import 'package:shared_preferences/shared_preferences.dart';

class LoginDataProvider {
  SharedPreferences? prefs;
  LoginDataProvider(this.prefs);
  findUser(String nome, String password) {}
}
