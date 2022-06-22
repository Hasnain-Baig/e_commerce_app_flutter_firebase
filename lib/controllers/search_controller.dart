import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  void onInit() {
    print("init");
    super.onInit();
    _searchResults = getAllItems();
  }

  TextEditingController _searchQueryController = TextEditingController();
  TextEditingController get searchQueryController => _searchQueryController;

  late Future<List> _searchResults;
  Future<List> get searchResults => _searchResults;

  Future<List> getAllItems() async {
    try {
      print("get");
      var dio = Dio();
      String url = "http://fakestoreapi.com/products";
      final response = await dio.get(url);
      update();
      return response.data;
    } catch (e) {
      print("Error============> ${e}");
      update();
      return [];
    }
  }

  Future<List> searchQuery() async {
    if (_searchQueryController.text != "") {
      try {
        var dio = Dio();
        String url =
            "http://fakestoreapi.com/products/category/${_searchQueryController.text}";
        final response = await dio.get(url);
        return response.data;
      } catch (e) {
        print("Error============> ${e}");
        update();
        return [];
      }
    }
    return [];
  }

  updateSearchResults() async {
    _searchResults = searchQuery();
    update();
  }

  refreshData() {
    if (_searchQueryController.text != "") {
      _searchResults = searchQuery();
    } else {
      _searchResults = getAllItems();
    }
    update();
  }
}
