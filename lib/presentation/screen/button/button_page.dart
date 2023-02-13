import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practise_functionality_screen/logic/auth/logout_cubit.dart';

import '../../router/app_router.dart';
import '../../router/app_routes_utills.dart';
import '../../widgets/app_easy_loading.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
          child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              navigatorKey.currentState?.pushNamed(AppRouter.firestore);
            },
            child: Text("1stScreen"),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(20),
            ),

          ),
          SizedBox(
            height: 14,
          ),
        ElevatedButton(
          onPressed: () {
            navigatorKey.currentState?.pushNamed(AppRouter.user);
          },
          child: Text("2stScreen"),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20),
          ),
        ),

          SizedBox(
            height: 10,
          ),
          BlocListener<LogoutCubit, LogoutState>(
            listener: (context, state) {
              if (state is LogoutLoading) {
                easyLoadingShowProgress(status: "Logout...");
              } else if (state is LogoutSuccess) {
                easyLoadingDismiss();
                ;
              } else if (state is LogoutError) {
                easyLoadingShowError(state.message);
              }
            },
            child: ElevatedButton(
              child: Text("signout"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20),
              ),
              onPressed: () {
                context.read<LogoutCubit>().signOut();
              },
            ),
          )


        ],
      )),
    );
  }
}
