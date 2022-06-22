import 'package:get/get.dart';
import '../components/theme/my_theme.dart';

class ThemeController extends GetxController {
  void onInit() {
    super.onInit();
    themeListener();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  themeListener() {
    currentTheme.addListener(() {
      update();
    });
  }

  changeTheme(value) {
    _isDarkTheme = value;
    currentTheme.toggleTheme();
    update();
  }
}
