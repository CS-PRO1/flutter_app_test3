import 'package:flutter/material.dart';
import 'package:flutter_application_3/Cache/cache.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/cubit.dart';
import 'package:flutter_application_3/Services/Dio%20Service/dio.dart';
import 'package:flutter_application_3/screens/login_screen.dart';
import 'package:flutter_application_3/screens/main_screen.dart';
import 'package:flutter_application_3/screens/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  var token = CacheHelper.get('token') ?? '';
  var on_board = CacheHelper.get('on_board') ?? false;
  Widget widget;
  if (!on_board) {
    widget = WelcomeScreen();
  } else if (token == '') {
    widget = LoginScreen();
  } else {
    widget = MainScreen();
  }
  DioHelper.init();
  FlutterNativeSplash.remove();
  runApp(MyApp(widget));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  dynamic widget;
  MyApp(widget) {
    this.widget = widget;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(create: (context) => AppCubit() //..getHome(),
            )
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red),
        debugShowCheckedModeBanner: false,
        home: widget,
      ),
    );
  }
}
