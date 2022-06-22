import 'package:e_commerce_app_flutter_firebase/controllers/bottom_nav_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/container/error_container.dart';
import '../../../components/container/shopping_item_container.dart';
import '../../../components/dialog_box/my_dialog_box.dart';
import '../../../controllers/home_controller.dart';

class MensClothing extends StatelessWidget {
  BottomNavBarController _bottomNavbarController =
      Get.put(BottomNavBarController());

  MensClothingController _mensClothingController =
      Get.put(MensClothingController());
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavBarController>(builder: (_) {
      return !_bottomNavbarController.activeCon
          ? MyErrorContainer("Internet Connection Error")
          : GetBuilder<JeweleryController>(builder: (_) {
              return Container(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [buildElectronicItemsContainer(context)],
                  ),
                ),
              );
            });
    });
  }

  Widget buildElectronicItemsContainer(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: FutureBuilder<List>(
          future: _mensClothingController.mensClothing,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return MyDialogBox("Error", snapshot.hasError);
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  Map item = {
                    "id": snapshot.data?[index]['id'],
                    "title": snapshot.data?[index]['title'],
                    "price": snapshot.data?[index]['price'],
                    "description": snapshot.data?[index]['description'],
                    "category": snapshot.data?[index]['category'],
                    "image": snapshot.data?[index]['image'],
                    "ratingRate": snapshot.data?[index]['rating']['rate'],
                    "ratingCount": snapshot.data?[index]['rating']['count'],
                  };

                  return ShoppingItemContainer(item);
                });
          }),
    );
  }
}
