import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/articleDetails.dart';
import 'package:project/resources.dart';

class MyArticles extends StatefulWidget {
  @override
  State<MyArticles> createState() => _MyArticlesState();
}

class _MyArticlesState extends State<MyArticles> {
  List<String> name = ["White hoodie for men"];
  List<String> photo = ['assets/hoodie_product_2.jpg'];
  List<String> description = ['qualite coton'];
  List<int> price = [4000];
  Future getData() async {
    var response, body, data;
    var box = Hive.box('user');
    var cookie = box.get('cookie');
    var url = '${Resources.Url}/articles';
    var uri = Uri.parse(url);
    try {
      response = await get(
        uri,
        headers: {
          "jwt": cookie,
        },
      );
      body = response.body;
      data = json.decode(body);
      data = data['data'];
      print('data=$data');
      return data;
    } catch (e) {
      print('error=${e}');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 90),
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        height: MediaQuery.of(context).size.height - 30,
                        child: FutureBuilder(
                            future: getData(),
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
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      const Text(
                                        "We couldn't find what you are looking for",
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                
                                return GridView.builder(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.65,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 15,
                                    ),
                                    itemBuilder: (BuildContext context, item) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(220, 210, 204, 1),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {},
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
                                                  snapshot.data[item]['pic'],
                                                  height: 200,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                  loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) =>
                                                      Icon(Icons.stop,
                                                          size: 150),
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Icon(Icons.error,
                                                          size: 150),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                child: Flexible(
                                                    child: Text(
                                                  snapshot.data[item]['name'],
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
                                              ),
                                              Divider(
                                                color: Color.fromRGBO(
                                                    109, 76, 61, 1),
                                                thickness: 1.0,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        var id = snapshot
                                                            .data[item]['_id'];
                                                        SuppAlert(id);
                                                      },
                                                      child: Icon(Icons.delete),
                                                    ),
                                                    SizedBox(),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (builder) {
                                                          print(snapshot
                                                              .data[item]);
                                                          return ArticleDetails
                                                              .overloadedContructor(
                                                                  true,snapshot
                                                            .data[item]['_id']);
                                                        }));
                                                      },
                                                      child: Icon(Icons.create),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                            }),
                      ),
                      SizedBox(height: 30),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Icon(
                      Icons.arrow_back,
                      color: Color.fromRGBO(109, 76, 61, 1),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Text(
                    'My Articles',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromRGBO(109, 76, 61, 1),
                    ),
                  ),
                  Container(height: 50),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              child: Container(
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(109, 76, 61, 1),
                ),
                child: TextButton(
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (builder) {
                      return ArticleDetails(false);
                    }));
                  },
                ),
              ),
              right: 0,
            )
          ],
        ),
      ),
    );
  }

  Future SuppAlert(String id) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceBetween,
          content: Text(
            'Are you sure you want to\ndelete this item',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Color.fromRGBO(109, 76, 61, 1)),
                )),
            TextButton(
                onPressed: () async {
                  try {
                    var box = Hive.box('user');
                    var uri = Uri.parse('${Resources.Url}/product/$id');
                    var response = await delete(
                      uri,
                      headers: {
                        'jwt': box.get('cookie'),
                        'Content-Type': 'application/json',
                      },
                    );
                    print(json.decode(response.body));
                    print('deleted');
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (builder) => MyArticles()));
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text('Delete',
                    style: TextStyle(color: Color.fromRGBO(109, 76, 61, 1)))),
          ],
        );
      },
    );
  }
}
