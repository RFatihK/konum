import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:konum/geolocator_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final geolocatorController = Get.put(GeolocatorController());

  getLocation() {
    Geolocator.requestPermission().then((request) {
      if (Platform.isIOS) {
        if (request != LocationPermission.whileInUse) {
          return;
        } else {
          geolocatorController.permissionOK();
        }
      } else {
        if (request != LocationPermission.always) {
          return;
        } else {
          geolocatorController.permissionOK();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Geçerli konum '),
          backgroundColor: Colors.green,
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () => getLocation(),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                  child: const Icon(Icons.map))),
          const SizedBox(height: 50),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                print(
                  'x: ${geolocatorController.currentLocation.latitude}, y: ${geolocatorController.currentLocation.longitude}',
                );
                Center(
                  child: Text(
                      'x: ${geolocatorController.currentLocation.latitude}, y: ${geolocatorController.currentLocation.longitude}'),
                );
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                  child: const Text('Göster')))
        ])));
  }
}
