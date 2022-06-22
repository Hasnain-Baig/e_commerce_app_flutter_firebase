import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/dialog_box/my_dialog_box.dart';
import 'login_controller.dart';

class FavouriteController extends GetxController {
  void onInit() {
    super.onInit();
    getFavItemsStream();
    initFavItems();
  }

  late List _favItems;
  List get favItems => _favItems;

  late Stream<QuerySnapshot> _favsStream;
  Stream<QuerySnapshot> get favsStream => _favsStream;
  LoginController _loginController = Get.put(LoginController());
  FirebaseFirestore db = FirebaseFirestore.instance;

  initFavItems() async {
    if (_loginController.userData['uid'] != null) {
      var u = await db
          .collection('users')
          .doc(_loginController.userData['uid'])
          .get();
      Map uData = u.data() as Map;
      _favItems = uData['favourites'];
    } else {
      _favItems = [];
    }

    update();
  }

  setFavItems(value) {
    _favItems = value;
  }

  getFavItemsStream() async {
    try {
      _favsStream = await db.collection('users').snapshots();
    } catch (e) {
      print("Error=====>${e}");
    }
  }

  checkFav(obj, context) async {
    if (_loginController.userData['uid'] != null) {
      myIf:
      if (_favItems.length >= 0) {
        for (var i = 0; i < _favItems.length; i++) {
          if (_favItems[i]['title'] == obj['title']) {
            _favItems.removeAt(i);
            update();
            break myIf;
          }
        }
        _favItems.add(obj);
      }
      update();

      try {
        FirebaseFirestore db = FirebaseFirestore.instance;
        var userId = _loginController.userData["uid"];

        await db.collection('users').doc(userId).update(
          {"favourites": _favItems},
        );

        update();
      } catch (e) {
        int errIndex = e.toString().indexOf(']');
        String error =
            e.toString().substring((errIndex + 1), e.toString().length - 1);

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return MyDialogBox("Error", error);
            });
      }
    } else {
      Object e = "You have to Login First!";
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return MyDialogBox("Error", e);
          });
    }
    update();
  }

  containsFavItem(obj) {
    if (_favItems.length > 0) {
      for (var i = 0; i < _favItems.length; i++) {
        if (_favItems[i]['title'] == obj['title']) {
          return true;
        }
      }
      return false;
    } else {
      return false;
    }
    update();
  }
}
