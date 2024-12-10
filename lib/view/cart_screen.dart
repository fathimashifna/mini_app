import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/datamodel.dart';
import '../res/widgets/app_colors.dart';
import '../viewmodel/cart_view_model.dart';

class CartScreen extends StatefulWidget {
  final List<Products> productList;

  const CartScreen(this.productList, {super.key});

  @override
  State<StatefulWidget> createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {

  final CartViewModel _cartViewModel = CartViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartViewModel.getCartItem(widget.productList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Image.asset('assets/images/home.png'),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<CartViewModel>(
        create: (context) => _cartViewModel,
        child: Consumer<CartViewModel>(
          builder: (context, value, child) {
            return ListView.builder(
                itemCount: value.productList.length,
                itemBuilder: (context, index) {
                  return   Column(
                    children: [
                      index == 0
                          ? Container(
                              alignment: Alignment.center,
                              width: 200,
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 8.0),
                              child: Text(
                                'Your Beauty Bag',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: AppColors.color_button,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0,right: 12.0,bottom: 10),
                        child: Card(
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    width: 130,
                                    height: 130,
                                    child: CachedNetworkImage(imageUrl:  value.productList[index].images![0].toString(),
                                      placeholder: (context,url)=> SizedBox(
                                          child: Image.network(value.productList[index].thumbnail.toString())),
                                      errorWidget: (context,url,erro)=>Container(
                                        color:Colors.grey,
                                        width: 100,
                                        height: 100,
                                        child: const Icon(Icons.error),
                                      ),

                                    )),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: 200,
                                    padding: const EdgeInsets.only(left:8.0,bottom: 8.0),
                                    child:Text(value.productList[index].title.toString(),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(color: AppColors.color_text, fontSize: 20, fontWeight: FontWeight.w600),

                                      ),),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left:8.0,bottom: 8.0),
                                    child: Text(value.productList[index].brand.toString(), style: GoogleFonts.openSans(
                                      textStyle: TextStyle(color: AppColors.color_text, fontSize: 14),

                                    ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0,bottom: 8.0),
                                    child: StarRating(
                                      rating: value.productList[index].rating!.toDouble(),
                                      allowHalfRating: true,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left:8.0,),
                                        child: Text('${value.productList[index].price}', style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              decoration: TextDecoration.lineThrough,
                                              color: AppColors.color_text, fontSize: 14),

                                        ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:5.0,),
                                        child: Text('${value.productList[index].discountPercentage}%', style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                              color: Colors.green, fontSize: 14,fontWeight: FontWeight.bold),

                                        ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:5.0),
                                        child: Text('${value.productList[index].discPrice!.toStringAsFixed(2)} AED', style: GoogleFonts.openSans(
                                          textStyle: TextStyle(color: AppColors.color_text, fontSize: 15,fontWeight: FontWeight.bold),

                                        ),),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  )
                                ],
                              ),


                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
