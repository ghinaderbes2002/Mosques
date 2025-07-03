import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mosques/core/classes/api_client.dart';
import 'package:mosques/core/classes/staterequest.dart';
import 'package:mosques/core/costant/App_link.dart';
import 'package:mosques/core/data/model/mosque_model.dart';

abstract class Homecontroller extends GetxController {
  fetchMosque();
  filterMosques(String query);
  // filterMosques({String? name, String? area, List<String>? services});
  fetchMosqueDetails(int mosqueId);
  fetchHistoricalMosques();
  fetchNearestMosque();
}

class Homecontrollerimp extends Homecontroller {
  TextEditingController searchController = TextEditingController();

  Staterequest staterequest = Staterequest.none;

  final List<MosquesModel> mosquesList = [];
  List<MosquesModel> filteredMosques = [];
  var mosqueDetails = Rxn<MosquesModel>(); // لعرض تفاصيل المسجد


  @override
  void filterMosques(String query) {
    query = query.toLowerCase();
    filteredMosques = mosquesList.where((mosque) {
      final name = mosque.nameMosque?.toLowerCase() ?? '';
      final area = mosque.address?.toLowerCase() ?? '';
      return name.contains(query) || area.contains(query);
    }).toList();

    update();
  }


Future<Position> getUserLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}

@override
  Future<MosquesModel?> fetchNearestMosque() async {
    try {
      Position position = await getUserLocation();
      print("Lat: ${position.latitude}, Lng: ${position.longitude}");


      ApiClient apiClient = ApiClient();
      final response = await apiClient.getData(
        url:
            '$serverLink/mosque/nearest?lat=${position.latitude}&lng=${position.longitude}',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['mosque'] != null) {
          return MosquesModel.fromJson(data['mosque']);
        }
      }
      Get.snackbar('خطأ', 'لم يتم العثور على أقرب مسجد');
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء جلب الموقع: $e');
    }
    return null;
  }


  @override
  Future<void> fetchMosque() async {
    ApiClient apiClient = ApiClient();
    staterequest = Staterequest.loading;
    update();

    try {
      ApiResponse<dynamic> getResponse = await apiClient.getData(
        url: '$serverLink/mosque/getMosques',
      );

      print('GET Response Status Code: ${getResponse.statusCode}');
      print('GET Response Data: ${getResponse.data}');

      if (getResponse.statusCode == 200 || getResponse.statusCode == 201) {
        Map<String, dynamic> data = getResponse.data;

        if (data.containsKey('mosques')) {
          List<dynamic> mosquesData = data['mosques'];

          mosquesList.clear();
          mosquesList.addAll(
              mosquesData.map((mosque) => MosquesModel.fromJson(mosque)));

          filteredMosques = List.from(mosquesList);

          print('Mosques List: $mosquesList');
        } else {
          print("Key 'mosques' not found in response data");
        }
      } else {
        Get.snackbar("خطأ", "لم تتمكن من جلب البيانات.");
      }
    } catch (error) {
      print(error);
      Get.snackbar("خطأ", "حدث خطأ غير متوقع: $error");
    } finally {
      staterequest = Staterequest.none;
      update(); // تحدث الواجهة بعد التحميل
    }
  }

  @override
  Future<void> fetchMosqueDetails(int mosqueId) async {
    ApiClient apiClient = ApiClient();
    staterequest = Staterequest.loading;
    await Future.delayed(Duration.zero, () {
      update(); // عندما تكتمل مرحلة البناء، قم بتحديث الواجهة
    });
    try {
      ApiResponse<dynamic> getResponse = await apiClient.getData(
        url: '$serverLink/mosque/withDetails?mosqueId=$mosqueId',
      );

      if (getResponse.statusCode == 200 || getResponse.statusCode == 201) {
        List mosquesData = getResponse.data['mosques'];
        mosqueDetails.value = MosquesModel.fromJson(
            mosquesData.firstWhere((e) => e['mosque_id'] == mosqueId));
      } else {
        Get.snackbar("خطأ", "لم تتمكن من جلب بيانات المسجد.");
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ غير متوقع: $e");
    } finally {
      staterequest = Staterequest.none;
      update();
    }
  }

  @override
  Future<void> fetchHistoricalMosques() async {
    ApiClient apiClient = ApiClient();
    staterequest = Staterequest.loading;
    update();

    try {
      ApiResponse<dynamic> getResponse = await apiClient.getData(
        url: '$serverLink/mosque/historical',
      );

      print('GET Response Status Code: ${getResponse.statusCode}');
      print('GET Response Data: ${getResponse.data}');

      if (getResponse.statusCode == 200 || getResponse.statusCode == 201) {
        Map<String, dynamic> data = getResponse.data;

        if (data.containsKey('mosques')) {
          List<dynamic> mosquesData = data['mosques'];

          mosquesList.clear();
          mosquesList.addAll(
              mosquesData.map((mosque) => MosquesModel.fromJson(mosque)));

          filteredMosques = List.from(mosquesList);

          print('Mosques List: $mosquesList');
        } else {
          print("Key 'mosques' not found in response data");
        }
      } else {
        Get.snackbar("خطأ", "لم تتمكن من جلب البيانات.");
      }
    } catch (error) {
      print(error);
      Get.snackbar("خطأ", "حدث خطأ غير متوقع: $error");
    } finally {
      staterequest = Staterequest.none;
      update(); // تحدث الواجهة بعد التحميل
    }
  }

  @override
  void onInit() {
    fetchMosque();
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
