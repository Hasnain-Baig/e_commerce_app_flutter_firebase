import 'package:e_commerce_app_flutter_firebase/controllers/login_controller.dart';
import 'package:e_commerce_app_flutter_firebase/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  LoginController _loginController = Get.put(LoginController());
  ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (_) {
      return Drawer(
          child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  buildProfileHeader(context),
                  Container(
                    color: Theme.of(context).colorScheme.secondary,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        buildProfileInfoListTiles(
                          context,
                          true,
                          "",
                          "",
                        ),
                        buildProfileInfoListTiles(context, false, "Account Id",
                            "${_loginController.userData['uid']}"),
                        buildProfileInfoListTiles(context, false, "Gender",
                            "${_loginController.userData['gender']}"),
                        buildProfileInfoListTiles(context, false, "Country",
                            "${_loginController.userData['country']}"),
                        buildProfileInfoListTiles(
                            context,
                            false,
                            "Email Address",
                            "${_loginController.userData['email']}"),
                        buildProfileInfoListTiles(
                            context,
                            false,
                            "Phone Number",
                            "${_loginController.userData['phone number']}"),
                      ],
                    ),
                  ),
                ],
              )));
    });
  }

  Widget buildProfileHeader(context) {
    return GetBuilder<ProfileController>(builder: (_) {
      return Container(
          padding: EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      // _profileController.openlogoutDialog(context);
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Text(
                        _loginController.userData['fullname']
                            .toString()
                            .toUpperCase()
                            .characters
                            .first,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  ),
                ]),
            SizedBox(height: 10),
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage("assets/images/cr7.jpg"),
            ),
            SizedBox(height: 20),
            Text(
              "${_loginController.userData['fullname'].toString().toUpperCase()}",
              style: TextStyle(fontSize: 20),
            )
          ]));
    });
  }

  Widget buildProfileInfoListTiles(context, isHeader, title, subtitle) {
    return !isHeader
        ? ListTile(
            leading: Icon(
              title == "Account Id"
                  ? Icons.verified_user_outlined
                  : title == "Date of Birth"
                      ? Icons.calendar_month
                      : title == "Country"
                          ? Icons.flag_outlined
                          : title == "Email Address"
                              ? Icons.email_outlined
                              : title == "Phone Number"
                                  ? Icons.phone_outlined
                                  : title == "Gender" && subtitle == "male"
                                      ? Icons.male
                                      : title == "Gender" &&
                                              subtitle == "female"
                                          ? Icons.female
                                          : Icons.add,
              color: Theme.of(context).colorScheme.onSecondary.withOpacity(.6),
              size: 24,
            ),
            title: Text(title,
                style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSecondary.withOpacity(.6),
                  fontWeight: FontWeight.w500,
                )),
            horizontalTitleGap: 5,
            subtitle: Text(subtitle,
                style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSecondary.withOpacity(.6),
                )),
          )
        : ListTile(
            title: Text("Account Details",
                style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSecondary.withOpacity(.9),
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                )),
          );
  }
}
