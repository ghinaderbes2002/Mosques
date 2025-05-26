import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mosques/core/data/model/mosque_model.dart';
import 'package:mosques/core/them/app_colors.dart';


class MosqueCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? address;
  final String? phone;
  final int? stars;
  final MosquesModel? mosquesModel;
  final List<Activity>? activities;
  final List<Service>? services;
  final bool showActivitiesAndServices;
  final double? averageRating;
  final bool? isHistorical;

  const MosqueCard({
    Key? key,
    this.title,
    this.description,
    this.imageUrl,
    this.address,
    this.phone,
    this.stars,
    this.mosquesModel,
    this.activities,
    this.services,
    this.showActivitiesAndServices = true,
    this.averageRating,
    this.isHistorical,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppColors.white,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        shadowColor: Colors.black12,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          // صورة الجامع
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              imageUrl!,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // التفاصيل
          Padding(
              padding: const EdgeInsets.all(12),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                // الاسم
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        title ?? "اسم غير متوفر",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.grey,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.mosque, color: AppColors.grey),
                  ],
                ),
                const SizedBox(height: 8),

                // العنوان
                if (address != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          address!,
                          style: const TextStyle(
                              fontSize: 14, color: AppColors.grey),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.location_on, color: AppColors.grey),
                    ],
                  ),
                const SizedBox(height: 6),

                // الهاتف
                if (phone != null && phone!.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        phone!,
                        style: const TextStyle(
                            fontSize: 14, color: AppColors.grey),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.phone, color: AppColors.grey),
                    ],
                  ),
                const SizedBox(height: 8),

                if (averageRating != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RatingBarIndicator(
                        rating: averageRating!,
                        itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                        itemCount: 5,
                        itemSize: 20.0,
                      ),
                    ],
                  ),

                if (showActivitiesAndServices) ...[
                  const SizedBox(height: 12),

                  if (activities != null && activities!.isNotEmpty) ...[
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "  : النشاطات  ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...activities!.map((activity) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                activity.name ?? "اسم النشاط غير متوفر",
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                activity.details ?? "لا يوجد شرح",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        )),
                  ] else
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "لا توجد نشاطات.",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                        textAlign: TextAlign.right,
                      ),
                    ),

                  const SizedBox(height: 12),

                  // الخدمات
                  if (services != null && services!.isNotEmpty) ...[
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "  : الخدمات  ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...services!.map((service) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                service.name ?? "اسم الخدمة غير متوفر",
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                service.description ?? "لا يوجد شرح",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        )),
                  ] else
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "لا توجد خدمات.",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                        textAlign: TextAlign.right,
                      ),
                    ),
                ],
              ]))
        ]));
  }
}
