import 'package:get/get.dart';

class MyAnimationController extends GetxController {
  late double _width;
  double get width => _width;

  late double _opacity;
  double get opacity => _opacity;

  void onInit() {
    super.onInit();
    _opacity = 0;
    _width = 0;
    Future.delayed(Duration(seconds: 1)).then((value) => {SplashAnimation()});
  }

  void onClose() {
    super.onClose();
  }

  SplashAnimation() {
    _width = 300;
    _opacity = 1;
    update();
  }
}
