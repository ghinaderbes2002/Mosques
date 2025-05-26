import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosques/controller/onboarding_controller.dart';
import 'package:mosques/core/them/app_colors.dart';
import 'package:mosques/core/them/app_fonts.dart';

class CustomButtonOnBoarding extends GetView<Onboardingcontrollerimp> {
  const CustomButtonOnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // تحديد وضع السمة الحالي ولكن لا نحتاج لتعديله هنا حيث أن زر المتابعة سيكون بلون العلامة التجارية
    // ويمكن استخدام تدرج لوني لتحسين المظهر
    final controller = Get.find<Onboardingcontrollerimp>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.primaryLight,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => controller.next(),
            child: Center(
              child: Text(
                "متابعة",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: AppFonts.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
