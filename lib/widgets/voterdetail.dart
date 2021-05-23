import 'package:E_Voting_System/providers/voterprovider.dart';
import 'package:provider/provider.dart';
import '../screens/voterdetailscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../screens/selectOption.dart';

class VoterDetail extends StatefulWidget {
  final int id;
  final int pollingStationId;
  final String name;
  final String nicNumber;
  final String mobileNumber;
  final String address;
  final String city;
  final String province;
  final String pollingStationNumber;
  final double longitude;
  final double latitude;
  VoterDetail(
      this.id,
      this.pollingStationId,
      this.name,
      this.nicNumber,
      this.mobileNumber,
      this.address,
      this.city,
      this.province,
      this.pollingStationNumber,
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
    print(widget.name);
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ClipOval(
            child: Image.asset(
              'assets/images/Logo 1.0.png',
              fit: BoxFit.cover,
              height: 140,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 2),
          child: Card(
              elevation: 3,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 6),
                    child: Icon(
                      Icons.account_circle,
                      size: 30,
                      color: Color.fromRGBO(24, 44, 37, 1),
                    ),
                  ),
                  Container(
                      child: Text(widget.name,
                          style: TextStyle(
                            //fontFamily: 'josefin',
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(24, 44, 37, 1),
                            fontSize: 20,
                          ))),
                ],
              )),
        ),
        Container(
          margin: EdgeInsets.only(top: 2),
          child: Card(
            elevation: 3,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20, left: 6),
                  child: Icon(
                    Icons.call,
                    size: 30,
                    color: Color.fromRGBO(24, 44, 37, 1),
                  ),
                ),
                Expanded(
                    child: Text(widget.mobileNumber,
                        style: TextStyle(
                          //fontFamily: 'josefin',
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(24, 44, 37, 1),
                          fontSize: 20,
                        )))
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 2),
          child: Card(
            elevation: 3,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20, left: 6),
                  child: Icon(
                    Icons.beenhere,
                    size: 30,
                    color: Color.fromRGBO(24, 44, 37, 1),
                  ),
                ),
                Expanded(
                    child: Text(widget.nicNumber,
                        style: TextStyle(
                          //fontFamily: 'josefin',
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(24, 44, 37, 1),
                          fontSize: 20,
                        )))
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 2),
          child: Card(
            elevation: 3,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20, left: 6),
                  child: Icon(
                    Icons.home,
                    size: 30,
                    color: Color.fromRGBO(24, 44, 37, 1),
                  ),
                ),
                Expanded(
                    child: Text(widget.address,
                        style: TextStyle(
                          //fontFamily: 'josefin',
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(24, 44, 37, 1),
                          fontSize: 20,
                        ))),
              ],
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 2),
            child: Card(
              elevation: 3,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 6),
                    child: Icon(
                      Icons.how_to_vote,
                      size: 30,
                      color: Color.fromRGBO(24, 44, 37, 1),
                    ),
                  ),
                  Expanded(
                      child: Text(widget.pollingStationNumber,
                          style: TextStyle(
                            //fontFamily: 'josefin',
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(24, 44, 37, 1),
                            fontSize: 20,
                          )))
                ],
              ),
            )),

/////
        ///
        Container(
            margin: EdgeInsets.only(top: 2),
            child: Card(
              elevation: 3,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 6),
                    child: Icon(
                      Icons.location_on,
                      size: 30,
                      color: Color.fromRGBO(24, 44, 37, 1),
                    ),
                  ),
                  Expanded(
                      child:
                          Text("You can see your Polling Station marked on Map",
                              style: TextStyle(
                                //fontFamily: 'josefin',
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(65, 91, 85, 1),
                                fontSize: 15,
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
          margin: EdgeInsets.only(top: 10, bottom: 20, left: 6, right: 6),
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromRGBO(24, 44, 37, 1),
            border: Border.all(style: BorderStyle.solid, width: 2.0),
            borderRadius: BorderRadius.circular(40),
          ),
          child: FlatButton(
              onPressed: () {
                print("Check if voter can cast vote!");

                if (Provider.of<VoterProvider>(context, listen: false)
                        .voteCast ==
                    "1") {
                  print(Provider.of<VoterProvider>(context, listen: false)
                      .voteCast);
                  print("You have already casted your vote!");
                }
                if (Provider.of<VoterProvider>(context, listen: false)
                        .voteCast ==
                    "0") {
                  print(Provider.of<VoterProvider>(context, listen: false)
                      .voteCast);
                  print("not casted yet!");
                  Navigator.of(context).pushNamed(SelectOptionScreen.routeName);
                }
              },
              child: Text(
                'Vote',
                style: TextStyle(
                    //fontFamily: 'josefin',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 15),
              )),
        ),
      ],
    );
  }
}
