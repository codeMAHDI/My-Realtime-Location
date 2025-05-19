import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'location_cubit.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>LocationCubit()..fetchCurrentLocation(),
      child: Scaffold(
        appBar: AppBar(title: Text("My Realtime Location")),
        body: BlocBuilder<LocationCubit,LatLng?>(
            builder: (context,location){
              if (location == null) {
                return Center(child: CircularProgressIndicator());
              }else{
                return GoogleMap(
                  initialCameraPosition: CameraPosition(target: location,zoom: 20),
                  myLocationEnabled: true,
                  markers: {
                    Marker(
                        markerId: MarkerId("current_location"),
                        position: location,
                        infoWindow: InfoWindow(title: "Flutter Batch 02 Location")
                    )
                  },
                );
              }
            }
        ),
        floatingActionButton:FloatingActionButton(
          onPressed: ()=> context.read<LocationCubit>().fetchCurrentLocation(),
          child:Icon(Icons.my_location),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );

  }
}
