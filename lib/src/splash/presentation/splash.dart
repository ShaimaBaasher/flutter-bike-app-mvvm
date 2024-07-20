import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/routes/pages.dart';
import 'bloc/splash_bloc.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    context.read<SplashBloc>().add(GetIfUserIsLoggedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is Logged) {
            Navigator.of(context).pushReplacement(AppPages.generateRouteSetting(
                RouteSettings(name: AppRoutes.HOME)));
          }

          if (state is NotLogged) {
            Navigator.of(context).pushReplacement(AppPages.generateRouteSetting(
                RouteSettings(name: AppRoutes.LOGIN)));
          }
        },
        builder: (context, state) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
