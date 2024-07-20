import 'package:bike_app/core/theme/colors.dart';
import 'package:bike_app/src/home/presentation/views/home.dart';
import 'package:bike_app/src/login/presentation/login.dart';
import 'package:bike_app/src/splash/presentation/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/pages.dart';
import 'core/service/injection_container.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppPages.provideBlocs(context)],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: mainColor,
          colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
          useMaterial3: false,
        ),
        home:  Splash(),
      ),
    );
  }
}

