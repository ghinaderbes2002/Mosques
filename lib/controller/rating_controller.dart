import 'dart:convert';
import 'package:get/get.dart';
import 'package:mosques/core/classes/api_client.dart';
import 'package:mosques/core/costant/App_link.dart';
import 'package:mosques/core/data/model/rating_model.dart';
import 'package:mosques/core/data/model/user_model.dart';
import 'package:mosques/core/services/SharedPreferences.dart';

abstract class RatingController extends GetxController {
  addRating(String mosqueId);
  fetchRatings(String mosqueId);
}

class RatingControllerimp extends RatingController {
  var ratings = <RatingModel>[].obs; // هذا مهم!
  var isLoading = true.obs;

  double selectedRating = 0;
  String? comment;


  
@override
  @override
  Future<void> addRating(String mosqueId) async {
    try {
      final MyServices myServices = Get.find();
      final String? userJson = myServices.sharedPref.getString("user");

      if (userJson == null) {
        Get.snackbar("خطأ", "لم يتم العثور على بيانات المستخدم");
        return;
      }

      final Map<String, dynamic> userMap = jsonDecode(userJson);
      final UsersModel currentUser = UsersModel.fromJson(userMap);
      final int userId = currentUser.id;

    final rating = RatingModel(
        ratingValue: selectedRating.toInt(),
comment: comment ?? "",
        mosqueId: int.parse(mosqueId),
        userId: userId,
      );


      final ratingJson = rating.toJson();
      print("Rating JSON: $ratingJson");

      ApiClient apiClient = ApiClient();
      final response = await apiClient.postData(
        url: '$serverLink/rating/mosques/ratings',
        data: ratingJson,
      );

      print("Response status: ${response.statusCode}");
      print("Response data: ${response.data}");

   final state = response.data['state']?.toString();
      final message = response.data['msg']?.toString();

      if (state == 'duplicate') {
        Get.snackbar("تنبيه", "لقد قمت بتقييم هذا المسجد من قبل");
      } else if (state == 'success') {
        Get.snackbar(
            "نجاح", "تم التقييم بنجاح"); 
        Get.back();
      } else {
        Get.snackbar("ملاحظة", message ?? "تمت العملية");
      }

    } catch (e) {
      print("Error sending rating: $e");
      Get.snackbar("خطأ", "حدث خطأ أثناء إرسال التقييم: $e");
    }
  }


  @override
  Future<List<RatingModel>> fetchRatings(String mosqueId) async {
    ApiClient apiClient = ApiClient();
    try {
      final response = await apiClient.getData(
        url: '$serverLink/rating/mosques/ratings/$mosqueId',
      );
      print("Response Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['ratings'];
        return data.map((json) => RatingModel.fromJson(json)).toList();
      } else {
        print("Error: ${response.statusCode} - ${response.data}");
        throw Exception("فشل في تحميل التقييمات");
      }
    } catch (e) {
      print("Error fetching ratings: $e");
      rethrow;
    }
    // finally {
    //   isLoading(false);
    //   update(); // تحديث GetBuilder
    // }
  }

@override
  Future<void> fetchRatingsandcomment(String mosqueId) async {
    isLoading.value = true;
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.getData(
        url: '$serverLink/mosque/mosques/$mosqueId/ratings',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['ratings'];
        ratings.value = data.map((json) => RatingModel.fromJson(json)).toList();
      } else {
        ratings.clear();
        throw Exception("فشل في تحميل التقييمات");
      }
    } catch (e) {
      ratings.clear();
      print("Error fetching ratings: $e");
    } finally {
      isLoading.value = false;
    }
  }


  double calculateAverageRating(List<RatingModel> ratings) {
    if (ratings.isEmpty) return 0.0;

    double sum = 0;
    for (var rating in ratings) {
      sum += rating.ratingValue;
    }
    return sum / ratings.length;
  }
}
