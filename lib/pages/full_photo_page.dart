import 'package:flutter/material.dart';

class FullPhotoPage extends StatelessWidget {
  String fullImage;

  FullPhotoPage({required this.fullImage});

  //const FullPhotoPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(fullImage),
          fit: BoxFit.cover,
        )),
      ),
    );
  }
}
