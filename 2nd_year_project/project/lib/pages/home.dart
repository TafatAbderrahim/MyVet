import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
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
                            icon: Image.asset('assets/categories/hoodie.png'))),
                    SizedBox(width: 10),
                  ],
                );
              },
            ),
          ),
          category('For you'),
          category('Most Popular'),
          category('Latest Updates'),
          category('Men clothes'),
          SizedBox(
            height: 70,
          ),
        ],
      ),
    );
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
