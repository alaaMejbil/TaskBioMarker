import 'package:biomarker_app/Model/biomarker.dart';
import 'package:biomarker_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'circular_container.dart';

class BioMarkerListTile extends StatelessWidget {
  final Biomarker currentItem;
  final onTap;

  const BioMarkerListTile({required this.currentItem, required this.onTap});

  @override
  Widget build(BuildContext context) {
    String rippleColor = currentItem.color!;

    return Padding(
      padding: EdgeInsets.only(bottom: 25),
      child: InkWell(
        splashColor: HexColor(rippleColor).withOpacity(0.2),
        onTap: this.onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Hero(
                    tag: currentItem.id!,
                    child: circularContainer(
                      symbol: currentItem.symbol!,
                      color: currentItem.color!,
                    )),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      currentItem.date,
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${currentItem.value}",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_sharp,
              size: 14,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
