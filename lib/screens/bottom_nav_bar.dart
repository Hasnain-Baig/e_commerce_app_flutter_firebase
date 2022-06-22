import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:e_commerce_app_flutter_firebase/controllers/bottom_nav_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBottomNavbar extends StatelessWidget {
  BottomNavBarController _bottomNavBarController =
      Get.put(BottomNavBarController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavBarController>(builder: (_) {
      return Scaffold(
        body: PageStorage(
            bucket: PageStorageBucket(),
            child: _bottomNavBarController.currentScreen),
        bottomNavigationBar: CircularBottomNavigation(
          barBackgroundColor: Theme.of(context).colorScheme.primary,
          selectedIconColor: Theme.of(context).colorScheme.primaryVariant,
          normalIconColor:
              Theme.of(context).colorScheme.onPrimary.withOpacity(.6),
          barHeight: 50,
          iconsSize: 22,
          circleStrokeWidth: 0,
          controller: _bottomNavBarController.navigationController,
          selectedCallback: (value) {
            _bottomNavBarController.changeScreen(value);
            print(value);
          },
          List.of([
            buildBottomNavbarTabs(context, "Home"),
            buildBottomNavbarTabs(context, "Search"),
            buildBottomNavbarTabs(context, "Favourite"),
            buildBottomNavbarTabs(context, "Cart")
          ]),
        ),
      );
    });
  }

  TabItem buildBottomNavbarTabs(context, value) {
    return TabItem(
        value == "Home"
            ? Icons.home
            : value == "Search"
                ? Icons.search
                : value == "Favourite"
                    ? Icons.favorite
                    : Icons.shopping_cart,
        value,
        Theme.of(context).colorScheme.secondary,
        labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold));
  }
}
