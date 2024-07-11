import 'package:flutter/material.dart';
import 'package:project/models/product.dart';

class Itemsized extends StatefulWidget {
  List<SizeSchema> sizes = [];

  Itemsized({
    Key? key,
    required this.sizes,
  }) : super(key: key);

  @override
  State<Itemsized> createState() => _ItemsizedState();
}

class _ItemsizedState extends State<Itemsized> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.sizes.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 1),
            child: SizedBox(
              width: 40,
              height: 40,
              child: TextButton(
                onPressed: () {
                  i = index;
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                child: Text(
                  widget.sizes[index].value,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
