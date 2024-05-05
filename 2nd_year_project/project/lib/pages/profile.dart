import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/bloc/loginbloc/login_bloc.dart';
import 'package:project/main.dart';
import 'package:project/models/user.dart';
import 'package:project/pages/favorites/favourites.dart';
import 'package:project/pages/log_in.dart';
import 'package:project/pages/myArticles.dart';
import 'package:project/pages/sellerForm.dart';
import 'package:project/pages/settings.dart';
import 'package:project/pages/sign_up.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  bool isConnected = false;
  void readData() {
    final _box = Hive.box('user');
    this.isConnected = _box.get('isConnected');
  }

  Widget build(BuildContext context) {
    readData();
    if (isConnected != null) {
      return Scaffold(
          body: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (context.read<User>().isConnected) {
          return ProfileAfter();
        } else {
          return ProfileBefore();
        }
      }));
    } else {
      return ProfileBefore();
    }
    ;
  }
}

class ProfileAfter extends StatefulWidget {
  @override
  State<ProfileAfter> createState() => _ProfileAfterState();
}

class _ProfileAfterState extends State<ProfileAfter> {
  bool isSeller = false;
  File? selectedImage;

  late String firstName = 'hh', lastName = 'oo', cookie = '';
  void readData() {
    final _box = Hive.box('user');
    //print(user["firstName"]);
    this.firstName = _box.get('firstName');
    this.lastName = _box.get('lastName');
    this.isSeller = _box.get('isSeller');
    this.cookie = _box.get('cookie');
  }

  @override
  Widget build(BuildContext context) {
    readData();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              child: Stack(
                children: [
                  //carre beige
                  Container(
                    height: 170,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(160, 136, 127, 1),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                  ),
                  //t3 photo
                  Column(
                    children: [
                      SizedBox(height: 60),
                      Stack(
                        children: [
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(217, 217, 217, 1),
                                shape: BoxShape.circle,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(99),
                                child: Image.network(
                                  height: 200,
                                  loadingBuilder:
                                      (context, child, loadingProgress) => Icon(
                                    Icons.person_rounded,
                                    size: 200,
                                  ),
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(
                                    Icons.person_rounded,
                                    size: 200,
                                  ),
                                  context.read<User>().profilePic,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0.0,
                            right: MediaQuery.of(context).size.width / 2 - 90,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(217, 217, 217, 1),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (C) {
                                        return SimpleDialog(
                                          backgroundColor: Colors.white,
                                          contentPadding: EdgeInsets.all(12),
                                          title: Text(
                                            'Add photo',
                                          ),
                                          children: [
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            Color.fromRGBO(217,
                                                                217, 217, 1))),
                                                onPressed: () {
                                                  pickImageCamera();
                                                },
                                                child: Text(
                                                  'Camera',
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          109, 76, 61, 1)),
                                                )),
                                            SizedBox(height: 10),
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            Color.fromRGBO(109,
                                                                76, 61, 1))),
                                                onPressed: () {
                                                  pickImageGallery();
                                                },
                                                child: Text(
                                                  'Gallery',
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          217, 217, 217, 1)),
                                                ))
                                          ],
                                        );
                                      });
                                  ;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            isSeller
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sells:+5000'),
                      Text('Rating:4,3'),
                      Text('Joined:28/07/2004')
                    ],
                  )
                : Row(),
            SizedBox(height: 10),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return ProfileOptions(
                  this.firstName + ' ' + this.lastName,
                  Icons.person_outline,
                );
              },
            ),
            Divider(thickness: 2),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return ProfileOptions(
                  context.read<User>().email,
                  Icons.mail_rounded,
                );
              },
            ),
            Divider(thickness: 2),
            ProfileOptions(
              '07********       ',
              Icons.phone_android,
            ),
            Divider(thickness: 2),
            Container(
              child: Column(children: [
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (c) => Myfavourites(false)));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(
                        Icons.favorite_border_outlined,
                        color: Color.fromRGBO(84, 69, 64, 1),
                        size: 30,
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Favorites',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(84, 69, 64, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ]),
            ),
            Divider(thickness: 2),
            isSeller
                ? Container(
                    child: Column(children: [
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (c) {
                            return MyArticles();
                          }));
                        },
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Image.asset(
                              'assets/MyArticles.png',
                              width: 30,
                              height: 30,
                              color: Color.fromRGBO(84, 69, 64, 1),
                            ),
                            SizedBox(width: 15),
                            Text(
                              'My articles',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(84, 69, 64, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                    ]),
                  )
                : Container(
                    child: Column(children: [
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (c) => SellerForm()));
                        },
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_circle_up_sharp,
                              color: Color.fromRGBO(84, 69, 64, 1),
                              size: 30,
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Upgrade to seller',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(84, 69, 64, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                    ]),
                  ),
            Divider(thickness: 2),
            Container(
              child: Column(children: [
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) => Settings()));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(
                        Icons.settings,
                        color: Color.fromRGBO(84, 69, 64, 1),
                        size: 30,
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(84, 69, 64, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ]),
            ),
            Divider(thickness: 2),
            Container(
              child: Column(children: [
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    context.read<User>().isConnected=false;
                    var box = Hive.box('user');
                    box.put('isConnected', false);
                    box.put('cookie', '');
                    box.put('id', '');
                    box.put('firstName', '');
                    box.put('lastName', '');
                    box.put('password', '');
                    box.put('email', '');
                    box.put('profilePic', '');
                    box.put('isSeller', '');
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (c) => MyWidget()));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(
                        Icons.logout,
                        color: Color.fromRGBO(84, 69, 64, 1),
                        size: 30,
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(84, 69, 64, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ]),
            ),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  Future pickImageGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(returnedImage!.path);
    });
  }

  Future pickImageCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) {
      return;
    }
    setState(() {
      selectedImage = File(returnedImage!.path);
    });
  }
}

// getBox(var box, var user) async {
//   box = await Hive.openBox('user');
//   user = box.get(1);
// }

class ProfileBefore extends StatefulWidget {
  @override
  State<ProfileBefore> createState() => _ProfileBeforeState();
}

class _ProfileBeforeState extends State<ProfileBefore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          'assets/background.jpeg',
        ),
        fit: BoxFit.cover,
      )),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 7,
          sigmaY: 7,
        ),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 220),
            Center(
              child: Text(
                'Get Started',
                style: TextStyle(
                  color: Color.fromRGBO(109, 76, 61, 1),
                  fontSize: 42,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              height: 300,
              child: Image.asset(
                'assets/whit_logo_Mesa de trabajo 1 1.png',
                color: Color.fromRGBO(255, 255, 255, 0.25),
              ),
            ),
            Container(
              height: 60,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 70),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 187, 187, 187),
                    blurRadius: 1,
                  )
                ],
                color: Color.fromRGBO(109, 76, 61, 1),
                borderRadius: BorderRadius.circular(33),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => Sign()));
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 70),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(33),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => Log()));
                },
                child: Text(
                  'Log In',
                  style: TextStyle(
                      fontSize: 25, color: Color.fromRGBO(109, 76, 61, 1)),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

Widget ProfileOptions(String text, IconData icon) {
  return Container(
    child: Column(children: [
      SizedBox(height: 10),
      GestureDetector(
        onTap: () {
          print('abcdefghijklmnopqrstuvwxyz');
        },
        child: Row(
          children: [
            SizedBox(width: 10),
            Icon(
              icon,
              color: Color.fromRGBO(84, 69, 64, 1),
              size: 30,
            ),
            SizedBox(width: 15),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(84, 69, 64, 1),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 10),
    ]),
  );
}
