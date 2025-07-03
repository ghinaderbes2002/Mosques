import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mosques/core/costant/App_routes.dart';
import 'package:mosques/core/middleware/OnBoardingMiddleware.dart';
import 'package:mosques/view/screen/auth/login.dart';
import 'package:mosques/view/screen/auth/signUp.dart';
import 'package:mosques/view/screen/home.dart';
import 'package:mosques/view/screen/mainHome.dart';
import 'package:mosques/view/screen/onboarding.dart';
import 'package:mosques/view/screen/mosquesHistorical%20.dart';

List<GetPage<dynamic>>? routes = [
// GetPage(
//     name: '/',
//     page: () => Container(),
//     middlewares: [OnBoardingMiddleware()],
//   ),

  // GetPage(
  //   name: '/',
  //   page: () => const OnBoarding(),
  //   middlewares: [OnBoardingMiddleware()],
  // ),

GetPage(
    name: '/',
    page: () => const SizedBox.shrink(), // أي Widget صغير
    middlewares: [OnBoardingMiddleware()],
  ),


  GetPage(
    name: AppRoute.onBoarding,
    page: () => const OnBoarding(),
  ),

  GetPage(
    name: AppRoute.mainHome,
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
