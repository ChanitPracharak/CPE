import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:mushrooms/model/DHT22.dart';
import 'package:mushrooms/model/StatusWorking.dart';

class Tab1 extends StatefulWidget {
  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
// Temp
  late DatabaseReference _DataTempRef =
      FirebaseDatabase.instance.ref('/DHT22/Temp/DataTemp');

// Hum
  late DatabaseReference _DataHumRef =
      FirebaseDatabase.instance.ref('/DHT22/Hum/DataHum');

// Dimmer
  late DatabaseReference _DimmerHeaterRef =
      FirebaseDatabase.instance.ref('/StatusEquipment/Heater/DimmerHeater');
  late DatabaseReference _DimmerFanRef =
      FirebaseDatabase.instance.ref('/StatusEquipment/Fan/DimmerFan');
  late DatabaseReference _DimmerWaterRef =
      FirebaseDatabase.instance.ref('/StatusEquipment/Water/DimmerWater');
  late DatabaseReference _DimmerCreateHumRef =
      FirebaseDatabase.instance.ref('/StatusEquipment/CreateHum/DimmerCreateHum');

  FirebaseException? _error;

  DHT22 dht22 = new DHT22();
  StatusWorking status = new StatusWorking();

  Color? ColorAllTemp = Colors.black;
  Color? ColorAllHum = Colors.black;

  var SizePhoneScreen;

  void initState() {
    dht22.DataTemp = 0;
    dht22.DataHum = 0;
    status.ChangeColorHeater = Color(0xFFbebebe);
    status.ChangeColorFan = Color(0xFFbebebe);
    status.ChangeColorWater = Color(0xFFbebebe);
    status.ChangeColorCreateHum = Color(0xFFbebebe);
    status.DimmerHeater = 0;
    status.DimmerCreateHum = 0;
    status.DimmerFan = 0;
    status.DimmerWater = 0;
    init();
    super.initState();
  }

  Future<void> init() async {
    // Temp
    _DataTempRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        // dht22.DataTemp = event.snapshot.value as double;
        dynamic koko = event.snapshot.value;
        dht22.DataTemp = double.parse(koko.toString());
        // print('dataTemp : ${dht22.DataTemp}');
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });

    // Hum
    _DataHumRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        dht22.DataHum = (event.snapshot.value ?? 0) as int?;
        // print('dataHum : ${dht22.DataHum}');
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });

    // Dimmer
    _DimmerHeaterRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        var data = (event.snapshot.value ?? 0) as int;
        status.DimmerHeater = (event.snapshot.value ?? 0) as int?;
        print('DimmerHeater : ${status.DimmerHeater}');
        if (status.DimmerHeater! > 0) {
          status.ChangeColorHeater = Color(0xFF66EC66);
        } else {
          status.ChangeColorHeater = Color(0xFFbebebe); 
        }
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });

    _DimmerFanRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        var data = (event.snapshot.value ?? 0) as int;
        status.DimmerFan = (event.snapshot.value ?? 0) as int?;
        print('DimmerFan : ${status.DimmerFan}');
        if (status.DimmerFan! > 0) {
          status.ChangeColorFan = Color(0xFF66EC66);
        } else {
          status.ChangeColorFan = Color(0xFFbebebe); 
        }
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });

    _DimmerWaterRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        var data = (event.snapshot.value ?? 0) as int;
        status.DimmerWater = (event.snapshot.value ?? 0) as int?;
        print('DimmerWater : ${status.DimmerWater}');
        if (status.DimmerWater! > 0) {
          status.ChangeColorWater = Color(0xFF66EC66);
        } else {
          status.ChangeColorWater = Color(0xFFbebebe); 
        }
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });

    _DimmerCreateHumRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        var data = (event.snapshot.value ?? 0) as int;
        status.DimmerCreateHum = (event.snapshot.value ?? 0) as int?;
        print('DimmerCreateHum : ${status.DimmerCreateHum}');
        if (status.DimmerCreateHum! > 0) {
          status.ChangeColorCreateHum = Color(0xFF66EC66);
        } else {
          status.ChangeColorCreateHum = Color(0xFFbebebe); 
        }
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    SizePhoneScreen = MediaQuery.of(context).size.width;
    print("SizePhoneScreen : " + SizePhoneScreen.toString());
    return Container(
      color: Color.fromARGB(255, 244, 242, 242),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                width: SizePhoneScreen / 2 - 26,
                height: 210, // 310
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 0.1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "อุณหภูมิ",
                            style: TextStyle(fontSize: 17),
                          ),
                          Icon(Icons.thermostat_rounded),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      indent: 10,
                      endIndent: 10,
                      thickness: 0.3,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 170,
                            height: 150,
                            // color: Colors.black,
                            child: SfRadialGauge(
                              axes: <RadialAxis>[
                                RadialAxis(
                                  minimum: 0,
                                  maximum: 100,
                                  showLabels: false,
                                  showTicks: false,
                                  radiusFactor: 1,
                                  axisLineStyle: AxisLineStyle(
                                    cornerStyle: CornerStyle.bothCurve,
                                    color: Colors.black12,
                                    thickness: 10,
                                  ),
                                  pointers: <GaugePointer>[
                                    RangePointer(
                                      value: dht22.DataTemp!,
                                      cornerStyle: CornerStyle.bothCurve,
                                      width: 10, //
                                      sizeUnit: GaugeSizeUnit.logicalPixel,
                                      gradient: const SweepGradient(
                                        colors: <Color>[
                                          Color(0xFFCC2B5E),
                                          Color(0xFF753A88)
                                        ],
                                        stops: <double>[0.25, 0.75],
                                      ),
                                    ),
                                    MarkerPointer(
                                      value: dht22.DataTemp!,
                                      enableDragging: true,
                                      onValueChanged: (val) {
                                        setState(() {});
                                      },
                                      markerHeight: 0, //
                                      markerWidth: 0, //
                                      markerType: MarkerType.circle,
                                      color: Color(0xFF753A88),
                                      borderWidth: 2,
                                      borderColor: Colors.white54,
                                    ),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      angle: 90,
                                      axisValue: 5,
                                      positionFactor: 0.2,
                                      widget: Text(
                                        "${dht22.DataTemp} °C",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFCC2B5E),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ////////////////////////// ความชื้นสัมพัทธ์ //////////////////////////
              Container(
                margin: EdgeInsets.all(10),
                width: SizePhoneScreen / 2 - 26,
                height: 210, // 310
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 0.1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "ความชื้นสัมพัทธ์",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                        Icon(Icons.ac_unit)
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      indent: 10,
                      endIndent: 10,
                      thickness: 0.3,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 170,
                            height: 150,
                            // color: Colors.black,
                            child: SfRadialGauge(
                              axes: <RadialAxis>[
                                RadialAxis(
                                  minimum: 0,
                                  maximum: 100,
                                  showLabels: false,
                                  showTicks: false,
                                  radiusFactor: 1,
                                  axisLineStyle: AxisLineStyle(
                                    cornerStyle: CornerStyle.bothCurve,
                                    color: Colors.black12,
                                    thickness: 10,
                                  ),
                                  pointers: <GaugePointer>[
                                    RangePointer(
                                      value: double.parse(
                                          dht22.DataHum.toString()),
                                      cornerStyle: CornerStyle.bothCurve,
                                      width: 10, //
                                      sizeUnit: GaugeSizeUnit.logicalPixel,
                                      gradient: const SweepGradient(
                                        colors: <Color>[
                                          Color(0xFFCC2B5E),
                                          Color(0xFF753A88)
                                        ],
                                        stops: <double>[0.25, 0.75],
                                      ),
                                    ),
                                    MarkerPointer(
                                      // value: ValueTemp,
                                      enableDragging: true,
                                      onValueChanged: (val) {
                                        setState(() {});
                                      },
                                      markerHeight: 0, //
                                      markerWidth: 0, //
                                      markerType: MarkerType.circle,
                                      color: Color(0xFF753A88),
                                      borderWidth: 2,
                                      borderColor: Colors.white54,
                                    ),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      angle: 90,
                                      axisValue: 5,
                                      positionFactor: 0.2,
                                      widget: Text(
                                        "${dht22.DataHum} %",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFCC2B5E),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ///////////////////////////////////////////////

          ///////////////////// ฮีตเตอร์ /////////////////////////
          Container(
            margin: EdgeInsets.only(
              top: 5,
              right: 16,
              left: 16,
              bottom: 10,
            ),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 0.1),
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Icon(Icons.thermostat_rounded),
                ),
                Expanded(
                  child: Text("ฮีตเตอร์"),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  // child: Text('${}'),
                  child: Text('${status.DimmerHeater} %'),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: status.ChangeColorHeater,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ],
            ),
          ),
          //////////////////////// พัดลมระบายอากาศ ///////////////////////////
          Container(
            margin: EdgeInsets.only(
              top: 5,
              right: 16,
              left: 16,
              bottom: 10,
            ),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 0.1),
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Image.asset('image/fan.png', height: 25, width: 25),
                ),
                Expanded(
                  child: Text("พัดลมระบายอากาศ"),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  // child: Text('${}'),
                  child: Text('${status.DimmerFan} %'),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: status.ChangeColorFan,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ],
            ),
          ),
          /////////////////////// อุปกรณ์ควบคุมการรดน้ำรดน้ำ ////////////////////////////
          Container(
            margin: EdgeInsets.only(
              top: 5,
              right: 16,
              left: 16,
              bottom: 10,
            ),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 0.1),
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Icon(Icons.water_drop_outlined, size: 25),
                ),
                Expanded(
                  child: Text("อุปกรณ์ควบคุมการรดน้ำรดน้ำ"),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  // child: Text('${status.StrWater}'),
                  child: Text('${status.DimmerWater} %'),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: status.ChangeColorWater,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ],
            ),
          ),
          /////////////////////// อุปกรณ์ควบคุมความชื้นสัมพัทธ์ ////////////////////////////
          Container(
            margin: EdgeInsets.only(
              top: 5,
              right: 16,
              left: 16,
              bottom: 10,
            ),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 0.1),
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Image.asset('image/soil_moisture.png',
                      height: 25, width: 25),
                ),
                Expanded(
                  child: Text("อุปกรณ์ควบคุมความชื้นสัมพัทธ์"),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  // child: Text('${status.StrCreateHum}'),
                  child: Text('${status.DimmerCreateHum} %'),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: status.ChangeColorCreateHum,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ],
            ),
          ),
          ///////////////////////////////////////////////
        ],
      ),
    );
  }
}
