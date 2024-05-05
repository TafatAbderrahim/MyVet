import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Ratestar extends StatefulWidget {
  bool isRated;
  bool isClickable;
  Ratestar({
    Key? key,
    required this.isRated,
    required this.isClickable,
  }) : super(key: key);

  @override
  State<Ratestar> createState() => _RatestarState();
}

class _RatestarState extends State<Ratestar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 29,
      height: 30,
      margin: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 2),
      child: ClipRect(
        child: Transform.scale(
          scale: 2.9,
          child: IconButton(
            onPressed: () {
              setState(() {
                if(widget.isClickable){widget.isRated = !widget.isRated;}
              });
            },
            icon: Icon(
              widget.isRated ? Icons.star : Icons.star_border,
              color: widget.isRated ? const Color(0xFFD9D226) : Colors.black,
              size: 9,
            ),
          ),
        ),
      ),
    );
  }
}
