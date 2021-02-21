import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PollingStationMap extends StatefulWidget {
  @override
  _PollingStationMapState createState() => _PollingStationMapState();
  final int id;
  final String address;
  final double longitude;
  final double latitude;
  PollingStationMap({this.id, this.address, this.longitude, this.latitude});
}

class _PollingStationMapState extends State<PollingStationMap> {
  bool init = true;
  final List<Marker> marker = [];
  GoogleMapController _controller;

  void didChangeDependencies() {
    if (init) {
      marker.add(Marker(
          infoWindow: InfoWindow(title: widget.address),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          markerId: MarkerId('M1'),
          position: LatLng(widget.latitude, widget.longitude)));
    }
    init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition _initialPosition = CameraPosition(
        target: LatLng(widget.latitude, widget.longitude), zoom: 17);
    return Container(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: GoogleMap(
            markers: marker.toSet(),
            mapType: MapType.hybrid,
            initialCameraPosition: _initialPosition,
            onMapCreated: (controller) {
              _controller = controller;
            },
          )),
    );
  }
}
