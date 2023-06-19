import 'package:shared_preferences/shared_preferences.dart';

class Shr {
  static Shr shr = Shr._();
  Shr._();
  Future<void> setData(bool check) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.setBool('check',check);
  }

  Future<bool?> readData()
  async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    bool? check = shr.getBool('check');
    return check;
  }
}