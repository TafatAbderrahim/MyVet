import 'package:flutter/material.dart';
import 'package:project/pages/articleDetails.dart';

class MyArticles extends StatefulWidget {
  @override
  State<MyArticles> createState() => _MyArticlesState();
}

class _MyArticlesState extends State<MyArticles> {
  List<String> name = ["White hoodie for men"];
  List<String> photo = ['assets/hoodie_product_2.jpg'];
  List<String> description = ['qualite coton'];
  List<int> price = [4000];
  @override
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
                  GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 19,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio:0.9,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 15,
                      ),
                      itemBuilder: (BuildContext context, item) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(220, 210, 204, 1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: GestureDetector(
                            onTap: () {},
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
                                    photo[0],
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                          child: Text(
                                        '${name[0]} $item',
                                        style: TextStyle(fontSize: 15),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              SuppAlert();
                                            },
                                            child: Icon(Icons.delete),
                                          ),
                                          SizedBox(width: 5),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (builder) {
                                                return ArticleDetails
                                                    .overloadedContructor(
                                                        true,
                                                        photo[0],
                                                        name[0],
                                                        description[0],
                                                        price[0]);
                                              }));
                                            },
                                            child: Icon(Icons.create),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ElevatedButton(
                child: Icon(
                  Icons.arrow_back,
                  color: Color.fromRGBO(109, 76, 61, 1),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Positioned(
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
              bottom: 30,
              right: 0,
            )
          ],
        ),
      ),
    );
  }

  Future SuppAlert() {
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
                onPressed: () {
                  print('deleted');
                },
                child: Text('Delete',
                    style: TextStyle(color: Color.fromRGBO(109, 76, 61, 1)))),
          ],
        );
      },
    );
  }
}
