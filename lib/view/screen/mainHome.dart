import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mosques/controller/navigation_controller.dart';
import 'package:mosques/core/static/static.dart';
import 'package:mosques/core/them/app_colors.dart';

class MainHome extends StatelessWidget {
  const MainHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Navigationcontrollerimp navcontroller = Get.put(Navigationcontrollerimp());
    return Scaffold(
        body: GetBuilder<Navigationcontrollerimp>(
            builder: (controller) => page[controller.selectedIendex]),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
            child: GNav(
              hoverColor: AppColors.primary,
              haptic: true,
              tabBorderRadius: 15,
              tabActiveBorder: Border.all(color: AppColors.primary, width: 1),
              tabBorder: Border.all(color: Colors.grey, width: 1),
              tabShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
              ],
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 600),
              gap: 8,
              color: Colors.grey[800],
              activeColor: AppColors.primary,
              iconSize: 24,
              tabBackgroundColor: Colors.blue.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              tabs: const [
                GButton(icon: LineIcons.home, text: 'الرئيسية'),
                GButton(icon: LineIcons.clock, text: 'أوقات الصلاة'),
                GButton(icon: LineIcons.searchLocation, text: 'الخريطة'),
                GButton(icon: LineIcons.user, text: 'الملف الشخصي'),
              ],
              selectedIndex: navcontroller.selectedIendex,
              onTabChange: (index) {
                navcontroller.changeTabIendex(index);
              },
            ),
          ),
        ));
  }
}
