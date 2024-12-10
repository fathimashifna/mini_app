import 'package:flutter/cupertino.dart';

import '../model/datamodel.dart';

class CartViewModel with ChangeNotifier {
  List<Products> productList = [];

  void getCartItem(List<Products> productsList){
    for(int i=0;i<productsList.length;i++){
      if(productsList[i].addedToCart == true){
        productList.add(productsList[i]);
      }
    }

    notifyListeners();
  }



}