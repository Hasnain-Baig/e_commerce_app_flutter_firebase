import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/dialog_box/my_dialog_box.dart';
import 'login_controller.dart';

class CartController extends GetxController {
  void onInit() {
    super.onInit();
    getCartItemsStream();
    initCartItems();
  }

  late List _cartItems;
  List get cartItems => _cartItems;

  late Stream<QuerySnapshot> _cartsStream;
  Stream<QuerySnapshot> get cartsStream => _cartsStream;
  LoginController _loginController = Get.put(LoginController());
  FirebaseFirestore db = FirebaseFirestore.instance;

  initCartItems() async {
    if (_loginController.userData['uid'] != null) {
      var u = await db
          .collection('users')
          .doc(_loginController.userData['uid'])
          .get();
      Map uData = u.data() as Map;
      _cartItems = uData['favourites'];
    } else {
      _cartItems = [];
    }

    update();
  }

  setCartItems(value) {
    _cartItems = value;
  }

  getCartItemsStream() async {
    try {
      _cartsStream = await db.collection('users').snapshots();
    } catch (e) {
      print("Error=====>${e}");
    }
  }

  checkCart(obj, context) async {
    if (_loginController.userData['uid'] != null) {
      myIf:
      if (_cartItems.length >= 0) {
        for (var i = 0; i < _cartItems.length; i++) {
          if (_cartItems[i]['title'] == obj['title']) {
            _cartItems.removeAt(i);
            update();
            break myIf;
          }
        }
        _cartItems.add(obj);
      }
      update();

      try {
        FirebaseFirestore db = FirebaseFirestore.instance;
        var userId = _loginController.userData["uid"];

        await db.collection('users').doc(userId).update(
          {"carts": _cartItems},
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

  containsCartItem(obj) {
    if (_cartItems.length > 0) {
      for (var i = 0; i < _cartItems.length; i++) {
        if (_cartItems[i]['title'] == obj['title']) {
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
