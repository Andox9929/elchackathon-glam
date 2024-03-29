import 'dart:async';
import 'dart:convert';

import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/custom_background.dart';
import 'package:ecommerce_int2/main.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/address/add_address_page.dart';
import 'package:ecommerce_int2/screens/category/category_list_page.dart';
import 'package:ecommerce_int2/screens/notifications_page.dart';
import 'package:ecommerce_int2/screens/payment/payment_page.dart';
import 'package:ecommerce_int2/screens/payment/payment_success.dart';
import 'package:ecommerce_int2/screens/product/components/shop_bottomSheet.dart';
import 'package:ecommerce_int2/screens/product/product_page.dart';
import 'package:ecommerce_int2/screens/product/view_product_page.dart';
import 'package:ecommerce_int2/screens/profile_page.dart';
import 'package:ecommerce_int2/screens/search_page.dart';
import 'package:ecommerce_int2/screens/search_result_page.dart';
import 'package:ecommerce_int2/screens/shop/check_out_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'components/custom_bottom_bar.dart';
import 'components/product_suggest.dart';
import 'components/tab_view.dart';
import 'package:alan_voice/alan_voice.dart';
import '../../data/product_data.dart' as _productData;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

List<String> timelines = ['Weekly featured', 'Best of June', 'Best of 2018'];
String selectedTimeline = 'Weekly featured';
List<Product> products = _productData.getProducts();
Timer _timer = new Timer(Duration.zero, () {});

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage>, RouteAware {
  late TabController tabController;
  late TabController bottomTabController;

  _MainPageState() {
    void _handleCommand(Map<String, dynamic> command) {
      print('Start handle Command');
      print("Output>>> $command");

      switch (command["command"]) {
        case "navigation":
          switch (command["route"]) {
            case "/home":
              bottomTabController.animateTo(0);
              break;
            case "/cart":
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CheckOutPage(),
                ),
              );
              // bottomTabController.animateTo(2);
              break;
            case "/search":
              String searchText = command["data"];
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SearchResultPage(
                    search: searchText,
                  ),
                ),
              );
              break;
            case "/product":
              String searchText = command["data"];
              Product selectedProduct = _productData.getProduct("DO2");
              if (command["type"] == 'id') {
                selectedProduct = products
                    .where((element) =>
                        element.id.toUpperCase() == searchText.toUpperCase())
                    .first;
              } else {
                selectedProduct = products
                    .where((element) =>
                        element.name.toUpperCase() == searchText.toUpperCase())
                    .first;
              }
              print("Output>>> ${selectedProduct.name}");
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ViewProductPage(
                    product: selectedProduct,
                  ),
                ),
              );
              break;
            case "/checkout":
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CheckOutPage(),
                ),
              );
              break;
            case "/addAddress":
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AddAddressPage(),
                ),
              );
              break;
            case "/payment":
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PaymentPage(),
                ),
              );
              break;
            case "/paymentSuccess":
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PaymentSuccessPage(
                    transactionId: "2023030007",
                  ),
                ),
              );
              break;
          }
          break;
        case 'getStarted':
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => MainPage(),
          ));
          break;
        case 'addToCart':
          // showDialog(
          //     context: context,
          //     builder: (BuildContext builderContext) {
          //       _timer = Timer(Duration(seconds: 2), () {
          //         Navigator.of(context).pop();
          //       });

          //       return AlertDialog(
          //         backgroundColor: Colors.red,
          //         title: Text('Title'),
          //         content: SingleChildScrollView(
          //           child: Text('Added to Cart'),
          //         ),
          //       );
          //     }).then((val) {
          //   if (_timer.isActive) {
          //     _timer.cancel();
          //   }
          // });
          final snackBar = SnackBar(content: Text("Items added to cart"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
        case 'buyNow':
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CheckOutPage(),
            ),
          );
          break;
      }
    }

    void _checkIsActive() async {
      var isActive = await AlanVoice.isActive();
      if (isActive) {
        print("Output>>> IS ACTIVE");
        // AlanVoice.showButton();
      } else {
        print("Output>>> IS NOT ACTIVE");
        // AlanVoice.hideButton();
      }
    }

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) {
      debugPrint("Output>>> got new command ${command.toString()}");
      _handleCommand(command.data);
    });

    AlanVoice.eventCallbacks.add((command) {
      debugPrint("Output>>> eventCallbacks");
      // _checkIsActive();
    });

    AlanVoice.activate();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setVisuals("main"));
    tabController = TabController(length: 5, vsync: this);
    bottomTabController = TabController(length: 3, vsync: this);

    // Welcome message
    // AlanVoice.playText("Welcome to Glam");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {}

  @override
  void didPop() {}

  void setVisuals(String screen) {
    var visual = "{\"screen\":\"$screen\"}";
    AlanVoice.setVisualState(visual);
  }

  @override
  Widget build(BuildContext context) {
    Widget appBar = Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // IconButton(
          //     onPressed: () => Navigator.of(context)
          //         .push(MaterialPageRoute(builder: (_) => NotificationsPage())),
          //     icon: Icon(Icons.notifications)),
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SearchPage())),
              icon: SvgPicture.asset('assets/icons/search_icon.svg'))
        ],
      ),
    );

    Widget topHeader = Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedTimeline = timelines[0];
                    products = _productData.getProducts();
                  });
                },
                child: Text(
                  timelines[0],
                  style: TextStyle(
                      fontSize: timelines[0] == selectedTimeline ? 20 : 14,
                      color: darkGrey),
                ),
              ),
            ),
            Flexible(
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedTimeline = timelines[1];
                    products = _productData.getProducts();
                  });
                },
                child: Text(timelines[1],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: timelines[1] == selectedTimeline ? 20 : 14,
                        color: darkGrey)),
              ),
            ),
            Flexible(
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedTimeline = timelines[2];
                    products = _productData.getProducts();
                  });
                },
                child: Text(timelines[2],
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: timelines[2] == selectedTimeline ? 20 : 14,
                        color: darkGrey)),
              ),
            ),
          ],
        ));

    /* Widget tabBar = TabBar(
      tabs: [
        Tab(text: 'Trending'),
        Tab(text: 'Sports'),
        Tab(text: 'Headsets'),
        Tab(text: 'Wireless'),
        Tab(text: 'Bluetooth'),
      ],
      labelStyle: TextStyle(fontSize: 16.0),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0,
      ),
      labelColor: darkGrey,
      unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.5),
      isScrollable: true,
      controller: tabController,
    );*/
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: CustomBottomBar(controller: bottomTabController),
      body: CustomPaint(
        painter: MainBackground(),
        child: TabBarView(
          controller: bottomTabController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            SafeArea(
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverToBoxAdapter(
                      child: appBar,
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello Leong,",
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              "What a great day to shopping!",
                              style: TextStyle(
                                fontSize: 38.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 70.0),
                            Text(
                              "You may also like",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ProductSuggest(
                        products: products,
                      ),
                    ),
                  ];
                },
                body: TabView(
                  tabController: tabController,
                ),
              ),
            ),
            // CategoryListPage(),
            CheckOutPage(),
            ProfilePage()
          ],
        ),
      ),
    );
  }
}
