import 'dart:ui';

import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/bloc/loginbloc/login_bloc.dart';
import 'package:project/models/user.dart';
import 'package:project/pages/forgetpassword/forgetpassword.dart';
import 'package:project/pages/profile.dart';
import 'package:project/pages/sign_up.dart';

class Log extends StatefulWidget {
  @override
  State<Log> createState() => _LogState();
}

class _LogState extends State<Log> {
  bool isPasswordVisible = false;
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    userNameController.addListener(() {
      return setState(() {});
    });
    passwordController.addListener(() {
      return setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.loading) {
          FloatingSnackBar(
              message: ('Loading data'),
              context: context,
              duration: Duration(milliseconds: 500));
        } else if (state.error) {
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text('Error fetchimg data')));
          FloatingSnackBar(
              message: 'error fetching data',
              context: context,
              duration: Duration(seconds: 1));
        } else if (state.succes) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
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
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Icon(
                          Icons.arrow_back,
                          color: Color.fromRGBO(109, 76, 61, 1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Welcome back !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(109, 76, 61, 1),
                        fontSize: 42,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: userNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(color: Color.fromRGBO(0, 0, 0, 0.25)),
                        hintText: 'Email',
                        prefixIcon: Icon(
                          Icons.person_outline,
                          size: 30,
                          color: Color.fromRGBO(109, 76, 61, 1),
                        ),
                        suffixIcon: userNameController.text.isEmpty
                            ? Container(width: 0)
                            : IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    userNameController.clear();
                                  });
                                },
                              ),
                      ),
                      textInputAction: TextInputAction.done,
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(217, 217, 217, 1),
                        borderRadius: BorderRadius.circular(33),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade800,
                            blurRadius: 2,
                            spreadRadius: 0.2,
                            offset: Offset(0, 2),
                          )
                        ]),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(33),
                        color: Color.fromRGBO(217, 217, 217, 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade800,
                            spreadRadius: 0.2,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: TextField(
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(166, 164, 173, 1)),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color.fromRGBO(109, 76, 61, 1),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: isPasswordVisible
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (c)=>ForgetPassword()));
                        },
                        child: Text(
                          'Forgot password',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Color.fromRGBO(109, 76, 61, 1),
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        )),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade800,
                          spreadRadius: 0.2,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        )
                      ],
                      color: Color.fromRGBO(109, 76, 61, 1),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (passwordController.text.isEmpty ||
                            userNameController.text.isEmpty) {
                          FloatingSnackBar(
                            message: 'You should enter informations first',
                            context: context,
                            duration: Duration(milliseconds: 500),
                          );
                        } else {
                          context.read<LoginBloc>().add(LoginEvent(
                              email: userNameController.text,
                              password: passwordController.text));
                        }
                      },
                      child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state.loading) {
                            return Center(
                              child: CircularProgressIndicator(
                                value: 1,
                                color: Colors.white,
                              ),
                            );
                          } else {
                            return Text(
                              'Log in',
                              style: TextStyle(
                                  fontSize: 25, color: Colors.white),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1.5,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'or',
                          style: TextStyle(fontSize: 33, color: Colors.white),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Divider(
                            thickness: 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/facebook_logo.png',
                            color: Colors.white,
                          ),
                          iconSize: 25,
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        height: 80,
                        width: 80,
                        child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/google_icon.png',
                            color: Colors.white,
                          ),
                          iconSize: 25,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account?',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Sign()));
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(109, 76, 61, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
