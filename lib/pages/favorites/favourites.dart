import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:project/models/product.dart';
import 'package:project/pages/article/colorwithsize.dart';
import 'package:project/pages/article/item.dart';
import 'package:project/pages/favorites/splashscreen.dart';
import 'package:project/pages/pallette.dart';
import 'package:http/http.dart';
import 'package:project/resources.dart';

class Myfavourites extends StatefulWidget {
  Myfavourites(this.isCart);
  bool isCart;
  @override
  State<Myfavourites> createState() => _MyfavouritesState(isCart);
}

class _MyfavouritesState extends State<Myfavourites> {
  //====declaration===========================
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phonenumber = TextEditingController();

  List<String> name = [
    'Vintage Tote Vintage Tote Vintage Tote Vintage Tote',
    'City Satchel',
    'Explorer Duffel',
    'Classic Briefcase',
    'Vintage Tote',
    'City Satchel',
    'Explorer Duffel',
    'Classic Briefcase',
  ];
  List<double> price = [1000, 2000, 3000, 4000, 1000, 2000, 3000, 4000];
  List<String> images = [
    'assets/hd.jpeg',
    'assets/photo.png',
    'assets/ph3.png',
    'assets/Hd.png',
    'assets/hd.jpeg',
    'assets/photo.png',
    'assets/ph3.png',
    'assets/Hd.png'
  ];
  List<ColorData> colorsWithBooleans = [
    ColorData(Colors.red,
        boolValue1: true,
        boolValue2: false,
        boolValue3: true,
        boolValue4: false,
        boolValue5: true,
        boolValue6: false),
    ColorData(Colors.grey,
        boolValue1: false,
        boolValue2: false,
        boolValue3: false,
        boolValue4: false,
        boolValue5: false,
        boolValue6: false),
    ColorData(Colors.green,
        boolValue1: true,
        boolValue2: true,
        boolValue3: true,
        boolValue4: true,
        boolValue5: true,
        boolValue6: true),
    ColorData(Colors.yellow,
        boolValue1: false,
        boolValue2: true,
        boolValue3: false,
        boolValue4: true,
        boolValue5: false,
        boolValue6: true),
    ColorData(Colors.orange,
        boolValue1: true,
        boolValue2: false,
        boolValue3: true,
        boolValue4: false,
        boolValue5: true,
        boolValue6: false),
    ColorData(Colors.purple,
        boolValue1: false,
        boolValue2: true,
        boolValue3: false,
        boolValue4: true,
        boolValue5: false,
        boolValue6: true),
    ColorData(Colors.black,
        boolValue1: true,
        boolValue2: false,
        boolValue3: true,
        boolValue4: false,
        boolValue5: true,
        boolValue6: false),
    ColorData(Colors.black12,
        boolValue1: false,
        boolValue2: true,
        boolValue3: false,
        boolValue4: true,
        boolValue5: false,
        boolValue6: true),
    ColorData(Colors.black54,
        boolValue1: true,
        boolValue2: false,
        boolValue3: true,
        boolValue4: false,
        boolValue5: true,
        boolValue6: false),
    ColorData(Colors.blue,
        boolValue1: false,
        boolValue2: true,
        boolValue3: false,
        boolValue4: true,
        boolValue5: false,
        boolValue6: true),
    ColorData(Colors.pink,
        boolValue1: true,
        boolValue2: false,
        boolValue3: true,
        boolValue4: false,
        boolValue5: true,
        boolValue6: false),
  ];
  List<String> size = [
    'M',
    'L',
    'S',
    'M',
    'L',
    'S',
    'M',
    'M',
  ];
  var seller;
  bool isCart;
  var cookie;
  double total = 0;

  _MyfavouritesState(this.isCart);

  Future getData(bool isCartt) async {
    var router = 'favorites';
    widget.isCart ? router = 'Cart' : 'favorites';
    var uri = Uri.parse('${Resources.Url}/${router}');

    var response, data, donnees;
    try {
      response = await get(
        uri,
        headers: {
          "jwt": cookie,
          "Content-Type": "application/json",
        },
      );

      data = response.body;
      donnees = json.decode(data);
      print(donnees);
      print(donnees['Cart']);

      print(isCartt);
      if (isCartt == true) {
        total = 0;
        // for (int v = 0; v < data['Cart']; v++) {
        //   total += donnees['Cart'][v]['price'];
        // }
        donnees = donnees['Cart'];
        return donnees;
      } else if (isCartt==false) {
        return donnees['favorites'];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('user');
    cookie = box.get('cookie');
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: getData(isCart) != []
                ? fullfavocart()
                : isCart
                    ? emptycart()
                    : emptyfavourites(),
          ),
          if (!isCart)
            Positioned(
              top: 20,
              left: 20,
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
          if (isCart &&
              name.isNotEmpty &&
              price.isNotEmpty &&
              images.isNotEmpty)
            Positioned(
              right: 20,
              bottom: 70,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    // barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return AlertDialog(
                            clipBehavior: Clip.none,
                            backgroundColor: const Color(0xFFD9D9D9),
                            content: Confirmbuy(
                                total: total,
                                addressController: address,
                                phoneNumberController: phonenumber));
                      });
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.iconsvgcolor,
                  minimumSize: const Size(100, 50),
                ),
                child: Text(
                  'Buy',
                  style: TextStyle(color: Pallete.texticon),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget fullfavocart() {
    return Container(
      clipBehavior: Clip.none,
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(top: 30,bottom: 100),
        child: FutureBuilder(
          future: getData(isCart).timeout(Duration(seconds: 20)),
          builder: (context, snapshot) {
            print('snapshot=${snapshot.data}');

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(84, 69, 64, 1),
                ),
              );
            } else if (snapshot.hasError) {
              if (snapshot.error is TimeoutException) {
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
                        'error time out    ',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                    ],
                  ),
                );
              } else {
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
                        'An error occurred. Please try again   ',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                    ],
                  ),
                );
              }
            } else if (!snapshot.hasData ||
                snapshot.data.isEmpty ||
                snapshot.data == null) {
              if (isCart) {
                return emptycart();
              } else {
                return emptyfavourites();
              }
            }

            return GridView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 5,
                mainAxisExtent: 240,
              ),
              itemBuilder: (context, index) {
                var box = Hive.box('user');
                return GestureDetector(
                  onTap: () async {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        print('${snapshot.data[index]['id']}');
                        return MyBottomSheet(
                          id: snapshot.data[index]['productId'],
                          isSignedIn: box.get('isConnected'),
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 25,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 20, bottom: 20),
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            margin: const EdgeInsets.only(left: 1),
                            child: Center(
                              child: Image.network(
                                snapshot.data[index]['pic'][0],
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'assets/whit_logo_Mesa de trabajo 1 1.png',
                                ),
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Image.asset(
                                      'assets/whit_logo_Mesa de trabajo 1 1.png',
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  snapshot.data[index]['name'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Price : ${snapshot.data[index]['price']} DA',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                isCart
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                            Text(
                                              'Size : ${size[index]}',
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                                'Quantity : ${snapshot.data[index]['quantity']}',
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ))
                                          ])
                                    : SizedBox(),
                                isCart
                                    ? Row(
                                        children: [
                                          const Text(
                                            'Color : ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Icon(
                                            Icons.circle,
                                            color: colorFromHex(
                                                '${snapshot.data[index]['color']}'),
                                            size: 25,
                                          ),
                                        ],
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            !isCart
                                ? Container(
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          name.removeAt(index);
                                          colorsWithBooleans.removeAt(index);
                                          price.removeAt(index);
                                          size.removeAt(index);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.add_shopping_cart,
                                        size: 30,
                                        color: Pallete.iconsvgcolor,
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(height: 10),
                            Container(
                              child: IconButton(
                                onPressed: () async {
                                  if (isCart) {
                                    try {
                                      var response;
                                      print("${snapshot.data[index]}");
                                      snapshot.data[index]['colors']['sizes']
                                          ["value"] = size[index];
                                      print("${snapshot.data[index]}");

                                      var uri = Uri.parse(
                                          '${Resources.Url}/cart/${snapshot.data[index]['productId']}');
                                      response = await delete(
                                        uri,
                                        headers: {
                                          "jwt": cookie,
                                          "Content-Type": "application/json",
                                        },
                                        body: json.encode({
                                          "productId":
                                              "${snapshot.data[index]['productId']}",
                                          "colors":
                                              "${snapshot.data[index]['colors']}",
                                        }),
                                      );
                                      response = response.body;
                                      response = json.decode(response);
                                      print(response);
                                      setState(() {
                                        
                                      });
                                    } catch (e) {
                                      print('error=${e}');
                                    }
                                  } else {
                                    try {
                                      var box = Hive.box('user');
                                      var token = box.get('cookie');
                                      print('token=${token}');
                                      var response;
                                      var uri = Uri.parse(
                                          '${Resources.Url}/favorites/product/${snapshot.data[index]['id']}');

                                      response = await post(uri,
                                          headers: {
                                            "Content-Type": "application/json",
                                            "Authorization": '$token',
                                          },
                                          body: json.encode(
                                            {},
                                          ));
                                          setState(() {
                                            
                                          });
                                    } catch (e) {
                                      print('error=${e}');
                                    }
                                  }
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Pallete.iconsvgcolor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );

          },
        ),
      ),
    );
  }

  Widget emptyfavourites() {
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 200),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/svgs/face-frown-solid 1.svg',
              color: Pallete.iconsvgcolor,
              width: 300,
              height: 300,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            alignment: Alignment.center,
            child: const Text(
              'No itmes added !',
              style: TextStyle(
                color: Pallete.iconsvgcolor,
                fontSize: 33,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget emptycart() {
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 200),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/svgs/epmtycart.svg',
              color: Pallete.iconsvgcolor,
              width: 300,
              height: 300,
            ),
          ),
          SizedBox(height: 50),
          Container(
            //margin: const EdgeInsets.only(left: 45),
            child: const Text(
              'No item to added!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                height: 1.0,
                color: Pallete.iconsvgcolor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
