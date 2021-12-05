import 'package:biomarker_app/Model/biomarker.dart';
import 'package:biomarker_app/wigdet/first_screen/circular_container.dart';
import 'package:biomarker_app/wigdet/second_screen/info_dialog.dart';
import 'package:biomarker_app/wigdet/second_screen/title_with_text.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home_screen.dart';

class BiomarkerDetailsScreen extends StatefulWidget {
  final Biomarker currentBiomarker;

  const BiomarkerDetailsScreen({Key? key, required this.currentBiomarker})
      : super(key: key);
  @override
  _BiomarkerDetailsScreenState createState() => _BiomarkerDetailsScreenState();
}

class _BiomarkerDetailsScreenState extends State<BiomarkerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'Biomarker Details',
          style: TextStyle(
              color: Colors.black87,
              fontSize: 22,
              letterSpacing: 1.1,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          "Blood",
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 7,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "${widget.currentBiomarker.symbol}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff4A4A4A),
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Icon(
                            Icons.access_time_rounded,
                            size: 19,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.currentBiomarker.date,
                      style: const TextStyle(
                        color: Color(0xff5A5A5A),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Hero(
                  tag: widget.currentBiomarker.id!,
                  child: circularContainer(
                    symbol: widget.currentBiomarker.symbol!,
                    color: widget.currentBiomarker.color!,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            DelayedDisplay(
              delay: const Duration(milliseconds: 200),
              fadingDuration: const Duration(milliseconds: 300),
              slidingBeginOffset: const Offset(0, 1),
              child: Text(
                'Your result is ${widget.currentBiomarker.value}',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: HexColor(widget.currentBiomarker.color!),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            DelayedDisplay(
              delay: const Duration(milliseconds: 300),
              fadingDuration: const Duration(milliseconds: 300),
              slidingBeginOffset: const Offset(0, 1),
              child: titleWithText(
                title: 'Info',
                msgText: widget.currentBiomarker.info!,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => InfoDialog(
                      text: widget.currentBiomarker.info!,
                      currentColor: HexColor(widget.currentBiomarker.color!),
                    ),
                  );
                },
              ),
            ),
            DelayedDisplay(
              delay: const Duration(milliseconds: 350),
              fadingDuration: const Duration(milliseconds: 300),
              slidingBeginOffset: const Offset(0, 1),
              child: titleWithText(
                title: 'Insights',
                msgText: widget.currentBiomarker.insight!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
