import 'dart:convert';

import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/custom_background.dart';
import 'package:ecommerce_int2/main.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/address/add_address_page.dart';
import 'package:ecommerce_int2/screens/category/category_list_page.dart';
import 'package:ecommerce_int2/screens/notifications_page.dart';
import 'package:ecommerce_int2/screens/payment/payment_page.dart';
import 'package:ecommerce_int2/screens/product/components/shop_bottomSheet.dart';
import 'package:ecommerce_int2/screens/product/product_page.dart';
import 'package:ecommerce_int2/screens/product/view_product_page.dart';
import 'package:ecommerce_int2/screens/profile_page.dart';
import 'package:ecommerce_int2/screens/search_page.dart';
import 'package:ecommerce_int2/screens/shop/check_out_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'components/custom_bottom_bar.dart';
import 'components/product_list.dart';
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

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage>, RouteAware {
  late TabController tabController;
  late TabController bottomTabController;

  _MainPageState() {
    void _handleCommand(Map<String, dynamic> command) {
      print('Start handle Command');

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
                  builder: (_) => SearchPage(
                    search: searchText,
                  ),
                ),
              );
              break;
            case "/product":
              String searchText = command["data"];
              Product selectedProduct = products
                  .where((element) => element.name.toLowerCase() == searchText)
                  .first;
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
          }
          break;
        case 'addToCart':
          final GlobalKey<ScaffoldState> _scaffoldKey =
              new GlobalKey<ScaffoldState>();
          _scaffoldKey.currentState!.showBottomSheet((context) {
            return ShopBottomSheet();
          });
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

    /// Init Alan Button with project key from Alan Studio
    AlanVoice.addButton(
      "7e8c76af5acb0245cbf3c098c789d13a2e956eca572e1d8b807a3e2338fdd0dc/stage",
    );

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) {
      debugPrint("got new command ${command.toString()}");
      _handleCommand(command.data);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setVisuals("main"));
    tabController = TabController(length: 5, vsync: this);
    bottomTabController = TabController(length: 4, vsync: this);
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => NotificationsPage())),
              icon: Icon(Icons.notifications)),
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
                    products = [
                      Product(
                          'el_lipstick_red',
                          'assets/el_lipstick_red.jpg',
                          'Estee Lauder Lipstick Red',
                          'A Red Lipstick from Estee Lauder',
                          'Estee Lauder',
                          'lipstick',
                          30.00),
                      Product(
                          'el_lipstick_red',
                          'assets/el_lipstick_red.jpg',
                          'Estee Lauder Lipstick Red',
                          'A Red Lipstick from Estee Lauder',
                          'Estee Lauder',
                          'lipstick',
                          30.00),
                      Product(
                          'el_lipstick_red',
                          'assets/el_lipstick_red.jpg',
                          'Estee Lauder Lipstick Red',
                          'A Red Lipstick from Estee Lauder',
                          'Estee Lauder',
                          'lipstick',
                          30.00),
                    ];
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
                    products = [
                      Product(
                          'el_lipstick_red',
                          'assets/el_lipstick_red.jpg',
                          'Estee Lauder Lipstick Red',
                          'A Red Lipstick from Estee Lauder',
                          'Estee Lauder',
                          'lipstick',
                          30.00),
                      Product(
                          'el_lipstick_red',
                          'assets/el_lipstick_red.jpg',
                          'Estee Lauder Lipstick Red',
                          'A Red Lipstick from Estee Lauder',
                          'Estee Lauder',
                          'lipstick',
                          30.00),
                      Product(
                          'el_lipstick_red',
                          'assets/el_lipstick_red.jpg',
                          'Estee Lauder Lipstick Red',
                          'A Red Lipstick from Estee Lauder',
                          'Estee Lauder',
                          'lipstick',
                          30.00),
                    ];
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
                    products = [
                      Product(
                          'el_lipstick_red',
                          'assets/el_lipstick_red.jpg',
                          'Estee Lauder Lipstick Red',
                          'A Red Lipstick from Estee Lauder',
                          'Estee Lauder',
                          'lipstick',
                          30.00),
                      Product(
                          'el_lipstick_red',
                          'assets/el_lipstick_red.jpg',
                          'Estee Lauder Lipstick Red',
                          'A Red Lipstick from Estee Lauder',
                          'Estee Lauder',
                          'lipstick',
                          30.00),
                      Product(
                          'el_lipstick_red',
                          'assets/el_lipstick_red.jpg',
                          'Estee Lauder Lipstick Red',
                          'A Red Lipstick from Estee Lauder',
                          'Estee Lauder',
                          'lipstick',
                          30.00),
                    ];
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
                  // These are the slivers that show up in the "outer" scroll view.
                  return <Widget>[
                    SliverToBoxAdapter(
                      child: appBar,
                    ),
                    SliverToBoxAdapter(
                      child: topHeader,
                    ),
                    SliverToBoxAdapter(
                      child: ProductList(
                        products: products,
                      ),
                    ),
                    // SliverToBoxAdapter(
                    //   child: tabBar,
                    // )
                  ];
                },
                body: TabView(
                  tabController: tabController,
                ),
              ),
            ),
            CategoryListPage(),
            CheckOutPage(),
            ProfilePage()
          ],
        ),
      ),
    );
  }
}
