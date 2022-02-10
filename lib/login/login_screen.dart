import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/login/cubit/cubit.dart';
import 'package:shopapp/login/cubit/states.dart';
import 'package:shopapp/register/register_screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
class LoginScreen extends StatelessWidget {
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
   var formKey=GlobalKey<FormState>();
  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => LoginCubit() ,
      child: BlocConsumer<LoginCubit,LoginState>(
        listener:(context, state) => {} ,
        builder: (context, state){
          return Scaffold(
        appBar: AppBar(),
        body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
        child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
          Text('LOGIN',style: TextStyle(fontWeight:FontWeight.bold,fontSize:26.sp ),),
          SizedBox(height: 16.h,),
          Text('login now to browse our hot offers',style: TextStyle(fontSize: 18.sp,color: Colors.black38),),
          SizedBox(height: 16.h,),
          defaultTextFormField(
          isPassword: false,
          controller:emailController, enable: true,
          suffixIcon:Icons.email_outlined,label:'E-mail Address',
          type:TextInputType.emailAddress,
          validate:(value) {
          if(value!.isEmpty){
          return'please enter your email address';
          }return null;
          },
          ),
          SizedBox(
          height: 20.h,
          ),
          defaultTextFormField(
            suffixOnPressed:(){
              LoginCubit.get(context).changePasswordVisibility();
            },
            onSubmit:(value){
              if(formKey.currentState!.validate()){
                LoginCubit.get(context).UserLogin(email: emailController.text, password: passwordController.text);
              }
            },
          isPassword: LoginCubit.get(context).isPassword,
          controller:passwordController, enable: true,
          suffixIcon:LoginCubit.get(context).suffix,
          prefixIcon: Icon(Icons.lock),
          label:'password',
          type:TextInputType.visiblePassword,
          validate:(value) {
          if(value!.isEmpty){
          return'please enter your password address';
          }return null;
          },
          ),
          SizedBox(height: 20.h,),
          ConditionalBuilder(
            builder:(context) => defaultButton(text: 'login', function:(){
              if(formKey.currentState!.validate()){
                LoginCubit.get(context).UserLogin(email: emailController.text, password: passwordController.text);

              }
            }),
            condition:state is! AppLoginLoadingState ,
              fallback:(context) => CircularProgressIndicator(),
          ),
          SizedBox(height: 10.h,),
          Row(mainAxisAlignment:MainAxisAlignment.center,
          children: [
          Text('Don\'t have an account?'),
          TextButton(child:Text('REGISTER'),onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder:(context)=>RegisterScreen()));
          },),
          ],),

          ],
          ),
        ),
        ),
        ),
        ),
        ) ;
        },
      ),
    );
  }
}
