import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:project/models/product.dart';
import 'package:project/pages/article/colorwithsize.dart';
import 'package:project/pages/article/item.dart';
import 'package:project/pages/favorites/splashscreen.dart';
import 'package:project/pages/pallette.dart';
import 'package:http/http.dart';

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
  double total = 100;

  _MyfavouritesState(this.isCart);

  Future getData() async {
    var host = '192.168.122.133';
    var router = 'favorites';
    widget.isCart ? router = 'cart' : 'favorites';
    var uri = Uri.parse('http://$host:5000/${router}');
    print(uri);
    var response, data, donnees;
    try {
      response = await get(
        uri,
        headers: {"jwt": cookie},
      );
      data = response.body;
      donnees = json.decode(data);
      donnees = donnees["favorites"];

      print(donnees);
      return donnees;
    } catch (e) {
      print('error= $e');
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
            child: getData() != []
                ? fullfavocart()
                : isCart
                    ? emptycart()
                    : emptyfavourites(),
          ),
          // If it's a cart, show buy button

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
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          backgroundColor: const Color(0xFFD9D9D9),
                          content: Confirmbuy(
                              total: total,
                              emailController: email,
                              addressController: address,
                              phoneNumberController: phonenumber));
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
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(top: 30),
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            print('snapshot=${snapshot.data}');
            if (snapshot.data == null || snapshot.data == []) {
              if (isCart) {
                emptycart();
              } else {
                emptyfavourites();
              }
            } else if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(84, 69, 64, 1),
                ),
              );
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
                Product product = Product.fromJson(snapshot.data[index]);
                return GestureDetector(
                  onTap: () async {
                    Product product = Product.fromJson(await getData());
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return MyBottomSheet(
                          name: product.name,
                          price: product.price,
                          image: product.pic,
                          colors: product.colors,
                          comments: product.comments,
                          isSignedIn: false,
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
                                product.pic[0],
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'assets/whit_logo_Mesa de trabajo 1 1.png',
                                  //height: 120,
                                ),
                                loadingBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'assets/whit_logo_Mesa de trabajo 1 1.png',
                                  //height: 300,
                                ),
                               // height: 300,
                               // width: 200,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          //width: double.maxFinite,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Price : ${product.price} DA',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  'Size : ${size[index]}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
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
                                      color: colorsWithBooleans[index].color,
                                      size: 25,
                                    ),
                                  ],
                                ),
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
                                onPressed: () {
                                  setState(() {
                                    name.removeAt(index);
                                    colorsWithBooleans.removeAt(index);
                                    price.removeAt(index);
                                    size.removeAt(index);
                                  });
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
