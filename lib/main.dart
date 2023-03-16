
import 'package:ecommerce_int2/screens/splash_page.dart';
import 'package:flutter/material.dart';
// Brandon
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';


// void main() async {
//   final appDocumentDir = await getApplicationDocumentsDirectory();
//   Hive.init(appDocumentDir.path);
//   await Hive.openBox<String>("credit_card_box_name");

//   runApp(MyApp());
// }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eCommerce int2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: Colors.transparent,
        primarySwatch: Colors.blue,
        fontFamily: "Montserrat",
      ),
      home: SplashScreen(),
    );
  }
}
