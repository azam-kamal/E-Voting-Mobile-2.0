import 'package:flutter/material.dart';
import '../screens/otpverficationscreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class VoterDetail extends StatefulWidget {
  final String id;
  final String markerId;

  final String name;
  final String nicNumber;
  final String mobileNumber;
  final String address;
  final String city;
  final String province;
  final String halkaNumber;
  final double longitude;
  final double latitude;
  VoterDetail(
      this.id,
      this.markerId,
      this.name,
      this.nicNumber,
      this.mobileNumber,
      this.address,
      this.city,
      this.province,
      this.halkaNumber,
      this.longitude,
      this.latitude);
  @override
  _VoterDetailState createState() => _VoterDetailState();
}

class _VoterDetailState extends State<VoterDetail> {
  final List<Marker> marker = [];
  GoogleMapController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var init = true;
  @override
  void didChangeDependencies() {
    if (init) {
      marker.add(Marker(
          infoWindow: InfoWindow(title: widget.address),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          markerId: MarkerId(widget.markerId),
          position: LatLng(widget.latitude, widget.longitude)));
    }
    init=false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition _initialPosition = CameraPosition(
        target: LatLng(widget.latitude, widget.longitude), zoom: 17);
    print(widget.name);
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ClipOval(
            child: Image.asset(
              'assets/images/Logo 2.0.png',
              fit: BoxFit.cover,
              height: 140,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10, top: 10),
          child: Card(
              elevation: 6,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Icon(
                      Icons.account_circle,
                      size: 30,
                      color: Colors.green[700],
                    ),
                  ),
                  Expanded(
                      child: Text(widget.name,
                          style: TextStyle(
                            fontFamily: 'josefin',
                            fontWeight: FontWeight.w700,
                            color: Colors.green[700],
                            fontSize: 20,
                          ))),
                ],
              )),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10, top: 10),
          child: Card(
            elevation: 6,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Icon(
                    Icons.call,
                    size: 30,
                    color: Colors.green[700],
                  ),
                ),
                Expanded(
                    child: Text(widget.mobileNumber,
                        style: TextStyle(
                          fontFamily: 'josefin',
                          fontWeight: FontWeight.w700,
                          color: Colors.green[700],
                          fontSize: 20,
                        )))
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10, top: 10),
          child: Card(
            elevation: 6,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Icon(
                    Icons.beenhere,
                    size: 30,
                    color: Colors.green[700],
                  ),
                ),
                Expanded(
                    child: Text(widget.nicNumber,
                        style: TextStyle(
                          fontFamily: 'josefin',
                          fontWeight: FontWeight.w700,
                          color: Colors.green[700],
                          fontSize: 20,
                        )))
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10, top: 10),
          child: Card(
            elevation: 6,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Icon(
                    Icons.home,
                    size: 30,
                    color: Colors.green[700],
                  ),
                ),
                Expanded(
                    child: Text(widget.address,
                        style: TextStyle(
                          fontFamily: 'josefin',
                          fontWeight: FontWeight.w700,
                          color: Colors.green[700],
                          fontSize: 20,
                        ))),
              ],
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(bottom: 10, top: 10),
            child: Card(
              elevation: 6,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Icon(
                      Icons.how_to_vote,
                      size: 30,
                      color: Colors.green[700],
                    ),
                  ),
                  Expanded(
                      child: Text(widget.halkaNumber,
                          style: TextStyle(
                            fontFamily: 'josefin',
                            fontWeight: FontWeight.w700,
                            color: Colors.green[700],
                            fontSize: 20,
                          )))
                ],
              ),
            )),
        Container(
          height: 300,
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
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.green[700],
            border: Border.all(style: BorderStyle.solid, width: 2.0),
            borderRadius: BorderRadius.circular(40),
          ),
          child: FlatButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(OtpVerificationScreen.routeName);
              },
              child: Text(
                'Next',
                style: TextStyle(
                    fontFamily: 'josefin',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 15),
              )),
        ),
      ],
    );
  }
}
