import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:followbus/model/modelStudentsList.dart';
import 'package:followbus/startScreens/login.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class map extends StatefulWidget {
  final List<DataS> datas;
  final String location;
  map({
    @required this.datas,
    @required this.location,
  });
  @override
  _HomeState createState() => _HomeState();
}

//
class _HomeState extends State<map> {
  GoogleMapController mapController; //contrller for Google map
  final Set<Marker> markers = new Set(); //markers for google map
  static const LatLng showLocation = const LatLng(32.430252, 35.856717);
  //location to show in map
  trueRegadmin(msg) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("driver have no Students"),
            content: Text(msg),
          );
        });
  }

  Set<Polygon> Tsp() {
    List<int> vertex = new List<int>();

    var polygonCoords = List<LatLng>();
    polygonCoords.add(LatLng(32.53697207062393, 35.855356080087624));
    for (int i = 0; i < widget.datas.length; i++) {
      print(widget.datas[i].name);
      widget.datas[i].location == widget.location
          ? polygonCoords.add(
              LatLng(double.parse(widget.datas[i].latitude),
                  double.parse(widget.datas[i].longitude)),
            )
          : DoNothingAction();
    }

    //  polygonCoords.add(LatLng(32.53083, 35.88224));
    //  polygonCoords.add(LatLng(32.54933, 35.88112));
    // polygonCoords.add(LatLng(32.537798, 35.856722));

    var polygonSet = Set<Polygon>();
    polygonSet.add(Polygon(
        polygonId: PolygonId('1'),
        points: polygonCoords,
        fillColor: Colors.white10,
        strokeWidth: 2,
        strokeColor: Colors.blue));

    return polygonSet;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _setPolygons();
  // }

  // Set<Polygon> _polygons = HashSet<Polygon>();
  // void _setPolygons() {
  //   List<LatLng> polygonLatLongs = List<LatLng>();
  //   polygonLatLongs.add(LatLng(32.537798, 35.856722));
  //   polygonLatLongs.add(LatLng(32.53083, 35.88224));
  //   polygonLatLongs.add(LatLng(32.54933, 35.88112));

  //   //   polygonCoords.add(LatLng(32.537798, 35.856722));
  //   //   polygonCoords.add(LatLng(32.53083, 35.88224));
  //   //   polygonCoords.add(LatLng(32.54933, 35.88112));
  //   _polygons.add(
  //     Polygon(
  //         polygonId: PolygonId("0"),
  //         points: polygonLatLongs,
  //         fillColor: Colors.white10,
  //         strokeWidth: 2,
  //         strokeColor: Colors.blue),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Google Map"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: GoogleMap(
          //Map widget from google_maps_flutter package
          zoomGesturesEnabled: true, //enable Zoom in, out on map
          initialCameraPosition: CameraPosition(
            //innital position in map
            target: showLocation, //initial position
            zoom: 10.0, //initial zoom level
          ),
          markers: getmarkers(widget.datas), //markers to show on map
          mapType: MapType.normal, //map type
          onMapCreated: (controller) {
            //method called when map is created
            setState(() {
              mapController = controller;
            });
          },
          polygons: Tsp()
          // myPolygon(),
          ),
    );
  }

  int Counter = 0;
  Set<Marker> getmarkers(List<DataS> dataList) {
    setState(() {
      markers.add(Marker(
        //add first marker
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(32.53697207062393, 35.855356080087624),
        //    : showLocation, //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: "school",
          snippet: "Start",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue), //Icon for Marker
      ));
      for (int i = 0; i < dataList.length; i++) {
        print('${dataList[i].latitude}/${dataList[i].longitude}');
        setState(() {
          dataList[i].location == widget.location
              ? Counter = Counter + 1
              : Counter = Counter + 0;
          dataList[i].location == widget.location
              ? markers.add(Marker(
                  //add first marker
                  markerId: MarkerId(showLocation.toString()),
                  position: LatLng(double.parse(dataList[i].latitude),
                      double.parse(dataList[i].longitude)),
                  //    : showLocation, //position of marker
                  infoWindow: InfoWindow(
                    //popup info
                    title: dataList[i].name,
                    snippet: dataList[i].phone + "($Counter)",
                  ),
                  icon: BitmapDescriptor.defaultMarker, //Icon for Marker
                ))
              : DoNothingAction();
        });
      }
    });

    // markers.add(Marker(
    //   //add first marker
    //   markerId: MarkerId(showLocation.toString()),
    //   position: LatLng(32.430252, 35.856717),
    //   //    : showLocation, //position of marker
    //   infoWindow: InfoWindow(
    //     //popup info
    //     title: 'Marker Title First ',
    //     snippet: 'My Custom Subtitle',
    //   ),
    //   icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    // ));
    return markers;
  }
}
