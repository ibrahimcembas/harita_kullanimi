import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Adana`ya gidek mi?'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //AIzaSyBKDrymuETQQ76Q9DPnI5p6ej1JV0ST1JQ

  Completer<GoogleMapController> haritaKontrol = Completer();

  var baslangicKonum =
      CameraPosition(target: LatLng(38.7412482, 26.1844276), zoom: 4);

  List<Marker> isaretler = <Marker>[];

  Future<void> konumaGit() async {
    GoogleMapController controller = await haritaKontrol.future;

    var gidilecekIsaret = Marker(
      markerId: MarkerId('Id'),
      position: LatLng(37.5005, 35.715),
      infoWindow: InfoWindow(title: 'Adana', snippet: 'Babba Merhaba'),
    );

    setState(() {
      isaretler.add(gidilecekIsaret);
    });

    var gidilecekKonum =
        CameraPosition(target: LatLng(37.5005, 35.715), zoom: 7);

    controller.animateCamera(CameraUpdate.newCameraPosition(gidilecekKonum));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: baslangicKonum,
                markers: Set<Marker>.of(isaretler),
                onMapCreated: (GoogleMapController controller) {
                  haritaKontrol.complete(controller);
                },
              ),
            ),
            RaisedButton(
              child: Text('Adana`ya Git'),
              onPressed: () {
                konumaGit();
              },
            ),
          ],
        ),
      ),
    );
  }
}
