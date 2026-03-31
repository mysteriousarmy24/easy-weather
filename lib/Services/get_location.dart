import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetLocation {
  Future<String> getCityNameFromCurrentLocation() async {
    //permissions
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    //get currunt position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    print("latitude: ${position.latitude}");
    print("longitude: ${position.longitude}");
    //converting position to placemark
    List<Placemark> playsMarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    String cityName = playsMarks[0].locality!;
    return cityName;
  }
}
