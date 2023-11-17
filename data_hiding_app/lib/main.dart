import 'package:data_hiding_app/Screen/admin_screen.dart';
import 'package:data_hiding_app/Screen/decode.dart';
import 'package:data_hiding_app/Screen/login_screen.dart';
import 'package:data_hiding_app/Screen/main_screen.dart';
import 'package:data_hiding_app/Screen/result_decode.dart';
import 'package:data_hiding_app/Screen/show_screen.dart';
import 'package:data_hiding_app/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserData()),
      ],
      child: const MyApp(),
    ),
     );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes:{
      //   "/login":(context) =>   LoginScreen(fullName: (String value) {  },),
      //   "/mainscreen":(context) => MainScreen(fullName: '',),
      //   "/showscreen":(context) => const ShowScreen()
      // },
      onGenerateRoute:(settings) {
        switch(settings.name){
          case "/login": 
            return MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      );
        case "/result": 
            return MaterialPageRoute(
        builder: (context) {
          return ShowScreenResult(fullName: settings.arguments.toString(),);
        },
      );
        case "/admin": 
            return MaterialPageRoute(
        builder: (context) {
          return AdminScreen(fullName: settings.arguments.toString());
        },
      );

      case "/decode": 
            return MaterialPageRoute(
        builder: (context) {
          return DecodeScreen(fullName: settings.arguments.toString(),);
        },
      );
      
      case "/mainscreen": 
            return MaterialPageRoute(
        builder: (context) {
          return MainScreen(fullName: settings.arguments.toString(),);
        },
      );

      case "/showscreen": 
            return MaterialPageRoute(
        builder: (context) {
          return ShowScreen(fullName: settings.arguments.toString(),);
        },
      );
        }
      },
      debugShowCheckedModeBanner: false,
      title: 'Data hiding Demo',
      home: LoginScreen(),
    );
  }
}


