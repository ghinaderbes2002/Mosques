import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosques/controller/home_controller.dart';
import 'package:mosques/controller/rating_controller.dart';
import 'package:mosques/core/costant/App_images.dart';
import 'package:mosques/core/data/model/rating_model.dart';
import 'package:mosques/view/screen/mosqueDetails.dart';
import 'package:mosques/view/widget/mosqueCard.dart';

class HistoricalMosques extends StatelessWidget {
  const HistoricalMosques({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<Homecontrollerimp>();
    final ratingController = Get.find<RatingControllerimp>();

    final historicalMosques = controller.filteredMosques
        .where((mosque) => mosque.isHistorical == true)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("المساجد التاريخية"),
        centerTitle: true,
      ),
      body: historicalMosques.isEmpty
          ? const Center(child: Text("لا يوجد مساجد تاريخية حالياً"))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 2 / 4,
                      ),
                      itemCount: historicalMosques.length,
                      itemBuilder: (context, index) {
                        final mosque = historicalMosques[index];

                        return InkWell(
                          onTap: () {
                            controller.fetchMosqueDetails(mosque.mosqueId!);
                            Get.to(() =>
                                MosqueDetails(mosqueId: mosque.mosqueId!));
                          },
                          child: FutureBuilder<List<RatingModel>>(
                            future: ratingController
                                .fetchRatings(mosque.mosqueId.toString()),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return const Center(
                                    child: Text("خطأ في تحميل التقييمات"));
                              } else {
                                final ratings = snapshot.data ?? [];
                                final averageRating = ratingController
                                    .calculateAverageRating(ratings);

                                return MosqueCard(
                                  title: mosque.nameMosque ?? "No Name",
                                  imageUrl: AppImage.mosque1,
                                  address: mosque.address ?? "No Address",
                                  phone: mosque.phoneNumber ?? "",
                                  showActivitiesAndServices: false,
                                  averageRating: averageRating,
                                  isHistorical: true,
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
