import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosques/controller/rating_controller.dart';

class Rating extends StatelessWidget {
  final String mosqueId;

  const Rating({super.key, required this.mosqueId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RatingControllerimp>(
      init: RatingControllerimp(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("تقييم الجامع"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  "اختر تقييمك",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < controller.selectedRating
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 30,
                      ),
                      onPressed: () {
                        controller.selectedRating = (index + 1).toDouble();
                        controller.update();
                      },
                    );
                  }),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "تعليقك (اختياري)",
                  ),
                  maxLines: 3,
                  onChanged: (value) {
                    controller.comment = value;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    print(
                        "تم الضغط على زر إرسال التقييم"); // ← تحقق من تنفيذ الضغط
                    controller.addRating(mosqueId);
                  },
                  icon: const Icon(Icons.send),
                  label: const Text("إرسال التقييم"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
