import 'package:card_swiper/card_swiper.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/product/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductSuggest extends StatelessWidget {
  List<Product> products;
  final SwiperController swiperController = SwiperController();
  ProductSuggest({required this.products});
  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height / 2.7;
    double cardWidth = MediaQuery.of(context).size.width / 1.8;
    return SizedBox(
      height: cardHeight,
      child: Swiper(
        itemCount: products.length,
        itemBuilder: (_, index) {
          return ProductCard(
              height: cardHeight, width: cardWidth, product: products[index]);
        },
        scale: 0.8,
        controller: swiperController,
        viewportFraction: 0.6,
        loop: false,
        fade: 0.5,
      ),
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
          MaterialPageRoute(builder: (_) => ProductPage(product: product))),
      child: Container(
        margin: EdgeInsets.only(top: 50),
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 30),
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
                  Column(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 50),
                            child: Text(
                              product.id,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 32.0),
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
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: -100,
              right: -70,
              child: Hero(
                tag: product.image,
                child: SvgPicture.asset(
                  product.image,
                  height: height / 1.2,
                  width: width / 1.2,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              left: 30,
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
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      // bottomLeft: Radius.circular(10),
                    ),
                    color: Color.fromARGB(255, 249, 85, 20),
                    // color: yellow,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 14),
                    child: Text(
                      'RM ${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
