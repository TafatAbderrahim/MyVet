// ignore_for_file: dead_code

//import 'dart:js_interop';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ArticleDetails extends StatefulWidget {
  late bool modify;
  late String photo, name, description;
  late int price;
  ArticleDetails(modify) {
    this.modify = modify;
  }
  ArticleDetails.overloadedContructor(
    modify,
    photo,
    name,
    description,
    price,
  ) {
    this.modify = modify;
    this.photo = photo;
    this.name = name;
    this.description = description;
    this.price = price;
  }

  State<ArticleDetails> createState() {
    if (modify == false) {
      return _ArticleDetailsState(modify);
    } else {
      return _ArticleDetailsState.overloadedContructor(
          modify, photo, name, description, price);
    }
  }
}

class _ArticleDetailsState extends State<ArticleDetails> {
  File? selectedImage;
  late TextEditingController quantiteController;
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  bool autoFocusDescription = false;
  bool autoFocusName = false;
  bool autoFocusPrice = false;
  Color addedColor = Colors.white;
  List<Color> colors = [
    Colors.black,
    Colors.white,
    Colors.brown,
    Colors.grey,
    Color.fromARGB(255, 255, 231, 160),
    Color.fromARGB(255, 0, 6, 104),
    Colors.blue,
    Colors.yellow,
    Colors.red,
    Color.fromARGB(255, 159, 11, 1),
    Colors.pink,
    Colors.lightGreenAccent,
    Colors.green,
    Color.fromARGB(255, 10, 86, 0),
  ];
  late List articleColors = [];
  List<String> sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL'];
  List<bool> sizeSelected = [false, false, false, false, false, false, false];
  late bool modify;
  late String photo, name, description;
  late int price;
  _ArticleDetailsState(modify) {
    this.modify = modify;
  }
  _ArticleDetailsState.overloadedContructor(
    modify,
    photo,
    name,
    description,
    price,
  ) {
    this.modify = modify;
    this.photo = photo;
    this.name = name;
    this.description = description;
    this.price = price;
  }
  @override
  void initState() {
    super.initState();
    if (modify == true) {
      nameController = new TextEditingController(text: name);
      descriptionController = new TextEditingController(text: description);
      priceController = new TextEditingController(text: price.toString());
    }
    quantiteController = new TextEditingController(text: 12.toString());
    nameController.addListener(() {
      return setState(() {});
    });
    descriptionController.addListener(() {
      return setState(() {});
    });
    priceController.addListener(() {
      return setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Text('Article details', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Container(
                      //t3 lphoto

                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromRGBO(220, 210, 204, 1),
                      ),
                      //t3photo:
                      child: Center(
                        child: modify
                            ? Stack(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    'assets/hoodie_product_2.jpg',
                                    height: 250,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  child: IconButton(
                                    color: Color.fromRGBO(109, 76, 61, 1),
                                    icon: Icon(
                                      Icons.create,
                                    ),
                                    onPressed: () {},
                                  ),
                                  bottom: 0.0,
                                  right: 0.0,
                                )
                              ])
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.add,
                                        size: 55,
                                      )),
                                  Text(
                                    'Add photo',
                                    style: TextStyle(fontSize: 22),
                                  )
                                ],
                              ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text('Description', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    fields(100, autoFocusDescription, 25, 255,
                        descriptionController, TextInputType.multiline),
                    SizedBox(height: 15),
                    Text('Name', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    fields(50, autoFocusName, 1, 33, nameController,
                        TextInputType.multiline),
                    SizedBox(height: 15),
                    Text('price', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    fields(50, autoFocusPrice, 1, 5, priceController,
                        TextInputType.number),
                    SizedBox(height: 15),

                    Text('Sizes', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(180)),
                      height: 40,
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: sizes.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 9,
                          ),
                          itemBuilder: (BuildContext context, item) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  sizeSelected[item] = !sizeSelected[item];
                                });
                              },
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    color: sizeSelected[item]
                                        ? Color.fromRGBO(109, 76, 61, 1)
                                        : Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white)),
                                child: Center(
                                    child: Text(sizes[item],
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: sizeSelected[item]
                                                ? Colors.white
                                                : Colors.black))),
                              ),
                            );
                          }),
                    ),

                    Row(
                      children: [
                        Text('Colors ', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    Text(
                      '(press on the color to delete it or adjust )',
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(height: 10),
                    //t3 colors
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(180)),
                          width: MediaQuery.of(context).size.width / 1.422,
                          height: 40,
                          child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: articleColors.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (BuildContext context, item) {
                                return GestureDetector(
                                  onTap: () {
                                    print('taped color');
                                    showDialog(
                                        context: context,
                                        builder: (C) {
                                          return SimpleDialog(
                                            title: Text(
                                              'Adjust quantite:',
                                              style: TextStyle(fontSize: 23),
                                            ),
                                            children: [
                                              Container(
                                                width: 300,
                                                child: GridView.builder(
                                                  itemCount: 7,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            (MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width) /
                                                            0.7,
                                                    crossAxisSpacing: 10,
                                                    mainAxisSpacing: 15,
                                                    crossAxisCount: 2,
                                                  ),
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          index) {
                                                    return Container(
                                                      height: 50,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            220, 210, 204, 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Center(
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          maxLines: 1,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .done,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                sizes[index],
                                                            counter: Offstage(),
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          articleColors
                                                              .removeAt(item);
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          Text('Delete color')),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text(
                                                          'Validate quantite')),
                                                ],
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black),
                                      color: articleColors[item],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Container(
                          width: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(220, 210, 204, 1),
                          ),
                          child: Center(
                            child: IconButton(
                              iconSize: 27,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (c) {
                                    return SimpleDialog(
                                      title: Text('Color '),
                                      children: [
                                        BlockPicker(
                                            availableColors: colors,
                                            pickerColor: addedColor,
                                            onColorChanged: (color) {
                                              setState(() {
                                                if (!articleColors
                                                    .contains(color)) {
                                                  articleColors.add(color);
                                                }
                                                Navigator.of(context).pop();
                                              });
                                            })
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.add),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      //boutton t3 save
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade800,
                              spreadRadius: 0.2,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            )
                          ],
                          color: Color.fromRGBO(109, 76, 61, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Save',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20)
                  ],
                ),
              ),
            ),
            Padding(
              //boutton retour
              padding: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back,
                  color: Color.fromRGBO(109, 76, 61, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fields(double height, bool autofocus, int maxlines, int maxlength,
      TextEditingController controller, TextInputType inputType) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(220, 210, 204, 1),
        borderRadius: BorderRadius.circular(15),
      ),
      height: height,
      child: Center(
        child: TextField(
          keyboardType: inputType,
          controller: controller,
          autofocus: autofocus,
          maxLength: maxlength,
          maxLines: maxlines,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            counter: Offstage(),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.create),
              onPressed: () {
                setState(() {
                  autofocus = true;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Future pickImageGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(returnedImage!.path);
    });
  }

  Future pickImageCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) {
      return;
    }
    setState(() {
      selectedImage = File(returnedImage!.path);
    });
  }
}
