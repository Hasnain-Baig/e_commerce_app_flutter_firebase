import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/bottom_nav_bar.dart';

class SplashController extends GetxController {
  void onInit() {
    _myTimer = 0;
    super.onInit();
    timerPlay();
  }

  late int _myTimer;
  int get myTimer => _myTimer;

  timerPlay() {
    var _splashScreenTimer;
    _splashScreenTimer =
        new Timer.periodic(new Duration(milliseconds: 1000), (timer) {
      _myTimer++;
      if (_myTimer == 5) {
        _splashScreenTimer.cancel();
        Get.to(WillPopScope(
            onWillPop: () async => false, child: MyBottomNavbar()));
      }
    });
  }
}
