import 'package:bike_app/src/home/presentation/views/home.dart';
import 'package:bike_app/src/login/presentation/bloc/login_bloc.dart';
import 'package:bike_app/src/login/presentation/login.dart';
import 'package:bike_app/src/products_detials/presentation/bloc/product_detials_bloc.dart';
import 'package:bike_app/src/splash/presentation/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../src/home/presentation/bloc/home_bloc.dart';
import '../../src/products_detials/presentation/views/product_detials.dart';
import '../service/injection_container.dart';
import 'app_routes.dart';

class AppPages {
  static final RouteObserver<Route> observer = RouteObserver();

  static List<PageEntity> routes() {
    return [
      // PageEntity(
      //   path: AppRoutes.INITIAL,
      //   page: const Home(),
      //   bloc: BlocProvider(create: (_) => sl<BottomBarNavigationBloc>()),
      // ),
      PageEntity(
        path: AppRoutes.SPLASH,
        page: Login(),
        bloc: BlocProvider(create: (_) => sl<SplashBloc>()),
      ),
      PageEntity(
        path: AppRoutes.LOGIN,
        page: Login(),
        bloc: BlocProvider(create: (_) => sl<LoginBloc>()),
      ),
      PageEntity(
        path: AppRoutes.HOME,
        page: Home(),
        bloc: BlocProvider(create: (_) => sl<HomeBloc>()),
      ),
      PageEntity(
        path: AppRoutes.DETIALS,
        page: ProductDetails(),
        bloc: BlocProvider(create: (_) => sl<ProductDetialsBloc>()),
      ),
      // PageEntity(
      //   path: AppRoutes.HOME,
      //   page: Home(),
      //   bloc: BlocProvider(create: (_) => sl<HomeBloc>()..add(HomeFirebaseListeningEvent())),
      // ),
    ];
  }

  static List<dynamic> provideBlocs(BuildContext context) {
    List<dynamic> blocList = <dynamic>[];
    for (var bloc in routes()) {
      blocList.add(bloc.bloc);
    }
    return blocList;
  }

  static MaterialPageRoute generateRouteSetting(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.path == settings.name);
      if (result.isNotEmpty) {
        return MaterialPageRoute<void>(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    return MaterialPageRoute<void>(
        builder: (_) => const Home(), settings: settings);
  }
}

class PageEntity<T> {
  const PageEntity({
    required this.path,
    required this.page,
    required this.bloc,
  });

  final String path;
  final Widget page;
  final dynamic bloc;
}

Future<dynamic> pushRoute(
    {required BuildContext context,
    required Widget route,
    bool isFullScreen = false}) async {
  var response = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => route, fullscreenDialog: isFullScreen));
  return response;
}
