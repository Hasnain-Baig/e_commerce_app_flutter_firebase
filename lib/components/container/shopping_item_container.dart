import 'package:e_commerce_app_flutter_firebase/controllers/cart_controller.dart';
import 'package:e_commerce_app_flutter_firebase/controllers/favourite_controller.dart';
import 'package:e_commerce_app_flutter_firebase/screens/item_description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingItemContainer extends StatelessWidget {
  Map item;
  ShoppingItemContainer(this.item);

  FavouriteController _favController = Get.put(FavouriteController());
  CartController _cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.to(ItemDescription(item));
        },
        child: buildItemTile(context));
  }

  Widget buildItemTile(context) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary.withOpacity(.1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Text(
                "${item['title']}\$",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
            ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    "${item['image']}",
                  ),
                ),
                title: Text(
                  "Price: ${item['price']}\$",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                subtitle: Row(
                  children: [
                    Text("Rating: "),
                    Icon(Icons.star,
                        color: item['ratingRate'] >= 1
                            ? Colors.amber[300]
                            : Theme.of(context)
                                .colorScheme
                                .onSecondary
                                .withOpacity(.4),
                        size: 16),
                    Icon(Icons.star,
                        color: item['ratingRate'] >= 2
                            ? Colors.amber[300]
                            : Theme.of(context)
                                .colorScheme
                                .onSecondary
                                .withOpacity(.4),
                        size: 16),
                    Icon(Icons.star,
                        color: item['ratingRate'] >= 3
                            ? Colors.amber[300]
                            : Theme.of(context)
                                .colorScheme
                                .onSecondary
                                .withOpacity(.4),
                        size: 16),
                    Icon(Icons.star,
                        color: item['ratingRate'] >= 4
                            ? Colors.amber[300]
                            : Theme.of(context)
                                .colorScheme
                                .onSecondary
                                .withOpacity(.4),
                        size: 16),
                    Icon(Icons.star,
                        color: item['ratingRate'] >= 5
                            ? Colors.amber[300]
                            : Theme.of(context)
                                .colorScheme
                                .onSecondary
                                .withOpacity(.4),
                        size: 16),
                    Text(" (${item['ratingCount']})")
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                buildRoundedIconButton(context, "favourite"),
                SizedBox(
                  width: 10,
                ),
                buildRoundedIconButton(context, "cart"),
              ],
            ),
          ],
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
                    ? _cartController.checkCart(item, context)
                    : _favController.checkFav(item, context);
              },
              icon: val == "cart" && _cartController.containsCartItem(item)
                  ? Icon(
                      CupertinoIcons.cart_badge_minus,
                    )
                  : val == "cart" && !_cartController.containsCartItem(item)
                      ? Icon(CupertinoIcons.cart_badge_plus)
                      : _favController.containsFavItem(item)
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
