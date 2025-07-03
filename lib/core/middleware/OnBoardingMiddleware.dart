// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mosques/core/costant/App_routes.dart';
// import 'package:mosques/core/services/SharedPreferences.dart';

// class OnBoardingMiddleware extends GetMiddleware {
//   MyServices myServices = Get.find();

//   @override
//   RouteSettings? redirect(String? route) {
//     String? onBoarded = myServices.sharedPref.getString("onBoarded");

//     if (onBoarded == "1") {
//       return const RouteSettings(name: AppRoute.login);
//     }
//     return null; // يكمل للـ "/"
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosques/core/costant/App_routes.dart';
import 'package:mosques/core/services/SharedPreferences.dart';
class OnBoardingMiddleware extends GetMiddleware {
  final MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    String? onBoarded = myServices.sharedPref.getString("onBoarded");
    bool isLoggedIn = myServices.sharedPref.getBool("isLoggedIn") ?? false;

    if (onBoarded != "1") {
      return RouteSettings(name: AppRoute.onBoarding);
    } else {
      if (!isLoggedIn) {
        return RouteSettings(name: AppRoute.login);
      } else {
        return RouteSettings(name: AppRoute.mainHome);
      }
    }
  }
}
