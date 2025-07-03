import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mosques/core/data/model/mosque_model.dart';
import 'package:mosques/core/them/app_colors.dart';

class MosqueCard extends StatefulWidget {
  final String? title;
  final String? description;
  final List<String>? imageUrls; // بدل imageUrl
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
    this.imageUrls,
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
  _MosqueCardState createState() => _MosqueCardState();
}

class _MosqueCardState extends State<MosqueCard> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.imageUrls ?? [];

    return Card(
      color: AppColors.white,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: Colors.black12,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        // Slider الصور
        if (images.isNotEmpty)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Column(
              children: [
                SizedBox(
                  height: 180,
                  child: PageView.builder(
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.network(
                        images[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Icon(Icons.error));
                        },
                      );
                    },
                  ),
                ),

                // مؤشرات الصور (dots)
                if (images.length > 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(images.length, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentImageIndex == index ? 12 : 8,
                          height: _currentImageIndex == index ? 12 : 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentImageIndex == index
                                ? AppColors.primary
                                : Colors.grey[300],
                          ),
                        );
                      }),
                    ),
                  ),
              ],
            ),
          )
        else
          // إذا ما في صور، تعرض مكانها اي عنصر بديل (مثل placeholder)
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: const Center(
              child:
                  Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
            ),
          ),

        // باقي تفاصيل الكارد
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // الاسم
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      widget.title ?? "اسم غير متوفر",
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
              if (widget.address != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        widget.address!,
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
              if (widget.phone != null && widget.phone!.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.phone!,
                      style:
                          const TextStyle(fontSize: 14, color: AppColors.grey),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.phone, color: AppColors.grey),
                  ],
                ),
              const SizedBox(height: 8),

              // التقييم
              if (widget.averageRating != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RatingBarIndicator(
                      rating: widget.averageRating!,
                      itemBuilder: (context, _) =>
                          const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 20.0,
                    ),
                  ],
                ),

              if (widget.showActivitiesAndServices) ...[
                const SizedBox(height: 12),

                if (widget.activities != null &&
                    widget.activities!.isNotEmpty) ...[
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "  : النشاطات  ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...widget.activities!.map(
                    (activity) => Padding(
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
                    ),
                  ),
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
                if (widget.services != null && widget.services!.isNotEmpty) ...[
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "  : الخدمات  ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...widget.services!.map(
                    (service) => Padding(
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
                    ),
                  ),
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
            ],
          ),
        )
      ]),
    );
  }
}
