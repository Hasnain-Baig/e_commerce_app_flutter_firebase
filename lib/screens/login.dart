import 'package:e_commerce_app_flutter_firebase/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'signup.dart';

class Login extends StatelessWidget {
  LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: GetBuilder<LoginController>(builder: (_) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
          ),
          height: double.infinity,
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              buildMyTextButton(context, "Sign Up"),
              SizedBox(
                height: 90,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .8,
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "Log In",
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    buildTextFieldContainer(context, "Email", false),
                    SizedBox(
                      height: 10,
                    ),
                    buildTextFieldContainer(context, "Pasword", true),
                    SizedBox(
                      height: 5,
                    ),
                    buildMyTextButton(context, "Forgot Password?"),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _loginController.isLoad
                            ? buildMyRaisedButton(context, "Load")
                            : buildMyRaisedButton(context, "Login"),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ]),
          ),
        );
      }),
    );
  }

  Widget buildTextFieldContainer(context, String value, isPassword) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * .8,
        height: 50,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: TextField(
          controller: isPassword
              ? _loginController.passwordController
              : _loginController.emailController,
          obscureText: isPassword ? _loginController.hidePass : false,
          keyboardType:
              isPassword ? TextInputType.text : TextInputType.emailAddress,
          autofocus: !isPassword,
          cursorColor: Theme.of(context).colorScheme.onSecondary,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: value,
            hintStyle: TextStyle(fontSize: 18),
            prefixIcon: isPassword
                ? Icon(
                    Icons.lock_outline,
                    size: 22,
                    color: Theme.of(context)
                        .colorScheme
                        .onSecondary
                        .withOpacity(0.5),
                  )
                : Icon(
                    Icons.email_outlined,
                    size: 22,
                    color: Theme.of(context)
                        .colorScheme
                        .onSecondary
                        .withOpacity(0.5),
                  ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _loginController.hidePass
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 22,
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(0.5),
                    ),
                    onPressed: () {
                      _loginController.hidePassword();
                    },
                  )
                : Text(""),
          ),
        ),
      ),
    );
  }

  Widget buildMyTextButton(context, String val) {
    return Container(
        child: val == "Sign Up"
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(
                        "Dont have an account? ",
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondary
                                .withOpacity(.7)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(Signup());
                        },
                        child: Text(val,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            )),
                      )
                    ],
                  )
                ],
              )
            : Text(
                val,
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(0.5),
                ),
              ));
  }

  Widget buildMyRaisedButton(context, String val) {
    return Container(
      width: MediaQuery.of(context).size.width * .3,
      height: 40,
      child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          textColor: Theme.of(context).colorScheme.onPrimary,
          color: Theme.of(context).colorScheme.primary,
          onPressed: () {
            _loginController.login(context);
          },
          child: val == "Login"
              ? Text(val)
              : SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).colorScheme.onPrimary),
                )),
    );
  }
}
