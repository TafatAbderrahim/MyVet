// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/pages/pallette.dart';

class Confirmbuy extends StatefulWidget {
  final double total;
  final TextEditingController emailController;
  final TextEditingController addressController;
  final TextEditingController phoneNumberController;

  const Confirmbuy({
    Key? key,
    required this.total,
    required this.emailController,
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

  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  void deletTextFields() {
    email.clear();
    address.clear();
    phoneNumber.clear();
  }

  void keepTextFields() {
    widget.emailController.text = email.text;
    widget.addressController.text = address.text;
    widget.phoneNumberController.text = phoneNumber.text;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 300,
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
              final isFilled = email.text.isNotEmpty &&
                  address.text.isNotEmpty &&
                  phoneNumber.text.isNotEmpty;
              setState(() {
                changesmade = isFilled;
              });
            },
            child: Column(
              children: [
                TextFormField(
                  maxLength: 255,
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Email',
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
                  height: 30,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: changesmade
                          ? () {
                              keepTextFields();
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Container(
                                      height: 300,
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            SvgPicture.asset(
                                              'lib/assets/svgs/Truemark.svg',
                                              width: 180,
                                              color: Pallete.iconsvgcolor,
                                            ),
                                            const SizedBox(height: 10),
                                            Container(
                                              alignment: Alignment.center,
                                              width: 160,
                                              child: const Text(
                                                'Your order has been\nconfirmed successfully',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            TextButton(
                                              onPressed: () {
                                                deletTextFields();

                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'Go Back',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color:
                                                        Pallete.iconsvgcolor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                              keepTextFields();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallete.iconsvgcolor,
                      ),
                      child: const Text(
                        'Confirm ',
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
