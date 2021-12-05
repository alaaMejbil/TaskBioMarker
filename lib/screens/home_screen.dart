import 'dart:async';
import 'dart:io';
import 'package:biomarker_app/providers/biomarkers_provider.dart';
import 'package:biomarker_app/screens/biomarker_details_screen.dart';
import 'package:biomarker_app/wigdet/first_screen/biomarker_list_tile.dart';
import 'package:biomarker_app/wigdet/second_screen/info_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../utils.dart';
import 'no_internet_screen.dart';

class HomeScreem extends StatefulWidget {
  const HomeScreem({Key? key}) : super(key: key);

  @override
  _HomeScreemState createState() => _HomeScreemState();
}

class _HomeScreemState extends State<HomeScreem> {
  bool isLoading = false;
  StreamSubscription? subscription;

  @override
  void initState() {
    try {
      isLoading = true;

      subscription =
          Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);

      Provider.of<BioMarkerProvider>(context, listen: false)
          .fetchBioMarkers()
          .catchError((e) async {
        final result = await Connectivity().checkConnectivity();
        showConnectivitySnackBar(result);
        Provider.of<BioMarkerProvider>(context, listen: false).toggelIsOnline();
      }).then((value) {
        setState(() {
          isLoading = false;
        });
      });
    } catch (e) {
      print(e);
    }

    super.initState();
  }

  @override
  void dispose() {
    subscription!.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var providerBio = Provider.of<BioMarkerProvider>(context);
    return Scaffold(
        //extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text(
            'Report List',
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            return await providerBio.fetchBioMarkers().catchError((e) async {
              final result = await Connectivity().checkConnectivity();
              showConnectivitySnackBar(result);

              Provider.of<BioMarkerProvider>(context, listen: false)
                  .toggelIsOnline();
            });
          },
          child: Provider.of<BioMarkerProvider>(context).isOnline
              ? (isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                        itemCount: providerBio.bioMarkers.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 270),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: BioMarkerListTile(
                                currentItem: providerBio.bioMarkers[index],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BiomarkerDetailsScreen(
                                        currentBiomarker:
                                            providerBio.bioMarkers[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ))
              : const NoInternetScreen(),
        ));
  }

  void showConnectivitySnackBar(ConnectivityResult result) {
    // final hasInternet = result != ConnectivityResult.none;
    // final message = hasInternet
    //     ? 'You have again ${result.toString()}'
    //     : 'You have no internet';
    // final color = hasInternet ? Colors.green : Colors.red;

    // print("*************** $message");
    if (result == ConnectivityResult.none) {
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(
          text: 'Check Your Internet Conection !',
        ),
      );
    } else {
      Provider.of<BioMarkerProvider>(context, listen: false).fetchBioMarkers();
    }
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
