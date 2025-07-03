import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosques/controller/home_controller.dart';
import 'package:mosques/controller/rating_controller.dart';
import 'package:mosques/core/classes/staterequest.dart';
import 'package:mosques/core/costant/App_link.dart';
import 'package:mosques/core/them/app_colors.dart';
import 'package:mosques/view/widget/dialog.dart';
import 'package:mosques/view/widget/mosqueCard.dart';

class MosqueDetails extends StatefulWidget {
  final int mosqueId;

  const MosqueDetails({Key? key, required this.mosqueId}) : super(key: key);

  @override
  State<MosqueDetails> createState() => _MosqueDetailsState();
}

class _MosqueDetailsState extends State<MosqueDetails> {
  final ratingController = Get.put(RatingControllerimp());
  final homeController = Get.put(Homecontrollerimp());

  @override
  void initState() {
    super.initState();
    homeController.fetchMosqueDetails(widget.mosqueId);
    ratingController.fetchRatingsandcomment(widget.mosqueId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تفاصيل المسجد',
          style: TextStyle(color: AppColors.primary),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GetBuilder<Homecontrollerimp>(
              builder: (controller) {
                if (controller.staterequest == Staterequest.loading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  );
                }
                if (controller.mosqueDetails.value == null) {
                  return const Center(child: Text("لا توجد تفاصيل للمسجد"));
                }
                var mosque = controller.mosqueDetails.value!;

                return MosqueCard(
                  title: mosque.nameMosque ?? "اسم المسجد",
                  imageUrls: [
                    if (mosque.mosqueImages != null &&
                        mosque.mosqueImages!.length > 1)
                      '${serverLink}${mosque.mosqueImages![1].imageUrl}',
                    if (mosque.mosqueImages != null &&
                        mosque.mosqueImages!.length > 2)
                      '${serverLink}${mosque.mosqueImages![2].imageUrl}',
                    if (mosque.mosqueImages != null &&
                        mosque.mosqueImages!.length > 3)
                      '${serverLink}${mosque.mosqueImages![3].imageUrl}',
                  ],                  address: mosque.address ?? "لا يوجد عنوان",
                  phone: mosque.phoneNumber ?? "لا يوجد رقم",
                  mosquesModel: mosque,
                  activities: mosque.activities,
                  services: mosque.services,
                );
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return RatingDialog(mosqueId: widget.mosqueId);
                    },
                  );
                },
                child: const Text(
                  "قيّم المسجد",
                  style: TextStyle(color: AppColors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // عرض التقييمات مع تحديث تلقائي
            Obx(() {
              if (ratingController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                );
              }
              if (ratingController.ratings.isEmpty) {
                return const Center(child: Text("لا توجد تقييمات حتى الآن"));
              }

              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: ratingController.ratings.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final rating = ratingController.ratings[index];
                  final userName = rating.user?.nameUser ?? "مستخدم";

                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    title: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userName,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: const Text(
                              "تقييم المستخدم",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${rating.ratingValue} / 5",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 8),
                              Row(
                                children: List.generate(5, (starIndex) {
                                  return Icon(
                                    starIndex < rating.ratingValue
                                        ? Icons.star
                                        : Icons.star_border,
                                    size: 18,
                                    color: starIndex < rating.ratingValue
                                        ? Colors.amber
                                        : Colors.grey[400],
                                  );
                                }),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerRight,
                            child: const Text(
                              "تعليق المستخدم",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            rating.comment.isNotEmpty
                                ? rating.comment
                                : "لا يوجد تعليق",
                            textAlign: TextAlign.right,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
