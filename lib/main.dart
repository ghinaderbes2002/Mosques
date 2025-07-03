import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosques/core/costant/App_routes.dart';
import 'package:mosques/core/services/SharedPreferences.dart';
import 'package:mosques/core/them/app_colors.dart';
import 'package:mosques/routes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 144, 201, 248).withOpacity(0.1),
        ),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      getPages: routes,
      
      
    );
  }
}
