import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:mosques/controller/rating_controller.dart';
import 'package:mosques/core/them/app_colors.dart';


class RatingDialog extends StatefulWidget {
  final int mosqueId;

  RatingDialog({required this.mosqueId});

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double selectedRating = 0;
  String? comment;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        "قيّم المسجد",
        style: TextStyle(color: AppColors.primary),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar.builder(
              initialRating: selectedRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: AppColors.primary,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  selectedRating = rating;
                });
              },
            ),
            SizedBox(height: 15),
            TextField(
              textDirection: TextDirection.rtl,
              cursorColor: AppColors.primary,
              style: TextStyle(color: AppColors.primary),
              decoration: InputDecoration(
                labelText: 'اكتب تعليقك',
                labelStyle: TextStyle(color: AppColors.primary),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  comment = value;
                });
              },
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     final controller = Get.find<RatingControllerimp>();
            //     controller.selectedRating = selectedRating;
            //     controller.comment = comment;
            //     controller.addRating(widget.mosqueId.toString());
            //     Get.back(); // إغلاق النافذة
            //   },
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: AppColors.primary,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            //   child: Text(
            //     "إرسال التقييم",
            //     style: TextStyle(color: AppColors.white),
            //   ),
            // ),
            ElevatedButton(
              onPressed: () async {
                if (selectedRating == 0) {
                  Get.snackbar("تنبيه", "الرجاء اختيار تقييم قبل الإرسال");
                  return;
                }

                final controller = Get.find<RatingControllerimp>();
                controller.selectedRating = selectedRating;
                controller.comment = comment;

                await controller.addRating(widget.mosqueId.toString());
                // ما في داعي لـ Get.back() هون، لأنه موجود داخل الدالة نفسها بعد النجاح
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "إرسال التقييم",
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
