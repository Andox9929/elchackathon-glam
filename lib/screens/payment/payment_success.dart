import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/screens/product/components/color_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentSuccessPage extends StatefulWidget {
  final String transactionId;

  PaymentSuccessPage({required this.transactionId});

  @override
  _PaymentSuccessPageState createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () =>
              Navigator.popUntil(context, ModalRoute.withName('/')),
          color: yellow,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 150,
            ),
            SizedBox(height: 20),
            Text(
              'Transaction Done!',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'RM 160.00',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'You have earned 1600 Points.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Text(
              'Transaction ID:',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              widget.transactionId,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                //
              },
              style: ElevatedButton.styleFrom(
                primary: yellow,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'View My Order',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
