import 'dart:io';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/screens/product/components/color_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:async';
// import 'package:hive/hive.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Color active = Colors.red;
  TextEditingController cardNumber = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController month = TextEditingController();
  TextEditingController cvc = TextEditingController();
  TextEditingController cardHolder = TextEditingController();

  ScrollController scrollController = ScrollController();
  // final creditCardBox = Hive.openBox<String>('creditCardBox');

  @override
  void initState() {
    super.initState();
    getCreditCardInfo();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection.index == 1) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
  }

  String convertCardNumber(String src, String divider) {
    String newStr = '';
    int step = 4;
    for (int i = 0; i < src.length; i += step) {
      newStr += src.substring(i, math.min(i + step, src.length));
      if (i + step < src.length) newStr += divider;
    }
    return newStr;
  }

  String convertMonthYear(String month, String year) {
    if (month.isNotEmpty)
      return month + '/' + year;
    else
      return '';
  }

  File? _image;
  InputImage? inputImage;
  final picker = ImagePicker();

  final _textDetector = GoogleMlKit.vision.textRecognizer();
  final creditCardRegex = RegExp(r"\b\d{4}[- ]?\d{4}[- ]?\d{4}[- ]?\d{4}\b");

  Future pickImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
        _image = File(pickedFile.path);
        inputImage = InputImage.fromFilePath(pickedFile.path);
        final recognizedText = await _textDetector.processImage(inputImage!);
        final text = recognizedText.text;

        final hasCreditCard = creditCardRegex.hasMatch(text);

        setState(() {
          if (hasCreditCard) {
            cardNumber.text = "1234567890121234";
            year.text = "23";
            month.text = "01";
            cardHolder.text = "Brandon";
          } else {
            cvc.text = "123";
          }
        });
      } catch (e) {
        print(e);
      }
    } else {
      print('No image selected.');
    }
  }

  Future captureImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      try {
        _image = File(pickedFile.path);
        inputImage = InputImage.fromFilePath(pickedFile.path);
        final recognizedText = await _textDetector.processImage(inputImage!);
        final text = recognizedText.text;

        final hasCreditCard = creditCardRegex.hasMatch(text);

        setState(() {
          if (hasCreditCard) {
            cardNumber.text = "1234567890121234";
            year.text = "23";
            month.text = "01";
            cardHolder.text = "Brandon";
          } else {
            cvc.text = "123";
          }
        });
      } catch (e) {
        print(e);
      }
    } else {
      print('No image selected.');
    }
  }

  Future<void> saveCreditCardInfo() async {
    // final creditCardBox = Hive.box<String>("creditCardBox");

    // await creditCardBox.put('cardNumber', cardNumber.text);
    // await creditCardBox.put('year', year.text);
    // await creditCardBox.put('month', month.text);
    // await creditCardBox.put('cardHolder', cardHolder.text);
    // await creditCardBox.put('cvc', cvc.text);

  }

  Future<void> getCreditCardInfo() async {
    // final creditCardBox = Hive.box<String>("creditCardBox");

    // cardNumber.text = creditCardBox.get('cardNumber') ?? '';
    // year.text = creditCardBox.get('year') ?? '';
    // month.text = creditCardBox.get('month') ?? '';
    // cardHolder.text = creditCardBox.get('cardHolder') ?? '';
    // cvc.text = creditCardBox.get('cvc') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    Widget addThisCard = InkWell(
      onTap: () => saveCreditCardInfo,
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("Add This Card",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    Widget scanFromPhoto = InkWell(
      onTap: pickImageFromGallery,
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("Scan From Photo",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    Widget scanThisCard = InkWell(
      onTap: captureImageFromCamera,
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("Scan This Card",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (_, constraints) => GestureDetector(
          onPanDown: (val) {},
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            controller: scrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Container(
                margin: const EdgeInsets.only(top: kToolbarHeight),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Payment',
                          style: TextStyle(
                            color: darkGrey,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CloseButton()
                      ],
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(32.0),
                      decoration: BoxDecoration(
                          color: active,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'CREDIT CARD',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            children: <Widget>[
                              Container(
                                height: 25,
                                width: 40,
                                color: Colors.white,
                              ),
                              Flexible(
                                  child: Center(
                                      child: Text(
                                          convertCardNumber(
                                              cardNumber.text, '-'),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)))),
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(convertMonthYear(month.text, year.text),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Text(cvc.text,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          Spacer(),
                          Text(cardHolder.text,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Colors.red,
                          Colors.blue,
                          Colors.purple[700],
                          Colors.green[700],
                          Colors.lightBlueAccent
                        ]
                            .map((c) => InkWell(
                                  onTap: () {
                                    setState(() {
                                      active = c ?? Colors.red;
                                    });
                                  },
                                  child: Transform.scale(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ColorOption(c ?? Colors.red),
                                      ),
                                      scale: active == c ? 1.2 : 1),
                                ))
                            .toList(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: shadow,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 16.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.grey[200],
                            ),
                            child: TextField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(16)
                              ],
                              controller: cardNumber,
                              onChanged: (val) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Card Number'),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.only(left: 16.0),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Colors.grey[200],
                                  ),
                                  child: TextField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2)
                                    ],
                                    controller: month,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Month'),
                                    onChanged: (val) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.only(left: 16.0),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Colors.grey[200],
                                  ),
                                  child: TextField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2)
                                    ],
                                    controller: year,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Year'),
                                    onChanged: (val) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.only(left: 16.0),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Colors.grey[200],
                                  ),
                                  child: TextField(
                                    controller: cvc,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'CVC'),
                                    onChanged: (val) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 16.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.grey[200],
                            ),
                            child: TextField(
                              controller: cardHolder,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Name on card'),
                              onChanged: (val) {
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.0),
                    Center(
                        child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: addThisCard,
                    )),
                    Center(
                        child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: scanFromPhoto,
                    )),
                    Center(
                        child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: scanThisCard,
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
