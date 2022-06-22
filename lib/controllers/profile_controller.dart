import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/dialog_box/logout_dialog_box.dart';
import 'login_controller.dart';

class ProfileController extends GetxController {
  LoginController _loginController = Get.put(LoginController());

  openlogoutDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return LogoutDialogBox();
        });
  }
}
