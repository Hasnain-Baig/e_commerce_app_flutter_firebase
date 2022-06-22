import 'package:e_commerce_app_flutter_firebase/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
import '../../screens/login.dart';

class LoginOrLogoutButton extends StatelessWidget {
  LoginController _loginController = Get.put(LoginController());
  ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return _loginController.userData["uid"] != null
        ? buildTextButton(context, "Logout")
        : buildTextButton(context, "Login");
  }

  Widget buildTextButton(context, val) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textColor: Theme.of(context).colorScheme.primaryVariant,
        color: Theme.of(context).colorScheme.secondary,
        child: Text(
          val,
        ),
        onPressed: () {
          val == "Login"
              ? Get.to(Login())
              : _profileController.openlogoutDialog(context);
        },
      ),
    );
  }
}
