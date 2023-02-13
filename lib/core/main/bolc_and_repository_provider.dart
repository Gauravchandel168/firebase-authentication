import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practise_functionality_screen/logic/auth/auth_cubit.dart';
import 'package:practise_functionality_screen/logic/internet/internet_cubit.dart';

import '../../data/repositories/auth_repository.dart';
import 'app.dart';

class BlocAndRepositoryProvider extends StatelessWidget {
  const BlocAndRepositoryProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),

      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => InternetCubit()..emitInternetAvailability(),
          ),
        ],
        child: App(),
      ),
    );
  }
}
