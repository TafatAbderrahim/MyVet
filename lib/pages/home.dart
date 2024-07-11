import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:project/models/user.dart';
import 'package:project/pages/article/item.dart';
import 'package:project/resources.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future getData() async {
    var response, body, data;
    var url = '${Resources.Url}/homepage';
    try {
      var box = Hive.box('user');
      response = await get(
        Uri.parse(url),
        headers: {
          "jwt": box.get('cookie'),
          "Content-Type": "application/json",
        },
      );
      body = response.body;
      data = json.decode(body);
      debugPrint('home=${data}');
      return data;
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    var data = getData();
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            clipBehavior: Clip.none,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Unleash your fashion \npotential today!',
                  style: TextStyle(fontSize: 22),
                ),
                Flexible(
                  child: Image.asset('assets/whit_logo_Mesa de trabajo 1 1.png',
                      color: Color.fromRGBO(220, 210, 204, 1)),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Color.fromRGBO(237, 231, 220, 1),
                //     borderRadius: BorderRadius.circular(15),
                //   ),
                //   child: IconButton(
                //     onPressed: () {
                //       print(NavIndex.PageIndex);
                //       NavIndex.PageIndex = 1;
                //       print(NavIndex.PageIndex);
                //       setState(() {});
                //     },
                //     icon: Icon(
                //       Icons.search_outlined,
                //       color: Color.fromRGBO(109, 76, 61, 1),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        FutureBuilder(
            future: data.timeout(Duration(seconds: 20)),
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
              } else if (!snapshot.hasData) {
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
              } else if (snapshot.hasData) {
                data = getData();
                print('data=${snapshot.data['mostSold']}');
                return Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          child: Center(
                              child: Text(
                            '20% OFF\nUntil Feb',
                            style: TextStyle(fontSize: 30),
                          )),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(220, 210, 204, 1),
                              borderRadius: BorderRadius.circular(30)),
                          height: 150,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Categories',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Container(
                                    height: 200,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(220, 210, 204, 1),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Image.asset(
                                            'assets/categories/hoodie.png'))),
                                SizedBox(width: 10),
                              ],
                            );
                          },
                        ),
                      ),
                      Column(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Most Sold',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold)),
                                      TextButton(
                                          onPressed: () {},
                                          child: Text('See All',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color.fromRGBO(
                                                      84, 69, 64, 1))))
                                    ]),
                              ),
                              SizedBox(height: 5),
                              Container(
                                height: 300,
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1.3,
                                    crossAxisCount: 1,
                                  ),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data['mostSold'].length,
                                  itemBuilder: (BuildContext context, item) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(220, 210, 204, 1),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (context) {
                                              return MyBottomSheet(
                                                  id: snapshot.data['mostSold']
                                                      [item]['_id'],
                                                  isSignedIn: context
                                                      .read<User>()
                                                      .isConnected);
                                            },
                                          );
                                          print('aaaaaaaaaa');
                                        },
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 230,
                                                child: Center(
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(30),
                                                      topRight: Radius.circular(30),
                                                      bottomLeft:
                                                          Radius.circular(30),
                                                      bottomRight:
                                                          Radius.circular(30),
                                                    ),
                                                    child: Image.network(
                                                      snapshot.data['mostSold']
                                                          [item]['pic'][0],
                                                      errorBuilder: (context, error,
                                                              stackTrace) =>
                                                          Image.asset(
                                                        'assets/whit_logo_Mesa de trabajo 1 1.png',
                                                      ),
                                                      loadingBuilder: (context,
                                                          child, loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) {
                                                          return child;
                                                        } else {
                                                          return Image.asset(
                                                            'assets/whit_logo_Mesa de trabajo 1 1.png',
                                                          );
                                                        }
                                                      },
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 15),
                                                child: Text(
                                                  '${snapshot.data['mostSold'][item]['name']}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 23),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 15),
                                                child: Text(
                                                  '${snapshot.data['mostSold'][item]['price']}',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Promoted',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold)),
                                      TextButton(
                                          onPressed: () {},
                                          child: Text('See All',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color.fromRGBO(
                                                      84, 69, 64, 1))))
                                    ]),
                              ),
                              SizedBox(height: 5),
                              Container(
                                clipBehavior: Clip.none,
                                height: 280,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: snapshot.data['promoted'].length > 0
                                      ? GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisSpacing: 10,
                                            childAspectRatio: 1.3,
                                            crossAxisCount: 1,
                                          ),
                                          //shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              snapshot.data['promoted'].length,
                                          itemBuilder:
                                              (BuildContext context, item) {
                                            return Container(
                                              height: 280,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    220, 210, 204, 1),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  print('aaaaaaaaaa');
                                                  MyBottomSheet(
                                                      id: snapshot
                                                              .data['promoted']
                                                          [item]['_id'],
                                                      isSignedIn: context
                                                          .read<User>()
                                                          .isConnected);
                                                },
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  30),
                                                          topRight:
                                                              Radius.circular(
                                                                  30),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  30),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  30),
                                                        ),
                                                        child: Image.network(
                                                          height: 20,
                                                          snapshot.data[
                                                                  'promoted']
                                                              [item]['pic'][0],
                                                          errorBuilder: (context,
                                                                  error,
                                                                  stackTrace) =>
                                                              Image.asset(
                                                            'assets/whit_logo_Mesa de trabajo 1 1.png',
                                                          ),
                                                          loadingBuilder: (context,
                                                              child,
                                                              loadingProgress) {
                                                            if (loadingProgress ==
                                                                null) {
                                                              return child;
                                                            } else {
                                                              return Image
                                                                  .asset(
                                                                'assets/whit_logo_Mesa de trabajo 1 1.png',
                                                              );
                                                            }
                                                          },
                                                  fit: BoxFit.cover,

                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15),
                                                        child: Text(
                                                          'Itemmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm $item',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 23),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15),
                                                        child: Text(
                                                          '$item',
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            );
                                          },
                                        )
                                      : Container(
                                          child: Center(
                                              child: Text(
                                            'Cooming soon',
                                            style: TextStyle(fontSize: 22),
                                          )),
                                        ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Shoes',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold)),
                                      TextButton(
                                          onPressed: () {},
                                          child: Text('See All',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color.fromRGBO(
                                                      84, 69, 64, 1))))
                                    ]),
                              ),
                              SizedBox(height: 5),
                              Container(
                                height: 300,
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1.3,
                                    crossAxisCount: 1,
                                  ),
                                  //shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data['Shoe'].length,
                                  itemBuilder: (BuildContext context, item) {
                                    return Container(
                                      height: 300,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(220, 210, 204, 1),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (context) {
                                              return MyBottomSheet(
                                                  id: snapshot.data['Shoe']
                                                      [item]['_id'],
                                                  isSignedIn: context
                                                      .read<User>()
                                                      .isConnected);
                                            },
                                          );
                                          print('aaaaaaaaaa');

                                        },
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  topRight: Radius.circular(30),
                                                  bottomLeft:
                                                      Radius.circular(30),
                                                  bottomRight:
                                                      Radius.circular(30),
                                                ),
                                                child: Image.network(
                                                  //height: 20,
                                                  snapshot.data['Shoe'][item]
                                                      ['pic'][0],
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Image.asset(
                                                    'assets/whit_logo_Mesa de trabajo 1 1.png',
                                                  ),
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    } else {
                                                      return Image.asset(
                                                        'assets/whit_logo_Mesa de trabajo 1 1.png',
                                                      );
                                                    }
                                                  },
                                                  fit: BoxFit.cover,

                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 15),
                                                child: Text(
                                                  '${snapshot.data['Shoe'][item]['name']}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 23),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 15),
                                                child: Text(
                                                  '${snapshot.data['Shoe'][item]['price']}',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox();
              }
            }),
      ],
    ));
  }

  Widget category(String categoryName) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(categoryName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            TextButton(
                onPressed: () {},
                child: Text('See All',
                    style: TextStyle(
                        fontSize: 18, color: Color.fromRGBO(84, 69, 64, 1))))
          ]),
        ),
        SizedBox(height: 5),
        Container(
          height: 280,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 20,
              childAspectRatio: 1.3,
              crossAxisCount: 1,
            ),
            //shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (BuildContext context, item) {
              return Container(
                height: 280,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(220, 210, 204, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: GestureDetector(
                  onTap: () {
                    print('aaaaaaaaaa');
                  },
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          child: Image.asset(
                            'assets/hoodie_product_2.jpg',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Itemmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm $item',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 23),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            '$item',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
