import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var currentIndex = RxInt(0);
  final currentIndexNotifier = ValueNotifier<int>(0);

  void changeTabIndex(int index) {
    currentIndex.value = index;
    currentIndexNotifier.value = index;
  }
}

