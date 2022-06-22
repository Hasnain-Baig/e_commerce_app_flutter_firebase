import 'dart:io';

import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/bottom_nav_bar_screens/cart.dart';
import '../screens/bottom_nav_bar_screens/favourite.dart';
import '../screens/bottom_nav_bar_screens/home.dart';
import '../screens/bottom_nav_bar_screens/search.dart';
import 'home_controller.dart';
import 'search_controller.dart';

class BottomNavBarController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _navigationController = CircularBottomNavigationController(0);
    checkUserConnection();
  }

  SearchController _searchController = Get.put(SearchController());
  ElectronicsController _electronicsController =
      Get.put(ElectronicsController());
  JeweleryController _jeweleryController = Get.put(JeweleryController());
  MensClothingController _mensClothingController =
      Get.put(MensClothingController());
  WomensClothingController _womensClothingController =
      Get.put(WomensClothingController());

  late CircularBottomNavigationController _navigationController;
  CircularBottomNavigationController get navigationController =>
      _navigationController;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  Widget _currentScreen = Home();
  Widget get currentScreen => _currentScreen;

  bool _activeCon = false;
  bool get activeCon => _activeCon;

  bool _isloading = false;
  bool get isloading => _isloading;

  checkUserConnection() async {
    try {
      _isloading = true;
      update();
      await InternetAddress.lookup('google.com');
      _isloading = false;
      update();
      _activeCon = true;
      _electronicsController.refreshData();
      _jeweleryController.refreshData();
      _mensClothingController.refreshData();
      _womensClothingController.refreshData();
      _searchController.refreshData();
      update();
    } catch (_) {
      _isloading = false;
      _activeCon = false;
      update();
    }
  }

  changeScreen(value) {
    _currentIndex = value;
    switch (value) {
      case 0:
        _currentScreen = Home();
        break;
      case 1:
        _currentScreen = Search();
        break;
      case 2:
        _currentScreen = Favourite();
        break;
      case 3:
        _currentScreen = Cart();
    }
    checkUserConnection();
    update();
  }

  decreaseCurrentIndexByOne() {
    _currentIndex--;
    update();
  }

  setCurrentScreenToFavourite() {
    // _currentScreen = Favourite();
    update();
  }
}
