import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SellerForm extends StatefulWidget {
  const SellerForm({super.key});

  @override
  State<SellerForm> createState() => _SellerFormState();
}

class _SellerFormState extends State<SellerForm> {
  bool modify = false;
  File? selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Text(
                    'Seller Form',
                    style: TextStyle(
                        fontSize: 33, color: Color.fromRGBO(109, 76, 61, 1)),
                  ),
                  SizedBox(width: 55)
                ],
              ),
              SizedBox(height: 30),
              fields('Phone number', 60, 1, 10, TextInputType.number),
              SizedBox(height: 30),
              Text('Take a photo of your ID card'),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  print('Photo');
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
                              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(217, 217, 217, 1))),
                                onPressed: () {
                                  pickImageCamera();
                                },
                                child: Text(
                                  'Camera',
                                  style: TextStyle(
                                      color: Color.fromRGBO(109, 76, 61, 1)),
                                )),
                                SizedBox(height: 10),
                            ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(109, 76, 61, 1))),
                                onPressed: () {
                                  pickImageGallery();
                                },
                                child: Text(
                                  'Gallery',
                                  style: TextStyle(
                                      color: Color.fromRGBO(217, 217, 217, 1)),
                                ))
                          ],
                        );
                      });
                },
                child: Container(
                  //t3 lphoto

                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromRGBO(220, 210, 204, 1),
                  ),
                  //t3photo:
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 55,
                        ),
                        Text(
                          'Add photo',
                          style: TextStyle(fontSize: 22),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                //boutton t3 save
                child: Container(
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Send Form',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fields(String hintText, double height, int maxlines, int maxlength,
      TextInputType inputType) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(220, 210, 204, 1),
        borderRadius: BorderRadius.circular(15),
      ),
      height: height,
      child: Center(
        child: TextField(
          keyboardType: inputType,
          //controller: controller,
          maxLength: maxlength,
          maxLines: maxlines,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: hintText,
            counter: Offstage(),
            border: InputBorder.none,
            suffixIcon: Icon(Icons.create),
          ),
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
