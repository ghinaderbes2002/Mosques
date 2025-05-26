import 'package:get/get.dart';

import 'package:mosques/core/classes/staterequest.dart';
import 'package:mosques/core/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

abstract class Profilecontroller extends GetxController {
  fatchUsers();
}

class Profilecontrollerimp extends Profilecontroller {
  final List<UsersModel> userlist = [];

  Staterequest staterequest = Staterequest.none;

  @override
  Future<void> fatchUsers() async {
    staterequest = Staterequest.loading;
    update();

    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString("user");

      if (jsonString != null) {
        final Map<String, dynamic> userMap = jsonDecode(jsonString);
        final currentUser = UsersModel.fromJson(userMap);

        userlist.clear();
        userlist.add(currentUser);

        print("Current user: ${currentUser.nameUser}");
      } else {
        Get.snackbar("خطأ", "لم يتم العثور على بيانات المستخدم.");
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء جلب المستخدم: $e");
    } finally {
      staterequest = Staterequest.none;
      update();
    }
  }

  @override
  void onInit() {
    fatchUsers();
    super.onInit();
  }
}
