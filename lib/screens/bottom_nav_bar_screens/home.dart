import 'package:e_commerce_app_flutter_firebase/components/drawer/my_drawer.dart';
import 'package:e_commerce_app_flutter_firebase/screens/bottom_nav_bar_screens/HomeTabs/electronics.dart';
import 'package:e_commerce_app_flutter_firebase/screens/bottom_nav_bar_screens/HomeTabs/jewelery.dart';
import 'package:e_commerce_app_flutter_firebase/screens/bottom_nav_bar_screens/HomeTabs/mens_clothing.dart';
import 'package:e_commerce_app_flutter_firebase/screens/bottom_nav_bar_screens/HomeTabs/womens_cloting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/button/login_logout_button.dart';
import '../../components/button/my_switch.dart';
import '../../controllers/login_controller.dart';

class Home extends StatelessWidget {
  LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: GetBuilder<LoginController>(builder: (_) {
          return Scaffold(
            drawer: MyDrawer(),
            appBar: AppBar(
              automaticallyImplyLeading:
                  _loginController.userData['uid'] != null ? true : false,
              title: Text("Home"),
              actions: [MySwitch(), LoginOrLogoutButton()],
              backgroundColor: Theme.of(context).colorScheme.primary,
              bottom: TabBar(
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Theme.of(context).colorScheme.onPrimary,
                  tabs: [
                    Container(
                      child: Tab(child: Text("Electronics")),
                    ),
                    Container(
                      child: Tab(child: Text("Jewelery")),
                    ),
                    Container(
                      child: Tab(child: Text("Men's Clothing")),
                    ),
                    Container(
                      child: Tab(child: Text("Women's Clothing")),
                    ),
                  ]),
            ),
            body: TabBarView(children: [
              Electronicz(),
              Jewelery(),
              MensClothing(),
              WomensClothing()
            ]),
          );
        }));
  }
}
