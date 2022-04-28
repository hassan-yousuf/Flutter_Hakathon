import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LiveLocation extends StatefulWidget {
  const LiveLocation({Key? key}) : super(key: key);

  @override
  State<LiveLocation> createState() => _LiveLocationState();
}

class _LiveLocationState extends State<LiveLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Icon(
                Icons.location_on,
                size: 85,
                color: Colors.red,
              ),
            ),
            Text(
              'Location',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(location),
            Text(
              'Address',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(address),
            ElevatedButton(
              onPressed: () async {
                Position position = await _determinePosition();
                location =
                    'Latitude:  ${position.latitude},   Longitude:  ${position.longitude}.';
                GetAddressFromLatLong(position);
                setState(() {});
              },
              child: Text('Locate Now!'),
            ),
          ],
        ),
      ),
    );
  }

  String location = '';
  String address = 'Press Button To Locate Your Self!';

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemark = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark place = placemark[0];
    address =
        'Address:    ${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode} ${place.country}';
    setState(() {});
  }
}
