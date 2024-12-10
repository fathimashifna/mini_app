import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/model/datamodel.dart';
import 'package:mini_app/view/cart_screen.dart';

import '../view/description_Screen.dart';

class DescriptionViewModel with ChangeNotifier {

  void addToCart(List<Products> productList, int index) {
    if (productList[index].addedToCart!) {
      productList[index].addedToCart = false;
    } else {
      productList[index].addedToCart = true;
    }
    notifyListeners();
  }

  void addToFav(List<Products> productList, int index){
    if( productList[index].wishlist ==1){
      productList[index].wishlist = 0;

    }else
    {
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
