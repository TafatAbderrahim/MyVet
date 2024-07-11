import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project/pages/pallette.dart';
import 'package:project/resources.dart';
import 'package:http/http.dart';

// ignore: must_be_immutable
class Liked extends StatefulWidget {
  final bool isSigned;
  final String id;

  Liked(
      {Key? key,
      required this.isSigned,
      required this.id,})
      : super(key: key);

  @override
  State<Liked> createState() => _LikedState();
}

class _LikedState extends State<Liked> {
  Future getData() async {
    var uri = Uri.parse('${Resources.Url}/product/${widget.id}');
    try {
      var box = Hive.box('user');
      var token = box.get('cookie');
      print('token=${token}');
      var data, donnees, response;
      response = await get(
        uri,
        headers: {"Content-Type": "application/json", "jwt": "$token"},
      );
      data = response.body;
      donnees = json.decode(data);
      print(donnees);
      donnees = donnees['isFavorite'];
      print(donnees);
      islaked = donnees;
      return donnees;
    } catch (e) {
      print('error= $e');
    }
  }

  bool islaked = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          alignment: Alignment.center,
          icon: Icon(
            islaked ? Icons.favorite : Icons.favorite_border,
            color: islaked ? Pallete.iconsvgcolor : Colors.black,
            size: 30,
          ),
          onPressed: () async {
            if (widget.isSigned) {
              print('id= ${widget.id}');
              var uri =
                  Uri.parse('${Resources.Url}/favorites/product/${widget.id}');

              try {
                var box = Hive.box('user');
                var token = box.get('cookie');
                print('token=${token}');
               var  response;
                response = await post(uri,
                    headers: {
                      "Content-Type": "application/json",
                      "Authorization": '$token',
                    },
                    body: json.encode(
                      {},
                    ));
                
                setState(() {
                  islaked = !islaked;
                });
              } catch (e) {
                print('error=${e}');
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('You need to sign in to like this item.'),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
