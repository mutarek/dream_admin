import 'package:dream_touch_admin/app/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/controller/auth_provider.dart';
import 'app/controller/home_provider.dart';
import 'app/screens/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isLogin = prefs.getBool("is_logged")??false;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => HomeProvider()),
    ],
    child: MyApp(isLogin),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(this.result, {super.key});

  final bool result;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: result == true ? const AdminHome() : LoginPage(),
    );
  }
}
