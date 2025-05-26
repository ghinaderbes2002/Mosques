import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mosques/core/costant/App_routes.dart';
import 'package:mosques/view/screen/auth/login.dart';
import 'package:mosques/view/screen/auth/signUp.dart';
import 'package:mosques/view/screen/home.dart';
import 'package:mosques/view/screen/mainHome.dart';
import 'package:mosques/view/screen/mosquesHistorical%20.dart';
import 'package:mosques/view/screen/onboarding.dart';

List<GetPage<dynamic>>? routes = [
  // GetPage(
  //   name: "/",
  //   // page: () => const MapTestScreen(),
  //   page: () => const OnBoarding(),
  // ),

  //   GetPage(
  //     name: "/",
  //     page: () => const Profile(),
  // ),

  GetPage(
    name: "/",
    page: () => const MainHome(),
  ),

  GetPage(
    name: AppRoute.mosquesHistorical,
    page: () => const HistoricalMosques(),
  ),

  GetPage(
    name: AppRoute.signup,
    page: () => const SignUp(),
  ),
  GetPage(
    name: AppRoute.login,
    page: () => const Login(),
  ),
  GetPage(
    name: AppRoute.home,
    page: () => const Home(),
  ),
];
