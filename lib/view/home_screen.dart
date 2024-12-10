
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../res/widgets/app_colors.dart';
import '../viewmodel/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _homeViewModel = HomeViewModel();

  int count = 0;
  @override
  void initState() {
    _homeViewModel.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Image.asset('assets/images/menu.png'),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: AppColors.color_white,
        centerTitle: true,
        title: Image.asset('assets/images/home.png'),
        actions:   [
          const Padding(
            padding:  EdgeInsets.only(right: 10),
            child: Icon(Icons.search),
          ),
          const Padding(
            padding:  EdgeInsets.only(right: 10),
            child: Icon(Icons.shopping_basket_outlined),
          ),
           Padding(
            padding:  const EdgeInsets.only(right: 10),
            child: Image.asset('assets/images/notification.png')
          ),
          
        ],
      ),
      drawer: Drawer (
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Material(
              color: AppColors.color_primary,
              child: InkWell(
                onTap: () {
                  HomeViewModel.closeDrawer(context);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top, bottom: 24),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 52,
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHNtaWx5JTIwZmFjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text('Ann',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 28, color: Colors.black),
                          )),
                      Text(
                        'ann5684@yahoo.com',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(
                ' My Profile ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              onTap: () {
                HomeViewModel.closeDrawer(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_basket_outlined),
              title: Text(
                ' My Cart',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              onTap: () {
                HomeViewModel.closeDrawer(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: Text(
                'Wish List ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              onTap: () {
                HomeViewModel.closeDrawer(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text(
                ' Edit Profile ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              onTap: () {
                HomeViewModel.closeDrawer(context);
              },
            ),

          ],
        ),
      ),
      body:  ChangeNotifierProvider<HomeViewModel>(
        create: (context) => _homeViewModel,
        child: Consumer<HomeViewModel>(
          builder: (context, value, child) {
            switch (value.productList.status) {
              //if the status is loading
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
            //if the status is error
              case Status.error:
                return Center(
                  child: Image.asset('assets/images/signal.png')
                );
            //if the status is completed
              case Status.completed:
                return ListView.builder(
                    itemCount: value.productList.data!.products!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          index ==0 ? Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left:8.0,bottom: 8.0),
                            child:Text( 'Discover Your Favorites',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(color: AppColors.color_button, fontSize: 20, fontWeight: FontWeight.w600),

                              ),),
                          ):Container(),
                          InkWell(
                            onTap:(){
                              //goto description page when clicking the item
                              _homeViewModel.gotoDesc(context,value.productList.data!.products!, index);

                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0,right: 12.0,bottom: 10),
                              child: Card(
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                              width: 130,
                                              height: 130,
                                              child: CachedNetworkImage(imageUrl:  value.productList.data!.products![index].images![0].toString(),
                                                placeholder: (context,url)=> SizedBox(
                                                    child: Image.network(value.productList.data!.products![index].thumbnail.toString())),
                                                errorWidget: (context,url,erro)=>Container(
                                                  color:Colors.grey,
                                                  width: 100,
                                                    height: 100,
                                                  child: const Icon(Icons.error),
                                                ),

                                              )),
                                        ),
                                        Positioned(
                                          left: 12,
                                          top: 16,
                                          child: SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: MaterialButton(
                                                onPressed: () {
                                                  // add item to fav list if clicks the fav icon
                                                  _homeViewModel.addToFav(value.productList.data!.products!,index);
                                                },
                                                color: AppColors.color_image_bg,
                                                padding: const EdgeInsets.all(6),
                                                shape: const CircleBorder(),
                                                child: value.productList.data!.products![index].wishlist==0 ? Image.asset('assets/images/wish.png') : Image.asset('assets/images/heart.png')
                                            ),
                                          ),
                                        )

                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          width: 200,
                                          padding: const EdgeInsets.only(left:8.0,bottom: 8.0),
                                          child:Text(value.productList.data!.products![index].title.toString(),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.openSans(
                                              textStyle: TextStyle(color: AppColors.color_text, fontSize: 20, fontWeight: FontWeight.w600),

                                            ),),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.only(left:8.0,bottom: 8.0),
                                          child: Text(value.productList.data!.products![index].brand.toString(), style: GoogleFonts.openSans(
                                            textStyle: TextStyle(color: AppColors.color_text, fontSize: 14),

                                          ),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,bottom: 8.0),
                                          child: StarRating(
                                            rating: value.productList.data!.products![index].rating!.toDouble(),
                                            allowHalfRating: true,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left:8.0,),
                                              child: Text('${value.productList.data!.products![index].price}', style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    decoration: TextDecoration.lineThrough,
                                                    color: AppColors.color_text, fontSize: 14),

                                              ),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left:5.0,),
                                              child: Text('${value.productList.data!.products![index].discountPercentage}%', style: GoogleFonts.openSans(
                                                textStyle: const TextStyle(
                                                    color: Colors.green, fontSize: 14,fontWeight: FontWeight.bold),

                                              ),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left:5.0),
                                              child: Text('${value.productList.data!.products![index].discPrice!.toStringAsFixed(2)} AED', style: GoogleFonts.openSans(
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
                          ),
                        ],
                      );
                    });

              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
