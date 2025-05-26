import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosques/controller/auth/signUp_controller.dart';
import 'package:mosques/core/function/validinput.dart';
import 'package:mosques/core/them/app_colors.dart';
import 'package:mosques/view/screen/auth/login.dart';
import 'package:mosques/view/widget/auth/CustomButton.dart';
import 'package:mosques/view/widget/auth/CustomTextFormFiled.dart';


class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpControllerImp());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GetBuilder<SignUpControllerImp>(
            builder: (controller) {
              return SingleChildScrollView(
                child: Form(
                  key: controller.formState,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "مسجدي",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomTextFormField(
                          controller: controller.name,
                          label: 'الاسم الكامل',
                          hintText: 'أدخل الاسم الكامل',
                          prefixIcon: Icons.person_outline,
                          validator: (val) =>
                              validInput(val!, 3, 100, "username"),
                          isDarkMode: false,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: controller.email,
                          validator: (val) =>
                              validInput(val!, 10, 100, "email"),
                          label: " البريد الالكتروني",
                          hintText: "أدخل البريد الالكتروني ",
                          prefixIcon: Icons.email_outlined,
                          isDarkMode: false,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: controller.password,
                          label: "كلمة المرور",
                          hintText: "********",
                          prefixIcon: Icons.lock_outline,
                          isPassword: controller.isPasswordHidden,
                          onPasswordToggle: controller.togglePasswordVisibility,
                          validator: controller.validatePassword,
                          isDarkMode: false,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: controller.phone,
                          validator: (val) =>
                              validInput(val!, 10, 100, "phone"),
                          label: " رقم الهاتف",
                          hintText: "أدخل رقم الهاتف",
                          prefixIcon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          isDarkMode: false,
                        ),
                        const SizedBox(height: 40),
                        CustomButton(
                          text: 'إنشاء حساب',
                          onPressed: () {
                            controller.signup();
                          },
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("لديك حساب بالفعل؟"),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () => Get.to(() => Login()),
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // مهم حتى ما ياخد كل عرض الشاشة
                                children: [
                                  Text(
                                    "تسجيل الدخول",
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.login,
                                      size: 18, color: AppColors.primary),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
