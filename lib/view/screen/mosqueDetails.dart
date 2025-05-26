import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosques/controller/home_controller.dart';
import 'package:mosques/controller/rating_controller.dart';
import 'package:mosques/core/classes/staterequest.dart';
import 'package:mosques/core/costant/App_images.dart';
import 'package:mosques/core/them/app_colors.dart';
import 'package:mosques/view/widget/dialog.dart';
import 'package:mosques/view/widget/mosqueCard.dart';

class MosqueDetails extends StatelessWidget {
  final int mosqueId;

  MosqueDetails({required this.mosqueId});

  @override
  Widget build(BuildContext context) {
    // تهيئة الـ RatingControllerimp
    Get.put(RatingControllerimp());

    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل المسجد',
            style: TextStyle(color: AppColors.primary)),
        centerTitle: true,
      ),
      body: GetBuilder<Homecontrollerimp>(
        initState: (_) {
          Get.find<Homecontrollerimp>().fetchMosqueDetails(mosqueId);
        },
        builder: (controller) {
          if (controller.staterequest == Staterequest.loading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            );
          }

          if (controller.mosqueDetails.value == null) {
            return Center(child: Text("لا توجد تفاصيل للمسجد"));
          }

          var mosque = controller.mosqueDetails.value!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MosqueCard(
                  title: mosque.nameMosque ?? "اسم المسجد",
                  imageUrl: AppImage.mosque1,
                  address: mosque.address ?? "لا يوجد عنوان",
                  phone: mosque.phoneNumber ?? "لا يوجد رقم",
                  mosquesModel: mosque,
                  activities: mosque.activities,
                  services: mosque.services,
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return RatingDialog(mosqueId: mosqueId);
                        },
                      );
                    },
                    child: Text(
                      "قيّم المسجد",
                      style: TextStyle(color: AppColors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
