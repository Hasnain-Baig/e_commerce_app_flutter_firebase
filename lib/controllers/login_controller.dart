import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app_flutter_firebase/screens/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/dialog_box/my_dialog_box.dart';
import 'favourite_controller.dart';

class LoginController extends GetxController {
  bool _hidePass = true;
  bool get hidePass => _hidePass;

  TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  bool _isLoad = false;
  bool get isLoad => _isLoad;

  Map _userData = {};
  Map get userData => _userData;

  void onInit() {
    super.onInit();
    _emailController.text = "";
    _passwordController.text = "";
  }

  void onClose() {
    super.onClose();
  }

  hidePassword() {
    _hidePass = !_hidePass;
    update();
  }

  login(context) async {
    print("\nEmail:${_emailController.text}\nPass:${_passwordController.text}");
    update();

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var email = emailController.text;
    var password = passwordController.text;

    if (email != "" && password != "") {
      try {
        _isLoad = true;
        update();

        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        final DocumentSnapshot snapshot =
            await db.collection("users").doc(user.user!.uid).get();
        _isLoad = false;
        update();

        _userData = snapshot.data() as Map;
        print("Snapshot : ${userData}");
        _userData["uid"] = user.user!.uid;
        print("User logged in");

        _emailController.clear();
        _passwordController.clear();

        FavouriteController _favController = Get.put(FavouriteController());
        _favController.initFavItems();

        Object e = "Logged In Successfully";

        Get.to(WillPopScope(
            onWillPop: () async => false, child: MyBottomNavbar()));
      } catch (e) {
        _isLoad = false;
        update();

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
      Object e = "Some Fields are Empty";
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return MyDialogBox("Error", e);
          });
    }
    update();
  }

  logout() {
    FavouriteController _favController = Get.put(FavouriteController());
    _userData = {};
    _favController.initFavItems();
    Get.back();
    update();
  }
}
