import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import './screens/homepage.dart';
import './services/group_service.dart';
import './services/sub_group_service.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => GroupService());
  GetIt.I.registerLazySingleton(() => SubGroupService());
}

void main() {
  setupLocator();
  runApp(
    MyApp(),
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
        primaryColor: Colors.blueGrey,
        accentColor: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
