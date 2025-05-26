import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosques/core/classes/api_client.dart';
import 'package:mosques/core/classes/staterequest.dart';
import 'package:mosques/core/costant/App_link.dart';
import 'package:mosques/core/data/model/user_model.dart';
import 'package:mosques/core/services/SharedPreferences.dart';
import 'package:mosques/view/screen/mainHome.dart';

abstract class LoginController extends GetxController {
  login();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  late TextEditingController name;
  late TextEditingController password;

  Staterequest staterequest = Staterequest.none;

  bool isPasswordHidden = true;

  @override
  login() async {
    ApiClient apiClient = ApiClient();
    if (formState.currentState!.validate()) {
      staterequest = Staterequest.loading;
      update();
      try {
        ApiResponse<dynamic> postResponse =
            await apiClient.postData(url: '$serverLink/auth/user_login', data: {
          'name_user': name.text.trim(),
          'password': password.text.trim(),
        });
        print('POST Response Data: ${postResponse.data}');
        print("Status Code: ${postResponse.statusCode}");
        print("Response Data: ${postResponse.data}");

        //       if ((postResponse.statusCode == 200 || postResponse.statusCode == 201) &&
        //  postResponse.data["state"].toString().toLowerCase().trim() == "success") {

        // final userData = postResponse.data["user"]; // تأكد من اسم المفتاح حسب الاستجابة
        // if (userData != null) {
        //   UsersModel currentUser = UsersModel.fromJson(userData);

        //   // خزّن المستخدم محلياً
        //   final prefs = await SharedPreferences.getInstance();
        //   prefs.setString("user", jsonEncode(currentUser.toJson()));

        //   // خزّن userId في SharedPreferences
        //   prefs.setString("userId", currentUser.userId.toString());

        //   print("تم حفظ بيانات المستخدم: ${currentUser.nameUser}");
        // }

        // print("نجاح تسجيل الدخول");
        // Get.offAll(() => const MainHome());
// }

        if ((postResponse.statusCode == 200 ||
                postResponse.statusCode == 201) &&
            postResponse.data["state"].toString().toLowerCase().trim() ==
                "success") {
          final userData =
              postResponse.data["user"]; // تأكد من اسم المفتاح حسب الاستجابة
          if (userData != null) {
            UsersModel currentUser = UsersModel.fromJson(userData);

            // // خزّن المستخدم محلياً
            // final prefs = await SharedPreferences.getInstance();
            // prefs.setString("user", jsonEncode(currentUser.toJson()));

            final myServices = Get.find<MyServices>();
            myServices.sharedPref
                .setString("user", jsonEncode(currentUser.toJson()));

            print("تم حفظ بيانات المستخدم: ${currentUser.nameUser}");
          }

          print("نجاح تسجيل الدخول");
          Get.offAll(() => const MainHome());
        }
      } catch (error) {
        Get.snackbar("خطأ", "حدث خطأ غير متوقع:");
      } finally {
        staterequest = Staterequest.none;
        update();
      }
    }
  }

  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    update();
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال كلمة المرور';
    }

    // تحقق من طول كلمة المرور
    if (value.length < 8) {
      return 'كلمة المرور يجب أن تحتوي على 8 أحرف على الأقل';
    }

    // تحقق من وجود حرف كبير
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'كلمة المرور يجب أن تحتوي على حرف كبير واحد على الأقل';
    }

    // تحقق من وجود حرف صغير
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'كلمة المرور يجب أن تحتوي على حرف صغير واحد على الأقل';
    }

    // تحقق من وجود رقم
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'كلمة المرور يجب أن تحتوي على رقم واحد على الأقل';
    }

    // تحقق من وجود رمز خاص
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'كلمة المرور يجب أن تحتوي على رمز خاص واحد على الأقل (@\$!%*?& وغيرها)';
    }

    return null;
  }

  @override
  void onInit() {
    name = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    password.dispose();
    super.dispose();
  }
}
