// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:hive/hive.dart';
// import 'package:project/models/product.dart';

// import 'package:project/models/user.dart';
// import 'package:project/pages/article/colorwithsize.dart';
// import 'package:project/pages/article/liked.dart';
// import 'package:project/pages/article/rate.dart';
// import 'package:project/pages/article/sized.dart';
// import 'package:project/pages/pallette.dart';

// class MyBottomSheet extends StatefulWidget {
//   //====declaration===========================
//   Product product;
//   MyBottomSheet(
//     this.product
//   );
//   @override
//   State<MyBottomSheet> createState() => _MyBottomSheetState();
// }

// class _MyBottomSheetState extends State<MyBottomSheet> {
//   //=======declaration
//   final bool _isLiked = false;
//   bool isTextFilled = false;

//   TextEditingController commentController = TextEditingController();

//   double rate = 4.5;
//   double revrate = 4.3;
//   bool star1 = false;
//   bool star2 = false;
//   bool star3 = false;
//   bool star4 = false;
//   bool star5 = false;
//   bool starreviews = false;
//   bool rateimage = false;

//   String val = '1';

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var box=Hive.box('user');
//     bool isConnected=box.get('isConnected');
//     late int choosedIndex = 0;
//     return DraggableScrollableSheet(
//       initialChildSize: 0.7,
//       minChildSize: 0.5,
//       maxChildSize: 0.95,
//       builder: (_, controller) => Container(
//         decoration: const BoxDecoration(
//             borderRadius: BorderRadius.vertical(
//               top: Radius.circular(20),
//             ),
//             color: Colors.white),
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Container(

//               height: 20,
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 130,
//               ),
//               child: IconButton(
//                 icon: SvgPicture.asset(
//                   'assets/svgs/Line 18.svg',
//                   width: 10,
//                   height: 10,
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ),
//             Container(
//               height: 200,

//               child: ListView(
//                 controller: controller,
//                 children: [
//                   Image.network(
//                       loadingBuilder: (context, child, loadingProgress) =>
//                           Icon(Icons.stop, size: 300),
//                       errorBuilder: (context, error, stackTrace) =>
//                           Icon(Icons.error, size: 300),
//                       alignment: Alignment.center,
//                       widget.product.pic[0],
//                       height: 300,
//                       fit: BoxFit.fitHeight),
//                   Padding(
//                     padding: EdgeInsets.only(left: 10, right: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           width: 180,
//                           child: Text(
//                             widget.product.name,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w600, fontSize: 20),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           rate.toString(),
//                           style: const TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.w500),
//                         ),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Ratestar(isRated: rateimage),
//                         ),
//                         Liked(islaked: _isLiked, isSigned: isConnected),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 10),
// //=======================================colors=================================
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10, right: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Stack(
//                           children: [
//                             Container(
//                               margin: const EdgeInsets.only(right: 20),
//                               transformAlignment: Alignment.centerLeft,
//                               height: 35,
//                               width: 200,
//                               child: ListView.builder(
//                                 padding: const EdgeInsets.only(left: 0),
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: widget.product.colors.length,
//                                 itemBuilder: (context, index) {
//                                   return Container(
//                                     margin: const EdgeInsets.only(right: 10),
//                                     width: 30,
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: IconButton(
//                                         padding: const EdgeInsets.only(left: 0),
//                                         onPressed: () {
//                                           setState(() {
//                                             choosedIndex = index;
//                                           });
//                                         },
//                                         icon: const Icon(
//                                           Icons.circle,
//                                           size: 30,
//                                         ),
//                                         color: Color(int.parse(
//                                             (widget.product.colors[index].color)
//                                                 .toString())),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
// //==============================================================================
//                             const Positioned(
//                               top: 8,
//                               left: 195,
//                               child: Icon(
//                                 Icons.arrow_forward,
//                                 color: Colors.grey,
//                                 size: 20,
//                               ),
//                             )
//                           ],
//                         ),
// //========quantity==============================================================
//                         Container(
//                           height:50 ,
//                           child: Align(
//                             alignment: Alignment.centerRight,
//                             child: Container(
//                               alignment: Alignment.centerRight,
//                               height: 30,
//                               width: 55,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 border: Border.all(color: Colors.black),
//                               ),
//                               child: DropdownButton<String>(
//                                 onTap: () {},
//                                 iconDisabledColor: const Color(0xFFA0887F),
//                                 itemHeight: 50,
//                                 underline: const Divider(
//                                   thickness: 0,
//                                   color: Colors.transparent,
//                                 ),
//                                 borderRadius: BorderRadius.circular(15),
//                                 dropdownColor: Pallete.iconsvgcolor,
//                                 value: val,
//                                 onChanged: (String? newValue) {
//                                   setState(() {
//                                     val = newValue!;
//                                   });
//                                 },
//                                 items: <String>[
//                                   '1',
//                                   '2',
//                                   '3',
//                                   '4',
//                                   '5',
//                                 ].map<DropdownMenuItem<String>>((String value) {
//                                   return DropdownMenuItem<String>(
//                                     value: value,
//                                     child: Text(
//                                       value,
//                                       style: const TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 15,
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
// //==============================================================================
//                   widget.product.colors.isEmpty
//                       ? SizedBox(height: 2)
//                       : Itemsized(widget.product.colors[choosedIndex].sizes),
//                   //==============================================================================
//                   SizedBox(width: 60),
//                   Text(
//                     '${widget.product.price.toString()}DA',
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                         overflow: TextOverflow.ellipsis),
//                   )
//                 ],
//               ),
//             ),
// //============Add to cart=======================================================<
//             Padding(
//               padding: const EdgeInsets.only(left: 10, right: 10),
//               child: Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: isConnected
//                         ? () {
//                             // Add your logic here for adding to cart
//                           }
//                         : null,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: isConnected
//                           ? Pallete.iconsvgcolor
//                           : Colors.grey,
//                       minimumSize: const Size(100, 45),
//                     ),
//                     child: const Text(
//                       'Add to cart',
//                       style: TextStyle(color: Pallete.texticon),
//                     ),
//                   ),

// //==============================================================================
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         left: 10, right: 10, bottom: 20, top: 20),
//                     child: Row(
//                       children: [
//                         const Text(
//                           'Reviews',
//                           style: TextStyle(
//                               fontSize: 25, fontWeight: FontWeight.w500),
//                         ),
//                         const SizedBox(width: 30),
//                         Text(
//                           revrate.toString(),
//                           style: const TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.w500),
//                         ),
//                         Ratestar(isRated: starreviews),
//                       ],
//                     ),
//                   ),
// //==============================================================================
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20, right: 10),
//                     child: Row(
//                       children: [
//                         Ratestar(isRated: star1),
//                         Ratestar(isRated: star2),
//                         Ratestar(isRated: star3),
//                         Ratestar(isRated: star4),
//                         Ratestar(isRated: star5),
//                       ],
//                     ),
//                   ),
// //==============================================================================
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10, right: 10),
//                     child: Container(
//                       constraints: const BoxConstraints(
//                         minHeight: 40.0,
//                       ),
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 243, 243, 243),
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             height: 200,
//                             child: SingleChildScrollView(
//                               child: TextField(
//                                 controller: commentController,
//                                 maxLines: null,
//                                 minLines: 1,
//                                 maxLength: 500,
//                                 onChanged: (text) {
//                                   setState(() {
//                                     isTextFilled = text.isNotEmpty;
//                                   });
//                                 },
//                                 decoration: const InputDecoration(
//                                   counterText: '',
//                                   contentPadding: EdgeInsets.symmetric(
//                                     vertical: 10,
//                                     horizontal: 20,
//                                   ),
//                                   border: InputBorder.none,
//                                   hintText: 'Add a comment...',
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 5),
//                             child: ElevatedButton(
//                               onPressed: commentController.text.isNotEmpty
//                                   ? () {
//                                       setState(() {
//                                         widget.product.comments
//                                             .add(CommentSchema(user:'',content:commentController.text,rating:4.0));
//                                         commentController.clear();
//                                         isTextFilled = false;
//                                       });
//                                     }
//                                   : null,
//                               style: ElevatedButton.styleFrom(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 10, horizontal: 20),
//                                 backgroundColor: Pallete.iconsvgcolor,
//                               ),
//                               child: const Text(
//                                 'Post',
//                                 style: TextStyle(color: Pallete.texticon),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       left: 10,
//                       right: 10,
//                     ),
//                     child: SizedBox(
//                       height: 400,
//                       child: ListView.builder(
//                         itemCount: widget.product.comments!.length,
//                         itemBuilder: (context, index) {
//                           return ListTile(
//                             title: Text(widget.product.comments![index].content),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:project/models/product.dart';
import 'package:project/pages/article/colorwithsize.dart';
import 'package:project/pages/article/liked.dart';
import 'package:project/pages/article/rate.dart';
import 'package:project/pages/article/sized.dart';
import 'package:project/pages/pallette.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyBottomSheet extends StatefulWidget {
  //====declaration===========================
  final String name;
  final double price;
  final List<String> image;
  final List<ColorSchema> colors;
  final List<CommentSchema> comments;
  final bool isSignedIn;

  const MyBottomSheet({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.colors,
    required this.comments,
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
  int activeindex = 0;
  @override
  void initState() {
    super.initState();

    star1 = false;
    star2 = false;
    star3 = false;
    star4 = false;
    star5 = false;
  }

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
            Expanded(
              child: ListView(
                controller: controller,
                children: [
                  Stack(
                    children: [
                      CarouselSlider.builder(
                        // carouselController: CarouselController(),
                        itemCount: widget.image.length,
                        itemBuilder: (context, index, realIndex) {
                          return Image.network(
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                    'assets/whit_logo_Mesa de trabajo 1 1.png',
                                    height: 300,
                                  ),
                              loadingBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                    'assets/whit_logo_Mesa de trabajo 1 1.png',
                                    height: 300,
                                  ),
                              alignment: Alignment.center,
                              widget.image[index],
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
                        child: buildIndicator(),
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
                          width: 300,
                          child: Text(
                            widget.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          rate.toString(),
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
                        Liked(islaked: _isLiked, isSigned: false),
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
                                itemCount: widget.colors == []
                                    ? 0
                                    : widget.colors.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    width: 30,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: IconButton(
                                        padding: const EdgeInsets.only(left: 0),
                                        onPressed: () {
                                          setState(() {
                                            sizes = widget.colors[index].sizes;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.circle,
                                          size: 30,
                                        ),
                                        color: colorsWithBooleans[index].color,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
//==============================================================================
                            widget.colors.length > 5
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
                                  '6'
                                ].map<DropdownMenuItem<String>>((String value) {
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
                  Itemsized(sizes: sizes),
                  SizedBox(
                    height: 20,
                  ),
//==============================================================================

                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.price.toString()}DA',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
//============Add to cart=======================================================<

                        ElevatedButton(
                          onPressed: widget.isSignedIn
                              ? () {
                                  // Add your logic here for adding to cart
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.isSignedIn
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
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: SizedBox(
                      height: 200,
                      child: SingleChildScrollView(
                        child: Text(
                            style: TextStyle(fontSize: 18),
                            'This \nis\n Our\nproduct\ndescription\n==\n==\n==\n==\n==\n==\n==\n==\n==\n==\n==\n==\n==\n==\n==\n==\n==\n==\n==\n==\n==\n==\n==\n==\n=='),
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
                      child: ListView.builder(
                        itemCount: widget.comments.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(widget.comments[index].content),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeindex,
        count: widget.image.length,
        effect: ExpandingDotsEffect(
            dotWidth: 15,
            activeDotColor: Color.fromRGBO(160, 136, 127, 1),
            dotColor: Color.fromRGBO(84, 69, 64, 1)),
      );

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
