import 'package:dio/dio.dart';
class DioHelper{
  static Dio? dio;
static initial(){
  dio=Dio(BaseOptions(baseUrl:'https://student.valuxapps.com/api/' ,
     headers: {
    'contentType':'application/json'
     },
      receiveDataWhenStatusError: true,),);
}
static Future<Response> getData({
  required String url,
  required Map<String,dynamic> query,
  String lang='ar',
  String? token,
})async{
  dio!.options.headers= {
    'contentType':'application/json',
    'lang':lang,
    'Authorization':token,
  };

  return await dio!.get(url,queryParameters: query);
}
static Future<Response> postData({
  required String url,
  required Map<String,dynamic> data,
  Map<String,dynamic>?query,
  String lang='ar',
  String? token,
})async{
  dio!.options.headers= {
    'contentType':'application/json',
    'lang':lang,
    'Authorization':token,
  };
  return dio!.post(url,data: data,queryParameters: query) ;
}
}