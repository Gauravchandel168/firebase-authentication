import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practise_functionality_screen/logic/auth/login_cubit.dart';

import '../../../logic/auth/google_login_cubit.dart';
import '../../widgets/app_easy_loading.dart';

class LoginPage extends StatelessWidget {
  final emailTextController=TextEditingController();
  final passwordTextController=TextEditingController();

   LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 48,),
            TextField(
              controller: emailTextController,
              decoration: InputDecoration(
                hintText: "Email"
              ),
            ),
            SizedBox(height: 16,),
            TextField(
              controller: passwordTextController,
              decoration: InputDecoration(
                  hintText: "Password"
              ),
            ),
            SizedBox(height: 24,),
            BlocListener<LoginCubit, LoginState>(
              listener:(context, state){
                if(state is LoginLoading){
                  easyLoadingShowProgress(status:"Login...");
                }else if(state is Loginsuccess){
                  easyLoadingDismiss();;
                }else if(state is LoginError){
                  easyLoadingShowError(state.message);
                }
              },
             child: ElevatedButton(onPressed: (){
               context.read<LoginCubit>().signIn(
                 emailTextController.text,  passwordTextController.text);
             }, child: Text("sign in")),
            ),
            SizedBox(height: 32,),
            BlocListener<GoogleLoginCubit, GoogleLoginState>(
              listener:(context, state){
                if(state is GoogleLoginLoading){
                  easyLoadingShowProgress(status:"Login...");
                }else if(state is GoogleLoginSuccess){
                  easyLoadingDismiss();;
                }else if(state is GoogleLoginError){
                  easyLoadingShowError(state.message);
                }
              },
              child: ElevatedButton(onPressed: (){
                context.read<GoogleLoginCubit>().signIn();
              }, child: Text("Google Sign in")),
            ),

          ],
        ),
      ),
      ),
    );
  }
}
