import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';
import 'login.dart';

class Signup extends StatelessWidget {
  SignupController _signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: GetBuilder<SignupController>(builder: (_) {
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
              buildMyTextButton(context, "Log In"),
              SizedBox(
                height: 60,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .8,
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    buildTextFieldContainer(context, "Full Name", false),
                    SizedBox(
                      height: 5,
                    ),
                    buildTextFieldContainer(context, "Gender", false),
                    SizedBox(
                      height: 5,
                    ),
                    buildTextFieldContainer(context, "Country", false),
                    SizedBox(
                      height: 5,
                    ),
                    buildTextFieldContainer(context, "Email Address", false),
                    SizedBox(
                      height: 5,
                    ),
                    buildTextFieldContainer(context, "Phone Number", false),
                    SizedBox(
                      height: 5,
                    ),
                    buildTextFieldContainer(context, "Password", true),
                    SizedBox(
                      height: 5,
                    ),
                    buildTextFieldContainer(context, "Confirm Password", true),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        buildMyRaisedButton(context, "Signup"),
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
    return Container(
        width: MediaQuery.of(context).size.width * .8,
        height: value == "Gender" ? 90 : 50,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: value == "Gender"
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text("   ${value}"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                          activeColor: Theme.of(context).colorScheme.primary,
                          value: 'male',
                          groupValue: _signupController.genderController.text,
                          onChanged: (val) {
                            _signupController.setGender(val.toString());
                          }),
                      Text("Male"),
                      Radio(
                          activeColor: Theme.of(context).colorScheme.primary,
                          value: 'female',
                          groupValue: _signupController.genderController.text,
                          onChanged: (val) {
                            _signupController.setGender(val.toString());
                          }),
                      Text("Female"),
                      Radio(
                          activeColor: Theme.of(context).colorScheme.primary,
                          value: 'other',
                          groupValue: _signupController.genderController.text,
                          onChanged: (val) {
                            _signupController.setGender(val.toString());
                          }),
                      Text("Other"),
                    ],
                  )
                ],
              )
            : TextField(
                controller: value == "Password"
                    ? _signupController.passwordController
                    : value == "Confirm Password"
                        ? _signupController.confPasswordController
                        : value == "Email Address"
                            ? _signupController.emailController
                            : value == "Full Name"
                                ? _signupController.fullNameController
                                : value == "Country"
                                    ? _signupController.countryController
                                    : _signupController.phoneNumController,
                obscureText: isPassword
                    ? value == "Password"
                        ? _signupController.hidePass
                        : _signupController.hideConfPass
                    : false,
                keyboardType: value == "Phone Number"
                    ? TextInputType.number
                    : !isPassword
                        ? TextInputType.emailAddress
                        : TextInputType.text,
                autofocus: false,
                // !isPassword,
                cursorColor: Theme.of(context).colorScheme.onSecondary,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: value,
                  hintStyle: TextStyle(fontSize: 16),
                  prefixIcon: isPassword
                      ? Icon(
                          Icons.lock_outline,
                          size: 22,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(0.5),
                        )
                      : value == "Email Address"
                          ? Icon(
                              Icons.email_outlined,
                              size: 22,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondary
                                  .withOpacity(0.5),
                            )
                          : value == "Full Name"
                              ? Icon(
                                  Icons.account_circle_outlined,
                                  size: 22,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary
                                      .withOpacity(0.5),
                                )
                              : value == "Country"
                                  ? Icon(
                                      Icons.flag_outlined,
                                      size: 22,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary
                                          .withOpacity(0.5),
                                    )
                                  : value == "Phone Number"
                                      ? Icon(
                                          Icons.phone,
                                          size: 22,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary
                                              .withOpacity(0.5),
                                        )
                                      : Text(""),
                  suffixIcon: (isPassword)
                      ? value == "Password"
                          ? IconButton(
                              icon: Icon(
                                _signupController.hidePass
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 22,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondary
                                    .withOpacity(0.5),
                              ),
                              onPressed: () {
                                _signupController.hidePassword();
                              },
                            )
                          : IconButton(
                              icon: Icon(
                                _signupController.hideConfPass
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 22,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondary
                                    .withOpacity(0.5),
                              ),
                              onPressed: () {
                                _signupController.hideConfPassword();
                              },
                            )
                      : Text(""),
                ),
              ));
  }

  Widget buildMyTextButton(context, String val) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            Text(
              "Already have an account?",
              style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(.7)),
            ),
            TextButton(
              child: Text(
                "${val}",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              onPressed: () {
                Get.to(Login());
              },
            ),
          ],
        )
      ],
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
            _signupController.signup(context);
          },
          child: val == "Signup"
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
