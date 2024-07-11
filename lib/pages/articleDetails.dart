import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';
import 'package:project/models/product.dart';
import 'package:project/models/user.dart';
import 'package:project/resources.dart';

// ignore: must_be_immutable
class ArticleDetails extends StatefulWidget {
  String id = '';
  bool modify;
  ArticleDetails(
    this.modify,
  ) {
    this.modify = modify;
  }
  ArticleDetails.overloadedContructor(this.modify, this.id);

  State<ArticleDetails> createState() {
    if (modify == false) {
      return _ArticleDetailsState(modify);
    } else {
      return _ArticleDetailsState.overloadedContructor(modify);
    }
  }

  Product product = Product(
    id: '',
    name: '',
    pic: [],
    price: 0,
    category: '',
    gender: '',
    age: '',
    sellerid: '',
    releaseDate: DateTime.now(),
    colors: [],
    comments: [],
    rating: 0,
    promotion: 0,
  );
}

class _ArticleDetailsState extends State<ArticleDetails> {
  File? selectedImage;

  late TextEditingController quantiteController;
  var nameController = TextEditingController(text: '');
  var descriptionController = TextEditingController(text: '');
  var priceController = TextEditingController(text: '0');
  var promotionController = TextEditingController(text: '0');

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
  String valGender = 'Male';
  String valAge = 'Adult';
  static String valCategory = 'Shoe';
  bool modify;
  late List articleColors = [];
  static bool isShoe = (valCategory == 'Shoe');
  late List<dynamic> sizes;
  _ArticleDetailsState(this.modify);

  _ArticleDetailsState.overloadedContructor(
    this.modify,
  );
  @override
  void initState() {
    super.initState();
    //int init = 0;
    if (modify == true) {
      nameController = new TextEditingController(text: widget.product.name);
      // descriptionController = new TextEditingController(text:widget.product.description);
      priceController =
          new TextEditingController(text: widget.product.price.toString());

      promotionController =
          new TextEditingController(text: widget.product.promotion.toString());
    }
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

  Future getProduct() async {
    var response;
    var data, donnees;
    var uri = Uri.parse('${Resources.Url}/product/${widget.id}');
    print(uri);
    try {
      response = await get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "jwt": context.read<User>().cookie
        },
      );
      data = response.body;
      donnees = json.decode(data);
      print('donnes=${donnees}');
      donnees = donnees['result'];
      return donnees;
    } catch (e) {
      print('error= $e');
    }
  }

  TextEditingController sController = TextEditingController(text: '0');
  TextEditingController mController = TextEditingController(text: '0');
  TextEditingController lController = TextEditingController(text: '0');
  TextEditingController xlController = TextEditingController(text: '0');
  TextEditingController xxlController = TextEditingController(text: '0');
  TextEditingController Controller43 = TextEditingController(text: '0');
  TextEditingController Controller44 = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    int activeindex = 0;
    !isShoe == true
        ? sizes = ['S', 'M', 'L', 'XL', 'XXL']
        : valAge == 'Adult'
            ? sizes = [38, 39, 40, 41, 42, 43, 44]
            : sizes = [30, 31, 32, 33, 34, 35, 36];
    return Scaffold(
      body: !modify
          ? Padding(
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
                          Text('Article details',
                              style: TextStyle(fontSize: 20)),
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
                                      CarouselSlider.builder(
                                        // carouselController: CarouselController(),
                                        itemCount: widget.product.pic.length,
                                        itemBuilder:
                                            (context, index, realIndex) {
                                          return Image.network(
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(
                                                    'assets/whit_logo_Mesa de trabajo 1 1.png',
                                                    height: 300,
                                                  ),
                                              loadingBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(
                                                    'assets/whit_logo_Mesa de trabajo 1 1.png',
                                                    height: 300,
                                                  ),
                                              alignment: Alignment.center,
                                              widget.product.pic[index],
                                              height: 300,
                                              fit: BoxFit.fitHeight);
                                        },
                                        options: CarouselOptions(
                                          height: 300,
                                          enableInfiniteScroll: false,
                                          animateToClosest: false,
                                          onPageChanged: (index, reason) =>
                                              setState(() {
                                            activeindex = index;
                                          }),
                                        ),
                                      ),
                                      Positioned(
                                        child: IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (C) {
                                                  return SimpleDialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    contentPadding:
                                                        EdgeInsets.all(12),
                                                    title: Text(
                                                      'Add photo',
                                                    ),
                                                    children: [
                                                      ElevatedButton(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStatePropertyAll(
                                                                      Color.fromRGBO(
                                                                          217,
                                                                          217,
                                                                          217,
                                                                          1))),
                                                          onPressed: () async {
                                                            widget.product.pic.add(
                                                                await pickImageCamera());
                                                          },
                                                          child: Text(
                                                            'Camera',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        109,
                                                                        76,
                                                                        61,
                                                                        1)),
                                                          )),
                                                      SizedBox(height: 10),
                                                      ElevatedButton(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStatePropertyAll(
                                                                      Color.fromRGBO(
                                                                          217,
                                                                          217,
                                                                          217,
                                                                          1))),
                                                          onPressed: () {
                                                            widget.product.pic
                                                                .removeAt(
                                                                    activeindex);
                                                          },
                                                          child: Text(
                                                            'Delete',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        109,
                                                                        76,
                                                                        61,
                                                                        1)),
                                                          )),
                                                      SizedBox(height: 10),
                                                      ElevatedButton(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStatePropertyAll(
                                                                      Color.fromRGBO(
                                                                          109,
                                                                          76,
                                                                          61,
                                                                          1))),
                                                          onPressed: () async {
                                                            widget.product.pic.add(
                                                                await pickImageGallery());
                                                          },
                                                          child: Text(
                                                            'Gallery',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        217,
                                                                        217,
                                                                        217,
                                                                        1)),
                                                          ))
                                                    ],
                                                  );
                                                });
                                            ;
                                          },
                                        ),
                                        bottom: 0.0,
                                        right: 0.0,
                                      )
                                    ])
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                          Text('Promotion(%)', style: TextStyle(fontSize: 18)),
                          SizedBox(height: 10),
                          fields(50, autoFocusPrice, 1, 5, promotionController,
                              TextInputType.number),
                          SizedBox(height: 15),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Shoe',
                                style: TextStyle(
                                  color: Color.fromRGBO(109, 76, 61, 1),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          //t3 colors
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(180)),
                                width:
                                    MediaQuery.of(context).size.width / 1.422,
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
                                          if (widget.modify) {
                                            sController = TextEditingController(
                                                text: widget
                                                    .product
                                                    .colors[item]
                                                    .sizes[0]
                                                    .inStock
                                                    .toString());
                                            mController = TextEditingController(
                                                text: widget
                                                    .product
                                                    .colors[item]
                                                    .sizes[1]
                                                    .inStock
                                                    .toString());
                                            lController = TextEditingController(
                                                text: widget
                                                    .product
                                                    .colors[item]
                                                    .sizes[2]
                                                    .inStock
                                                    .toString());
                                            xlController =
                                                TextEditingController(
                                                    text: widget
                                                        .product
                                                        .colors[item]
                                                        .sizes[3]
                                                        .inStock
                                                        .toString());
                                            xxlController =
                                                TextEditingController(
                                                    text: widget
                                                        .product
                                                        .colors[item]
                                                        .sizes[4]
                                                        .inStock
                                                        .toString());
                                          }
                                          print('taped color + $isShoe');
                                          showDialog(
                                              context: context,
                                              builder: (C) {
                                                return SimpleDialog(
                                                  title: Text(
                                                    'Adjust quantite:',
                                                    style:
                                                        TextStyle(fontSize: 23),
                                                  ),
                                                  children: [
                                                    Container(
                                                      width: 300,
                                                      child: GridView.builder(
                                                        itemCount: sizes.length,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                          childAspectRatio:
                                                              MediaQuery.of(
                                                                          context)
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
                                                            (BuildContext
                                                                    context,
                                                                index) {
                                                          List Quantite = [
                                                            sController,
                                                            mController,
                                                            lController,
                                                            xlController,
                                                            xxlController,
                                                          ];
                                                          if (isShoe) {
                                                            Quantite.add(
                                                                Controller43);
                                                            Quantite.add(
                                                                Controller44);
                                                          }
                                                          return Container(
                                                            height: 50,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      220,
                                                                      210,
                                                                      204,
                                                                      1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            child: Center(
                                                              child: TextField(
                                                                controller:
                                                                    Quantite[
                                                                        index],
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                maxLines: 1,
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .done,
                                                                decoration:
                                                                    InputDecoration(
                                                                  suffixText: sizes[
                                                                          index]
                                                                      .toString(),
                                                                  counter:
                                                                      Offstage(),
                                                                  border:
                                                                      InputBorder
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
                                                              widget.product
                                                                  .colors
                                                                  .removeAt(
                                                                      item);
                                                              setState(() {
                                                                articleColors
                                                                    .removeAt(
                                                                        item);
                                                              });
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                                'Delete color')),
                                                        TextButton(
                                                            onPressed: () {
                                                              List Quantite = [
                                                                sController,
                                                                mController,
                                                                lController,
                                                                xlController,
                                                                xxlController,
                                                              ];
                                                              if (isShoe) {
                                                                Quantite.add(
                                                                    Controller43);
                                                                Quantite.add(
                                                                    Controller44);
                                                              }
                                                              for (int i = 0;
                                                                  i <
                                                                      sizes
                                                                          .length;
                                                                  i++) {
                                                                SizeSchema size = !isShoe
                                                                    ? SizeSchema(
                                                                        value: sizes[
                                                                            i],
                                                                        shoeSize:
                                                                            0,
                                                                        inStock:
                                                                            int.parse(Quantite[i]
                                                                                .text))
                                                                    : SizeSchema(
                                                                        value:
                                                                            '',
                                                                        shoeSize:
                                                                            sizes[
                                                                                i],
                                                                        inStock:
                                                                            int.parse(Quantite[i].text));
                                                                widget
                                                                    .product
                                                                    .colors[
                                                                        item]
                                                                    .sizes
                                                                    .add(size);
                                                              }
                                                              Navigator.of(
                                                                      context)
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
                                            border:
                                                Border.all(color: Colors.black),
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
                                                    ColorSchema newColor =
                                                        new ColorSchema(
                                                            color: color.hex,
                                                            sizes: []);
                                                    widget.product.colors
                                                        .add(newColor);
                                                    setState(() {
                                                      if (!articleColors
                                                          .contains(color)) {
                                                        articleColors
                                                            .add(color);
                                                      }

                                                      Navigator.of(context)
                                                          .pop();
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
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: DropdownButton<String>(
                                          underline: Divider(
                                            thickness: 0,
                                            color: Colors.transparent,
                                          ),
                                          hint: Text('Gender'),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          iconDisabledColor: Colors.grey,
                                          value: valGender,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              valGender = newValue!;
                                            });
                                          },
                                          items: <String>[
                                            'Male',
                                            'Female',
                                            'Unisex',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            // Widget icon;
                                            // if (value == 'Men') {
                                            //   icon = const Icon(Icons.person);
                                            // } else if (value == 'Women') {
                                            //   icon = SvgPicture.asset(
                                            //     'assets/svgs/women.svg',
                                            //     width: 15,
                                            //     height: 15,
                                            //   );
                                            // } else {
                                            //   icon = const Icon(Icons.child_care);
                                            // }
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    value,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: DropdownButton<String>(
                                          iconDisabledColor: Colors.grey,
                                          itemHeight: 50,
                                          underline: Divider(
                                            thickness: 0,
                                            color: Colors.transparent,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          hint: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10),
                                              child: const Text('Category')),
                                          value: valCategory,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              valCategory = newValue!;
                                              if (valCategory == 'Shoe') {
                                                isShoe == true;
                                              }
                                            });
                                          },
                                          items: <String>[
                                            "Shoe",
                                            "Pants",
                                            "Hoodie",
                                            "TShirt",
                                            "Jacket",
                                            "Sweater",
                                            "Shorts",
                                            "Skirt",
                                            "Dress",
                                            "Hidjeb",
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: DropdownButton<String>(
                                          iconDisabledColor: Colors.grey,
                                          itemHeight: 50,
                                          underline: Divider(
                                            thickness: 0,
                                            color: Colors.transparent,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          hint: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10),
                                              child: const Text('Age')),
                                          value: valAge,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              valAge = newValue!;
                                            });
                                          },
                                          items: <String>[
                                            'Kid',
                                            'Adult',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                                onPressed: () async {
                                  var box = Hive.box('user');
                                  var id = box.get('id');
                                  widget.product.name = nameController.text;
                                  widget.product.price =
                                      int.parse(priceController.text);
                                  widget.product.promotion =
                                      int.parse(promotionController.text) * 100;
                                  widget.product.comments = [];
                                  widget.product.rating = 0;
                                  widget.product.category = valCategory;
                                  widget.product.gender = valGender;
                                  widget.product.age = valAge;
                                  widget.product.sellerid = id;
                                  widget.product.releaseDate = DateTime.now();

                                  try {
                                    List list = [];
                                    String listJson;
                                    for (var v = 0;
                                        v < widget.product.colors.length;
                                        v++) {
                                      print(
                                          'colors=${widget.product.colors[v].toJson()}');
                                      list.add(
                                          widget.product.colors[v].toJson());
                                    }
                                    listJson = jsonEncode(list);
                                    print('list=${list}');
                                    print('list json=${listJson}');

                                    if (modify == true) {
                                      var uri = Uri.parse(
                                          '${Resources.Url}/product/${widget.id}');
                                      var response = await put(uri,
                                          headers: {
                                            'jwt': box.get('cookie'),
                                          },
                                          body: ({
                                            'name': nameController.text,
                                            'pic': 'picture',
                                            'price': (priceController.text),
                                            'category': valCategory,
                                            'colors': list,
                                            'gender': valGender,
                                            'age': valAge,
                                            'description':
                                                descriptionController.text,
                                          }));
                                      print(
                                          'response1=${json.decode(response.body)}');
                                    } else {
                                      var uri = Uri.parse(
                                          '${Resources.Url}/${box.get('id')}');
                                      var response = await post(uri,
                                          headers: {
                                            'jwt': box.get('cookie'),
                                            'Content-Type': 'application/json',
                                          },
                                          body: json.encode({
                                            'name': nameController.text,
                                            'pic': 'picture',
                                            'price': (priceController.text),
                                            'category': valCategory,
                                            'colors': list,
                                            'gender': valGender,
                                            'age': valAge,
                                            'description':
                                                descriptionController.text,
                                          }));
                                      print(
                                          'response2=${json.decode(response.body)}');
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
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
            )
          : FutureBuilder(
              future: getProduct(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(84, 69, 64, 1),
                    ),
                  );
                } else if (snapshot.data.length == 0) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/file-search-icon.svg',
                          width: 140,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'No results found     ',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const Text(
                          "We couldn't find what you are looking for",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                {
                  print(snapshot.data);
                  var colorssss = snapshot.data['colors'];
                  nameController =
                      TextEditingController(text: snapshot.data['name']);
                  // descriptionController = TextEditingController(text: snapshot.data['description']);
                  priceController = TextEditingController(
                      text: snapshot.data['price'].toString());
                  promotionController = TextEditingController(
                      text: snapshot.data['promotion'].toString());

                  if (snapshot.data['category'] == 'Shoe') {
                    isShoe = true;
                  }
                  for (int i = 0; i < snapshot.data['colors'].length; i++) {
                    articleColors.add(
                        colorFromHex((snapshot.data['colors'][i]['color'])));
                    //print((snapshot.data['colors'][i]['color']));
                  }

                  valCategory = snapshot.data['category'];
                  valGender = snapshot.data['gender'];
                  valAge = snapshot.data['age'];

                  return Padding(
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
                                Text('Article details',
                                    style: TextStyle(fontSize: 20)),
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
                                            CarouselSlider.builder(
                                              // carouselController: CarouselController(),
                                              itemCount:
                                                  widget.product.pic.length,
                                              itemBuilder:
                                                  (context, index, realIndex) {
                                                return Image.network(
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Image.asset(
                                                          'assets/whit_logo_Mesa de trabajo 1 1.png',
                                                          height: 300,
                                                        ),
                                                    loadingBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Image.asset(
                                                          'assets/whit_logo_Mesa de trabajo 1 1.png',
                                                          height: 300,
                                                        ),
                                                    alignment: Alignment.center,
                                                    widget.product.pic[index],
                                                    height: 300,
                                                    fit: BoxFit.fitHeight);
                                              },
                                              options: CarouselOptions(
                                                height: 300,
                                                enableInfiniteScroll: false,
                                                animateToClosest: false,
                                                onPageChanged:
                                                    (index, reason) =>
                                                        setState(() {
                                                  activeindex = index;
                                                }),
                                              ),
                                            ),
                                            Positioned(
                                              child: IconButton(
                                                icon: Icon(Icons.edit),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (C) {
                                                        return SimpleDialog(
                                                          backgroundColor:
                                                              Colors.white,
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  12),
                                                          title: Text(
                                                            'Add photo',
                                                          ),
                                                          children: [
                                                            ElevatedButton(
                                                                style: ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStatePropertyAll(Color.fromRGBO(
                                                                            217,
                                                                            217,
                                                                            217,
                                                                            1))),
                                                                onPressed:
                                                                    () async {
                                                                  widget.product
                                                                      .pic
                                                                      .add(
                                                                          await pickImageCamera());
                                                                },
                                                                child: Text(
                                                                  'Camera',
                                                                  style: TextStyle(
                                                                      color: Color.fromRGBO(
                                                                          109,
                                                                          76,
                                                                          61,
                                                                          1)),
                                                                )),
                                                            SizedBox(
                                                                height: 10),
                                                            ElevatedButton(
                                                                style: ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStatePropertyAll(Color.fromRGBO(
                                                                            217,
                                                                            217,
                                                                            217,
                                                                            1))),
                                                                onPressed: () {
                                                                  widget.product
                                                                      .pic
                                                                      .removeAt(
                                                                          activeindex);
                                                                },
                                                                child: Text(
                                                                  'Delete',
                                                                  style: TextStyle(
                                                                      color: Color.fromRGBO(
                                                                          109,
                                                                          76,
                                                                          61,
                                                                          1)),
                                                                )),
                                                            SizedBox(
                                                                height: 10),
                                                            ElevatedButton(
                                                                style: ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStatePropertyAll(Color.fromRGBO(
                                                                            109,
                                                                            76,
                                                                            61,
                                                                            1))),
                                                                onPressed:
                                                                    () async {
                                                                  widget.product
                                                                      .pic
                                                                      .add(
                                                                          await pickImageGallery());
                                                                },
                                                                child: Text(
                                                                  'Gallery',
                                                                  style: TextStyle(
                                                                      color: Color.fromRGBO(
                                                                          217,
                                                                          217,
                                                                          217,
                                                                          1)),
                                                                ))
                                                          ],
                                                        );
                                                      });
                                                  ;
                                                },
                                              ),
                                              bottom: 0.0,
                                              right: 0.0,
                                            )
                                          ])
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                Text('Description',
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(height: 10),
                                fields(
                                    100,
                                    autoFocusDescription,
                                    25,
                                    255,
                                    descriptionController,
                                    TextInputType.multiline),
                                SizedBox(height: 15),
                                Text('Name', style: TextStyle(fontSize: 18)),
                                SizedBox(height: 10),
                                fields(50, autoFocusName, 1, 33, nameController,
                                    TextInputType.multiline),
                                SizedBox(height: 15),
                                Text('price', style: TextStyle(fontSize: 18)),
                                SizedBox(height: 10),
                                fields(50, autoFocusPrice, 1, 5,
                                    priceController, TextInputType.number),
                                SizedBox(height: 15),
                                Text('Promotion(%)',
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(height: 10),
                                fields(50, autoFocusPrice, 1, 5,
                                    promotionController, TextInputType.number),
                                SizedBox(height: 15),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      side: BorderSide.none,
                                      fillColor: MaterialStatePropertyAll(
                                          Color.fromRGBO(220, 210, 204, 1)),
                                      checkColor:
                                          Color.fromRGBO(109, 76, 61, 1),
                                      value: isShoe,
                                      onChanged: (value) {
                                        setState(() {
                                          isShoe = !isShoe;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Shoe',
                                      style: TextStyle(
                                        color: Color.fromRGBO(109, 76, 61, 1),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                //t3 colors
                                Row(
                                  children: [
                                    Text('Colors ',
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                                Text(
                                  '(press on the color to delete it or adjust )',
                                  style: TextStyle(fontSize: 13),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(180)),
                                      width: MediaQuery.of(context).size.width /
                                          1.422,
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
                                          itemBuilder:
                                              (BuildContext context, item) {
                                            return GestureDetector(
                                              onTap: () {
                                                if (widget.modify &&
                                                    !snapshot
                                                        .data['colors'][item]
                                                            ['sizes']
                                                        .isEmpty) {
                                                  sController =
                                                      TextEditingController(
                                                          text: snapshot
                                                              .data['colors']
                                                                  [item]
                                                                  ['sizes'][0]
                                                                  ['inStock']
                                                              .toString()
                                                          // widget
                                                          //     .product
                                                          //     .colors[item]
                                                          //     .sizes[0]
                                                          //     .inStock
                                                          //     .toString(),
                                                          );
                                                  mController = snapshot
                                                              .data['colors']
                                                                  [item]
                                                                  ['sizes']
                                                              .length >
                                                          1
                                                      ? TextEditingController(
                                                          text: snapshot
                                                              .data['colors']
                                                                  [item]
                                                                  ['sizes'][1]
                                                                  ['inStock']
                                                              .toString())
                                                      : TextEditingController(
                                                          text: '0');
                                                  lController = snapshot
                                                              .data['colors']
                                                                  [item]
                                                                  ['sizes']
                                                              .length >
                                                          2
                                                      ? TextEditingController(
                                                          text: snapshot
                                                              .data['colors']
                                                                  [item]
                                                                  ['sizes'][2]
                                                                  ['inStock']
                                                              .toString())
                                                      : TextEditingController(
                                                          text: '0');
                                                  xlController = snapshot
                                                              .data['colors']
                                                                  [item]
                                                                  ['sizes']
                                                              .length >
                                                          3
                                                      ? TextEditingController(
                                                          text: snapshot
                                                              .data['colors']
                                                                  [item]
                                                                  ['sizes'][3]
                                                                  ['inStock']
                                                              .toString())
                                                      : TextEditingController(
                                                          text: '0');
                                                  xxlController = snapshot
                                                              .data['colors']
                                                                  [item]
                                                                  ['sizes']
                                                              .length >
                                                          4
                                                      ? TextEditingController(
                                                          text: snapshot
                                                              .data['colors']
                                                                  [item]
                                                                  ['sizes'][4]
                                                                  ['inStock']
                                                              .toString())
                                                      : TextEditingController(
                                                          text: '0');
                                                }
                                                print('taped color+  $isShoe');
                                                showDialog(
                                                    context: context,
                                                    builder: (C) {
                                                      return SimpleDialog(
                                                        title: Text(
                                                          'Adjust quantite:',
                                                          style: TextStyle(
                                                              fontSize: 23),
                                                        ),
                                                        children: [
                                                          Container(
                                                            width: 300,
                                                            child: GridView
                                                                .builder(
                                                              itemCount:
                                                                  sizes.length,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              gridDelegate:
                                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                                childAspectRatio: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width) /
                                                                    0.7,
                                                                crossAxisSpacing:
                                                                    10,
                                                                mainAxisSpacing:
                                                                    15,
                                                                crossAxisCount:
                                                                    2,
                                                              ),
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      index) {
                                                                List Quantite =
                                                                    [
                                                                  sController,
                                                                  mController,
                                                                  lController,
                                                                  xlController,
                                                                  xxlController,
                                                                ];
                                                                if (isShoe) {
                                                                  Quantite.add(
                                                                      Controller43);
                                                                  Quantite.add(
                                                                      Controller44);
                                                                }
                                                                return Container(
                                                                  height: 50,
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            220,
                                                                            210,
                                                                            204,
                                                                            1),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                  ),
                                                                  child: Center(
                                                                    child:
                                                                        TextField(
                                                                      controller:
                                                                          Quantite[
                                                                              index],
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      maxLines:
                                                                          1,
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .done,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        suffixText:
                                                                            sizes[index].toString(),
                                                                        counter:
                                                                            Offstage(),
                                                                        border:
                                                                            InputBorder.none,
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
                                                                  onPressed:
                                                                      () {
                                                                    widget
                                                                        .product
                                                                        .colors
                                                                        .removeAt(
                                                                            item);
                                                                    setState(
                                                                        () {
                                                                      articleColors
                                                                          .removeAt(
                                                                              item);
                                                                    });
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      'Delete color')),
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    List
                                                                        Quantite =
                                                                        [
                                                                      sController,
                                                                      mController,
                                                                      lController,
                                                                      xlController,
                                                                      xxlController,
                                                                    ];
                                                                    if (isShoe) {
                                                                      Quantite.add(
                                                                          Controller43);
                                                                      Quantite.add(
                                                                          Controller44);
                                                                    }
                                                                    for (int i =
                                                                            0;
                                                                        i < sizes.length;
                                                                        i++) {
                                                                      SizeSchema size = !isShoe
                                                                          ? SizeSchema(
                                                                              value: sizes[
                                                                                  i],
                                                                              shoeSize:
                                                                                  0,
                                                                              inStock: int.parse(Quantite[i]
                                                                                  .text))
                                                                          : SizeSchema(
                                                                              value: '',
                                                                              shoeSize: sizes[i],
                                                                              inStock: int.parse(Quantite[i].text));
                                                                      colorssss.add(
                                                                          size);
                                                                    }
                                                                    Navigator.of(
                                                                            context)
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
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  color: colorFromHex(
                                                      snapshot.data['colors']
                                                          [item]['color']),
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
                                                        onColorChanged:
                                                            (color) {
                                                          ColorSchema newColor =
                                                              new ColorSchema(
                                                                  color:
                                                                      color.hex,
                                                                  sizes: []);
                                                          widget.product.colors
                                                              .add(newColor);
                                                          setState(() {
                                                            if (!articleColors
                                                                .contains(
                                                                    color)) {
                                                              articleColors
                                                                  .add(color);
                                                            }

                                                            Navigator.of(
                                                                    context)
                                                                .pop();
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
                                Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Colors.black),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: DropdownButton<String>(
                                                underline: Divider(
                                                  thickness: 0,
                                                  color: Colors.transparent,
                                                ),
                                                hint: Text('Gender'),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                iconDisabledColor: Colors.grey,
                                                value: valGender,
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    valGender = newValue!;
                                                  });
                                                },
                                                items: <String>[
                                                  'Male',
                                                  'Female',
                                                  'Unisex',
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  // Widget icon;
                                                  // if (value == 'Men') {
                                                  //   icon = const Icon(Icons.person);
                                                  // } else if (value == 'Women') {
                                                  //   icon = SvgPicture.asset(
                                                  //     'assets/svgs/women.svg',
                                                  //     width: 15,
                                                  //     height: 15,
                                                  //   );
                                                  // } else {
                                                  //   icon = const Icon(Icons.child_care);
                                                  // }
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          value,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Colors.black),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: DropdownButton<String>(
                                                iconDisabledColor: Colors.grey,
                                                itemHeight: 50,
                                                underline: Divider(
                                                  thickness: 0,
                                                  color: Colors.transparent,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                hint: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: const Text('Age')),
                                                value: valAge,
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    valAge = newValue!;
                                                  });
                                                },
                                                items: <String>[
                                                  'Kid',
                                                  'Adult',
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Colors.black),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: DropdownButton<String>(
                                                iconDisabledColor: Colors.grey,
                                                itemHeight: 50,
                                                underline: Divider(
                                                  thickness: 0,
                                                  color: Colors.transparent,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                hint: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child:
                                                        const Text('Category')),
                                                value: valCategory,
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    valCategory = newValue!;
                                                  });
                                                },
                                                items: <String>[
                                                  "Shoe",
                                                  "Pants",
                                                  "Hoodie",
                                                  "TShirt",
                                                  "Jacket",
                                                  "Sweater",
                                                  "Shorts",
                                                  "Skirt",
                                                  "Dress",
                                                  "Hidjeb",
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
                                      onPressed: () async {
                                        var box = Hive.box('user');
                                        var id = box.get('id');
                                        widget.product.name =
                                            nameController.text;
                                        widget.product.price =
                                            int.parse(priceController.text);
                                        widget.product.promotion =
                                            int.parse(promotionController.text);
                                        widget.product.comments = [];
                                        widget.product.rating = 0;
                                        widget.product.category = valCategory;
                                        widget.product.gender = valGender;
                                        widget.product.age = valAge;
                                        widget.product.sellerid = id;
                                        widget.product.releaseDate =
                                            DateTime.now();
                                        var colorat = widget.product.colors;
                                        var colorss = [];
                                        colorat.forEach((element) {
                                          var jsonn = element.toJson();
                                          colorss.add(jsonn);
                                        });
                                        try {
                                          if (modify == true) {
                                            var uri = Uri.parse(
                                                '${Resources.Url}/product/${widget.id}');
                                            var response =
                                                await put(uri, headers: {
                                              'jwt': box.get('cookie'),
                                            }, body: {
                                              'name': nameController.text,
                                              'pic':
                                                  'https://storage.googleapis.com/kagglesdsdata/datasets/139630/329006/fashion-dataset/images/10028.jpg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=databundle-worker-v2%40kaggle-161607.iam.gserviceaccount.com%2F20240603%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20240603T163607Z&X-Goog-Expires=345600&X-Goog-SignedHeaders=host&X-Goog-Signature=93dd8f0d4d270a23f85f7da27920f28eb7b48f3bee0e8943f73762190c9daa34f0a5ec57b99f1f4dfc535c9503f17092bda3af98fb4d4c45e4839a9a87918d7266e6f721ca0a9a91985010b4f96de9e1afac1ca0052c194900e9bdcfded611c0c9dd9af9c868ce48fc3499596ca13ffc5b7917a7f72d70032e80674b24893b74284fa29fc51c63d683f0cf2aa5a7f758fffe5f0ab1883e2ce11a348ee412644ffce6aedab6a042b959473efec650ab30cc8ee8c7e7966443c75da31512ac1410c0763f36e67ffa8acf22571e538d34dc239e1149aca4e887b08c00ce9352c61cfb0791ad96e8c69425560e37857b348ba2d086d4a61aef8b86dd0d48b138011f',
                                              'price': (priceController.text),
                                              'category': valCategory,
                                              'colors': colorss,
                                              'gender': valGender,
                                              'age': valAge,
                                              'description':
                                                  descriptionController.text,
                                            });
                                            print(json.decode(
                                                response.body)['message']);
                                          } else {
                                            var uri = Uri.parse(
                                                '${Resources.Url}/product/${box.get('id')}');
                                            var response =
                                                await post(uri, headers: {
                                              'jwt': box.get('cookie'),
                                            }, body: {
                                              'name': nameController.text,
                                              'pic':
                                                  'https://storage.googleapis.com/kagglesdsdata/datasets/139630/329006/fashion-dataset/images/10028.jpg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=databundle-worker-v2%40kaggle-161607.iam.gserviceaccount.com%2F20240603%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20240603T163607Z&X-Goog-Expires=345600&X-Goog-SignedHeaders=host&X-Goog-Signature=93dd8f0d4d270a23f85f7da27920f28eb7b48f3bee0e8943f73762190c9daa34f0a5ec57b99f1f4dfc535c9503f17092bda3af98fb4d4c45e4839a9a87918d7266e6f721ca0a9a91985010b4f96de9e1afac1ca0052c194900e9bdcfded611c0c9dd9af9c868ce48fc3499596ca13ffc5b7917a7f72d70032e80674b24893b74284fa29fc51c63d683f0cf2aa5a7f758fffe5f0ab1883e2ce11a348ee412644ffce6aedab6a042b959473efec650ab30cc8ee8c7e7966443c75da31512ac1410c0763f36e67ffa8acf22571e538d34dc239e1149aca4e887b08c00ce9352c61cfb0791ad96e8c69425560e37857b348ba2d086d4a61aef8b86dd0d48b138011f',
                                              'price': (priceController.text),
                                              'category': valCategory,
                                              'colors': colorss,
                                              'gender': valGender,
                                              'age': valAge,
                                              'description':
                                                  descriptionController.text,
                                            });
                                            print(json.decode(response.body));
                                          }
                                        } catch (e) {
                                          print('error:${e}');
                                        }
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.white),
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
                  );
                }
              }),
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
