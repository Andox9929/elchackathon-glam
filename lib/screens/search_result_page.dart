import 'package:alan_voice/alan_voice.dart';
import 'package:ecommerce_int2/data/product_data.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/main/components/product_list.dart';
import 'package:ecommerce_int2/screens/main/main_page.dart';
import 'package:ecommerce_int2/screens/product/components/rating_bottomSheet.dart';
import 'package:ecommerce_int2/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app_properties.dart';

class SearchResultPage extends StatefulWidget {
  final String search;

  SearchResultPage({required this.search});

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> with RouteAware {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Product> products = getProducts();
  List<Product> searchResults = [];

  int active = 0;

  @override
  void initState() {
    // TODO: implement initState

    List<Product> tempList = getProductsByKeywords(widget.search);
    searchResults.clear();
    searchResults.addAll(tempList);

    String productNames = "";
    bool _stop = false;
    tempList.asMap().forEach((index, element) {
      // read three Items only
      if (index < 3) {
        if (index == tempList.length - 1) {
          productNames += "and ";
        }
        productNames += "${element.name} from ${element.brand}, ";
      } else {
        if (_stop == false) {
          productNames += "and more.";
          _stop = true;
        }
      }
    });

    // Alan Voice
    AlanVoice.playText(
        "We have $productNames, to view the product, say 'I want to see' follow by product code.");

    super.initState();
  }

  @override
  void didPush() {
    setVisuals('search_result');
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
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: yellow,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: darkGrey),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SearchPage())),
            )
          ],
          title: Text(
            widget.search,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: "Montserrat",
                fontSize: 18.0),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: ProductList(products: searchResults),
          ),
        ));
  }
}
