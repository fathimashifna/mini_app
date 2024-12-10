import '../model/datamodel.dart';
import '../repository/home_repository.dart';

import 'package:flutter/material.dart';

import '../data/response/api_response.dart';
import '../utils/utils.dart';
import '../view/description_Screen.dart';

class HomeViewModel with ChangeNotifier {
  final _homeRepository = HomeRepository();

  ApiResponse<DataModel> productList = ApiResponse.loading();

  setProductList(ApiResponse<DataModel> response) {
    productList = response;
    notifyListeners();
  }

  void fetchProducts() async {
    setProductList(ApiResponse.loading());

    _homeRepository.fetchProductsListApi().then((data) {
      setProductList(ApiResponse.completed(data));
    }).onError((error, stackTrace) {
      setProductList(ApiResponse.error(error.toString()));
      Utils.toastMessage("Please try again later");
    });
  }

  void addToFav(List<Products> productList, int index) {
    if (productList[index].wishlist == 1) {
      productList[index].wishlist = 0;
    } else {
      productList[index].wishlist = 1;
    }
    notifyListeners();
  }

  void gotoDesc(BuildContext context, List<Products> productList, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DescScreen(index, productList)),
    );
  }

  static void closeDrawer(BuildContext context) {
    Navigator.pop(context);
  }
}
