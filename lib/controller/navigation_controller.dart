import 'package:get/get.dart';

abstract class Navigationcontroller extends GetxController {
  var selectedIendex = 0;
  changeTabIendex(int index);
}

class Navigationcontrollerimp extends Navigationcontroller {
  @override
  changeTabIendex(int index) {
    selectedIendex = index;
    update();
  }
}
