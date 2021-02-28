import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dawerha/Models/ItemCodeObject.dart';
import 'package:dawerha/Models/OrderItemObject.dart';
import 'package:dawerha/Utils/colors.dart';
import 'package:dawerha/Utils/styles.dart';
import 'package:dawerha/Utils/BaseFunctions.dart';
import 'package:dawerha/Widgets/CustomNumberPicker.dart';
import 'package:dawerha/Widgets/NewButton.dart';
import 'package:flutter/material.dart';
import 'package:dawerha/Widgets/CreateOrderItem.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dawerha/screens/HomeOwnerScreens/HomeOwnerCreateOrderScreenThree.dart';

class HomeOwnerCreateOrderScreenTwo extends StatefulWidget {
  @override
  _HomeOwnerCreateOrderScreenTwoState createState() =>
      _HomeOwnerCreateOrderScreenTwoState();

  double selectedLat;
  double selectedLng;
  String selectedAddressId;
  HomeOwnerCreateOrderScreenTwo(
      this.selectedLat, this.selectedLng, this.selectedAddressId);
}

class _HomeOwnerCreateOrderScreenTwoState
    extends State<HomeOwnerCreateOrderScreenTwo> {
  final borderStyle = BoxDecoration(
      border: Border(
          top: BorderSide(color: Colors.black),
          bottom: BorderSide(color: Colors.black),
          left: BorderSide(color: Colors.black),
          right: BorderSide(color: Colors.black)),
      borderRadius: BorderRadius.circular(5.0));

  //Parameters
  List<ItemCodeObject> items = [];
  List<OrderItemObject> selectedItems = [];

  String selectedItem = 'اختر مادة';
  int selectedWeight = 0;
  String imagePath = '';
  File imageFile;
  var _firestore;

  //Build method
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text(
            'طلب جديد',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              Text(
                'اختر المواد التي لديك',
                style: smallStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: double.infinity,
                decoration: borderStyle,
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: selectedItem,
                    items: getSpinnerData(),
                    onChanged: (v) {
                      setState(() {
                        selectedItem = v;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'الوزن بالكيلو غرام',
                      style: smallStyle,
                    ),
                  ),
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomNumberPicker(
                          index: selectedWeight,
                          onPlus: (v) {
                            selectedWeight = v;
                          },
                          onMinus: (v) {
                            selectedWeight = v;
                          },
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'إرفاق صورة الأكياس',
                    style: smallStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Icon(
                      FontAwesomeIcons.questionCircle,
                      color: Color(text_color),
                    ),
                  )
                ],
              ),
              Center(
                child: Stack(
                  children: <Widget>[
                    Visibility(
                      visible: imageFile == null ? true : false,
                      child: GestureDetector(
                        onTap: () {
                          pickImage();
                        },
                        child: Icon(
                          Icons.image,
                          size: 100.0,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: imageFile == null ? false : true,
                      child: GestureDetector(
                        onTap: () {
                          pickImage();
                        },
                        child: imageFile != null
                            ? Image.file(
                                imageFile,
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              )
                            : Container(),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              NewButton(
                title: 'إضافةالمادة للقائمة',
                onPressed: () {
                  if (selectedItem == 'اختر مادة') {
                    showToast(context, 'يجب عليك اختيار مادة');
                    return;
                  }
                  if (selectedWeight == 0) {
                    showToast(context, 'يجب عليك اختيار الوزن');
                    return;
                  }
                  if (imagePath == '') {
                    showToast(context, 'يجب عليك اختيار صورة');
                    return;
                  }
                  selectedItems.add(OrderItemObject(
                    "",
                    "",
                    getItemId(selectedItem),
                    imagePath,
                    selectedWeight,
                    selectedWeight,
                  ));
                  setState(() {
                    selectedItem = 'اختر مادة';
                    selectedWeight = 0;
                    imagePath = '';
                    imageFile = null;
                  });
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Visibility(
                visible: selectedItems.length > 0 ? true : false,
                child: Container(
                  width: double.infinity,
                  decoration: borderStyle,
                  padding:
                      EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                  child: ListView.builder(
                    itemBuilder: (context, position) {
                      return CreateOrderItem(
                        title: getItemName(selectedItems[position].item_id),
                        onRemove: () {
                          setState(() {
                            selectedItems.removeAt(position);
                          });
                        },
                      );
                    },
                    shrinkWrap: true,
                    itemCount: selectedItems.length,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              NewButton(
                title: 'إرسال الطلب',
                onPressed: () {
                  if (selectedItems.length == 0) {
                    showToast(context, 'يجب عليك اختيار المواد');
                    return;
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeOwnerCreateOrderScreenThree(
                        widget.selectedLat,
                        widget.selectedLng,
                        widget.selectedAddressId,
                        selectedItems);
                  }));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  //Get DropDown items
  List<DropdownMenuItem<String>> getSpinnerData() {
    List<DropdownMenuItem<String>> data = [];
    data.add(DropdownMenuItem<String>(
      child: Text('اختر مادة'),
      value: 'اختر مادة',
    ));
    for (int i = 0; i < items.length; i++) {
      data.add(DropdownMenuItem<String>(
        child: Text(items[i].type),
        value: items[i].type,
      ));
    }
    return data;
  }

  //Pick image method
  void pickImage() async {
    PickedFile image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        final file = File(image.path);
        imageFile = file;
      });
      imagePath = image.path;
    } else {
      showToast(context, 'يجب عليك اختيار صورة اخرى');
    }
  }

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    getItems();
  }

  Future<void> getItems() async {
    _firestore
        .collection('ItemCode')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                setState(() {
                  items.add(ItemCodeObject.fromJson(doc.data()));
                });
              })
            });
  }

  String getItemName(String itemId) {
    print(itemId);
    String out = "";
    if (items.length > 0) {
      for (ItemCodeObject ito in items) {
        if (ito.id == itemId) {
          out = ito.type;
        }
      }
    }
    return out;
  }

  String getItemId(String name) {
    String out = "";
    if (items.length > 0) {
      for (ItemCodeObject ito in items) {
        if (ito.type == name) {
          out = ito.id;
        }
      }
    }
    return out;
  }
}
