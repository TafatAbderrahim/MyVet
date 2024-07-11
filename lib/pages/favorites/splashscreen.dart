// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/models/user.dart';
import 'package:project/pages/pallette.dart';
import 'package:project/resources.dart';
import 'package:http/http.dart';

class Confirmbuy extends StatefulWidget {
  final double total;
  final TextEditingController addressController;
  final TextEditingController phoneNumberController;

  const Confirmbuy({
    Key? key,
    required this.total,
    required this.addressController,
    required this.phoneNumberController,
  }) : super(key: key);

  @override
  State<Confirmbuy> createState() => _ConfirmbuyState();
}

class _ConfirmbuyState extends State<Confirmbuy> {
  //====declaration===========================
  GlobalKey<FormState> fkey = GlobalKey();

  bool changesmade = false;

  TextEditingController address = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  void deletTextFields() {
    address.clear();
    phoneNumber.clear();
  }

  void keepTextFields() {
    widget.addressController.text = address.text;
    widget.phoneNumberController.text = phoneNumber.text;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 230,
      child: Column(
        children: [
          Text(
            'Total : ${widget.total.toString()} DA',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: fkey,
            onChanged: () {
              final isFilled =
                  address.text.isNotEmpty && phoneNumber.text.isNotEmpty;
              setState(() {
                changesmade = isFilled;
              });
            },
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  controller: address,
                  maxLength: 255,
                  keyboardType: TextInputType.text,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Adress',
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    counterText: '',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  maxLength: 10,
                  controller: phoneNumber,
                  keyboardType: TextInputType.phone,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Phone number',
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 12, 8, 8),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    counterText: '',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: changesmade
                          ? () async {
                              var response;
                              try {
                                var uri =
                                    Uri.parse('${Resources.Url}/cart/buy');
                                response = await post(uri, headers: {
                                  "jwt": context.read<User>().cookie,
                                  "Content-Type": "application/json",
                                });
                                print(json.decode(response.body));
                              } catch (e) {
                                print(e);
                              }
                              keepTextFields();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      json.decode(response.body)['message'])));
                              keepTextFields();
                              Navigator.of(context).pop();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallete.iconsvgcolor,
                      ),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(color: Pallete.texticon),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                            onPressed: () {
                              deletTextFields();
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Pallete.iconsvgcolor),
                            )),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
