import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/login_controller.dart';

class LogoutDialogBox extends StatelessWidget {
  LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Text(
          "Log Out",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Text("Do you want to log out?"),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildLogoutButton(context, "Yes"),
              buildLogoutButton(context, "No"),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildLogoutButton(context, value) {
    return GetBuilder<LoginController>(builder: (_) {
      return Container(
        margin: EdgeInsets.only(right: 20),
        child: ElevatedButton(
          onPressed: () {
            value == "Yes" ? _loginController.logout() : Get.back();
          },
          child: Text(value),
        ),
      );
    });
  }
}
