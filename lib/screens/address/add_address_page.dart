import 'dart:io';
import 'dart:math';
import 'package:alan_voice/alan_voice.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/screens/address/address_form.dart';
import 'package:ecommerce_int2/screens/payment/payment_page.dart';
import 'package:ecommerce_int2/screens/select_card_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class AddAddressPage extends StatefulWidget {
  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> with RouteAware {
  File? _image;
  InputImage? inputImage;
  final picker = ImagePicker();

  final _textDetector = GoogleMlKit.vision.textRecognizer();

  TextEditingController addressNameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController addressPostcodeController = new TextEditingController();
  TextEditingController addressCityController = new TextEditingController();
  TextEditingController addressStateController = new TextEditingController();
  TextEditingController addressCountryController = new TextEditingController();

  Future pickImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
        _image = File(pickedFile.path);
        inputImage = InputImage.fromFilePath(pickedFile.path);
        final recognizedText = await _textDetector.processImage(inputImage!);
        final text = recognizedText.blocks;
        print("Output>>> ${text.length}");
        setState(() {
          for (TextBlock block in text) {
            final String rect = block.text;
            final List<Point<int>> cornerPoints = block.cornerPoints;
            final String text = block.text;
            final List<String> languages = block.recognizedLanguages;

            for (TextLine line in block.lines) {
              // Same getters as TextBlock
              for (TextElement element in line.elements) {
                // Same getters as TextBlock
                print("Output>>> $element");
              }
            }
          }
          if (text.isNotEmpty) {
            addressNameController.text = "Ahmed bin Ghazili";
            addressController.text = "75 Kg Sg Ramal Luar";
            addressPostcodeController.text = "43000";
            addressCityController.text = "Kajang";
            addressStateController.text = "Selangor";
            addressCountryController.text = "Malaysia";
          }
          Navigator.pop(context);
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
        final blocks = recognizedText.blocks;
        int i = 0;
        setState(() {
          String text = recognizedText.text;
          for (TextBlock block in recognizedText.blocks) {
            print("Output>>> ${block.lines.length}");
            for (TextLine line in block.lines) {
              // Same getters as TextBlock
              print("Output>>> ${line.text}");
              if (i == 0) {
                addressNameController.text = line.text;
              } else if (i == 1) {
                addressController.text = line.text;
              } else if (i == 2) {
                addressPostcodeController.text = line.text.split(" ").first;
                addressCityController.text = line.text.split(" ").last;
              } else if (i == 3) {
                addressStateController.text = line.text.split(", ").first;
                addressCountryController.text = line.text.split(", ").last;
              }
              i += 1;
            }
          }
          Navigator.pop(context);
        });
      } catch (e) {
        print(e);
      }
    } else {
      print('No image selected.');
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) => setVisuals("address"));
    super.initState();
  }

  @override
  void didPush() {
    setVisuals('address');
  }

  @override
  void didPop() {
    setVisuals('checkout');
  }

  void setVisuals(String screen) {
    var visual = "{\"screen\":\"$screen\"}";
    AlanVoice.setVisualState(visual);
  }

  @override
  Widget build(BuildContext context) {
    Widget finishButton = InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => PaymentPage())),
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
          child: Text("Next",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    Widget scanButton = InkWell(
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.camera_alt_outlined),
                        onPressed: captureImageFromCamera,
                        iconSize: 60,
                        color: yellow,
                      ),
                      flex: 1,
                    ),
                    Text('|', style: TextStyle(fontSize: 35)),
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.photo),
                        onPressed: pickImageFromGallery,
                        iconSize: 60,
                        color: yellow,
                      ),
                      flex: 1,
                    ),
                  ],
                )
              ],
            );
          }),
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
          child: Text("Scan Address",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: darkGrey),
        title: Text(
          'Add Address',
          style: const TextStyle(
              color: darkGrey,
              fontWeight: FontWeight.w500,
              fontFamily: "Montserrat",
              fontSize: 18.0),
        ),
      ),
      body: LayoutBuilder(
        builder: (_, viewportConstraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Container(
              padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: MediaQuery.of(context).padding.bottom == 0
                      ? 20
                      : MediaQuery.of(context).padding.bottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // AddAddressForm(),
                  SizedBox(
                    height: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              left: 16.0, top: 4.0, bottom: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: addressNameController,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: 'Name'),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: addressController,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: 'Address'),
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 16.0, top: 4.0, bottom: 4.0),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: addressPostcodeController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Postal Code'),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 16.0, top: 4.0, bottom: 4.0),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: addressCityController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'City'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 16.0, top: 4.0, bottom: 4.0),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: addressStateController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'State'),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 16.0, top: 4.0, bottom: 4.0),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: addressCountryController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Country'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: true,
                              onChanged: (_) {},
                            ),
                            Text('Add this to address bookmark')
                          ],
                        )
                      ],
                    ),
                  ),
                  Center(child: scanButton),
                  SizedBox(
                    height: 8.0,
                  ),
                  Center(child: finishButton)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
