import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:shopapp/bloc/cubit/states.dart';
import 'package:shopapp/models/LoginModel.dart';
import '../../shared/network/endpoint.dart';
import '../../shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoginCubit extends Cubit<LoginState>{
  LoginCubit() : super(AppLoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel loginModel=LoginModel();


  void UserLogin({required String email,required String password}){
    emit(AppLoginLoadingState());
    DioHelper.postData(url:Login, data:{
      'email':email,
      'password':password,
    }).then((value){
      // print(value.data);
      // print(value.data['message']);
      loginModel=LoginModel.fromJson(value.data);
      // print(loginModel.message);
      //  print(loginModel.status);
      //  print(loginModel.data!.token);
        emit(AppLoginSuccessState(loginModel));
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