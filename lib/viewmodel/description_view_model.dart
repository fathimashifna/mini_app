import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/model/datamodel.dart';
import 'package:mini_app/view/cart_screen.dart';

import '../view/description_Screen.dart';

class DescriptionViewModel with ChangeNotifier {

  void addToCart(List<Products> productList, int index) {
    // add item to cart
    if (productList[index].addedToCart!) {
      productList[index].addedToCart = false;
    } else {
      // if the cart is already available in the cart and user want to remove from the cart
      productList[index].addedToCart = true;
    }
    notifyListeners();
  }

  void addToFav(List<Products> productList, int index){

    if( productList[index].wishlist ==1){
      // remove product from fav list
      productList[index].wishlist = 0;

    }else
    {
      // added to fav list
      productList[index].wishlist = 1;
    }
    notifyListeners();
  }

  void gotoCartPage(BuildContext context,List<Products> productList){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CartScreen(productList)),
    );
  }
}
