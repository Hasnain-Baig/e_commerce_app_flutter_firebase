import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  void onInit() {
    super.onInit();
  }

  void onClose() {
    super.onInit();
  }
}

class ElectronicsController extends GetxController {
  void onInit() {
    super.onInit();
    _electronics = getElectronicsData();
  }

  late Future<List> _electronics;
  Future<List> get electronics => _electronics;

  Future<List> getElectronicsData() async {
    try {
      var dio = Dio();
      String url = "https://fakestoreapi.com/products/category/electronics";
      final response = await dio.get(url);
      return response.data;
    } catch (e) {
      print(e);
      return [];
    }
  }

  refreshData() {
    _electronics = getElectronicsData();
    update();
  }
}

class JeweleryController extends GetxController {
  void onInit() {
    super.onInit();
    _jewelery = getJeweleryData();
  }

  late Future<List> _jewelery;
  Future<List> get jewelery => _jewelery;

  Future<List> getJeweleryData() async {
    try {
      var dio = Dio();
      String url = "https://fakestoreapi.com/products/category/jewelery";
      final response = await dio.get(url);
      return response.data;
    } catch (e) {
      print(e);
      return [];
    }
  }

  refreshData() {
    _jewelery = getJeweleryData();
    update();
  }
}

class MensClothingController extends GetxController {
  void onInit() {
    super.onInit();
    _mensClothing = getMensClothingData();
  }

  late Future<List> _mensClothing;
  Future<List> get mensClothing => _mensClothing;

  Future<List> getMensClothingData() async {
    try {
      var dio = Dio();
      String url = "https://fakestoreapi.com/products/category/men's clothing";
      final response = await dio.get(url);
      return response.data;
    } catch (e) {
      print(e);
      return [];
    }
  }

  refreshData() {
    _mensClothing = getMensClothingData();
    update();
  }
}

class WomensClothingController extends GetxController {
  void onInit() {
    super.onInit();
    _womensClothing = getWomensClothingData();
  }

  late Future<List> _womensClothing;
  Future<List> get womensClothing => _womensClothing;

  Future<List> getWomensClothingData() async {
    try {
      var dio = Dio();
      String url =
          "https://fakestoreapi.com/products/category/women's clothing";
      final response = await dio.get(url);
      return response.data;
    } catch (e) {
      print(e);
      return [];
    }
  }

  refreshData() {
    _womensClothing = getWomensClothingData();
    update();
  }
}
