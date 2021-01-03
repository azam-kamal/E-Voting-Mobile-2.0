import 'package:flutter/material.dart';
import '../models/voter.dart';
import '../providers/voterprovider.dart';
import 'package:provider/provider.dart';
import '../providers/authprovider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class ManageVoterScreen extends StatefulWidget {
  @override
  _ManageVoterScreenState createState() => _ManageVoterScreenState();
  static const routeName = '/ManageVoterScreen';
}

class _ManageVoterScreenState extends State<ManageVoterScreen> {
  GoogleMapController _controller;
  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(24.8607, 67.0011), zoom: 18);
  List<Marker> marker = [];
  void addMarker(coordinates) {
    setState(() {
      marker.add(Marker(markerId: MarkerId('M1'), position: coordinates));
    });
  }

  String addressLoc;
  double lng;
  double lt;
  double longitude;
  double latitude;

  bool isLoading = false;
  var manageVoter = Voter(
    voterId: null,
    voterHalkaLocationMarkerId: null,
    voterName: null,
    voterNicNumber: null,
    voterMobileNumber: null,
    voterAddress: null,
    voterHalkaNumber: null,
    votercityName: null,
    voterProvince: null,
    voterHalkaLocationLongitude: null,
    voterHalkaLocationLatitude: null,
  );
  final formKey = GlobalKey<FormState>();
  void saveForm() async {
    setState(() {
      isLoading = true;
    });
    try {
      formKey.currentState.save();
      bool checkNic = await Provider.of<AuthProvider>(context, listen: false)
          .MatchNicExist(manageVoter.voterNicNumber);
      bool checkNumber =
          await await Provider.of<AuthProvider>(context, listen: false)
              .MatchMobileNumberExist(manageVoter.voterMobileNumber);
      print(checkNic);
      if (!checkNic && !checkNumber) {
        print(longitude);
        print(latitude);
        await Provider.of<VoterProvider>(context, listen: false).registerVoter(
            manageVoter, 'M1', lng.toString(), lt.toString());
      } else {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                content: Text('Nic & Mobile number already exist'),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: Text('Okay'))
                ],
              );
            });
      }
    } catch (error) {
      throw error;
    } finally {
      setState(() {
        isLoading = false;
      });
      // Navigator.of(context).pop();
    }
  }
@override
  void dispose() {
   _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  saveForm();
                  print('Voter Registered Successfully');
                })
          ],
          centerTitle: true,
          title: Text(
            'Managing Voter',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'satisfy',
                fontWeight: FontWeight.w400,
                fontSize: 25),
          ),
          backgroundColor: Colors.green[700],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              )
            : Container(
                height: double.infinity,
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                      child: Container(
                          margin: EdgeInsets.all(10),
                          height: 1160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: Card(
                            elevation: 6,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        labelText: 'Enter voter name',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    onSaved: (value) {
                                      manageVoter = Voter(
                                          voterId: manageVoter.voterId,
                                          voterHalkaLocationMarkerId:
                                              manageVoter
                                                  .voterHalkaLocationMarkerId,
                                          voterName: value,
                                          voterNicNumber:
                                              manageVoter.voterNicNumber,
                                          voterMobileNumber:
                                              manageVoter.voterMobileNumber,
                                          voterAddress:
                                              manageVoter.voterAddress,
                                          voterHalkaNumber:
                                              manageVoter.voterHalkaNumber,
                                          votercityName:
                                              manageVoter.votercityName,
                                          voterProvince:
                                              manageVoter.voterProvince,
                                          voterHalkaLocationLongitude:
                                              manageVoter
                                                  .voterHalkaLocationLongitude,
                                          voterHalkaLocationLatitude:
                                              manageVoter
                                                  .voterHalkaLocationLatitude);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        labelText: 'Enter voter nic number',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    onSaved: (value) {
                                      manageVoter = Voter(
                                          voterId: manageVoter.voterId,
                                          voterHalkaLocationMarkerId:
                                              manageVoter
                                                  .voterHalkaLocationMarkerId,
                                          voterName: manageVoter.voterName,
                                          voterNicNumber: value,
                                          voterMobileNumber:
                                              manageVoter.voterMobileNumber,
                                          voterAddress:
                                              manageVoter.voterAddress,
                                          voterHalkaNumber:
                                              manageVoter.voterHalkaNumber,
                                          votercityName:
                                              manageVoter.votercityName,
                                          voterProvince:
                                              manageVoter.voterProvince,
                                          voterHalkaLocationLongitude:
                                              manageVoter
                                                  .voterHalkaLocationLongitude,
                                          voterHalkaLocationLatitude:
                                              manageVoter
                                                  .voterHalkaLocationLatitude);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        labelText: 'Enter voter mobile number',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    onSaved: (value) {
                                      manageVoter = Voter(
                                          voterId: manageVoter.voterId,
                                          voterHalkaLocationMarkerId:
                                              manageVoter
                                                  .voterHalkaLocationMarkerId,
                                          voterName: manageVoter.voterName,
                                          voterNicNumber:
                                              manageVoter.voterNicNumber,
                                          voterMobileNumber: value,
                                          voterAddress:
                                              manageVoter.voterAddress,
                                          voterHalkaNumber:
                                              manageVoter.voterHalkaNumber,
                                          votercityName:
                                              manageVoter.votercityName,
                                          voterProvince:
                                              manageVoter.voterProvince,
                                          voterHalkaLocationLongitude:
                                              manageVoter
                                                  .voterHalkaLocationLongitude,
                                          voterHalkaLocationLatitude:
                                              manageVoter
                                                  .voterHalkaLocationLatitude);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        labelText: 'Enter voter address',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    onSaved: (value) {
                                      manageVoter = Voter(
                                          voterId: manageVoter.voterId,
                                          voterHalkaLocationMarkerId:
                                              manageVoter
                                                  .voterHalkaLocationMarkerId,
                                          voterName: manageVoter.voterName,
                                          voterNicNumber:
                                              manageVoter.voterNicNumber,
                                          voterMobileNumber:
                                              manageVoter.voterMobileNumber,
                                          voterAddress: value,
                                          voterHalkaNumber:
                                              manageVoter.voterHalkaNumber,
                                          votercityName:
                                              manageVoter.votercityName,
                                          voterProvince:
                                              manageVoter.voterProvince,
                                          voterHalkaLocationLongitude:
                                              manageVoter
                                                  .voterHalkaLocationLongitude,
                                          voterHalkaLocationLatitude:
                                              manageVoter
                                                  .voterHalkaLocationLatitude);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        labelText: 'Enter voter city name',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    onSaved: (value) {
                                      manageVoter = Voter(
                                          voterId: manageVoter.voterId,
                                          voterHalkaLocationMarkerId:
                                              manageVoter
                                                  .voterHalkaLocationMarkerId,
                                          voterName: manageVoter.voterName,
                                          voterNicNumber:
                                              manageVoter.voterNicNumber,
                                          voterMobileNumber:
                                              manageVoter.voterMobileNumber,
                                          voterAddress:
                                              manageVoter.voterAddress,
                                          voterHalkaNumber:
                                              manageVoter.votercityName,
                                          votercityName: value,
                                          voterProvince:
                                              manageVoter.voterProvince,
                                          voterHalkaLocationLongitude:
                                              manageVoter
                                                  .voterHalkaLocationLongitude,
                                          voterHalkaLocationLatitude:
                                              manageVoter
                                                  .voterHalkaLocationLatitude);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        labelText: 'Enter voter province name',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    onSaved: (value) {
                                      manageVoter = Voter(
                                          voterId: manageVoter.voterId,
                                          voterHalkaLocationMarkerId:
                                              manageVoter
                                                  .voterHalkaLocationMarkerId,
                                          voterName: manageVoter.voterName,
                                          voterNicNumber:
                                              manageVoter.voterNicNumber,
                                          voterMobileNumber:
                                              manageVoter.voterMobileNumber,
                                          voterAddress:
                                              manageVoter.voterAddress,
                                          voterHalkaNumber:
                                              manageVoter.voterHalkaNumber,
                                          votercityName:
                                              manageVoter.votercityName,
                                          voterProvince: value,
                                          voterHalkaLocationLongitude:
                                              manageVoter
                                                  .voterHalkaLocationLongitude,
                                          voterHalkaLocationLatitude:
                                              manageVoter
                                                  .voterHalkaLocationLatitude);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        labelText: 'Enter voter halka number',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    onSaved: (value) {
                                      manageVoter = Voter(
                                          voterId: manageVoter.voterId,
                                          voterHalkaLocationMarkerId:
                                              manageVoter
                                                  .voterHalkaLocationMarkerId,
                                          voterName: manageVoter.voterName,
                                          voterNicNumber:
                                              manageVoter.voterNicNumber,
                                          voterMobileNumber:
                                              manageVoter.voterMobileNumber,
                                          voterAddress:
                                              manageVoter.voterAddress,
                                          voterHalkaNumber: value,
                                          votercityName:
                                              manageVoter.votercityName,
                                          voterProvince:
                                              manageVoter.voterProvince,
                                          voterHalkaLocationLongitude:
                                              manageVoter
                                                  .voterHalkaLocationLongitude,
                                          voterHalkaLocationLatitude:
                                              manageVoter
                                                  .voterHalkaLocationLatitude);
                                    },
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.all(5),
                                    child: Card(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                           Expanded(
                                              child: Container(
                                            width: 100,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  labelText: 'Latitude'),
                                              onChanged: (val) {
                                                setState(() {
                                                  lt = double.parse(val);
                                                });
                                              },
                                            ),
                                          )),
                                          Expanded(
                                            child: Container(
                                              width: 100,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    labelText: 'Longitude'),
                                                onChanged: (val) {
                                                  setState(() {
                                                    lng = double.parse(val);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                         
                                        ],
                                      ),
                                    )),
                                Stack(
                                  children: <Widget>[
                                    Card(
                                        elevation: 6,
                                        child: Container(
                                            margin: EdgeInsets.all(10),
                                            height: 350,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: GoogleMap(
                                                mapType: MapType.normal,
                                                markers: marker.toSet(),
                                                trafficEnabled: true,
                                                onMapCreated: (controller) {
                                                  // controller.setMapStyle('assets/dark.json');
                                                  setState(() {
                                                    _controller = controller;
                                                  });
                                                },
                                                onTap: (coordinates) {
                                                  _controller.animateCamera(
                                                      CameraUpdate.newLatLng(
                                                          coordinates));
                                                  addMarker(coordinates);
                                                },
                                                compassEnabled: true,
                                                initialCameraPosition:
                                                    _initialPosition,
                                              ),
                                            ))),
                                    Positioned(
                                        bottom: 20,
                                        left: 160,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.green[700],
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: IconButton(
                                                iconSize: 30,
                                                icon: Icon(Icons.location_off),
                                                onPressed: () {
                                                  setState(() {
                                                    marker.removeWhere(
                                                        (element) =>
                                                            'M1' ==
                                                            element.markerId
                                                                .value);

                                                    longitude = 0;
                                                    latitude = 0;
                                                    addressLoc = null;
                                                  });
                                                }))),
                                    Positioned(
                                        bottom: 20,
                                        left: 90,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.green[700],
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: IconButton(
                                                iconSize: 30,
                                                icon: Icon(Icons.location_on),
                                                onPressed: () async {
                                                  if (marker.isNotEmpty) {
                                                    longitude = marker[0]
                                                        .position
                                                        .longitude;
                                                    latitude = marker[0]
                                                        .position
                                                        .latitude;
                                                    print(marker[0]
                                                        .position
                                                        .longitude);
                                                    final coordinates =
                                                        new Coordinates(
                                                            latitude,
                                                            longitude);
                                                    var address = await Geocoder
                                                        .local
                                                        .findAddressesFromCoordinates(
                                                            coordinates);
                                                    print('Longitude' +
                                                        longitude.toString());
                                                    print('Latitude' +
                                                        latitude.toString());
                                                    setState(() {
                                                      addressLoc = address
                                                          .first.addressLine;
                                                    });
                                                    showDialog(
                                                        context: context,
                                                        builder: (ctx) {
                                                          return AlertDialog(
                                                            content: Text(
                                                                '${address.first.addressLine} End'
                                                                ),
                                                          );
                                                        });
                                                  } else {
                                                    print('Null');
                                                  }
                                                })))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(top:30,right: 2),
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.green[700],
                                          border: Border.all(
                                              style: BorderStyle.solid,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: FlatButton(
                                            child: Text(
                                              'Find Station',
                                              style: TextStyle(
                                                  fontFamily: 'josefin',
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            onPressed: () async {
                                              Geolocator()
                                                  .placemarkFromCoordinates(
                                                      lt,lng)
                                                  .then((value) {
                                                _controller.animateCamera(
                                                    CameraUpdate.newCameraPosition(
                                                        CameraPosition(
                                                            target: LatLng(
                                                                value[0]
                                                                    .position
                                                                    .latitude,
                                                                value[0]
                                                                    .position
                                                                    .longitude),
                                                            zoom: 17)));
                                              });
                                            }),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(top: 30),
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.green[700],
                                          border: Border.all(
                                              style: BorderStyle.solid,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: FlatButton(
                                            onPressed: () {
                                              saveForm();
                                              print(
                                                  'Voter Registered Successfully');
                                            },
                                            child: Text(
                                              'Register Voter',
                                              style: TextStyle(
                                                  fontFamily: 'josefin',
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            )),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ))),
                ),
              ));
  }
}
