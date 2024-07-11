import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  TextEditingController userNameController = TextEditingController();
  void initState() {
    super.initState();
    userNameController.addListener(() {
      return setState(() {});
    });
  }

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
          padding: EdgeInsets.all( 20),
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
            SizedBox(height: MediaQuery.of(context).size.height / 3-100),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Reset password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(109, 76, 61, 1),
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              child: TextField(
                keyboardType: TextInputType.number,
                controller: userNameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.25)),
                  hintText: 'password',
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
            SizedBox(height: 30),
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
                onPressed: () {},
                child: Text(
                  'Reset password',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 3),
          ],
        ),
      ),
    ));
  }
}
