abstract class LoginState{}
class AppLoginInitialState extends LoginState{}
class AppLoginLoadingState extends LoginState{}
class AppLoginSuccessState extends LoginState{}
class AppLoginErrorState extends LoginState{
  String error;
  AppLoginErrorState(this.error);
}
class AppLoginChangePasswordState extends LoginState{}
