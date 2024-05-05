import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:project/models/product.dart';
import 'package:project/models/user.dart';
import 'package:project/pages/article/item.dart';
import 'package:project/pages/pallette.dart';
import 'package:http/http.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  //====declaration===========================
  late TextEditingController searchController;
  String? valGender;
  String? valAge;
  String? valPrice;

  bool isfound = true;

  var seller;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  Future getData(
    String Search,
    String? Price,
    String? Age,
    String? Gender,
  ) async {
    var response;
    String query = '';
    var data, donnees;
    var host = '192.168.34.133';

    if (Price == 'Decroissant' && Price != null) {
      Price = 'd';
      query = query + 'sort=d';
    }
    if (Age != 'all' && Age != null) {
      query = query + '&age=${Age}';
    }
    if (Gender != 'all' && Gender != null) {
      query = query + '&gender=${Gender}';
    }
    if (Search != null) {
      query = query + '&name=${Search}';
    }
    if (query.startsWith('&') == true) {
      query = query.substring(1);
    }
    query = '?' + query;
    var uri = Uri.parse('http://${host}:5000/search${query}');
    print(uri);
    try {
      response = await get(
        uri,
        headers: {"Content-Type": "application/json"},
      );
      data = response.body;
      print(data);
      donnees = json.decode(data);
      print(donnees);
      return donnees['result'];
    } catch (e) {
      print('error= $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.058,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: TextField(
                      autocorrect: true,
                      controller: searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search...',
                        suffixIcon: searchController.text.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    searchController.clear();
                                  });
                                },
                                child: const Icon(
                                  Icons.clear,
                                  size: 20,
                                ),
                              )
                            : null,
                      ),
                      onChanged: (value) {
                        getData(
                            searchController.text, valPrice, valAge, valGender);
                        setState(() {});
                      },
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                      left: 10, top: 20, right: 10, bottom: 10),
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
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: DropdownButton<String>(
                                underline: Divider(
                                  thickness: 0,
                                  color: Colors.transparent,
                                ),
                                hint: Text('Gender'),
                                borderRadius: BorderRadius.circular(15),
                                iconDisabledColor: Colors.grey,
                                dropdownColor: Pallete.iconsvgcolor,
                                value: valGender,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    valGender = newValue!;
                                    getData(searchController.text, valPrice,
                                        valAge, valGender);
                                  });
                                },
                                items: <String>[
                                  'Male',
                                  'Female',
                                  'Unisex',
                                  'all'
                                ].map<DropdownMenuItem<String>>((String value) {
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
                                          style: TextStyle(fontSize: 12),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: DropdownButton<String>(
                                iconDisabledColor: Colors.grey,
                                itemHeight: 50,
                                underline: Divider(
                                  thickness: 0,
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                dropdownColor: Pallete.iconsvgcolor,
                                hint: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: const Text('Age')),
                                value: valAge,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    valAge = newValue!;
                                    getData(searchController.text, valPrice,
                                        valAge, valGender);
                                  });
                                },
                                items: <String>[
                                  'Kid',
                                  'Adult',
                                  'all',
                                ].map<DropdownMenuItem<String>>((String value) {
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: DropdownButton<String>(
                                iconDisabledColor: Colors.grey,
                                itemHeight: 50,
                                underline: Divider(
                                  thickness: 0,
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                dropdownColor: Pallete.iconsvgcolor,
                                hint: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: const Text('Price')),
                                value: valPrice,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    valPrice = newValue!;
                                    getData(searchController.text, valPrice,
                                        valAge, valGender);
                                  });
                                },
                                items: <String>[
                                  'Croissant',
                                  'Decroissant',
                                ].map<DropdownMenuItem<String>>((String value) {
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
                SizedBox(height: 50),
              ],
            ),
          ),
          Positioned.fill(
            top: screenHeight * 0.13,
            child: searchController.text.isNotEmpty
                ? searchScreen()
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget searchScreen() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(height: 30),
        Expanded(
          child: FutureBuilder(
              future:
                  getData(searchController.text, valPrice, valAge, valGender),
              builder: (context, snapshot) {
                print(snapshot.data);
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
                  print('data =${snapshot.data}');

                  //snapshot.data=snapshot.data.documents.map((getData(Search, Price, Age, Gender)))
                  return Expanded(
                    child: GridView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        //mainAxisSpacing: screenWidth * 0.05,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        print('length=${snapshot.data.length}');
                        print('index $index =${snapshot.data[index]}');
                        return GestureDetector(
                          onTap: () {
                            Product product =
                                Product.fromJson(snapshot.data[index]);
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                var box = Hive.box('user');
                                bool isConnected = box.get('isConnected');
                                return MyBottomSheet(
                                  name: product.name,
                                  price: product.price,
                                  image: product.pic,
                                  colors: product.colors,
                                  comments: product.comments,
                                  isSignedIn: isConnected,
                                );
                              },
                            );
                          },
                          child: Column(children: [
                            Container(
                              // margin: const EdgeInsets.only(right: 20, left: 20),
                              // width: screenWidth * 0.4,
                              // height: screenHeight * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  snapshot.data[index]['pic'][0],
                                  width: 150,
                                  height: 180,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) =>
                                          Icon(Icons.stop, size: 150),
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.error, size: 150),
                                ),
                              ),
                            ),
                            // const
                            SizedBox(
                              // height: 5,
                              height: screenHeight * 0.006,
                            ),
                            Container(
                              // width: 140,
                              width: screenWidth * 0.35,
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                snapshot.data[index]['name'],
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              // width: 140,
                              width: screenWidth * 0.35,
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                '${snapshot.data[index]['price']} DA',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ]),
                        );
                      },
                    ),
                  );
                }
              }),
        ),
        Container(height: 40, color: Colors.transparent),
      ],
    );
  }
}
