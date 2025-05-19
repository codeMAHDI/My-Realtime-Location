import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationCubit extends Cubit<LatLng?> {
  LocationCubit() : super(null);

  Future<void> fetchCurrentLocation() async {
    PermissionStatus permissionStatus = await Permission.location.request();
    if (permissionStatus == PermissionStatus.granted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("Lat" + position.latitude.toString());
      print("Lon" + position.longitude.toString());
      emit(LatLng(position.latitude, position.longitude));
    } else {
      emit(null);
    }
  }
}


