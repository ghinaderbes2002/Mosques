// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:mosque/controller/onboarding_controller.dart';
// import 'package:mosque/core/static/static.dart';
// import 'package:mosque/core/them/app_colors.dart';

// class DotOb extends StatelessWidget {
//   const DotOb({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<Onboardingcontrollerimp>(builder: (controller) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ...List.generate(
//             onBoardingList.length,
//             (index) => AnimatedContainer(
//               margin: const EdgeInsets.only(right: 3),
//               duration: const Duration(milliseconds: 600),
//               width: controller.currentPage == index ? 15 : 6,
//               height: 6,
//               decoration: BoxDecoration(
//                 color: AppColors.primary,
//                 borderRadius: BorderRadius.circular(6),
//               ),
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosques/controller/onboarding_controller.dart';
import 'package:mosques/core/static/static.dart';
import 'package:mosques/core/them/app_colors.dart';

class CustomDotControllerOnBoarding extends StatelessWidget {
  const CustomDotControllerOnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // تحديد وضع السمة الحالي
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // تعيين لون النقاط غير النشطة بناءً على وضع السمة
    final inactiveDotColor = isDarkMode ? Colors.grey[700] : Colors.grey[300];

    return GetBuilder<Onboardingcontrollerimp>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          onBoardingList.length,
          (index) => Container(
            margin: const EdgeInsets.only(right: 8),
            width: controller.currentPage == index ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: controller.currentPage == index
                  ? AppColors.primary
                  : inactiveDotColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}
