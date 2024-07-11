import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:project/models/user.dart';
import 'package:project/pages/pallette.dart';
import 'package:project/resources.dart';
//import 'package:lib/pages/pallette.dart';
import 'package:http/http.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  static const route = '/personalinfo';
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double sizedboxheight = 10;
  GlobalKey<FormState> formkey = GlobalKey();
  bool showpassword = true;
  bool changesMade = false;
  //new changing inforamtion
  TextEditingController newfirstname = TextEditingController();
  TextEditingController newlastname = TextEditingController();
  TextEditingController newemail = TextEditingController();
  TextEditingController newPhonenumber = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController prePassword = TextEditingController();
//old informaion
  String previousPassword = 'co'; // Correct previous password
  List<String> information = [
    'First name',
    'Last name',
    'Email',
    'Phone number',
    'Previous Password',
    'New Password',
    'Confirm Password'
  ];
  final Map<String, bool> _passwordVisibility = {
    'Previous Password': false,
    'New Password': false,
    'Confirm Password': false,
  };

  bool showPasswordFor(String label) {
    return _passwordVisibility[label]!;
  }

  @override
  void initState() {
    var box = Hive.box('user');
    newfirstname = TextEditingController(text: box.get('firstName'));
    newlastname = TextEditingController(text: box.get('lastName'));
    newemail = TextEditingController(text: box.get('email'));
    // newPhonenumber = TextEditingController(box.get('phone'));
    newPassword = TextEditingController();
    confirmpassword = TextEditingController();
    prePassword = TextEditingController();
  }

  void togglePasswordVisibility(String label) {
    setState(() {
      _passwordVisibility[label] = !_passwordVisibility[label]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 40,
              left: 23,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back,
                  size: 40,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 80, left: 20, right: 20, bottom: 0),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 230, bottom: 1),
                        child: texttitle(information[0]),
                      ),
                      mytextfield(information[0], newfirstname),
                      SizedBox(height: sizedboxheight),
                      Padding(
                        padding: const EdgeInsets.only(right: 230, bottom: 1),
                        child: texttitle(information[1]),
                      ),
                      mytextfield(information[1], newlastname),
                      SizedBox(height: sizedboxheight),
                      Padding(
                        padding: const EdgeInsets.only(right: 260, bottom: 1),
                        child: texttitle(information[2]),
                      ),
                      mytextfield(information[2], newemail),
                      SizedBox(height: sizedboxheight),
                      Padding(
                        padding: const EdgeInsets.only(right: 200, bottom: 1),
                        child: texttitle(information[3]),
                      ),
                      mytextfield(information[3], newPhonenumber),
                      SizedBox(height: sizedboxheight),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 1, left: 10),
                        child: titlepasword(information[4]),
                      ),
                      mytextfield(information[4], prePassword),
                      SizedBox(height: sizedboxheight),
                      Padding(
                        padding: const EdgeInsets.only(right: 190, bottom: 1),
                        child: texttitle(information[5]),
                      ),
                      mytextfield(information[5], newPassword),
                      SizedBox(height: sizedboxheight),
                      Padding(
                        padding: const EdgeInsets.only(right: 170, bottom: 1),
                        child: texttitle(information[6]),
                      ),
                      mytextfield(information[6], confirmpassword),
                      SizedBox(height: sizedboxheight),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 150, top: 10),
                            child: ElevatedButton(
                              onPressed: (changesMade &&
                                      ((newPassword.text.isNotEmpty &&
                                          confirmpassword.text.isNotEmpty &&
                                          newPassword.text ==
                                              confirmpassword.text)))
                                  ? () async {
                                      var box = Hive.box('user');
                                      var cookie = box.get('cookie');
                                      var uri, response;
                                      uri = Uri.parse(
                                          '${Resources.Url}/Settings');
                                      try {
                                        print(newemail.text);
                                        response = await patch(
                                          uri,
                                          headers: {
                                            "jwt": cookie,
                                            "Content-Type": "application/json",
                                          },
                                          body: json.encode({
                                            "email": newemail.text,
                                            "firstName": newfirstname.text,
                                            "lastName": newlastname.text,
                                            "password": newPassword.text,
                                            "pic": "picture",
                                          }),
                                        );
                                        var box = Hive.box('user');
                                        box.put('firstName', newfirstname.text);
                                        box.put('lastName', newlastname.text);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              'Changes saved successfully'),
                                          duration: Duration(seconds: 2),
                                        ));
                                        print('response:${response.body}');
                                      } catch (e) {
                                        print(e);
                                      }

                                      setState(() {
                                        changesMade = false;
                                      });
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Pallete.iconsvgcolor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                              ),
                              child: const Text(
                                'Save changes',
                                style: TextStyle(
                                    color: Pallete.texticon, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//==========================================================================
  Widget titlepasword(String info) {
    return Row(
      children: [
        Text(
          info,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const Text(
          ' *',
          style: TextStyle(color: Colors.red, fontSize: 15),
        ),
      ],
    );
  }

  Widget texttitle(String info) {
    return Text(
      info,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    );
  }

  Widget mytextfield(
    String labeltex,
    TextEditingController newinfo,
  ) {
    bool obscureText = (labeltex == 'Previous Password' ||
        labeltex == 'New Password' ||
        labeltex == 'Confirm Password');
    TextInputType keyboardType;
    if (labeltex == information[2]) {
      keyboardType = TextInputType.emailAddress;
    } else if (labeltex == information[3]) {
      keyboardType = TextInputType.phone;
    } else {
      keyboardType = TextInputType.text;
    }
    int mx;
    if (labeltex == information[3]) {
      mx = 10;
    } else {
      mx = 255;
    }

    return TextFormField(
      controller: newinfo,
      maxLength: mx,
      keyboardType: keyboardType, //type of TextFormField
      autofocus: true,

      obscureText: obscureText
          ? !showPasswordFor(labeltex)
          : false, //visibility text (password)
      decoration: InputDecoration(
        suffixIcon: labeltex == 'Previous Password'
            ? IconButton(
                onPressed: () {
                  togglePasswordVisibility(labeltex);
                },
                icon: Icon(
                  showPasswordFor(labeltex)
                      ? Icons.remove_red_eye
                      : Icons.visibility_off,
                  color: Colors.grey,
                  size: 20,
                ),
              )
            : null,
        counterText: '',
        fillColor: Pallete.txtfieldcolor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      ),
      onChanged: (value) {
        setState(() {
          changesMade = true;
        });
      },

      validator: (value) {
        if (labeltex == 'Previous Password' && value != previousPassword) {}
        if (labeltex == information[6] && value != newPassword.text) {}
        return null;
      },
    );
  }
}
