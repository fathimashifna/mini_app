import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_app/model/datamodel.dart';
import 'package:mini_app/res/widgets/app_colors.dart';
import 'package:provider/provider.dart';

import '../viewmodel/description_view_model.dart';

class DescScreen extends StatefulWidget {
  final int index;
  final List<Products>productList;
  const DescScreen(this.index,this.productList);

  @override
  DescScreenState createState() => DescScreenState();
}

class DescScreenState extends State<DescScreen> {
  int index = 0;
  List<Products>? productList;
  final DescriptionViewModel _descriptionViewModel = DescriptionViewModel();
  @override
  void initState() {
    super.initState();
    index= widget.index;
    productList = widget.productList;

  }

  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  Widget slider() {
    return CarouselSlider(
        disableGesture: productList![index].images!.length > 2 ? false : true,
        options: CarouselOptions(
          reverse: false,
          enableInfiniteScroll:
          productList![index].images!.length > 2 ? false : true,
          autoPlay: productList![index].images!.length > 2 ? true : false,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
        ),
        items: productList![index]
            .images!
            .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius:
              const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Container(
                      color: AppColors.color_primary,
                      child: Image.network(item,
                          fit: BoxFit.cover, width: 1000.0)),
                  productList![index].images!.length > 2
                      ? Positioned(
                    bottom: 10.0,
                    left: 0.0,
                    right: 0.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: productList![index]
                          .images!
                          .asMap()
                          .entries
                          .map((entry) {
                        return GestureDetector(
                          onTap: () => _controller
                              .animateToPage(entry.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context)
                                    .brightness ==
                                    Brightness.dark
                                    ? Colors.black
                                    : AppColors.color_button)
                                    .withOpacity(
                                    _current == entry.key
                                        ? 0.9
                                        : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                      : Container(),
                ],
              )),
        ))
            .toList());
  }

  Widget textView(String text, double fontsize,Color colors,FontWeight fontWeight) {
    return Text(text,
        style: GoogleFonts.openSans(
            textStyle:
            TextStyle(color: colors, fontSize: fontsize,fontWeight: fontWeight)));
  }

  Widget titleTextView(String text, double fontsize) {
    return Text(text,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.openSans(
            textStyle:
            TextStyle(color: AppColors.color_text, fontSize: fontsize)));
  }
  Widget strikeTextView(String text, double fontsize,Color colors,FontWeight fontWeight) {
    return Text(text,
      style: GoogleFonts.openSans(
        textStyle: TextStyle(
            decoration: TextDecoration.lineThrough,
            color: colors,
            fontSize: fontsize,fontWeight: fontWeight),
      ),);
  }
  Widget roundButton(){
    return  ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>( AppColors.color_button),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(color: AppColors.color_button)
                )
            )
        ),
        onPressed: ()  {
          _descriptionViewModel.addToCart(productList!,index);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_basket_outlined,color: Colors.white,),
            const SizedBox(
              width: 8,
            ),
            textView(productList![index].addedToCart! == false ? 'Add To cart'.toUpperCase() : 'Remove from cart'.toUpperCase(), 16, Colors.white, FontWeight.normal)
          ],
        )
    );
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
          actions:  [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.shopping_basket_outlined),
                onPressed: () {
                  _descriptionViewModel.gotoCartPage(context,productList!);
                },
              ),
            ),
          ],
        ),
        body: ChangeNotifierProvider<DescriptionViewModel>(
          create: (context) => _descriptionViewModel,
          child: Consumer<DescriptionViewModel>(
            builder: (context,value,child){
              return SingleChildScrollView(
                  child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left:8.0,bottom: 8.0),
                          child:Text( 'Everything You Need to Know',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(color: AppColors.color_button, fontSize: 20, fontWeight: FontWeight.w600),

                            ),),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                                margin: const EdgeInsets.only(top: 8.0),
                                height: MediaQuery.of(context).size.height * 0.35,
                                child: slider())),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 350,
                          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                          child: titleTextView(productList![index].title.toString(), 20),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 30.0, bottom: 8.0),
                          child: textView(productList![index].brand.toString(), 18,AppColors.color_text,FontWeight.normal),
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 30.0, bottom: 8.0),
                              child: StarRating(
                                rating: productList![index].rating!.toDouble(),
                                allowHalfRating: true,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 30.0, bottom: 8.0),
                              child: textView(
                                  '${productList![index].reviews!.length} ratings',14,AppColors.color_button,FontWeight.normal),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 30.0,
                              ),
                              child: textView(
                                  '${productList![index].discountPercentage}%',18, Colors.green,FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5.0,
                              ),
                              child: strikeTextView(
                                  '${productList![index].price}',18,AppColors.color_text,FontWeight.normal

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: textView(
                                  '${productList![index].discPrice!.toStringAsFixed(2)} AED',
                                  20, AppColors.color_text, FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 30.0, bottom: 5.0, top: 5.0),
                          child: textView(
                              productList![index].warrantyInformation.toString(),14,
                              AppColors.color_text, FontWeight.normal),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 30.0, bottom: 8.0, top: 5.0),
                            child: textView(
                                productList![index].description.toString(),
                                16, AppColors.color_text,FontWeight.normal)),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin:const EdgeInsets.only(left: 0.0),
                              width: 40,
                              height: 40,
                              child: MaterialButton(
                                  onPressed: () {
                                    _descriptionViewModel.addToFav(productList!, index);
                                  },
                                  color: AppColors.color_image_bg,
                                  padding: const EdgeInsets.all(6),
                                  shape: const CircleBorder(),
                                  child: productList![index].wishlist==0 ? Image.asset('assets/images/wish.png') : Image.asset('assets/images/heart.png')
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: roundButton())
                          ],
                        )

                      ]));
            },
          ),
        )
    );
  }
}
