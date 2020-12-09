import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/routes_provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _isInit = true;
  GoogleMapController mapController;
  LatLng _center = const LatLng(30.02273, 31.23789);
  Set<Polyline> _mapPolylines = {};

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<RouteProviders>(context, listen: false)
          .fetchAndSetUser()
          .then((val) {
        Polyline resultedPolyline =
            Provider.of<RouteProviders>(context, listen: false).getRoute();
        print(resultedPolyline.width);
        setState(() {
          _mapPolylines = {resultedPolyline};
          _center = LatLng(resultedPolyline.points[0].latitude,
              resultedPolyline.points[0].longitude);
          mapController.animateCamera(CameraUpdate.newLatLng(_center));
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
              polylines: _mapPolylines,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 16.0,
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: _buildDialog,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.2,
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(100)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      "assets/images/about.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  void _buildDialog() async {
    String content = await Provider.of<RouteProviders>(context, listen: false)
        .fetchAboutData();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              // title: Text("I"),
              content: SingleChildScrollView(child: Html(data: content)),

              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            ));
  }
}
