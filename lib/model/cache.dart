import 'package:shared_preferences/shared_preferences.dart';

class Cache{

  Future<void> saveId(String id)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', id);
  }

  Future<String> getId()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id =  prefs.getString('id') ?? '';
    return id;
  }

}