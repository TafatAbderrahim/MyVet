import 'package:flutter/material.dart';

class OthersProfile extends StatefulWidget {
  const OthersProfile({super.key});

  @override
  State<OthersProfile> createState() => _OthersProfileState();
}

class _OthersProfileState extends State<OthersProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 320,
              child: Stack(
                children: [
                  //carre beige
                  Container(
                    height: 220,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(160, 136, 127, 1),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                  ),
                  //photo
                  Center(
                    child: Container(
                      height: 550,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromRGBO(217, 217, 217, 1),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Color.fromRGBO(109, 76, 61, 1),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(217, 217, 217, 1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person_rounded,
                              size: 200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                'Ahmed Ahmed',
                style: TextStyle(fontSize: 33),
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 33,
                    color: Color.fromRGBO(84, 69, 64, 1),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Joined 12th Feb 2023',
                    style: TextStyle(
                        fontSize: 17, color: Color.fromRGBO(84, 69, 64, 1)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Icon(
                    Icons.sell,
                    size: 33,
                    color: Color.fromRGBO(84, 69, 64, 1),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'More then 1** articles selled',
                    style: TextStyle(
                        fontSize: 17, color: Color.fromRGBO(84, 69, 64, 1)),
                  ),
                ],
                
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 33,
                    color: Color.fromRGBO(84, 69, 64, 1),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Rating',
                    style: TextStyle(
                        fontSize: 17, color: Color.fromRGBO(84, 69, 64, 1)),
                  ),
                ],
                
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Ahmad’s articles',
                style: TextStyle(fontSize: 25),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 20,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    childAspectRatio: MediaQuery.of(context).size.height /
                        (MediaQuery.of(context).size.width) /
                        3.3,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, item) {
                    return Container(
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
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Itemmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm $item',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 23),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  '$item',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ]),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
