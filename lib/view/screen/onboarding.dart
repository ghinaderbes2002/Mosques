// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mosque/controller/onboarding_controller.dart';
// import 'package:mosque/core/static/static.dart';
// import 'package:mosque/core/them/app_colors.dart';
// import 'package:mosque/view/widget/buttonOB.dart';
// import 'package:mosque/view/widget/dotOB.dart';

// class OnBoarding extends StatelessWidget {
//   const OnBoarding({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Get.put(Onboardingcontrollerimp());

//     return GetBuilder<Onboardingcontrollerimp>(builder: (controller) {
//       return Expanded(
//         flex: 4,
//         child: PageView.builder(
//           onPageChanged: (value) => controller.onPageChanged(value),
//           controller: controller.pageController,
//           itemCount: onBoardingList.length,
//           itemBuilder: (context, index) => Column(
//             children: [
//               Text(
//                 onBoardingList[index].title!,
//                 style: const TextStyle(
//                   color: AppColors.background,
//                   fontSize: 30,
//                   decoration: TextDecoration.none,
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Image.asset(
//                 onBoardingList[index].image!,
//                 height: 300,
//                 width: 300,
//               ),
//               const SizedBox(height: 5),
//               Align(
//                 alignment: Alignment.center,
//                 child: Text(onBoardingList[index].description!,
//                     style: const TextStyle(
//                       color: AppColors.background,
//                       fontSize: 15,
//                       fontStyle: FontStyle.normal,
//                       decoration: TextDecoration.none,
//                     )),
//               ),
//               const SizedBox(height: 20),
//               const ButtonOB(),
//               const SizedBox(height: 20),
//               const DotOb(),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosques/controller/onboarding_controller.dart';
import 'package:mosques/core/them/app_colors.dart';
import 'package:mosques/view/widget/CustomSliderOnBoarding.dart';
import 'package:mosques/view/widget/buttonOB.dart';
import 'package:mosques/view/widget/dotOB.dart';


class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(Onboardingcontrollerimp());

    // تحديد وضع السمة الحالي
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // تعيين لون الخلفية بناءً على وضع السمة
    final backgroundColor = isDarkMode ? Color(0xFF1A1A1A) : AppColors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          const Expanded(
            child: CustomSliderOnBoarding(),
          ),
          const SizedBox(height: 20),
          const CustomDotControllerOnBoarding(),
          const SizedBox(height: 20),
          const CustomButtonOnBoarding(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
