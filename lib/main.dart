import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopapp/bloc/cubit/observer.dart';
import 'package:shopapp/modules/layout/shop_layout.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/network/local/cashe_helper.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.initial();
  await CasheHelper.int();
  bool? onBoarding = CasheHelper.getData(key: 'onBoarding');
  String? token = CasheHelper.getData(key: 'token');
  late Widget widget;
  if (onBoarding != null) {
    if (token != null) {
      print('onboarding&token != null');
      widget = const ShopLayout();
    } else {
      print('onboarding != null and token = null');
      widget = LoginScreen();
    }
    print('onboarding = null');
    widget = onBoardingScreen();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => MaterialApp(
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
        home: startWidget,
      ),
    );
  }
}
