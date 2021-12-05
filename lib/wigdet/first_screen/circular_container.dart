import 'package:biomarker_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class circularContainer extends StatelessWidget {
  final String symbol;
  final String color;

  const circularContainer({Key? key, required this.symbol, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        color: HexColor(color).withOpacity(0.3),
        shape: BoxShape.circle,
        border: Border.all(
          color: HexColor(color),
          width: 4,
        ),
      ),
      child: Center(
        child: Text(
          "${symbol}",
          style: TextStyle(fontSize: 14, color: HexColor(color)),
        ),
      ),
    );
  }
}
