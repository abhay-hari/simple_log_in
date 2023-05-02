import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:map_launcher/map_launcher.dart';
import '../../db/functions/dbfunctions.dart';
import '../../model/cart mode.dart';

class ScreenDeleveryOrders extends StatefulWidget {
  const ScreenDeleveryOrders({super.key});

  @override
  State<ScreenDeleveryOrders> createState() => _ScreenDeleveryOrdersState();
}

class _ScreenDeleveryOrdersState extends State<ScreenDeleveryOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text("All Orders"),
          SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ValueListenableBuilder<List<AddtoCart>>(
                valueListenable: cartListNotifier,
                builder: (context, cartList, child) {
                  return ListView.separated(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(10),
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      final data = cartList[index];
                      return Container(
                        height: 125,
                        decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "${data.name}",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            Text("${data.location}",
                                textAlign: TextAlign.center),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    callNowbutton(data.phoneNumber);
                                    // print(data.phoneNumber.trim());
                                    // launchUrlString(
                                    //     'tel:+${data.phoneNumber.trim()}');
                                  },
                                  child: Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            60,
                                    decoration: BoxDecoration(
                                        color: Colors.yellow[100],
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: ListTile(
                                      title: Text("Call now"),
                                      trailing: Icon(Icons.call),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await launchMap(double.parse(data.lat),
                                        double.parse(data.long));
                                  },
                                  child: Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            60,
                                    decoration: BoxDecoration(
                                        color: Colors.green[100],
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: ListTile(
                                      title: Text("Go to"),
                                      trailing: Icon(Icons.navigation),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                  );
                },
              ))
        ],
      ),
    );
  }

  Future<void> callNowbutton(String phoneNumber) async {
    final Uri url = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("cant call");
    }
  }

  Future<void> launchMap(double latitude, double longitude) async {
    final availableMaps = await MapLauncher.installedMaps;
    print(availableMaps);
    await availableMaps.first
        .showMarker(coords: Coords(latitude, longitude), title: "");
  }
}

  // Future<void> launchMapsUrl(String lat, String long) async {
  //   final url = 'https://maps.google.com/?q=8.343105,77.132187';
  //   // final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(Uri.parse(url));

  //     print("uri launched");
  //   } else {
  //     throw 'Could not launch';
  //     print("uri error");
  //   }
  // }

  // Future<void> _openMap(String lat, String long) async {
  //   String googleUrl = "https://maps.google.com/?q=8.343105,77.132187";
  //   await canLaunchUrlString(googleUrl)
  //       ? launchUrlString(googleUrl)
  //       : throw "could not launch $googleUrl";
  // }

  // Future<void> openMap(double latitude, double longitude) async {
  //   String googleUrl =
  //       'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  //   if (await canLaunchUrl(Uri.parse(googleUrl))) {
  //     await launchUrl(Uri.parse(googleUrl));
  //   } else {
  //     throw 'Could not open the map.';
  //   }
  // }

  // launchURL() async {
  //   const String homeLat = "37.3230";
  //   const String homeLng = "-122.0312";

  //   final String googleMapslocationUrl =
  //       "https://www.google.com/maps/search/?api=1&query=${homeLat},${homeLng}";

  //   final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

  //   if (await canLaunch(encodedURl)) {
  //     await launch(encodedURl);
  //   } else {
  //     print('Could not launch $encodedURl');
  //     throw 'Could not launch $encodedURl';
  //   }
  // }
// ListTile(
//                         title: Text(data.name),
//                         subtitle: Text(data.location),
//                         trailing: IconButton(
//                             onPressed: () async {
//                               await launchMap(double.parse(data.lat),
//                                   double.parse(data.long));
//                               // launchURL();
//                               // openMap(double.parse(data.lat),
//                               //     double.parse(data.long));
//                               // await _openMap(data.lat, data.long);
//                             },
//                             icon: Icon(
//                               Icons.near_me,
//                               color: Colors.green[300],
//                             )),
//                       );
                    