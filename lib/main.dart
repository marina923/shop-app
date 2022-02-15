import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopapp/login/cubit/observer.dart';
import 'package:shopapp/on_boarding/on_boarding_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/network/local/cashe_helper.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

void main() async{
  Bloc.observer = MyBlocObserver();
  DioHelper.initial();
  await CasheHelper.int();
  bool onBoarding=CasheHelper.getData(key: 'onBoarding');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:()=> MaterialApp(
        builder: (context, widget) {
          //add this line
          ScreenUtil.setContext(context);
          return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:onBoardingScreen(),
      ),
    );
  }
}

