import 'package:ecommerce_int2/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomBar extends StatelessWidget {
  final TabController controller;

  const CustomBottomBar({
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.transparent, spreadRadius: 0, blurRadius: 10),
      ]),
      child: ClipRRect(
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home_filled, color: yellow),
                onPressed: () {
                  controller.animateTo(0);
                },
              ),
              /* IconButton(
                icon: Image.asset('assets/icons/category_icon.png'),
                onPressed: () {
                  controller.animateTo(1);
                },
              ), */
              IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: yellow,
                ),
                onPressed: () {
                  controller.animateTo(1);
                },
              ),
              IconButton(
                icon: Icon(Icons.person_rounded, color: yellow),
                onPressed: () {
                  controller.animateTo(2);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
