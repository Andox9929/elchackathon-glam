import 'package:alan_voice/alan_voice.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/auth/welcome_back_page.dart';
import 'package:ecommerce_int2/screens/intro_page.dart';
import 'package:ecommerce_int2/screens/main/main_page.dart';
import 'package:ecommerce_int2/screens/payment/payment_page.dart';
import 'package:ecommerce_int2/screens/product/components/shop_bottomSheet.dart';
import 'package:ecommerce_int2/screens/product/view_product_page.dart';
import 'package:ecommerce_int2/screens/search_page.dart';
import 'package:ecommerce_int2/screens/shop/check_out_page.dart';
import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';

import 'address/add_address_page.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;

  // _IntroPageState() {}

  @override
  void initState() {
    super.initState();
    // controller = AnimationController(
    //     duration: Duration(milliseconds: 2500), vsync: this);
    // opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
    //   ..addListener(() {
    //     setState(() {});
    //   });
    // controller.forward().then((_) {
    //   navigationPage();
    // });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void navigationPage() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => IntroPage()));
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/splash_screen.png'), fit: BoxFit.fill)),
      child: Container(
        child: new Stack(
          children: <Widget>[
            new Positioned(
              left: 25.0,
              top: 450.0,
              child: TextButton(
                child: Text('Get Started'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: yellow,
                  disabledForegroundColor: Colors.grey.withOpacity(0.38),
                  fixedSize: Size(150, 50),
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.8)),
                  elevation: 10,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => MainPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
