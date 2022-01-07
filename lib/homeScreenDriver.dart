import 'package:flutter/material.dart';
import 'package:followbus/model/modelStudentsList.dart';
import 'package:followbus/mapScreen.dart';
import 'package:geolocator/geolocator.dart';

import 'package:latlong/latlong.dart';

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

List<String> filterLocation = List();

class HomePageDriver extends StatefulWidget {
  final List<DataS> datas;
  final String location;
  HomePageDriver({
    @required this.datas,
    @required this.location,
  });
  @override
  _State createState() => _State();
}

class _State extends State<HomePageDriver> {
  double longitude = 0, latitude = 0;
  List<DataS> filter = List();

  _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      longitude = position.longitude;
      latitude = position.latitude;
    });
  }

  double _getDistance(List splitLocation) {
    final Distance distance = new Distance();

    final double meter = distance(
        new LatLng(
            double.parse(splitLocation[0]), double.parse(splitLocation[1])),
        new LatLng(latitude, longitude));
    if (meter < 1000000) {
      return meter / 1000; // نق مليون متر من مكان السائق
    } else {
      return 0;
    }
  }

  static Future<void> openMap(String latitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  void initState() {
    super.initState();

    _getLocation();
  }

  trueList() {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => LoginPage()));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("driver has no Students"),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: const PreferredSize(
      //   child: BankAppBar(),
      //   preferredSize: Size(double.infinity, kToolbarHeight),
      // ),
      backgroundColor: Color.fromRGBO(229, 234, 240, 1),
      body: ListView(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            fit: StackFit.passthrough,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                height: screenHeight * .3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70.0),
                      bottomRight: Radius.circular(70.0)),
                  image: DecorationImage(
                      image: AssetImage('assets/BusHome.jpg'),
                      fit: BoxFit.cover),
                  gradient: LinearGradient(
                      colors: [Colors.blue[400], Colors.blue],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter),
                ),
              ),
              Positioned(
                top: screenHeight * .26,
                child: Container(
                  width: screenWidth * .6,
                  height: screenHeight * .07,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          child: Center(
                            child: Text(
                              "تفاصيل",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: screenWidth * .06,
                                fontFamily: 'Pacifico',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            filterLocation.length == 0
                                ? trueList()
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => map(
                                            datas: filter,
                                            location: widget.location)));
                          },
                          child: Container(
                            child: Center(
                              child: Text(
                                "خريطة",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: screenWidth * .06,
                                  fontFamily: 'Pacifico',
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Container(
              height: screenHeight - screenHeight * .1,
              child: ListView(
                children: List.generate(widget.datas.length, (index) {
                  double distance = widget.datas[index].distance;
                  String lat;
                  String long;
                  filter = widget.datas;
                  widget.datas.forEach((element) {
                    lat = double.parse(element.latitude) >= 99 //32
                        ? "0"
                        : element.latitude;
                    long = double.parse(element.longitude) >= 99 //35
                        ? "0"
                        : element.longitude;
                    // List splitLocation = latAndLong
                    //     .replaceAll('(', '')
                    //     .replaceAll(')', '')
                    //     .split(',');
                    //  print(splitLocation);
                    List splitLocation;

                    splitLocation = [lat, long]; //0lat  1 long
                    //  filterLocation.add(filter)

                    element.setDistance(_getDistance(splitLocation));
                  });

                  filter.sort((a, b) => a.distance.compareTo(b.distance));
                  List splitLocation = [lat, long];
                  return filter[index].location == widget.location
                      ? Card(
                          context,
                          filter[index].name.toString(),
                          "7:50",
                          distance.toString(),
                          '[${filter[index].latitude},${filter[index].longitude}]') //[32.22222,35.25566]
                      : Container();
                }),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 20.0),
          //   child: Card(context, "20", "ahmad", "1", "7:30 AM"),
          // ),
          // Card(context, "21", "rania", "2", "7:40 AM"),
          //  Card(context, "22", "jorg", "3", "7:50 AM"),
          // Container(
          //   height: screenHeight - screenHeight * .1,
          //   child: ListView.builder(
          //     itemCount: widget.datas.length,
          //     itemBuilder: (context, i) {
          //       return Card(
          //           context, widget.datas[i].name.toString(), "7:50 AM");
          //       // return ListTile(
          //       //   title: Text(widget.datas[i].classR.toString()),
          //       // );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}

Widget Card(
    context, String name, String Taim, String distance, String latlong) {
  //30m distance /latlong openMap
  Future<void> openMap() async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latlong';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  filterLocation.add(name);

  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.height;
  return Container(
    padding: EdgeInsets.only(
        top: 20.0, left: screenWidth * .04, right: screenWidth * .04),
    height: screenHeight * .38,
    child: Container(
      // height: screenHeight * .3,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: Padding(
          padding: EdgeInsets.only(
              top: 20.0, left: screenWidth * .04, right: screenWidth * .04),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Text(
                      ("(" + distance.toString() + "/Km" + ")"),
                      style: TextStyle(color: Colors.orangeAccent),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.pink[500],
                      size: 30,
                    ),
                    onPressed: () => openMap(),
                    //  GoogleMap(                                                    //   onMapCreated:
                    //       _onMapCreated,
                    //   initialCameraPosition:
                    //       CameraPosition(
                    //     target: _center,
                    //     zoom: 90.0,
                    //   ),
                    // ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "إلى",
                    style: TextStyle(
                        fontSize: screenWidth * .05,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: screenWidth * .5,
                    //    height: 20,
                    child: Column(
                      children: [
                        Container(
                          // height: 10,
                          width: screenWidth * .2,
                          height: screenHeight * .04,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/car2.png'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "من",
                    style: TextStyle(
                        fontSize: screenWidth * .05,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "المدرسة",
                    style: TextStyle(
                        fontSize: screenWidth * .046,
                        color: Colors.black26,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: screenWidth * .5,
                    //    height: 20,
                    child: Column(
                      children: [
                        Container(
                          // height: 10,
                          width: screenWidth * .2,
                          height: screenHeight * .04,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "المنزل",
                    style: TextStyle(
                        fontSize: screenWidth * .046,
                        color: Colors.black26,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: screenWidth * .04,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "إسم الطالب",
                      style: TextStyle(
                          fontSize: screenWidth * .04,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "8:00 Am",
                      style: TextStyle(
                          fontSize: screenWidth * .04,
                          color: Colors.black26,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      Taim,
                      style: TextStyle(
                          fontSize: screenWidth * .04,
                          color: Colors.black26,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                ),
              ),
              Row(
                children: List.generate(
                    150 ~/ 3,
                    (index) => Expanded(
                          child: Container(
                            color: index % 2 == 0
                                ? Colors.transparent
                                : Colors.grey,
                            height: 2,
                          ),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "إضغط للمزيد من التفاصيل",
                      style: TextStyle(
                          fontSize: screenWidth * .06,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(2.0),
                    //   child: Container(
                    //     height: screenHeight * .03,
                    //     width: screenWidth * .1,
                    //     decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image: AssetImage('assets/newd.png'),
                    //           fit: BoxFit.cover),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          )),
    ),
  );
}
