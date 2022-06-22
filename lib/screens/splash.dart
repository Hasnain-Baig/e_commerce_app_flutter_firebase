import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/animation_controller.dart';
import '../controllers/splash_controller.dart';

class Splash extends StatelessWidget {
  SplashController _splashController = Get.put(SplashController());
  MyAnimationController _animationController = Get.put(MyAnimationController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAnimationController>(builder: (_) {
      return Scaffold(
        body: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 25),
                Center(
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.all(10),
                    width: _animationController.width,
                    duration: Duration(milliseconds: 500),
                    child: AnimatedOpacity(
                      opacity: _animationController.opacity,
                      duration: Duration(seconds: 1),
                      child: Center(
                        child: Text(
                          "E-COMMERCE APP",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 24,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 30,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: AnimatedOpacity(
                        opacity: _animationController.opacity,
                        duration: Duration(seconds: 2),
                        child: Text(
                          "By Hasnain",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w200),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      );
    });
  }
}
