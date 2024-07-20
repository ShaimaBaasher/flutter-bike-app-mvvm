import 'package:bike_app/src/splash/presentation/bloc/splash_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../src/home/data/repositories/home_repo.dart';
import '../../src/home/presentation/bloc/home_bloc.dart';
import '../../src/login/data/repositories/auth_repo.dart';
import '../../src/login/presentation/bloc/login_bloc.dart';
import '../../src/products_detials/presentation/bloc/product_detials_bloc.dart';
import '../network/api_helper.dart';
import 'package:http/http.dart' as http;

import '../network/cache.dart';
import '../network/end_points.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerLazySingleton(() => Cache())
    ..registerLazySingleton<http.Client>(() => http.Client())
    ..registerLazySingleton(() => APISRepo(sl(), sl(), BASE_URL))
    ..registerLazySingleton(() => SplashBloc())
    ..registerLazySingleton(() => AuthService())
    ..registerLazySingleton(() => LoginBloc(authService: sl()))
    ..registerLazySingleton(() => ProductDetialsBloc())
    ..registerLazySingleton(() => HomeRepo(sl()))
    ..registerLazySingleton(() => HomeBloc(homeRepo: sl()));
}
