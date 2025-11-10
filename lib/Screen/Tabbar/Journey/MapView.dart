import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// Model for map markers
class MapMarker {
  final int id;
  final double latitude;
  final double longitude;

  MapMarker({
    required this.id,
    required this.latitude,
    required this.longitude,
  });
}

// Main Custom Map Widget
class CustomMapWidget extends StatelessWidget {
  final List<MapMarker> markers;
  final double zoom;
  final LatLng? initialCenter;
  final Function(int id)? onPinTap;

  const CustomMapWidget({
    super.key,
    required this.markers,
    this.zoom = 12,
    this.initialCenter,
    this.onPinTap,
  });

  // Helper to safely create LatLng
  LatLng _safeLatLng(double? lat, double? lng) {
    if (lat == null ||
        lng == null ||
        lat.isNaN ||
        lng.isNaN ||
        lat.isInfinite ||
        lng.isInfinite) {
      debugPrint('Invalid coordinates detected, using default (0,0)');
      return const LatLng(0, 0);
    }
    return LatLng(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    final mapController = MapController();

    return Expanded(
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: initialCenter ?? const LatLng(48.8566, 2.3522), // Paris
          initialZoom: zoom,
        ),
        children: [
          // OpenStreetMap Tiles
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.custommap',
          ),

          // Marker Layer
          MarkerLayer(
            markers: markers.map((marker) {
              final LatLng pos = _safeLatLng(marker.latitude, marker.longitude);
              return Marker(
                point: pos,
                width: 60,
                height: 60,
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: () {
                    debugPrint("📍 Pin tapped with ID: ${marker.id}");
                    if (onPinTap != null) {
                      onPinTap!(marker.id);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Tapped pin ID: ${marker.id}"),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  child: _CustomPin(size: 36, mapImg: "assets/pinStr.png"),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// Custom pin widget (just image + shadow)
class _CustomPin extends StatelessWidget {
  final double size;
  final String mapImg;

  const _CustomPin({this.size = 28, required this.mapImg});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          mapImg,
          width: size,
          height: size,
          fit: BoxFit.contain,
        ),
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 2),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black26,
          ),
        ),
      ],
    );
  }
}



