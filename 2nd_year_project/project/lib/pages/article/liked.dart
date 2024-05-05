import 'package:flutter/material.dart';
import 'package:project/pages/pallette.dart';

// ignore: must_be_immutable
class Liked extends StatefulWidget {
  bool islaked;
  final bool isSigned;

  Liked({Key? key, required this.islaked, required this.isSigned})
      : super(key: key);

  @override
  State<Liked> createState() => _LikedState();
}

class _LikedState extends State<Liked> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          alignment: Alignment.center,
          icon: Icon(
            widget.islaked ? Icons.favorite : Icons.favorite_border,
            color: widget.islaked ? Pallete.iconsvgcolor : Colors.black,
            size: 30,
          ),
          onPressed: () {
            if (widget.isSigned) {
              setState(() {
                widget.islaked = !widget.islaked;
              });
            } else {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //     content: Text('You need to sign in to like this item.'),
              //   ),
              // );
            }
          },
        ),
      ),
    );
  }
}
