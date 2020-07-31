import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.77,
      width: double.infinity,
      margin: EdgeInsets.only(right: 5.0,left: 5.0, top: 5.0),
      child: GridView.builder(
          padding: const EdgeInsets.all(5.0),
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 2.5,
            mainAxisSpacing: 2.5,
          ),
          itemBuilder: (_, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GridTile(child: Image.network("https://cdn.pixabay.com/photo/2017/07/31/04/11/tomato-2556426_960_720.jpg"),
              footer: GridTileBar(
                backgroundColor: Theme.of(context).accentColor,
                title: Text("Item"),
              ),
              ),
            );
          }),
    );
  }
}
