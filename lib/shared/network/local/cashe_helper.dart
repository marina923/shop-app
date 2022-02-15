import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';
class CasheHelper{
  static SharedPreferences? sharedPreferences;
  static int() async {
    sharedPreferences = await SharedPreferences.getInstance();

  }
static Future<bool>saveData(
  {
  required String key,
    required dynamic value,
})async{
  if(value is bool) return await sharedPreferences!.setBool(key,value);
  else if(value is String) return await sharedPreferences!.setString(key,value);
 else if(value is double) return await sharedPreferences!.setDouble(key,value);
  return await sharedPreferences!.setInt(key,value);

  }
  static dynamic getData({required String key}){
    return sharedPreferences!.get(key);
  }
}