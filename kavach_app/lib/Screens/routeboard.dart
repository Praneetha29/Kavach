import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({Key? key}) : super(key: key);

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  double _totalDistance = 0.0;
  Map<String, Map<String, double>> _distanceData = {
    'Today': {},
    'Yesterday': {},
    'This Week': {},
    'Last Week': {},
    'This Month': {},
    'Last Month': {},
  };

  String _selectedDayFilter = 'Today';
  String _selectedWeekFilter = 'This Week';
  String _selectedMonthFilter = 'This Month';

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
  Map<String, List<LatLng>> _routePoints = {
    'Today': [],
    'Yesterday': [],
    'This Week': [],
    'Last Week': [],
    'This Month': [],
    'Last Month': [],
  };

  @override
  void initState() {
    super.initState();
    _generateMockData();
  }

  void _generateMockData() {
    Random random = Random();
    double totalDistanceTillDate = 0.0;

    _distanceData.forEach((filter, data) {
      List<LatLng> mockDestinations = List.generate(4, (index) {
        double latitude = 22.2526 + random.nextDouble() * 0.02;
        double longitude = 84.9010 + random.nextDouble() * 0.02;
        return LatLng(latitude, longitude);
      });

      _routePoints[filter] = mockDestinations;

      for (LatLng destination in mockDestinations) {
        _addMarker(destination);
      }

      double totalDistance = _calculateTotalDistance(mockDestinations);
      data['Total Distance'] = totalDistance;

      if (filter == 'Today') {
        totalDistanceTillDate += totalDistance;
      }
    });

    _totalDistance = totalDistanceTillDate;
    _updateMapRoute();
  }

  double _calculateTotalDistance(List<LatLng> points) {
    double totalDistance = 0.0;

    for (int i = 0; i < points.length - 1; i++) {
      LatLng start = points[i];
      LatLng end = points[i + 1];
      totalDistance += _calculateDistance(start, end);
    }

    return totalDistance;
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const double earthRadius = 6371;

    double lat1 = _toRadians(start.latitude);
    double lon1 = _toRadians(start.longitude);
    double lat2 = _toRadians(end.latitude);
    double lon2 = _toRadians(end.longitude);

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }

  void _addMarker(LatLng position) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
        ),
      );
    });
  }

  void _selectDayFilter(String? filter) {
    setState(() {
      _selectedDayFilter = filter ?? 'Today';
      _updateTotalDistance();
      _updateMapRoute();
    });
  }

  void _selectWeekFilter(String? filter) {
    setState(() {
      _selectedWeekFilter = filter ?? 'This Week';
      _updateTotalDistance();
      _updateMapRoute();
    });
  }

  void _selectMonthFilter(String? filter) {
    setState(() {
      _selectedMonthFilter = filter ?? 'This Month';
      _updateTotalDistance();
      _updateMapRoute();
    });
  }

  void _updateTotalDistance() {
    _totalDistance = _distanceData[_selectedDayFilter]!['Total Distance'] ?? 0.0;
  }

  void _updateMapRoute() {
    setState(() {
      _markers.clear();
      List<LatLng> selectedRoute = _routePoints[_selectedDayFilter] ?? [];
      for (LatLng point in selectedRoute) {
        _addMarker(point);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Dashboard'),
        backgroundColor: Color(0XFF005653),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _markers.isNotEmpty ? _markers.first.position : LatLng(0, 0),
                  zoom: 14,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: _markers,
                polylines: {
                  Polyline(
                    polylineId: PolylineId('route'),
                    points: _routePoints[_selectedDayFilter] ?? [],
                    color: Colors.blue,
                    width: 4,
                  ),
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Distance Till Date',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('${_totalDistance.toStringAsFixed(2)} km'),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Distance by Day',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<String>(
                        value: _selectedDayFilter,
                        onChanged: _selectDayFilter,
                        items: ['Today', 'Yesterday'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildDistanceList(_distanceData[_selectedDayFilter]!),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Distance by Week',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<String>(
                        value: _selectedWeekFilter,
                        onChanged: _selectWeekFilter,
                        items: ['This Week', 'Last Week'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildDistanceList(_distanceData[_selectedWeekFilter]!),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Distance by Month',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<String>(
                        value: _selectedMonthFilter,
                        onChanged: _selectMonthFilter,
                        items: ['This Month', 'Last Month'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildDistanceList(_distanceData[_selectedMonthFilter]!),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDistanceList(Map<String, double> distanceMap) {
    return Column(
      children: distanceMap.entries.map((entry) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(entry.key),
            Text('${entry.value.toStringAsFixed(2)} km'),
          ],
        );
      }).toList(),
    );
  }
}