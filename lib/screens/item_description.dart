import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../controllers/favourite_controller.dart';

class ItemDescription extends StatelessWidget {
  Map data;
  ItemDescription(this.data);

  FavouriteController _favController = Get.put(FavouriteController());
  CartController _cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          height: double.infinity,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: IntrinsicHeight(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Text(
                      "${data['title']}",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                        height: 300,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Image.network(data['image'])),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(.6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Text("Description")),
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: Text("${data['description']}")),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Price: ${data['price']}\$",
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Rating: ",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary
                                              .withOpacity(.5)),
                                    ),
                                    Icon(Icons.star,
                                        color: data['ratingRate'] >= 1
                                            ? Colors.amber[300]
                                            : Theme.of(context)
                                                .colorScheme
                                                .onSecondary
                                                .withOpacity(.4),
                                        size: 16),
                                    Icon(Icons.star,
                                        color: data['ratingRate'] >= 2
                                            ? Colors.amber[300]
                                            : Theme.of(context)
                                                .colorScheme
                                                .onSecondary
                                                .withOpacity(.4),
                                        size: 16),
                                    Icon(Icons.star,
                                        color: data['ratingRate'] >= 3
                                            ? Colors.amber[300]
                                            : Theme.of(context)
                                                .colorScheme
                                                .onSecondary
                                                .withOpacity(.4),
                                        size: 16),
                                    Icon(Icons.star,
                                        color: data['ratingRate'] >= 4
                                            ? Colors.amber[300]
                                            : Theme.of(context)
                                                .colorScheme
                                                .onSecondary
                                                .withOpacity(.4),
                                        size: 16),
                                    Icon(Icons.star,
                                        color: data['ratingRate'] >= 5
                                            ? Colors.amber[300]
                                            : Theme.of(context)
                                                .colorScheme
                                                .onSecondary
                                                .withOpacity(.4),
                                        size: 16),
                                    Text(
                                      " (${data['ratingCount']})",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary
                                              .withOpacity(.5)),
                                    )
                                  ],
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.primary,
                          thickness: 3,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              buildRoundedIconButton(context, "favourite"),
                              SizedBox(
                                width: 10,
                              ),
                              buildRoundedIconButton(context, "cart"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildRoundedIconButton(context, val) {
    return GetBuilder<FavouriteController>(builder: (_) {
      return GetBuilder<CartController>(builder: (_) {
        return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary.withOpacity(.1),
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: IconButton(
              onPressed: () {
                val == "cart"
                    ? _cartController.checkCart(data, context)
                    : _favController.checkFav(data, context);
              },
              icon: val == "cart" && _cartController.containsCartItem(data)
                  ? Icon(
                      CupertinoIcons.cart_badge_minus,
                    )
                  : val == "cart" && !_cartController.containsCartItem(data)
                      ? Icon(CupertinoIcons.cart_badge_plus)
                      : _favController.containsFavItem(data)
                          ? Icon(Icons.favorite,
                              color: Color.fromARGB(255, 225, 0, 0))
                          : Icon(
                              Icons.favorite_outline,
                              color: Theme.of(context).colorScheme.onSecondary,
                            )),
        );
      });
    });
  }
}
