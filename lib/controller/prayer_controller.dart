// import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mosques/core/classes/api_client.dart';
import 'package:mosques/core/classes/staterequest.dart';
import 'package:mosques/core/costant/App_link.dart';


abstract class PrayerController extends GetxController {
  getPrayerTimes(double lat, double lng);
  getCurrentLocationAndFetchPrayerTimes();
}

class PrayerControllerimp extends PrayerController {
  Staterequest staterequest = Staterequest.none;
  Map<String, dynamic>? prayerTimes;

  @override
  Future<void> getPrayerTimes(double lat, double lng) async {
    ApiClient apiClient = ApiClient();
    staterequest = Staterequest.loading;
    update();

    try {
      ApiResponse<dynamic> getResponse = await apiClient.getData(
          url: '$serverLink/api/prayer-times?lat=$lat&lng=$lng');

      print('GET Response Status Code: ${getResponse.statusCode}');
      print('GET Response Data: ${getResponse.data}');

      if (getResponse.statusCode == 200 || getResponse.statusCode == 201) {
        Map<String, dynamic> data = getResponse.data;

        if (data.containsKey('times')) {
          prayerTimes = data;
          print('Prayer Times: ${data['times']}');
        } else {
          print("Key 'times' not found in response data");
        }
      } else {
        Get.snackbar("خطأ", "لم تتمكن من جلب أوقات الصلاة.");
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء جلب أوقات الصلاة: $e");
    } finally {
      staterequest = Staterequest.none;
      update();
    }
  }

  @override
  Future<void> getCurrentLocationAndFetchPrayerTimes() async {
    staterequest = Staterequest.loading;
    update();
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar("الموقع غير مفعل", "يرجى تفعيل خدمة الموقع");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar("صلاحيات مرفوضة", "يرجى السماح بالوصول للموقع");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar("مرفوض دائمًا", "توجه للإعدادات لتفعيل الموقع");
        return;
      }

      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      await getPrayerTimes(position.latitude, position.longitude);
    } catch (e) {
      print("Error fetching location: $e");
      Get.snackbar("خطأ", "تعذر تحديد الموقع: $e");
    }
  }

  @override
  void onInit() {
    getCurrentLocationAndFetchPrayerTimes();
    super.onInit();
  }

  // @override
  // void onInit() {
  //   getPrayerTimes(36.2021, 37.1343);
  //   super.onInit();
  // }
}
