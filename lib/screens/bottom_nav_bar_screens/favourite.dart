import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app_flutter_firebase/components/container/shopping_item_container.dart';
import 'package:e_commerce_app_flutter_firebase/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/button/login_logout_button.dart';
import '../../components/button/my_switch.dart';
import '../../components/container/error_container.dart';
import '../../components/drawer/my_drawer.dart';
import '../../controllers/bottom_nav_bar_controller.dart';
import '../../controllers/favourite_controller.dart';
import '../login.dart';

class Favourite extends StatelessWidget {
  FavouriteController _favController = Get.put(FavouriteController());
  LoginController _loginController = Get.put(LoginController());
  BottomNavBarController _bottomNavbarController =
      Get.put(BottomNavBarController());

  @override
  Widget build(BuildContext context) {
    print("fav=============>${_bottomNavbarController.activeCon}");

    return GetBuilder<LoginController>(builder: (_) {
      return Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            automaticallyImplyLeading:
                _loginController.userData['uid'] != null ? true : false,
            title: Text("Favourite"),
            actions: [MySwitch(), LoginOrLogoutButton()],
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          body: GetBuilder<BottomNavBarController>(builder: (_) {
            return !_bottomNavbarController.activeCon
                ? MyErrorContainer("Internet Connection Error")
                : _loginController.userData["uid"] == null
                    ? buildLoginFirstContainer(context)
                    : Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: Column(
                            children: [buildFavouriteItemsContainer(context)],
                          ),
                        ),
                      );
          }));
    });
  }

  Widget buildLoginFirstContainer(context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary.withOpacity(.1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "No favourites, You have to log in first!",
              style: TextStyle(
                color:
                    Theme.of(context).colorScheme.onSecondary.withOpacity(.6),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                textColor: Theme.of(context).colorScheme.primaryVariant,
                color: Theme.of(context).colorScheme.background,
                child: Text(
                  "Login",
                ),
                onPressed: () {
                  Get.to(Login());
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildFavouriteItemsContainer(context) {
    return GetBuilder<FavouriteController>(builder: (_) {
      return Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: _favController.favsStream,
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // scrollDirection: Axis.vertical,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map data = document.data() as Map;
                  var userId = document.id;

                  return userId == _loginController.userData['uid']
                      ? data['favourites'] == null ||
                              data['favourites'].length == 0
                          ? buildNoFavouritesContainer(context)
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data['favourites'].length,
                              itemBuilder: (context, index) {
                                Map favItemsData = data['favourites'][index];
                                return ShoppingItemContainer(favItemsData);
                              })
                      : SizedBox(
                          height: 0,
                        );
                }).toList(),
              );
            }),
      );
    });
  }

  Widget buildNoFavouritesContainer(context) {
    return Center(
        child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary.withOpacity(.1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(
              "No Favourites",
              style: TextStyle(
                color:
                    Theme.of(context).colorScheme.onSecondary.withOpacity(.6),
              ),
            )));
  }
}
