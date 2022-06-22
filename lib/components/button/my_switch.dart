import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/theme_controller.dart';

class MySwitch extends StatelessWidget {
  ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (_) {
      return Row(
        children: [
          Switch(
            activeColor: Theme.of(context).colorScheme.onBackground,
            inactiveThumbColor: Theme.of(context).colorScheme.onBackground,
            value: _themeController.isDarkTheme,
            onChanged: (value) {
              _themeController.changeTheme(value);
            },
          ),
        ],
      );
    });
  }
}
