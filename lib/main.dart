// import 'package:device_preview/device_preview.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_shop/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import './screens/homepage.dart';
import './services/group_service.dart';
import './services/sub_group_service.dart';
import './services/product_service.dart';
import './models/cart.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => GroupService());
  GetIt.I.registerLazySingleton(() => SubGroupService());
  GetIt.I.registerLazySingleton(() => ProductService());
}

void main() {
  setupLocator();
  runApp(
  //     DevicePreview(builder: (context) => ChangeNotifierProvider(
  //   create: (context) => Cart(),
  //   child: MyApp(),
  // ),)
      ChangeNotifierProvider(
    create: (context) => Cart(),
    child: MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  static const BASE_URL = "http://sksapi.suninfotechnologies.in/";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Easy Shop",
      theme: ThemeData(
          primaryColor: Color.fromRGBO(66, 67, 69, 1),
          accentColor: Colors.orange,
          fontFamily: 'Poppins',
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline3: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
            headline4: TextStyle(fontSize: 24,color: Colors.white),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Fryo',color: Colors.white),
          )),
      home: HomePage(),
      routes: {
        CartScreen.routeName: (_) => CartScreen(),
      },
    );
  }
}