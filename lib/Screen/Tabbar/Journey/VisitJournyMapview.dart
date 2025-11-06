import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class JourneyVisitRootOnMapScreen extends StatefulWidget {
  final String title;
  final String imagePath;

  const JourneyVisitRootOnMapScreen({
    Key? key,
    required this.title,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<JourneyVisitRootOnMapScreen> createState() =>
      _JourneyVisitRootOnMapScreenState();
}

class _JourneyVisitRootOnMapScreenState
    extends State<JourneyVisitRootOnMapScreen> {
  final List<MapMarker> markers = [
    MapMarker(id: 1, latitude: 20.7935, longitude: 70.7033), // Kodinar
    MapMarker(id: 2, latitude: 22.3039, longitude: 70.8022), // Rajkot
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          /// 🔹 Fullscreen Map View
          CustomMapWidget(
            markers: markers,
            zoom: 7.5,
            initialCenter: const LatLng(21.5, 70.75),
          ),

          /// 🔹 Header (Back button floating on top)
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/backArrow.png", height: 26, width: 26),
                  const SizedBox(width: 10),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: App_BlackColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Model for map markers
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

/// Custom Map Widget
class CustomMapWidget extends StatelessWidget {
  final List<MapMarker> markers;
  final double zoom;
  final LatLng? initialCenter;

  const CustomMapWidget({
    super.key,
    required this.markers,
    this.zoom = 12,
    this.initialCenter,
  });

  @override
  Widget build(BuildContext context) {
    final kodinar = LatLng(20.7935, 70.7033);
    final rajkot = LatLng(22.3039, 70.8022);

    return FlutterMap(
      options: MapOptions(
        initialCenter: initialCenter ?? const LatLng(21.5, 70.75),
        initialZoom: zoom,
      ),
      children: [
        /// Map Tiles
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.custommap',
        ),

        /// 🔹 Route Line from Kodinar → Rajkot
        PolylineLayer(
          polylines: [
            Polyline(
              points: [kodinar, rajkot],
              strokeWidth: 4,
              color: Colors.blueAccent.withOpacity(0.8),
            ),
          ],
        ),

        /// 🔹 Markers
        MarkerLayer(
          markers: markers.map((marker) {
            final LatLng pos = LatLng(marker.latitude, marker.longitude);
            return Marker(
              point: pos,
              width: 60,
              height: 60,
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/pinStr.png",
                width: 30,
                height: 30,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
