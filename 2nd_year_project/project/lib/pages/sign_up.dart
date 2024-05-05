import 'dart:ui';

import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/bloc/signupbloc/register_bloc.dart';
import 'package:project/pages/log_in.dart';
import 'package:project/pages/profile.dart';

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final password2 = TextEditingController();
  final phoneNumer = TextEditingController();

  bool agree = false;
  bool isSeller = false;
  void initState() {
    super.initState();
    firstName.addListener(() {
      return setState(() {});
    });
    lastName.addListener(() {
      return setState(() {});
    });
    email.addListener(() {
      return setState(() {});
    });
    password.addListener(() {
      return setState(() {});
    });
    password2.addListener(() {
      return setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.error == true) {
          FloatingSnackBar(
            message: 'Error registering',
            context: context,
            duration: Duration(milliseconds: 500),
          );
        } else if (state.exist == true) {
          FloatingSnackBar(
            message: 'User already exist',
            context: context,
            duration: Duration(milliseconds: 500),
          );
        } else if (state.success == true) {
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
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(children: [
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(217, 217, 217, 1),
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
                    SizedBox(height: 100),
                    Text(
                      'Sign up',
                      //textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Color.fromRGBO(109, 76, 61, 1),
                        fontSize: 42,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Flexible(
                            child: fields('First name', firstName, false,
                                TextInputType.text)),
                        SizedBox(width: 5),
                        Flexible(
                            child: fields('Last name', lastName, false,
                                TextInputType.text)),
                      ],
                    ),
                    SizedBox(height: 15),
                    fields(
                        'Phone Number', phoneNumer, false, TextInputType.phone),
                    SizedBox(height: 15),
                    fields('Email', email, false, TextInputType.emailAddress),
                    SizedBox(height: 15),
                    fields('Password', password, true, TextInputType.text),
                    SizedBox(height: 15),
                    fields('Confirm password', password2, true,
                        TextInputType.text),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          side: BorderSide.none,
                          fillColor: MaterialStatePropertyAll(Colors.white),
                          checkColor: Color.fromRGBO(109, 76, 61, 1),
                          value: agree,
                          onChanged: (value) {
                            setState(() {
                              agree = !agree;
                            });
                          },
                        ),
                        Text(
                          'I agree with the',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'privacy',
                            style: TextStyle(
                              color: Color.fromRGBO(109, 76, 61, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade800,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          )
                        ],
                        color: Color.fromRGBO(109, 76, 61, 1),
                        borderRadius: BorderRadius.circular(33),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if (password.text.length <= 4) {
                            FloatingSnackBar(
                                duration: Duration(milliseconds: 500),
                                message:
                                    'Password should be superior than 4 characters',
                                context: context);
                          } else if (password.text == password2.text && agree) {
                            context.read<RegisterBloc>().add(RegisterEvent(
                                firstName.text,
                                lastName.text,
                                email.text,
                                password.text));
                          } else if (password.text != password2.text && agree) {
                            FloatingSnackBar(
                                duration: Duration(milliseconds: 500),
                                message: 'Password doesn\'t match',
                                context: context);
                          } else if (!agree) {
                            FloatingSnackBar(
                                duration: Duration(milliseconds: 500),
                                message: 'You should agree first',
                                context: context);
                          }
                        },
                        child: BlocBuilder<RegisterBloc, RegisterState>(
                          builder: (context, state) {
                            if (state.loading == true) {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: 1,
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return Text(
                                'Sign up',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account ?',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => Log()));
                          },
                          child: Text(
                            'Log in',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(109, 76, 61, 1)),
                          ),
                        )
                      ],
                    )
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget fields(
      String hintext, var Controller, bool ispassword, TextInputType type) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color.fromRGBO(217, 217, 217, 1),
          borderRadius: BorderRadius.circular(33),
        ),
        child: TextField(
          keyboardType: type,
          obscureText: ispassword,
          controller: Controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(color: Color.fromRGBO(166, 164, 173, 1)),
            hintText: hintext,
          ),
        ),
      ),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(33), boxShadow: [
        BoxShadow(
          color: Colors.grey.shade800,
          spreadRadius: 0.2,
          blurRadius: 2,
          offset: Offset(0, 2),
        )
      ]),
    );
  }
}
