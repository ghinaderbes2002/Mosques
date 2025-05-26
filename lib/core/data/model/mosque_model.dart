import 'package:mosques/core/data/model/mosque_Image_model.dart';

class MosquesModel {
  final int? mosqueId;
  final String? nameMosque;
  final String? address;
  final double? latitude; // ✅ مضاف حديثًا
  final double? longitude; // ✅ مضاف حديثًا
  final String? phoneNumber;
  final bool? isHistorical;
   final List<Activity>? activities;
  final List<Service>? services;
  final List<MosqueImage>? mosqueImages;

  MosquesModel({
    this.mosqueId,
    this.nameMosque,
    this.address,
    this.latitude, // ✅
    this.longitude, // ✅
    this.phoneNumber,
    this.isHistorical,
    this.activities,
    this.services,
    this.mosqueImages,
  });

  factory MosquesModel.fromJson(Map<String, dynamic> json) {
    return MosquesModel(
      mosqueId: json['mosque_id'],
      nameMosque: json['name_mosque'],
      address: json['address'],
      latitude: json['latitude']?.toDouble(), // ✅ تأكد نحوله لـ double
      longitude: json['longitude']?.toDouble(), // ✅
      phoneNumber: json['phone_number'],
      isHistorical: json['is_historical'],
      activities: (json['activities'] as List?)
          ?.map((e) => Activity.fromJson(e))
          .toList(),
      services:
          (json['services'] as List?)?.map((e) => Service.fromJson(e)).toList(),
         mosqueImages: (json['mosque_images'] as List?)
          ?.map((e) => MosqueImage.fromJson(e))
          .toList(),    );
  }
}
class Activity {
  final String? name;
  final String? details;

  Activity({this.name, this.details});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      name: json['name'],
      details: json['details'],
    );
  }
}

class Service {
  final String? name;
  final String? description;

  Service({this.description, this.name});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      name: json['service_name'],
      description: json['description'],
    );
  }
}














