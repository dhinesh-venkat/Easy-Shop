import 'package:easy_shop/widgets/grids.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../screens/cart_screen.dart';

class HomePage extends StatelessWidget {
  //const HomePage({Key key}) : super(key: key);

  static final List<String> imgList = [
    "https://cdn.pixabay.com/photo/2017/11/02/09/04/drink-2910441_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/06/04/16/31/banner-2371477_960_720.jpg",
    "https://cdn.pixabay.com/photo/2018/02/04/23/58/easter-eggs-3131190_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/04/03/21/46/snacks-2199659_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/07/05/17/42/candy-1499082_960_720.jpg",
  ];

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Image.network(item,
                    fit: BoxFit.cover, width: double.infinity),
              ),
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              })
        ],
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Easy Shop",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            child: Container(
              height: 125,
              width: double.infinity,
              margin: EdgeInsets.only(left: 5, right: 5,top: 5),
              child: CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Grids(),
        ],
      ),
    );
  }
}
