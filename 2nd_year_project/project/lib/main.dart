import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/bloc/loginbloc/login_bloc.dart';
import 'package:project/bloc/signupbloc/register_bloc.dart';
import 'package:project/blocobv.dart';
import 'package:project/models/user.dart';
// import 'package:project/pages/articleDetails.dart';
import 'package:project/pages/favorites/favourites.dart';
import 'package:project/pages/favorites/splashscreen.dart';
import 'package:project/pages/home.dart';
import 'package:project/pages/log_in.dart';
// import 'package:project/pages/log_in.dart';
// import 'package:project/pages/myArticles.dart';
// import 'package:project/pages/othersProfile.dart';
import 'package:project/pages/profile.dart';
import 'package:project/pages/searchpage.dart';
import 'package:project/pages/sellerForm.dart';
import 'package:project/pages/sign_up.dart';
//import 'package:project/pages/sellerForm.dart';
import 'package:project/pages/splashscreen.dart';
// import 'package:project/pages/sign_up.dart';
// import 'package:project/pages/splashscreen.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('user');

  runApp(MainApp());
  Bloc.observer = DebugBlocObserver();
}

// ignore: must_be_immutable
class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => MainAppState();
}

class MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  @override
  var box = Hive.box('user');

  boxData() {
    if (!box.containsKey('isConnected')) {
      box.add('cookie');
      box.put('cookie','');
      box.add('id');
      box.put('id','');
      box.add('firstName');
      box.put('firstName', '');

      box.add('lastName');
      box.put('lastName', '');

      box.add('email');
      box.add('password');

      box.put('password', '');
      box.put('email', '');

      box.add('profilePic');
      box.put('profilePic', '');

      box.add('isSeller');
      box.put('isSeller', '');

      box.add('isConnected');
      box.put('isConnected', false);
    }
  }

  Widget build(BuildContext context) {
    boxData();
    return RepositoryProvider(
      create: (context) => User(
        cookie: box.get('cookie'),
          id: box.get('id'),
          firstName: box.get('firstName'),
          lastName: box.get('lastName'),
          email: box.get('email'),
          profilePic: box.get('profilePic'),
          isConnected: box.get('isConnected'),
          isSeller: false),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc(context.read<User>())),
          BlocProvider(create: (context) => RegisterBloc(context.read<User>())),
        ],
        child: SafeArea(
          child: MaterialApp(
            theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
            title: 'MyVet',
            debugShowCheckedModeBanner: false,
            home: MyWidget(),
          ),
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: null,
      body: Stack(
        children: [
          Container(
            child: CurrentPage(),
          ),
          Positioned.fill(
            top: MediaQuery.of(context).size.height-110,
            child: Center(
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(12, 5, 5, 12),
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.white)],
                  color: Color.fromRGBO(160, 136, 127, 1),
                  borderRadius: BorderRadius.all(Radius.circular(33)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(NavIndex.pages.length, (index) {
                    return IconButton(
                      iconSize: 30,
                      color: (index == NavIndex.PageIndex)
                          ? Color.fromRGBO(84, 69, 64, 1)
                          : Colors.white,
                      icon: NavIndex.items[index],
                      onPressed: () {
                        setState(() {
                          NavIndex.PageIndex = index;
                        });
                      },
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavIndex {
  static int PageIndex = 0;
  static var pages = [
    Home(),
    Search(),
    Myfavourites(true),
    Profile(),
  ];
  static final items = [
    Icon(Icons.home),
    Icon(Icons.search),
    Icon(Icons.shopping_cart),
    Icon(Icons.person_outline),
  ];
}

class CurrentPage extends StatefulWidget {
  const CurrentPage({super.key});

  @override
  State<CurrentPage> createState() => _CurrentPageState();
}

class _CurrentPageState extends State<CurrentPage> {
  @override
  Widget build(BuildContext context) {
    return NavIndex.pages[NavIndex.PageIndex];
  }
}
