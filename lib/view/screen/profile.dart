import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosques/controller/profile_controller.dart';
import 'package:mosques/core/classes/staterequest.dart';
import 'package:mosques/core/costant/App_routes.dart';
import 'package:mosques/core/them/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Profilecontrollerimp>(
      init: Profilecontrollerimp(),
      builder: (controller) {
        if (controller.staterequest == Staterequest.loading) {
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.primary))),
          );
        }

        if (controller.userlist.isEmpty) {
          return const Scaffold(
            body: Center(child: Text("لا يوجد بيانات مستخدم.")),
          );
        }

        final user = controller.userlist[0];

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "الملف الشخصي",
              style: TextStyle(color: AppColors.primary),
            ),
            centerTitle: true,
            backgroundColor: AppColors.white,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // الاسم
                  _buildInfoCard("الاسم", user.nameUser),
                  const SizedBox(height: 12),

                  // الإيميل
                  _buildInfoCard("البريد الإلكتروني", user.email),
                  const SizedBox(height: 12),

                  // رقم الهاتف
                  _buildInfoCard("رقم الهاتف", user.phoneNumber),
                  const SizedBox(height: 30),

                  // زر تسجيل الخروج
                  ElevatedButton.icon(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove("user");
                      Get.delete<
                          Profilecontrollerimp>(); // لحذف الكونترولر الخاص بالملف الشخصي

                      Get.offAllNamed(AppRoute.login);
                    },
                    icon: const Icon(Icons.logout, color: AppColors.white),
                    label: const Text(
                      "تسجيل الخروج",
                      style: TextStyle(color: AppColors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(String title, String? value) {
    IconData iconData;

    switch (title) {
      case "الاسم":
        iconData = Icons.person;
        break;
      case "البريد الإلكتروني":
        iconData = Icons.email;
        break;
      case "رقم الهاتف":
        iconData = Icons.phone;
        break;
      default:
        iconData = Icons.info_outline;
    }
    return Card(
      elevation: 4,
      color: AppColors.accent4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        trailing: Icon(iconData, color: AppColors.primary),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
        subtitle: Text(
          value ?? "غير متوفر",
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
