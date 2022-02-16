




import 'package:shopapp/models/LoginModel.dart';

abstract class LoginState{}
class AppLoginInitialState extends LoginState{}
class AppLoginLoadingState extends LoginState{}
class AppLoginSuccessState extends LoginState{
 final LoginModel loginModel;
 AppLoginSuccessState(this.loginModel);
}
class AppLoginErrorState extends LoginState{
  String error;
  AppLoginErrorState(this.error);
}
class AppLoginChangePasswordState extends LoginState{}
