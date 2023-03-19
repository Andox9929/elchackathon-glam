import 'package:alan_voice/alan_voice.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/product/components/rating_bottomSheet.dart';
import 'package:ecommerce_int2/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app_properties.dart';
import 'components/color_list.dart';
import 'components/more_products.dart';
import 'components/product_options.dart';

class ViewProductPage extends StatefulWidget {
  final Product product;

  ViewProductPage({required this.product});

  @override
  _ViewProductPageState createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> with RouteAware {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int active = 0;

  ///list of product colors
  List<Widget> colors() {
    List<Widget> list = [];
    for (int i = 0; i < 5; i++) {
      list.add(
        InkWell(
          onTap: () {
            setState(() {
              active = i;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Transform.scale(
              scale: active == i ? 1.2 : 1,
              child: Card(
                elevation: 3,
                color: Colors.primaries[i],
                child: SizedBox(
                  height: 32,
                  width: 32,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    Product product = widget.product;
    AlanVoice.playText(
        "${product.name}, a ${product.category} from ${product.brand}. ${product.description}. The price is RM ${product.price}");
    AlanVoice.playText(
        "To buy now, say 'Buy now'. To add to cart, say 'Add to cart'.");
    super.initState();
  }

  @override
  void didPush() {
    setVisuals('view_product');
  }

  @override
  void didPop() {
    setVisuals('search');
  }

  void setVisuals(String screen) {
    var visual = "{\"screen\":\"$screen\"}";
    AlanVoice.setVisualState(visual);
  }

  @override
  Widget build(BuildContext context) {
    Widget description = Padding(
      padding: const EdgeInsets.all(24.0),
      child: Text(
        widget.product.description,
        maxLines: 5,
        semanticsLabel: '...',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.6)),
      ),
    );

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: yellow,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: darkGrey),
          actions: <Widget>[
            IconButton(
              icon: new SvgPicture.asset(
                'assets/icons/search_icon.svg',
                fit: BoxFit.scaleDown,
              ),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SearchPage())),
            )
          ],
          title: Text(
            widget.product.category[0].toUpperCase() +
                widget.product.category.substring(1).toLowerCase(),
            style: const TextStyle(
                color: darkGrey,
                fontWeight: FontWeight.w500,
                fontFamily: "Montserrat",
                fontSize: 18.0),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                ProductOption(
                  _scaffoldKey,
                  product: widget.product,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Text(
                    "RM" + widget.product.price.toStringAsFixed(2),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(255, 255, 255, 0.6),
                    ),
                  ),
                ),
                description,
                /* Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Flexible(
                      child: ColorList([
                        Colors.red,
                        Colors.blue,
                        Colors.purple,
                        Colors.green,
                        Colors.yellow
                      ]),
                    ),
                    RawMaterialButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return RatingBottomSheet();
                          },
                          //elevation: 0,
                          //backgroundColor: Colors.transparent
                        );
                      },
                      constraints:
                          const BoxConstraints(minWidth: 45, minHeight: 45),
                      child: Icon(Icons.favorite,
                          color: Color.fromRGBO(255, 137, 147, 1)),
                      elevation: 0.0,
                      shape: CircleBorder(),
                      fillColor: Color.fromRGBO(255, 255, 255, 0.4),
                    ),
                  ]),
                ), */
                MoreProducts()
              ],
            ),
          ),
        ));
  }
}
