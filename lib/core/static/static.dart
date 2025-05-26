import 'package:flutter/material.dart';
import 'package:mosques/core/costant/App_images.dart';
import 'package:mosques/model/OnBoardingModel.dart';
import 'package:mosques/view/screen/home.dart';
import 'package:mosques/view/screen/map_test_screen.dart';
import 'package:mosques/view/screen/prayer.dart';
import 'package:mosques/view/screen/profile.dart';


List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
    title: "مرحبًا بك في دليل المساجد",
    image: AppImage.on1,
    description:
        " اكتشف المساجد القريبة منك وكن دائمًا على موعد مع الصلاة حيثما كنت",
  ),
  OnBoardingModel(
    title: "كل مسجد، كل صلاة",
    image: AppImage.on2,
    description:
        " مواقيت الصلاة الدقيقة، معلومات عن المساجد، وخدمات مخصصة لكل مصلٍّ",
  ),
  OnBoardingModel(
    title: "معك دائمًا في طريق الخير",
    image: AppImage.on3,
    description: " انضم إلى مجتمع المصلين وشارك الخيرات أينما كنت",
  ),
];

final List<Widget> page = [
  const Home(),
  const PrayerTimes(),
  const MapTestScreen(),
  const Profile()
];
