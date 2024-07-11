// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:project/pages/article/item.dart';
// import 'package:project/pages/pallette.dart';

// class Category extends StatefulWidget {
//   const Category({Key? key}) : super(key: key);

//   static const route = '/categories';

//   @override
//   State<Category> createState() => _CategoryState();
// }

// class _CategoryState extends State<Category> {
//   //====declaration===========================
//   String? selectedValue;
//   String? val;

//   List<String> name = [
//     'Vintage Tote',
//     'City Satchel',
//     'Explorer Duffel',
//     'Classic Briefcase',
//     'Vintage Tote',
//     'City Satchel',
//     'Explorer Duffel',
//     'Classic Briefcase',
//   ];
//   List<double> price = [1000, 2000, 3000, 4000, 1000, 2000, 3000, 4000];
//   List<String> images = [
//     'lib/assets/images/hd.jpeg',
//     'lib/assets/images/photo.png',
//     'lib/assets/images/ph3.png',
//     'lib/assets/images/Hd.png',
//     'lib/assets/images/hd.jpeg',
//     'lib/assets/images/photo.png',
//     'lib/assets/images/ph3.png',
//     'lib/assets/images/Hd.png'
//   ];
//   var seller;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           if (name.isNotEmpty && price.isNotEmpty && images.isNotEmpty)
//             Positioned(
//               child: Column(
//                 children: [
//                   Container(
//                     alignment: Alignment.center,
//                     margin: const EdgeInsets.only(
//                         left: 60, top: 80, bottom: 5, right: 60),
//                     child: Row(
//                       children: [
//                         Container(
//                           alignment: Alignment.center,
//                           height: 30,
//                           width: 110,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             border: Border.all(color: Colors.black),
//                           ),
//                           child: DropdownButton<String>(
//                             underline: const Divider(
//                               thickness: 0,
//                               color: Colors.transparent,
//                             ),
//                             hint: Container(
//                               margin: const EdgeInsets.only(left: 10),
//                               child: const Text('Gender'),
//                             ),
//                             borderRadius: BorderRadius.circular(15),
//                             iconDisabledColor: Pallete.iconsvgcolor,
//                             dropdownColor: Pallete.iconsvgcolor,
//                             value: selectedValue,
//                             onChanged: (String? newValue) {
//                               setState(() {
//                                 selectedValue = newValue!;
//                               });
//                             },
//                             items: <String>['Men', 'Women', 'Kids']
//                                 .map<DropdownMenuItem<String>>((String value) {
//                               Widget icon;
//                               if (value == 'Men') {
//                                 icon = const Icon(Icons.person);
//                               } else if (value == 'Women') {
//                                 icon = SvgPicture.asset(
//                                   'lib/assets/svgs/women.svg',
//                                   width: 15,
//                                   height: 15,
//                                 );
//                               } else {
//                                 icon = const Icon(Icons.child_care);
//                               }
//                               return DropdownMenuItem<String>(
//                                 value: value,
//                                 child: Row(
//                                   children: [
//                                     icon,
//                                     const SizedBox(width: 8),
//                                     Text(
//                                       value,
//                                       textAlign: TextAlign.center,
//                                       style: const TextStyle(fontSize: 12),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         Container(
//                           alignment: Alignment.center,
//                           height: 30,
//                           width: 110,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             border: Border.all(color: Colors.black),
//                           ),
//                           child: DropdownButton<String>(
//                             iconDisabledColor: const Color(0xFFA0887F),
//                             itemHeight: 50,
//                             underline: const Divider(
//                               thickness: 0,
//                               color: Colors.transparent,
//                             ),
//                             borderRadius: BorderRadius.circular(15),
//                             dropdownColor: const Color(0xFFA0887F),
//                             hint: Container(
//                               margin: const EdgeInsets.only(left: 10),
//                               child: const Text('Price'),
//                             ),
//                             value: val,
//                             onChanged: (String? newValue) {
//                               setState(() {
//                                 val = newValue!;
//                               });
//                             },
//                             items: <String>[
//                               '0-1000DA',
//                               '1000-2000DA',
//                               '2000-3500DA',
//                               '3500-4500DA',
//                               '4500-5500DA',
//                               '++5500DA'
//                             ].map<DropdownMenuItem<String>>((String value) {
//                               return DropdownMenuItem<String>(
//                                 value: value,
//                                 child: Text(
//                                   value,
//                                   style: const TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 11,
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: GridView.builder(
//                       itemCount: name.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 20,
//                         childAspectRatio: 0.8,
//                       ),
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () {
//                             showModalBottomSheet(
//                               backgroundColor: Colors.transparent,
//                               isScrollControlled: true,
//                               context: context,
//                               builder: (context) => MyBottomSheet(
//                                  name[index],
//                                  price[index],
//                                  images[index],
//                                  false,
//                                  seller,
//                               ),
//                             );
//                           },
//                           child: Column(
//                             children: [
//                               Container(
//                                 margin:
//                                     const EdgeInsets.only(right: 20, left: 20),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15),
//                                   color: Colors.white,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       blurRadius: 10,
//                                       offset: const Offset(0, 4),
//                                     ),
//                                   ],
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(15),
//                                   child: Image.asset(
//                                     images[index],
//                                     width: 150,
//                                     height: 180,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               Container(
//                                 width: 140,
//                                 alignment: Alignment.bottomLeft,
//                                 child: Text(
//                                   name[0],
//                                   style: const TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                               Container(
//                                 width: 140,
//                                 alignment: Alignment.bottomLeft,
//                                 child: Text(
//                                   ' ${price[index]} DA',
//                                   style: const TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           Positioned(
//             top: 40,
//             left: 23,
//             child: GestureDetector(
//               onTap: () => Navigator.pop(context),
//               child: const Icon(
//                 Icons.arrow_back,
//                 size: 40,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
