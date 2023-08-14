import 'package:flutter/material.dart';

import 'package:mushrooms/Tab2_editFan.dart';
import 'package:mushrooms/Tab2_editHum.dart';
import 'package:mushrooms/Tab2_editWater.dart';
import 'package:mushrooms/Tab2_editTemp.dart';

import 'package:flutter_switch/flutter_switch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:mushrooms/model/DHT22.dart';
import 'package:mushrooms/model/Fan.dart';
import 'package:mushrooms/model/Watering.dart';

class Tab2 extends StatefulWidget {
  @override
  State<Tab2> createState() => _Tab2State();
}

final SaveTemp = TextEditingController();
final SaveHum = TextEditingController();

class _Tab2State extends State<Tab2> {
  // Temp
  late DatabaseReference _TempCombineDataRef =
      FirebaseDatabase.instance.ref('/DHT22/Temp/CombineData');
  late DatabaseReference _TempModeRef =
      FirebaseDatabase.instance.ref('/DHT22/Temp/mode');
  late DatabaseReference _TempStatuseRef =
      FirebaseDatabase.instance.ref('/DHT22/Temp/status');
  late DatabaseReference _DimmerHeaterRef =
      FirebaseDatabase.instance.ref('/DHT22/Temp/PWM');

// Hum
  late DatabaseReference _HumCombineDataRef =
      FirebaseDatabase.instance.ref('/DHT22/Hum/CombineData');
  late DatabaseReference _HumModeRef =
      FirebaseDatabase.instance.ref('/DHT22/Hum/mode');
  late DatabaseReference _HumStatusRef =
      FirebaseDatabase.instance.ref('/DHT22/Hum/status');
  late DatabaseReference _DimmerCreateHumRef =
      FirebaseDatabase.instance.ref('/DHT22/Hum/PWM');

// Fan
  late DatabaseReference _FanCombineDataRef =
      FirebaseDatabase.instance.ref('/Fan/CombineData');
  late DatabaseReference _FanModeRef =
      FirebaseDatabase.instance.ref('/Fan/mode');
  late DatabaseReference _FanStatusRef =
      FirebaseDatabase.instance.ref('/Fan/status');
  late DatabaseReference _DimmerFanRef =
      FirebaseDatabase.instance.ref('/Fan/PWM');

// Water
  late DatabaseReference _WaterCombineDataRef =
      FirebaseDatabase.instance.ref('/Water/CombineData');
  late DatabaseReference _WaterModeRef =
      FirebaseDatabase.instance.ref('/Water/mode');
  late DatabaseReference _WaterStatusRef =
      FirebaseDatabase.instance.ref('/Water/status');
  late DatabaseReference _DimmerWaterRef =
      FirebaseDatabase.instance.ref('/Water/PWM');

  FirebaseException? _error;

  DHT22 dht22 = new DHT22();
  Fan fan = new Fan();
  Watering watering = new Watering();

  Color? ColorAllTemp = Colors.black;
  Color? ColorAllHum = Colors.black;

  void initState() {
    dht22.ModeTemp = '';
    dht22.ModeHum = '';
    fan.Mode = '';
    watering.Mode = '';

    dht22.StatusTemp = false;
    dht22.StatusHum = false;

    fan.Status = false;
    watering.Status = false;

    dht22.DimmerHeater = 0;
    dht22.DimmerHum = 0;
    fan.Dimmer;
    watering.Dimmer;

    init();
    super.initState();
  }

  Future<void> init() async {
    // Temp
    _TempCombineDataRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        dht22.TempCombineData = (event.snapshot.value ?? 0) as String?;
        // print('TempCombineData : ${dht22.TempCombineData}');
        var data = dht22.TempCombineData?.split('/');
        dht22.TempStartCon = double.parse(data![0]);
        dht22.TempEndCon = double.parse(data[1]);
        dht22.TempStartTime = data[2].trim();
        dht22.TempEndTime = data[3].trim();
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });
    _TempModeRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        dht22.TempCombineData = (event.snapshot.value ?? 0) as String?;
        // print('TempCombineData : ${dht22.TempCombineData}');
        var data = dht22.TempCombineData?.split('/');
        dht22.ModeTemp = data![0].trim();
        if (dht22.ModeTemp == 'ตลอดเวลา') {
          ColorAllTemp = Color.fromARGB(255, 187, 186, 182);
        } else if (dht22.ModeTemp == 'ตามเวลาที่กำหนด') {
          ColorAllTemp = Colors.black;
        }
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });
    _TempStatuseRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        var data1 = (event.snapshot.value ?? 0) as int;
        dht22.StatusTemp = data1.isOdd;
        print('dht22.StatusTemp : ${dht22.StatusTemp}');
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });
    _DimmerHeaterRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        var data = (event.snapshot.value ?? 0) as int;
        dht22.DimmerHeater = (event.snapshot.value ?? 0) as int?;
        print('DimmerHeater : ${dht22.DimmerHeater}');
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });

    // Hum
    _HumCombineDataRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        dht22.HumCombineData = (event.snapshot.value ?? 0) as String?;
        // print('HumCombineData : ${dht22.HumCombineData}');
        var data = dht22.HumCombineData?.split('/');
        dht22.HumStartCon = int.parse(data![0]);
        dht22.HumEndCon = int.parse(data[1]);
        dht22.HumStartTime = data[2].trim();
        dht22.HumEndTime = data[3].trim();
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });
    _HumModeRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        dht22.HumCombineData = (event.snapshot.value ?? 0) as String?;
        // print('HumCombineData : ${dht22.HumCombineData}');
        var data = dht22.HumCombineData?.split('/');
        dht22.ModeHum = data![0].trim();
        if (dht22.ModeHum == 'ตลอดเวลา') {
          ColorAllHum = Color.fromARGB(255, 187, 186, 182);
        } else if (dht22.ModeHum == 'ตามเวลาที่กำหนด') {
          ColorAllHum = Colors.black;
        }
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });
    _HumStatusRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        var data1 = (event.snapshot.value ?? 0) as int;
        dht22.StatusHum = data1.isOdd;
        print('dht22.StatusHum : ${dht22.StatusHum}');
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
        dht22.DimmerHum = (event.snapshot.value ?? 0) as int?;
        print('DimmerHum : ${dht22.DimmerHum}');
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });

    // Fan
    _FanCombineDataRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        String? str = (event.snapshot.value ?? 0) as String?;
        // print('HumCombineData : ${dht22.HumCombineData}');
        var data = str?.split('/');
        fan.StartTime = data![0].trim();
        fan.EndTime = data[1].trim();
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });
    _FanModeRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        String? str = (event.snapshot.value ?? 0) as String?;
        // print('HumCombineData : ${dht22.HumCombineData}');
        var data = str?.split('/');
        fan.Mode = data![0].trim();
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });
    _FanStatusRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        var data1 = (event.snapshot.value ?? 0) as int;
        fan.Status = data1.isOdd;
        print('fan.Status : ${fan.Status}');
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
        fan.Dimmer = (event.snapshot.value ?? 0) as int?;
        print('DimmerFan : ${fan.Dimmer}');
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });

    // Water
    _WaterCombineDataRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        String? str = (event.snapshot.value ?? 0) as String?;
        // print('HumCombineData : ${dht22.HumCombineData}');
        var data = str?.split('/');
        watering.StartTime = data![0].trim();
        watering.EndTime = data[1].trim();
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });
    _WaterModeRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        String? str = (event.snapshot.value ?? 0) as String?;
        // print('HumCombineData : ${dht22.HumCombineData}');
        var data = str?.split('/');
        watering.Mode = data![0].trim();
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });
    _WaterStatusRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        var data1 = (event.snapshot.value ?? 0) as int;
        watering.Status = data1.isOdd;
        print('watering.Status : ${watering.Status}');
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
        watering.Dimmer = (event.snapshot.value ?? 0) as int?;
        print('DimmerWater : ${watering.Dimmer}');
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
    return Container(
      color: Color.fromARGB(255, 244, 242, 242),
      child: ListView(
        children: [
          //////////////////// ระบบควบคุมอุณหภูมิ ////////////////////
          Container(
            height: 260,
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 40,
                right: MediaQuery.of(context).size.width / 40,
                top: 20),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Icon(Icons.abc),
                    // Image.asset('image/fan.png', height: 35, width: 35),
                    Icon(
                      Icons.thermostat_rounded,
                      size: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 190, left: 0),
                      child: Text(
                        "ฮีตเตอร์ ",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0, right: 10),
                      child: FlutterSwitch(
                        showOnOff: true,
                        activeTextColor: Colors.black,
                        inactiveTextColor: Color.fromARGB(255, 23, 114, 180),
                        value: dht22.StatusTemp!,
                        onToggle: (val) {
                          dht22.StatusTemp = val;
                          setState(
                            () {
                              dht22.StatusTemp == true
                                  ? _TempStatuseRef.set(1)
                                  : _TempStatuseRef.set(0);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                  indent: 10,
                  endIndent: 10,
                  thickness: 0.3,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "โหมด : ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "${dht22.ModeTemp}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "อุณหภูมิควบคุม : ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "${dht22.TempStartCon} °C ถึง ${dht22.TempEndCon} °C",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(
                        //   "${dht22.TempStartCon} °C ถึง ${dht22.TempEndCon} °C",
                        //   style: TextStyle(fontSize: 18),
                        // ),
                        Text(
                          "ระดับควบคุม : ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "${dht22.DimmerHeater} %",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "เริ่มการควบคุม : ",
                          style: TextStyle(fontSize: 18, color: ColorAllTemp),
                        ),
                        Text(
                          "${dht22.TempStartTime} น.",
                          style: TextStyle(fontSize: 18, color: ColorAllTemp),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "สิ้นสุดการควบคุม : ",
                          style: TextStyle(fontSize: 18, color: ColorAllTemp),
                        ),
                        Text(
                          "${dht22.TempEndTime} น.",
                          style: TextStyle(fontSize: 18, color: ColorAllTemp),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 100 + 300),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Tab2_editTemp()),
                      );
                    },
                    icon: Icon(Icons.edit, size: 30),
                  ),
                ),
              ],
            ),
          ),
          //////////////////// ระบบควบคุมความชื้นสัมพัทธ์ ////////////////////
          Container(
            height: 260,
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 40,
                right: MediaQuery.of(context).size.width / 40,
                top: 20),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Icon(Icons.abc),
                    // Image.asset('image/fan.png', height: 35, width: 35),
                    // Icon(Icons.thermostat_rounded, size: 30,),
                    Icon(Icons.ac_unit, size: 30),
                    Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Text(
                        "อุปกรณ์ควบคุมความชื้นสัมพัทธ์ ",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0, right: 10),
                      child: FlutterSwitch(
                        showOnOff: true,
                        activeTextColor: Colors.black,
                        inactiveTextColor: Color.fromARGB(255, 23, 114, 180),
                        value: dht22.StatusHum!,
                        onToggle: (val) {
                          dht22.StatusHum = val;
                          setState(
                            () {
                              dht22.StatusHum == true
                                  ? _HumStatusRef.set(1)
                                  : _HumStatusRef.set(0);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                  indent: 10,
                  endIndent: 10,
                  thickness: 0.3,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "โหมด : ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "${dht22.ModeHum}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ความชื้นสัมพัทธ์ควบคุม : ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "${dht22.HumStartCon} % ถึง ${dht22.HumEndCon} %",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ระดับควบคุม : ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "${dht22.DimmerHum} %",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "เริ่มการควบคุม : ",
                          style: TextStyle(fontSize: 18, color: ColorAllHum),
                        ),
                        Text(
                          "${dht22.HumStartTime} น.",
                          style: TextStyle(fontSize: 18, color: ColorAllHum),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "สิ้นสุดการควบคุม : ",
                          style: TextStyle(fontSize: 18, color: ColorAllHum),
                        ),
                        Text(
                          "${dht22.HumEndTime} น.",
                          style: TextStyle(fontSize: 18, color: ColorAllHum),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 100 + 300),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Tab2_editHum()),
                      );
                    },
                    icon: Icon(Icons.edit, size: 30),
                  ),
                ),
              ],
            ),
          ),
          //////////////////// ระบบควบคุมพัดลมระบายอากาศ ////////////////////
          Container(
            height: 250,
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 40,
                right: MediaQuery.of(context).size.width / 40,
                top: 20),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Icon(Icons.abc),
                    // Image.asset('image/fan.png', height: 35, width: 35),
                    // Icon(Icons.thermostat_rounded, size: 30,),
                    // Icon(Icons.ac_unit, size: 30),
                    Image.asset('image/fan.png', height: 35, width: 35),
                    Padding(
                      padding: EdgeInsets.only(right: 100),
                      child: Text(
                        "พัดลมระบายอากาศ",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0, right: 10),
                      child: FlutterSwitch(
                        showOnOff: true,
                        activeTextColor: Colors.black,
                        inactiveTextColor: Color.fromARGB(255, 23, 114, 180),
                        value: fan.Status!,
                        onToggle: (val) {
                          fan.Status = val;
                          setState(
                            () {
                              fan.Status == true
                                  ? _FanStatusRef.set(1)
                                  : _FanStatusRef.set(0);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                  indent: 10,
                  endIndent: 10,
                  thickness: 0.3,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "โหมด : ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "${fan.Mode}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ระดับควบคุม : ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "${fan.Dimmer} %",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "เริ่มการควบคุม : ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "${fan.StartTime} น.",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "สิ้นสุดการควบคุม : ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "${fan.EndTime} น.",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 100 + 300),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Tab2_editFan()),
                      );
                    },
                    icon: Icon(Icons.edit, size: 30),
                  ),
                ),
              ],
            ),
          ),
          //////////////////// ระบบควบคุมการรดน้ำ ////////////////////
          Container(
            height: 250,
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 40,
                right: MediaQuery.of(context).size.width / 40,
                top: 20),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Icon(Icons.abc),
                    // Image.asset('image/fan.png', height: 35, width: 35),
                    Icon(Icons.water_drop_outlined, size: 35),
                    Padding(
                      padding: EdgeInsets.only(right: 80),
                      child: Text(
                        "อุปกรณ์ควบคุมการรดน้ำ",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0, right: 10),
                      child: FlutterSwitch(
                        showOnOff: true,
                        activeTextColor: Colors.black,
                        inactiveTextColor: Color.fromARGB(255, 23, 114, 180),
                        value: watering.Status!,
                        onToggle: (val) {
                          watering.Status = val;
                          setState(
                            () {
                              watering.Status == true
                                  ? _WaterStatusRef.set(1)
                                  : _WaterStatusRef.set(0);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                  indent: 10,
                  endIndent: 10,
                  thickness: 0.3,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "โหมด : ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "${watering.Mode}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ระดับควบคุม : ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "${watering.Dimmer} %",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "เริ่มการควบคุม : ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "${watering.StartTime} น.",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "สิ้นสุดการควบคุม : ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "${watering.EndTime} น.",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 100 + 300),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Tab2_editWater()),
                      );
                    },
                    icon: Icon(Icons.edit, size: 30),
                  ),
                ),
              ],
            ),
          ),
          /////////////////////////////////////// Container ปิดท้าย ////////////////////////////////////////////////////
          Padding(
              padding: EdgeInsets.only(top: 10),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    height: 5,
                    width: 390,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 1))
                        ]))
              ]))
          /////////////////////////////////////// Container ปิดท้าย ///////////////////////////////////////////////////
        ],
      ),
    );
  }
}
