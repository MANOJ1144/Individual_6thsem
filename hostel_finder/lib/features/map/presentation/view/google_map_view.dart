import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  late GoogleMapController mapController;
  late Set<Marker> markers;
  late LatLng myLocation;

  @override
  void initState() {
    markers = {};
    myLocation = const LatLng(27.7172, 85.3240);
    markers.add(
      Marker(
        markerId: const MarkerId('myLocation'),
        position: myLocation,
        infoWindow: const InfoWindow(
          title: 'Goapl Dai ko chatamari',
          snippet: 'Chatamari',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(target: myLocation, zoom: 10),
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }
}
