import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosques/controller/prayer_controller.dart';
import 'package:mosques/core/classes/staterequest.dart';
import 'package:mosques/core/them/app_colors.dart';

class PrayerTimes extends StatelessWidget {
  const PrayerTimes({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<PrayerControllerimp>(
        init: PrayerControllerimp(),
        builder: (controller) {
          if (controller.staterequest == Staterequest.loading) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "أوقات الصلاة",
                  style: TextStyle(color: AppColors.primary),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: Icon(Icons.my_location),
                    onPressed: () {
                      // controller.getCurrentLocationAndFetchPrayerTimes();
                    },
                  )
                ],
              ),
              body: Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.primary))),
            );
          }

          if (controller.prayerTimes == null) {
            return Scaffold(
              appBar: AppBar(title: Text("أوقات الصلاة")),
              body: Center(child: Text("لم يتم العثور على بيانات")),
            );
          }

          final times = controller.prayerTimes!['times'];

          return Scaffold(
            appBar: AppBar(
              title: Text("أوقات الصلاة"),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  _buildTimeCard('الفجر', times['fajr']),
                  _buildTimeCard('الشروق', times['sunrise']),
                  _buildTimeCard('الظهر', times['dhuhr']),
                  _buildTimeCard('العصر', times['asr']),
                  _buildTimeCard('المغرب', times['maghrib']),
                  _buildTimeCard('العشاء', times['isha']),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeCard(String title, String time) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.teal[50],
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        trailing: Text(
          time,
          style: TextStyle(fontSize: 18, color: AppColors.primary),
        ),
      ),
    );
  }
}
