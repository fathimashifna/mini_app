import 'package:flutter/cupertino.dart';

import '../model/datamodel.dart';

class CartViewModel with ChangeNotifier {
  List<Products> productList = [];
  //fetch the items to the cart, if addedToCart variable is true item is present in the cart
  void getCartItem(List<Products> productsList){
    for(int i=0;i<productsList.length;i++){
      if(productsList[i].addedToCart == true){
        productList.add(productsList[i]);
      }
    }

    notifyListeners();
  }



}