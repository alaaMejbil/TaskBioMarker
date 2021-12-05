import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: 75,
            color: Colors.red,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'No Internet Connection !',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'check your internet connection and try agine.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
