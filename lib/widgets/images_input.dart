import 'package:flutter/material.dart';

class ImagesInput extends StatefulWidget {
  const ImagesInput({super.key});

  @override
  State<ImagesInput> createState() => _ImagesInputState();
}

class _ImagesInputState extends State<ImagesInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          margin: const EdgeInsets.only(
            top: 8,
            right: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: const Center(
            child: Text('No image!'),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.camera),
          label: const Text('Take picture'),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).primaryColor, textStyle: TextStyle(
              fontSize: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
        )),
      ],
    );
  }
}
