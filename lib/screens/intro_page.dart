import 'dart:async';

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

  _IntroPageState() {
    void _handleCommand(Map<String, dynamic> command) {
      print('Start handle Command');
      print("Output>>> $command");

      switch (command["command"]) {
        case 'getStarted':
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => MainPage(),
          ));
          break;
      }
    }

    /// Init Alan Button with project key from Alan Studio
    AlanVoice.addButton(
      "7e8c76af5acb0245cbf3c098c789d13a2e956eca572e1d8b807a3e2338fdd0dc/stage",
    );

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) {
      debugPrint("Output>>> got new command ${command.toString()}");
      _handleCommand(command.data);
    });
  }

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
    Timer(Duration(seconds: 2), () {
      AlanVoice.activate();
      AlanVoice.playText("Welcome to Glam");
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
              top: 475.0,
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
