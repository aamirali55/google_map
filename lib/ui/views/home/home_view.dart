import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: model.currentPosition,
                  zoom: 12,
                ),
                mapType: MapType.normal,
                markers: model.markers,
                onMapCreated: model.onMapCreated,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
              Positioned(
                top: 50,
                left: 16,
                right: 16,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for a place...',
                      prefixIcon: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (query) {
                      if (query.isNotEmpty) {
                        model.searchPlace(query);
                      }
                    },
                  ),
                ),
              ),
              if (model.isBusy)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        );
      },
    );
  }
}
