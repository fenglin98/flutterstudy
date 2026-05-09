import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(22.55329, 113.88308),
    zoom: 14,
  );

  static const LatLng _centerPoint = LatLng(22.55329, 113.88308);

  late final Set<Marker> _markers = _generateMarkers();

  Set<Marker> _generateMarkers() {
    final random = Random();
    final markers = <Marker>{};

    markers.add(Marker(
      markerId: const MarkerId('center'),
      position: _centerPoint,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    ));

    for (int i = 0; i < 20; i++) {
      final distance = 1000 + random.nextDouble() * 9000;
      final angle = random.nextDouble() * 2 * pi;
      final lat = _centerPoint.latitude + (distance / 111000) * cos(angle);
      final lng = _centerPoint.longitude + (distance / (111000 * cos(_centerPoint.latitude * pi / 180))) * sin(angle);

      markers.add(Marker(
        markerId: MarkerId('place_$i'),
        position: LatLng(lat, lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        markers: _markers,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        onTap: (_) {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
