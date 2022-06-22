import 'package:e_commerce_app_flutter_firebase/components/container/shopping_item_container.dart';
import 'package:e_commerce_app_flutter_firebase/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/button/login_logout_button.dart';
import '../../components/button/my_switch.dart';
import '../../components/container/error_container.dart';
import '../../components/dialog_box/my_dialog_box.dart';
import '../../components/drawer/my_drawer.dart';
import '../../controllers/bottom_nav_bar_controller.dart';
import '../../controllers/search_controller.dart';

class Search extends StatelessWidget {
  SearchController _searchController = Get.put(SearchController());
  LoginController _loginController = Get.put(LoginController());
  BottomNavBarController _bottomNavbarController =
      Get.put(BottomNavBarController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(builder: (_) {
      return GetBuilder<LoginController>(builder: (_) {
        return Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            automaticallyImplyLeading:
                _loginController.userData['uid'] != null ? true : false,
            title: Text("Search"),
            actions: [MySwitch(), LoginOrLogoutButton()],
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                buildInputContainer(context),
                GetBuilder<BottomNavBarController>(builder: (_) {
                  return !_bottomNavbarController.activeCon
                      ? MyErrorContainer("Internet Connection Error")
                      : buildSearchViews(context);
                }),
              ],
            ),
          ),
        );
      });
    });
  }

  Widget buildInputContainer(context) {
    return GetBuilder<SearchController>(builder: (_) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: TextField(
                    controller: _searchController.searchQueryController,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      hintText: "Search",
                      hintStyle: TextStyle(fontSize: 16),
                      border: InputBorder.none,
                    ),
                    cursorColor: Theme.of(context).colorScheme.onSecondary,
                  )),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: 50,
              height: 45,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primary),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                  ),
                  onPressed: () {
                    _searchController.updateSearchResults();
                  },
                  child: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
            )
          ],
        ),
      );
    });
  }

  Widget buildSearchViews(context) {
    return GetBuilder<SearchController>(builder: (_) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: FutureBuilder<List>(
            future: _searchController.searchResults,
            builder: (context, snapshot) {
              print("snap=======>${snapshot.data}");

              if (snapshot.hasError) {
                return MyDialogBox("Error", snapshot.hasError);
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return snapshot.data?.length == 0
                  ? Center(child: Text("No Data Found"))
                  : ListView.builder(
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
                          "ratingCount": snapshot.data?[index]['rating']
                              ['count'],
                        };

                        return ShoppingItemContainer(item);
                      });
            }),
      );
    });
  }
}
