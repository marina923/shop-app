import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextFormField({
  TextEditingController? controller,
  TextInputType? type,
  String? label,
  required bool enable,
  Icon? prefixIcon,
  IconData? suffixIcon,
  void Function()? suffixOnPressed,
String? Function(String?)? validate,
  bool isPassword=false,
  void Function(String)? onSubmit,
})=> TextFormField(
  onFieldSubmitted: onSubmit,
  obscureText: isPassword,
  controller:controller,
  keyboardType:type,
  decoration:InputDecoration(hintText: label,enabled: enable,
      hintStyle: TextStyle(color: Colors.black12,
      ),
      prefixIcon:prefixIcon,
      suffixIcon:suffixIcon != null
          ? IconButton(
        icon: Icon(suffixIcon),
        onPressed: suffixOnPressed,
      )
          : null,
      border:OutlineInputBorder()) ,
  validator:validate,
);
Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUppercase = true,
  double radius = 0.0,
  required String text,
  required void Function()? function,
}) =>
    Container(
      height: 40.h,
      width: width,
      child: MaterialButton(
        child: Text(isUppercase ? text.toUpperCase() : text),
        textColor: Colors.white,
        onPressed: function,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
void showToastState({required String text,required ToastStates state})=>Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor:chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0);

enum ToastStates{SUCCESS,ERROR,WARNING}
Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color=Colors.green;
       break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
      case ToastStates.WARNING:
    color=Colors.amber;
    break;
  }
  return color;
}