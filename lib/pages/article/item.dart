import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:project/models/product.dart';
import 'package:project/pages/article/colorwithsize.dart';
import 'package:project/pages/article/liked.dart';
import 'package:project/pages/article/rate.dart';
import 'package:project/pages/article/sized.dart';
import 'package:project/pages/pallette.dart';
import 'package:project/resources.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyBottomSheet extends StatefulWidget {
  //====declaration===========================
  final String id;
  final bool isSignedIn;

  const MyBottomSheet({
    Key? key,
    required this.id,
    required this.isSignedIn,
  }) : super(key: key);

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  //=======declaration
  final bool _isLiked = false;
  bool isTextFilled = false;

  List<ColorData> colorsWithBooleans = [];

  TextEditingController commentController = TextEditingController();

  List<SizeSchema> sizes = [];

  double rate = 4.5;
  double revrate = 4.3;
  late bool star1;
  late bool star2;
  late bool star3;
  late bool star4;
  late bool star5;
  bool starreviews = true;
  bool rateimage = false;
  String val = '1';
  var box;
  int activeindex = 0;
  int sizeIndex = 0;
  var data;
  int colorIndex = 0;
  @override
  void initState() {
    super.initState();

    star1 = false;
    star2 = false;
    star3 = false;
    star4 = false;
    star5 = false;
    box = Hive.box('user');
    data = getData();
  }

  Future getData() async {
    var uri = Uri.parse('${Resources.Url}/product/${widget.id}');
    print(uri);
    var response, data, donnees;
    var box = Hive.box('user');
    var cookie = box.get('cookie');
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
      return donnees;
    } catch (e) {
      print('error= $e');
      return [];
    }
  }

  late var snap;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            color: Colors.white),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 20,
              padding: const EdgeInsets.symmetric(
                horizontal: 130,
              ),
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/svgs/Line 18.svg',
                  width: 10,
                  height: 10,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            FutureBuilder(
              future: getData().timeout(Duration(seconds: 20)),
              builder: (context, snapshot) {
                snap = snapshot;
                print(snapshot);
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
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54),
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
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                    );
                  }
                } else if (!snapshot.hasData || snapshot.data.length == 0) {
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

                return Expanded(
                  child: ListView(
                    controller: controller,
                    children: [
                      Stack(
                        children: [
                          CarouselSlider.builder(
                            carouselController: CarouselController(),
                            itemCount: snapshot.data['result']['pic'].length,
                            itemBuilder: (context, index, realIndex) {
                              return Image.network(
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                        'assets/whit_logo_Mesa de trabajo 1 1.png',
                                        height: 300,
                                      ),
                                  loadingBuilder:
                                      (context, error, stackTrace) =>
                                          Image.asset(
                                            'assets/whit_logo_Mesa de trabajo 1 1.png',
                                            height: 300,
                                          ),
                                  snapshot.data['result']['pic'][index]
                                      .toString(),
                                  height: 300,
                                  fit: BoxFit.fitHeight);
                            },
                            options: CarouselOptions(
                              height: 300,
                              enableInfiniteScroll: false,
                              animateToClosest: false,
                              onPageChanged: (index, reason) => setState(() {
                                activeindex = index;
                              }),
                            ),
                          ),
                          Positioned(
                            child: AnimatedSmoothIndicator(
                              activeIndex: activeindex,
                              count: snapshot.data['result']['pic'].length,
                              effect: ExpandingDotsEffect(
                                  dotWidth: 15,
                                  activeDotColor:
                                      Color.fromRGBO(160, 136, 127, 1),
                                  dotColor: Color.fromRGBO(84, 69, 64, 1)),
                            ),
                            bottom: 10,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 250,
                              child: Text(
                                snapshot.data['result']['name'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 20),
                              ),
                            ),
                            Text(
                              snapshot.data['result']['rating'].toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Ratestar(
                                isRated: rateimage,
                                isClickable: false,
                              ),
                            ),
                            Liked(
                              isSigned: box.get('isConnected'),
                              id: snapshot.data['result']['_id'],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      //=======================================colors=================================
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  transformAlignment: Alignment.centerLeft,
                                  height: 35,
                                  width: 200,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.only(left: 0),
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        snapshot.data['result']['colors'] == []
                                            ? 0
                                            : snapshot.data['result']['colors']
                                                .length,
                                    itemBuilder: (context, i) {
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        width: 30,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: IconButton(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            onPressed: () {
                                              setState(() {
                                                colorIndex = i;
                                                sizes.clear();
                                                for (int j = 0;
                                                    j <
                                                        snapshot
                                                            .data['result']
                                                                ['colors'][i]
                                                                ['sizes']
                                                            .length;
                                                    j++) {
                                                  sizes.add(SizeSchema.fromJson(
                                                      snapshot.data['result']
                                                              ['colors'][i]
                                                          ['sizes'][j]));
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.circle,
                                              size: 30,
                                            ),
                                            // color:
                                            //     colorsWithBooleans[i].color,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                //==============================================================================
                                snapshot.data['result']['colors'].length > 5
                                    ? const Positioned(
                                        top: 8,
                                        left: 195,
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                            //========quantity==============================================================
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  height: 30,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: DropdownButton<String>(
                                    onTap: () {},
                                    iconDisabledColor: const Color(0xFFA0887F),
                                    itemHeight: 50,
                                    underline: const Divider(
                                      thickness: 0,
                                      color: Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                    dropdownColor: Pallete.iconsvgcolor,
                                    value: val,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        val = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      '1',
                                      '2',
                                      '3',
                                      '4',
                                      '5',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //==============================================================================
                      //Itemsized(sizes: sizes),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(sizes.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 1),
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: TextButton(
                                  onPressed: () {
                                    sizeIndex = index;
                                  },
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero),
                                  ),
                                  child: Text(
                                    snapshot.data['result']['category'] !=
                                            'Shoe'
                                        ? sizes[index].value
                                        : sizes[index].shoeSize.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      //==============================================================================

                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${snapshot.data['result']['price'].toString()}DA',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                SizedBox(width: 10),
                                snapshot.data['result']['promotion'] != 0
                                    ? Text(
                                        '-${snapshot.data['result']['promotion']}%',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                            //============Add to cart=======================================================<

                            ElevatedButton(
                              onPressed: () async {
                                if (box.get('isConnected')) {
                                  try {
                                    var response;
                                    var cookie = box.get('cookie');
                                    print(snapshot.data['result']['_id']);
                                    print(snapshot.data['result']['colors']
                                        [colorIndex]['color']);

                                    var siiize;
                                    if (snapshot.data['result']['category'] ==
                                        'Shoe') {
                                      siiize = snapshot.data['result']['colors']
                                              [colorIndex]['sizes'][sizeIndex]
                                          ['shoeSize'];
                                    } else {
                                      siiize = snapshot.data['result']['colors']
                                              [colorIndex]['sizes'][sizeIndex]
                                          ['value'];
                                    }
                                    print(val);
                                    print(siiize);
                                    var uri = Uri.parse(
                                        '${Resources.Url}/cart/product/${snapshot.data['result']['_id']}');
                                    response = await post(
                                      uri,
                                      headers: {
                                        "jwt": cookie,
                                        "Content-Type": "application/json",
                                      },
                                      body: json.encode({
                                        "name": snapshot.data['result']['name'],
                                        "pic": snapshot.data['result']['pic']
                                            [0],
                                        "price": snapshot.data['result']
                                            ['price'],
                                        "quantiy": val,
                                        "productId":
                                            "${snapshot.data['result']['productId']}",
                                        "color":
                                            "${snapshot.data['result']['colors'][colorIndex]['color']}",
                                        "size": siiize,
                                      }),
                                    );
                                    response = response.body;
                                    response = json.decode(response);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Added to cart succesfully')));
                                    print(response);
                                    Navigator.of(context).pop();
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(content: Text('${response['message']}')));
                                  } catch (e) {
                                    print(e);
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Login first')));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: box.get('isConnected')
                                    ? Pallete.iconsvgcolor
                                    : Colors.grey,
                                minimumSize: const Size(100, 45),
                              ),
                              child: const Text(
                                'Add to cart',
                                style: TextStyle(color: Pallete.texticon),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //=======================Description===================================
                      Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: SizedBox(
                          height: 200,
                          child: SingleChildScrollView(
                            child: snapshot.data['result']['description'] == ''
                                ? Text(
                                    style: TextStyle(fontSize: 18),
                                    'No description')
                                : Text(
                                    style: TextStyle(fontSize: 18),
                                    '${snapshot.data['result']['description']}'),
                          ),
                        ),
                      ),

                      //==============================================================================
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 20, top: 20),
                        child: Row(
                          children: [
                            const Text(
                              'Reviews',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 30),
                            Text(
                              revrate.toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            Ratestar(isRated: true, isClickable: false),
                          ],
                        ),
                      ),
                      //==============================================================================
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 29,
                              height: 30,
                              margin: const EdgeInsets.only(
                                  left: 0, right: 0, top: 0, bottom: 2),
                              child: ClipRect(
                                child: Transform.scale(
                                  scale: 2.9,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (true) {
                                          star1 = !star1;
                                          if (!star1) {
                                            star5 = star1;
                                            star2 = star1;
                                            star3 = star1;
                                            star4 = star1;
                                          }
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      star1 ? Icons.star : Icons.star_border,
                                      color: star1
                                          ? const Color(0xFFD9D226)
                                          : Colors.black,
                                      size: 9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 29,
                              height: 30,
                              margin: const EdgeInsets.only(
                                  left: 0, right: 0, top: 0, bottom: 2),
                              child: ClipRect(
                                child: Transform.scale(
                                  scale: 2.9,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        star2 = !star2;
                                        if (!star2) {
                                          star5 = star2;
                                          star3 = star2;
                                          star4 = star2;
                                        } else {
                                          star1 = true;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      star2 ? Icons.star : Icons.star_border,
                                      color: star2
                                          ? const Color(0xFFD9D226)
                                          : Colors.black,
                                      size: 9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 29,
                              height: 30,
                              margin: const EdgeInsets.only(
                                  left: 0, right: 0, top: 0, bottom: 2),
                              child: ClipRect(
                                child: Transform.scale(
                                  scale: 2.9,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        star3 = !star3;
                                        if (!star3) {
                                          star5 = star3;
                                          star4 = star3;
                                        } else {
                                          star1 = true;
                                          star2 = true;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      star3 ? Icons.star : Icons.star_border,
                                      color: star3
                                          ? const Color(0xFFD9D226)
                                          : Colors.black,
                                      size: 9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 29,
                              height: 30,
                              margin: const EdgeInsets.only(
                                  left: 0, right: 0, top: 0, bottom: 2),
                              child: ClipRect(
                                child: Transform.scale(
                                  scale: 2.9,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        star4 = !star4;
                                        if (!star4) {
                                          star5 = false;
                                        } else {
                                          star1 = true;
                                          star2 = true;
                                          star3 = true;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      star4 ? Icons.star : Icons.star_border,
                                      color: star4
                                          ? const Color(0xFFD9D226)
                                          : Colors.black,
                                      size: 9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 29,
                              height: 30,
                              margin: const EdgeInsets.only(
                                  left: 0, right: 0, top: 0, bottom: 2),
                              child: ClipRect(
                                child: Transform.scale(
                                  scale: 2.9,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        star5 = !star5;
                                        if (!star5) {
                                        } else {
                                          star4 = star5;
                                          star1 = star5;
                                          star2 = star5;
                                          star3 = star5;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      star5 ? Icons.star : Icons.star_border,
                                      color: star5
                                          ? const Color(0xFFD9D226)
                                          : Colors.black,
                                      size: 9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //==============================================================================
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          constraints: const BoxConstraints(
                            minHeight: 40.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 243, 243, 243),
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: TextField(
                                    controller: commentController,
                                    maxLines: null,
                                    minLines: 1,
                                    maxLength: 500,
                                    onChanged: (text) {
                                      setState(() {
                                        isTextFilled = text.isNotEmpty;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 20,
                                      ),
                                      border: InputBorder.none,
                                      hintText: 'Add a comment...',
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: ElevatedButton(
                                  onPressed: commentController.text.isNotEmpty
                                      ? () {}
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    backgroundColor: Pallete.iconsvgcolor,
                                  ),
                                  child: const Text(
                                    'Post',
                                    style: TextStyle(color: Pallete.texticon),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: SizedBox(
                          height: 400,
                          child: snapshot.data['result']['comments'].length != 0
                              ? ListView.builder(
                                  itemCount: snapshot
                                      .data['result']['comments'].length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(snapshot
                                          .data['comments'][index].content),
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                    'No comments yet',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() {
    snap = data;
    return AnimatedSmoothIndicator(
      activeIndex: activeindex,
      count: snap['pic'].length,
      effect: ExpandingDotsEffect(
          dotWidth: 15,
          activeDotColor: Color.fromRGBO(160, 136, 127, 1),
          dotColor: Color.fromRGBO(84, 69, 64, 1)),
    );
  }

  Widget ratestar(var isRated, var isClickable) {
    return Container(
      width: 29,
      height: 30,
      margin: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 2),
      child: ClipRect(
        child: Transform.scale(
          scale: 2.9,
          child: IconButton(
            onPressed: () {
              setState(() {
                if (isClickable) {
                  isRated = !isRated;
                }
              });
            },
            icon: Icon(
              isRated ? Icons.star : Icons.star_border,
              color: isRated ? const Color(0xFFD9D226) : Colors.black,
              size: 9,
            ),
          ),
        ),
      ),
    );
  }
}
