import 'dart:math';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:shopapp/login/cubit/states.dart';
import '../../shared/network/endpoint.dart';
import '../../shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoginCubit extends Cubit<LoginState>{
  LoginCubit() : super(AppLoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  void UserLogin({required String email,required String password}){
    emit(AppLoginLoadingState());
    DioHelper.postData(url:Login, data:{
      'email':email,
      'password':password,
    })?.then((value){
      print(value.data);
      print(value.data['message']);

      emit(AppLoginSuccessState());
    }).catchError((error){
      emit(AppLoginErrorState(error.toString()));
    });
    
  }
  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix= isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(AppLoginChangePasswordState());
  }
}