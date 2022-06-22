import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/bottom_nav_bar_controller.dart';

class MyErrorContainer extends StatelessWidget {
  String val;

  MyErrorContainer(this.val);
  BottomNavBarController _bottomNavBarController =
      Get.put(BottomNavBarController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavBarController>(builder: (_) {
      return Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${val}",
                style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSecondary.withOpacity(.6),
                ),
              ),
              _bottomNavBarController.isloading
                  ? Container(
                      margin: EdgeInsets.only(top: 10),
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 10),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        textColor: Theme.of(context).colorScheme.primaryVariant,
                        color: Theme.of(context).colorScheme.background,
                        child: Text(
                          "Refresh",
                        ),
                        onPressed: () {
                          _bottomNavBarController.checkUserConnection();
                        },
                      ),
                    )
            ],
          ),
        ),
      );
    });
  }
}
