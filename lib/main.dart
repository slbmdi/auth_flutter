import 'package:auth_flutter/helper/constance.dart';
import 'package:auth_flutter/views/home.dart';
import 'package:auth_flutter/views/login/login.dart';
import 'package:auth_flutter/views/login/login_otp.dart';
import 'package:auth_flutter/views/login/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  final box = GetStorage();

  App.token = box.read('token');

  runApp(const App());
}

class App extends StatelessWidget {
  static String? token = "";
  const App({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'askme',
      //!
      theme: ThemeData(
          fontFamily: 'estedad',
          //!38.39.40
          inputDecorationTheme: InputDecorationTheme(
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(10),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ConstColor.backgroundAppBar))),
          //!42
          textSelectionTheme:
              TextSelectionThemeData(cursorColor: ConstColor.backgroundAppBar),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: ConstColor.backgroundAppBar))
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          ),
      textDirection: TextDirection.rtl,
      getPages: [
        GetPage(name: '/home', page: () => const Home()),
        GetPage(name: '/login', page: () => const Login()),
        GetPage(name: '/login/otp', page: () => const LoginOtp()),
        GetPage(name: '/login/register', page: () => const Register())
      ],
      initialRoute: token == null ? '/login' : '/home',
    );
  }
}
