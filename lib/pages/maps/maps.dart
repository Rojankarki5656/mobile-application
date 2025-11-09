import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsApp extends StatefulWidget {
  const MapsApp({super.key});

  @override
  State<MapsApp> createState() => _MapsAppState();
}

class _MapsAppState extends State<MapsApp> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  final LatLng _center = const LatLng(27.7172, 85.3240);
  double _zoomLevel = 12.0;

  Future<void> _zoomIn() async {
    final GoogleMapController controller = await _controller.future;
    if (controller == null) return; // 👈 Check first
    setState(() {
      _zoomLevel++;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _center, zoom: _zoomLevel),
        ),
      );
    });
  }

  Future<void> _zoomOut() async {
    final GoogleMapController controller = await _controller.future;
    if (controller == null) return; // 👈 Check first
    setState(() {
      _zoomLevel--;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _center, zoom: _zoomLevel),
        ),
      );
    });
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  String? _maptheme;
  Future _loadMapStyle() async {
    _maptheme = await (rootBundle.loadString("raw/maptheme.json")) as String?;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            markers: {const Marker(
              markerId: const MarkerId('kathmandu_marker'),
              position: LatLng(27.684698289440277, 85.31661429864955),
              infoWindow: const InfoWindow(
                title: 'Kathmandu',
                snippet: 'Capital of Nepal',
              ),
            ),},
            initialCameraPosition: _kGooglePlex,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          // Custom Zoom Buttons
          Positioned(
            right: 10,
            bottom: 80,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'zoom_in',
                  mini: true,
                  backgroundColor: Colors.teal,
                  onPressed: _zoomIn,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'zoom_out',
                  mini: true,
                  backgroundColor: Colors.teal,
                  onPressed: _zoomOut,
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

}

