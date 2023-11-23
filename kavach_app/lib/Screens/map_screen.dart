import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex =
  const CameraPosition(target: LatLng(22.2530, 84.9016), zoom: 14.4746);

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  List<LatLng> latlng = [
    LatLng(22.2530, 84.9016),
    LatLng(22.2530, 85.85601289664406),
  ];

  loadData() {
    getUserCurrentLocation().then((value) async {
      print('my desired location');
      print(value.latitude.toString() + " " + value.longitude.toString());

      _markers.add(
        Marker(
          markerId: MarkerId('2'),
          position: LatLng(20.291715556253198, 85.85601289664406),
          infoWindow: InfoWindow(title: 'Plutone'),
        ),
      );

      CameraPosition cameraPosition =
      CameraPosition(zoom: 14, target: LatLng(value.latitude, value.longitude));

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError((error, stackTrace) {
      print("error" + error.toString());
    });

    Position position = await Geolocator.getCurrentPosition();

    // Uncomment the following lines to add a marker at the user's current location
    _markers.add(
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(
          title: 'Your Location',
          snippet: 'This is your current location',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );

    return position;
  }

  @override
  void initState() {
    super.initState();
    loadData();

    for (int i = 0; i < latlng.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: latlng[i],
          infoWindow: InfoWindow(title: 'Cool place', snippet: '5 star'),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      setState(() {});
    }

    _polyline.add(
      Polyline(
        polylineId: PolylineId('1'),
        points: latlng,
        color: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          markers: _markers,
          polylines: _polyline,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_disabled_outlined),
        onPressed: () {
          loadData(); // Reload data when the button is pressed
        },
      ),
    );
  }
}