import 'package:card_swiper/card_swiper.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/product/product_page.dart';
import 'package:ecommerce_int2/screens/product/view_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductList extends StatelessWidget {
  List<Product> products;

  ProductList({required this.products});

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height / 2.7;
    double cardWidth = MediaQuery.of(context).size.width / 1.8;

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: cardWidth / cardHeight,
      ),
      itemBuilder: (_, index) {
        return Padding(
          padding: EdgeInsets.all(7),
          child: ProductCard(
            height: cardHeight,
            width: cardWidth,
            product: products[index],
          ),
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final double height;
  final double width;

  const ProductCard({
    required this.product,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ViewProductPage(product: product))),
      child: Container(
        margin: EdgeInsets.only(top: 50),
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              // margin: const EdgeInsets.only(left: 30),
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                color: Color.fromARGB(255, 0, 178, 178),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // IconButton(
                  //   icon: Icon(Icons.favorite_border),
                  //   onPressed: () {},
                  //   color: Color.fromARGB(255, 0, 178, 178),
                  // ),
                  Column(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 50, bottom: 20),
                            child: Text(
                              product.id,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          )),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Text(
                              product.name,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            ),
                          )),
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: Container(
                      //     margin: const EdgeInsets.only(bottom: 12.0),
                      //     padding:
                      //         const EdgeInsets.fromLTRB(8.0, 4.0, 12.0, 4.0),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.only(
                      //           topLeft: Radius.circular(10),
                      //           bottomLeft: Radius.circular(10),
                      //           bottomRight: Radius.circular(10)),
                      //       color: Color.fromARGB(255, 249, 85, 20),
                      //     ),
                      //     child: Text(
                      //       'RM ${product.price}',
                      //       style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: -90,
              right: -60,
              child: Hero(
                tag: product.image,
                child: SvgPicture.asset(
                  product.image,
                  height: height / 1.3,
                  width: width / 1.3,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    // bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  color: Color.fromRGBO(247, 247, 247, 1.000),
                ),
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                  color: Color.fromARGB(255, 0, 178, 178),
                ),
              ),
            ),
            Positioned(
                right: 0,
                bottom: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  child: Text(
                    'RM ${product.price}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
