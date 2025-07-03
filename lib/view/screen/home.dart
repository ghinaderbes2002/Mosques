import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosques/controller/home_controller.dart';
import 'package:mosques/controller/rating_controller.dart';
import 'package:mosques/core/classes/HindlingDataRequest.dart';
import 'package:mosques/core/classes/staterequest.dart';
import 'package:mosques/core/costant/App_images.dart';
import 'package:mosques/core/costant/App_link.dart';
import 'package:mosques/core/data/model/mosque_model.dart';
import 'package:mosques/core/data/model/rating_model.dart';
import 'package:mosques/core/them/app_colors.dart';
import 'package:mosques/view/screen/mosqueDetails.dart';
import 'package:mosques/view/screen/mosquesHistorical%20.dart';
import 'package:mosques/view/widget/mosqueCard.dart';



class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(Homecontrollerimp());
    final RatingControllerimp ratingController = Get.put(RatingControllerimp());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الصفحة الرئيسية",
          style: TextStyle(color: AppColors.primary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.account_balance), 
            tooltip: "المساجد التاريخية",
            onPressed: () {
              Get.to(() => HistoricalMosques());
            },
          ),
             IconButton(
            icon: Icon(Icons.my_location),
            tooltip: "أقرب مسجد",
            onPressed: () async {
              final controller = Get.find<Homecontrollerimp>();
              MosquesModel? nearestMosque =
                  await controller.fetchNearestMosque();
              if (nearestMosque != null) {
                controller.mosqueDetails.value = nearestMosque;
                Get.to(() => MosqueDetails(mosqueId: nearestMosque.mosqueId!));
              }
            },
          ),
        ],
      ),
      body: GetBuilder<Homecontrollerimp>(
        builder: (controller) {
          if (controller.staterequest == Staterequest.loading) {
            return Center(
                child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.primary)));
          }

          if (controller.staterequest == Staterequest.none) {
            print('Mosques List: ${controller.mosquesList}');
          }

          return HindlingDataRequest(
            stateRequest: controller.staterequest,
            widget: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller.searchController,
                    onChanged: (value) {
                      controller.filterMosques(value);
                    },
                    cursorColor: AppColors.primary,
                    decoration: InputDecoration(
                      hintText: "ابحث عن مسجد بالاسم أو المنطقة",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                      filled: true,
                      fillColor: AppColors.white,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 2 / 4,
                      ),
                      itemCount: controller.filteredMosques
                          .where((mosque) => mosque.isHistorical == false)
                          .toList()
                          .length,
                      itemBuilder: (context, index) {
                        final mosque = controller.filteredMosques
                            .where((mosque) => mosque.isHistorical == false)
                            .toList()[index];

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
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Text("خطأ في تحميل التقييمات");
                              } else {
                                final ratings = snapshot.data ?? [];
                                final averageRating = ratingController
                                    .calculateAverageRating(ratings);
                                

              print("=================================================");

                                print('${serverLink}${mosque.mosqueImages![0].imageUrl}');
                                return MosqueCard(
                                  title: mosque.nameMosque ?? "No Name",
                               imageUrls: [
                                    if (mosque.mosqueImages != null &&
                                        mosque.mosqueImages!.isNotEmpty)
                                      '${serverLink}${mosque.mosqueImages![0].imageUrl}',
                                  ],

                                  address: mosque.address ?? "No Address",
                                  phone: mosque.phoneNumber ?? "",
                                  showActivitiesAndServices: false,
                                  averageRating: averageRating,
                                  isHistorical: mosque.isHistorical ?? false,
                                );
                              }
                            },
                          ),
                        );
                      },
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


