import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:flutter_switch/flutter_switch.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:mushrooms/model/StatusEquipment.dart';

class Tab3 extends StatefulWidget {
  const Tab3({Key? key}) : super(key: key);

  @override
  State<Tab3> createState() => _Tab3State();
}

class _Tab3State extends State<Tab3> {
  final DimmerStatusHeater = TextEditingController();
  final DimmerStatusHum = TextEditingController();
  final DimmerStatusFan = TextEditingController();
  final DimmerStatusWater = TextEditingController();

  late DatabaseReference _StateHeaterRef =
      FirebaseDatabase.instance.ref('/StatusEquipment/Heater/Heater');
  late DatabaseReference _StateCreateHumRef =
      FirebaseDatabase.instance.ref('/StatusEquipment/CreateHum/CreateHum');

  late DatabaseReference _StateFanRef =
      FirebaseDatabase.instance.ref('/StatusEquipment/Fan/Fan');
  late DatabaseReference _StateWaterRef =
      FirebaseDatabase.instance.ref('/StatusEquipment/Water/Water');

  late DatabaseReference _StateSYSLocalTime =
      FirebaseDatabase.instance.ref('/SYSlocaltiem/status');

  FirebaseException? _error;

  StatusEquipment Status = new StatusEquipment();

  double HeightHeater = 140;
  double HeightCreateHum = 140;
  double HeightFan = 140;
  double HeightWater = 140;

  // Error Heater
  int ErrorDimmerNullHeater = 0;
  int ErrorDimmerMoreHeater = 0;
  int ErrorDimmerLessHeater = 0;

  // Error CreaterHum
  int ErrorDimmerNullCreateHum = 0;
  int ErrorDimmerMoreCreateHum = 0;
  int ErrorDimmerLessCreateHum = 0;

  // Error Fan
  int ErrorDimmerNullFan = 0;
  int ErrorDimmerMoreFan = 0;
  int ErrorDimmerLessFan = 0;

  // Error Water
  int ErrorDimmerNullWater = 0;
  int ErrorDimmerMoreWater = 0;
  int ErrorDimmerLessWater = 0;

  void initState() {
    Status.Heater = false;
    Status.Fan = false;
    Status.CreateHum = false;
    Status.Water = false;

    init();
    super.initState();
  }

  Future<void> init() async {
    _StateHeaterRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        var data1 = (event.snapshot.value ?? 0) as int;
        Status.Heater = data1.isOdd;
        print('StateHeater1 : ${Status.Heater}');
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });

    _StateCreateHumRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        var data2 = (event.snapshot.value ?? 0) as int;
        Status.CreateHum = data2.isOdd;
        // print('StateFogging : ${Status.Fogging}');
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });

    _StateFanRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        var data3 = (event.snapshot.value ?? 0) as int;
        Status.Fan = data3.isOdd;
        print('StateFan : ${Status.Fan}');
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });

    _StateWaterRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        var data4 = (event.snapshot.value ?? 0) as int;
        Status.Water = data4.isOdd;
        print('StateWater : ${Status.Water}');
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        _error = error;
      });
    });

    _StateSYSLocalTime.onValue.listen((DatabaseEvent event) {
      setState(() {
        _error = null;
        var data4 = (event.snapshot.value ?? 0) as int;
        Status.SysLocalTime = data4.isOdd;
        print('StateSysLocalTime : ${Status.SysLocalTime}');
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
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: HeightHeater, // 140
                      width: 374, // 374
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
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text("ฮีตเตอร์ "),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: FlutterSwitch(
                                    showOnOff: true,
                                    activeTextColor: Colors.black,
                                    inactiveTextColor:
                                        Color.fromARGB(255, 23, 114, 180),
                                    value: Status.Heater!,
                                    onToggle: (val) {
                                      Status.Heater = val;
                                      setState(
                                        () {
                                          if (DimmerStatusHeater.text.isEmpty) {
                                            HeightHeater = 170;
                                            ErrorDimmerMoreHeater = 0;
                                            ErrorDimmerLessHeater = 0;
                                            ErrorDimmerNullHeater = 1;
                                            Status.Heater = false;
                                          } else if (!DimmerStatusHeater
                                                  .text.isEmpty &&
                                              int.parse(
                                                      DimmerStatusHeater.text) >
                                                  100) {
                                            HeightHeater = 170;
                                            ErrorDimmerNullHeater = 0;
                                            ErrorDimmerLessHeater = 0;
                                            ErrorDimmerMoreHeater = 1;
                                            Status.Heater = false;
                                          } else if (!DimmerStatusHeater
                                                  .text.isEmpty &&
                                              int.parse(
                                                      DimmerStatusHeater.text) <
                                                  0) {
                                            HeightHeater = 170;
                                            ErrorDimmerNullHeater = 0;
                                            ErrorDimmerMoreHeater = 0;
                                            ErrorDimmerLessHeater = 1;
                                            Status.Heater = false;
                                          } else {
                                            HeightHeater = 140;
                                            ErrorDimmerNullHeater = 0;
                                            ErrorDimmerMoreHeater = 0;
                                            ErrorDimmerLessHeater = 0;
                                            Status.Heater == true
                                                ? _StateHeaterRef.set(1)
                                                : _StateHeaterRef.set(0);
                                            FirebaseDatabase.instance
                                                .ref(
                                                    '/StatusEquipment/Heater/DimmerHeater')
                                                .set(int.parse(
                                                    DimmerStatusHeater.text));
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 10, // ระยะห่างของเส้น
                            color: Color.fromARGB(255, 130, 124, 124), // สีเส้น
                            thickness: 1, // ความหน้าของเส้น
                            indent: 10, // ให้เส้นสั้นลงจากข้างหน้า
                            endIndent: 10, // ให้เส้นสั้นลงจากข้างหลัง
                          ),
                          /////////////////////////////////////////////////////
                          SizedBox(height: 10),
                          ////////////////// Dimmer /////////////////////////
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  height: 48, // 48
                                  // width: MediaQuery.of(context).size.width,
                                  width: 350, // 350
                                  color: Colors.transparent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 350, // 350
                                  child: TextFormField(
                                    // style: TextStyle(color: Colors.red),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(
                                          RegExp(r'[,-]')),
                                    ],
                                    controller: DimmerStatusHeater,
                                    onChanged: (String val) {
                                      setState(() {});
                                    },
                                    validator: (text) {
                                      if (text!.isEmpty) {
                                        return 'กรุณากรอกค่า PWM';
                                      } else if (double.parse(text) > 100) {
                                        return 'กรุณากรอกค่าPWMไม่เกินกว่า 100 %';
                                      } else if (double.parse(text) < 25) {
                                        return 'กรุณากรอกค่าPWMไม่ต่ำกว่า 0 %';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    // maxLines: null,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 14, // 14
                                        horizontal: 15, // 15
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      // filled: true,
                                      hintStyle: TextStyle(
                                        color: Colors.grey[800],
                                      ), // Colors.grey[800]
                                      labelText: "ระดับควบคุม : ",
                                      fillColor:
                                          Colors.white70, // Colors.white70,
                                      // alignLabelWithHint: true,
                                      isDense: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ////////////////////////////// end Dimmer /////////////////////////////////////
                          AlertErrorDimmerNullHeater(),
                          AlertErrorDimmerMoreHeater(),
                          AlertErrorDimmerLessHeater(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ////////////////////////////////////////////////////////////////////////////////////////////
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: HeightCreateHum, // 140
                      width: 374, // 374
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
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text("อุปกรณ์ควบคุมความชื้นสัมพัทธ์ "),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: FlutterSwitch(
                                    showOnOff: true,
                                    activeTextColor: Colors.black,
                                    inactiveTextColor:
                                        Color.fromARGB(255, 23, 114, 180),
                                    value: Status.CreateHum!,
                                    onToggle: (val) {
                                      Status.CreateHum = val;
                                      setState(
                                        () {
                                          if (DimmerStatusHum.text.isEmpty) {
                                            HeightCreateHum = 170;
                                            ErrorDimmerMoreCreateHum = 0;
                                            ErrorDimmerLessCreateHum = 0;
                                            ErrorDimmerNullCreateHum = 1;
                                            Status.CreateHum = false;
                                          } else if (!DimmerStatusHum
                                                  .text.isEmpty &&
                                              int.parse(DimmerStatusHum.text) >
                                                  100) {
                                            HeightCreateHum = 170;
                                            ErrorDimmerNullCreateHum = 0;
                                            ErrorDimmerLessCreateHum = 0;
                                            ErrorDimmerMoreCreateHum = 1;
                                            Status.CreateHum = false;
                                          } else if (!DimmerStatusHum
                                                  .text.isEmpty &&
                                              int.parse(DimmerStatusHum.text) <
                                                  0) {
                                            HeightCreateHum = 170;
                                            ErrorDimmerNullCreateHum = 0;
                                            ErrorDimmerMoreCreateHum = 0;
                                            ErrorDimmerLessCreateHum = 1;
                                            Status.CreateHum = false;
                                          } else {
                                            HeightCreateHum = 140;
                                            ErrorDimmerNullCreateHum = 0;
                                            ErrorDimmerMoreCreateHum = 0;
                                            ErrorDimmerLessCreateHum = 0;
                                            Status.CreateHum == true
                                                ? _StateCreateHumRef.set(1)
                                                : _StateCreateHumRef.set(0);
                                            FirebaseDatabase.instance
                                                .ref(
                                                    '/StatusEquipment/CreateHum/DimmerCreateHum')
                                                .set(int.parse(
                                                    DimmerStatusHum.text));
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 10, // ระยะห่างของเส้น
                            color: Color.fromARGB(255, 130, 124, 124), // สีเส้น
                            thickness: 1, // ความหน้าของเส้น
                            indent: 10, // ให้เส้นสั้นลงจากข้างหน้า
                            endIndent: 10, // ให้เส้นสั้นลงจากข้างหลัง
                          ),
                          /////////////////////////////////////////////////////
                          SizedBox(height: 10),
                          ////////////////// Dimmer /////////////////////////
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  height: 48, // 48
                                  // width: MediaQuery.of(context).size.width,
                                  width: 350, // 350
                                  color: Colors.transparent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 350, // 350
                                  child: TextFormField(
                                    // style: TextStyle(color: Colors.red),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(
                                          RegExp(r'[,-]')),
                                    ],
                                    controller: DimmerStatusHum,
                                    onChanged: (String val) {
                                      setState(() {});
                                    },
                                    validator: (text) {
                                      if (text!.isEmpty) {
                                        return 'กรุณากรอกค่า PWM';
                                      } else if (double.parse(text) > 100) {
                                        return 'กรุณากรอกค่าPWMไม่เกินกว่า 100 %';
                                      } else if (double.parse(text) < 25) {
                                        return 'กรุณากรอกค่าPWMไม่ต่ำกว่า 0 %';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    // maxLines: null,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 14, // 14
                                        horizontal: 15, // 15
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      // filled: true,
                                      hintStyle: TextStyle(
                                        color: Colors.grey[800],
                                      ), // Colors.grey[800]
                                      labelText: "ระดับควบคุม : ",
                                      fillColor:
                                          Colors.white70, // Colors.white70,
                                      // alignLabelWithHint: true,
                                      isDense: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ////////////////////////////// end Dimmer /////////////////////////////////////
                          AlertErrorDimmerNullCreaterHum(),
                          AlertErrorDimmerMoreCreaterHum(),
                          AlertErrorDimmerLessCreaterHum(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ///////////////////////////////////////////////////////////////////////////////////////////
              ///
              ////////////////////////////////////////////////////////////////////////////////////////////
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: HeightFan, // 140
                      width: 374, // 374
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
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text("พัดลมระบายอากาศ "),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: FlutterSwitch(
                                    showOnOff: true,
                                    activeTextColor: Colors.black,
                                    inactiveTextColor:
                                        Color.fromARGB(255, 23, 114, 180),
                                    value: Status.Fan!,
                                    onToggle: (val) {
                                      Status.Fan = val;
                                      setState(
                                        () {
                                          if (DimmerStatusFan.text.isEmpty) {
                                            HeightFan = 170;
                                            ErrorDimmerMoreFan = 0;
                                            ErrorDimmerLessFan = 0;
                                            ErrorDimmerNullFan = 1;
                                            Status.Fan = false;
                                          } else if (!DimmerStatusFan
                                                  .text.isEmpty &&
                                              int.parse(DimmerStatusFan.text) >
                                                  100) {
                                            HeightFan = 170;
                                            ErrorDimmerNullFan = 0;
                                            ErrorDimmerLessFan = 0;
                                            ErrorDimmerMoreFan = 1;
                                            Status.Fan = false;
                                          } else if (!DimmerStatusFan
                                                  .text.isEmpty &&
                                              int.parse(DimmerStatusFan.text) <
                                                  0) {
                                            HeightFan = 170;
                                            ErrorDimmerNullFan = 0;
                                            ErrorDimmerMoreFan = 0;
                                            ErrorDimmerLessFan = 1;
                                            Status.Fan = false;
                                          } else {
                                            HeightFan = 140;
                                            ErrorDimmerNullFan = 0;
                                            ErrorDimmerMoreFan = 0;
                                            ErrorDimmerLessFan = 0;
                                            Status.Fan == true
                                                ? _StateFanRef.set(1)
                                                : _StateFanRef.set(0);
                                            FirebaseDatabase.instance
                                                .ref(
                                                    '/StatusEquipment/Fan/DimmerFan')
                                                .set(int.parse(
                                                    DimmerStatusFan.text));
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 10, // ระยะห่างของเส้น
                            color: Color.fromARGB(255, 130, 124, 124), // สีเส้น
                            thickness: 1, // ความหน้าของเส้น
                            indent: 10, // ให้เส้นสั้นลงจากข้างหน้า
                            endIndent: 10, // ให้เส้นสั้นลงจากข้างหลัง
                          ),
                          /////////////////////////////////////////////////////
                          SizedBox(height: 10),
                          ////////////////// Dimmer /////////////////////////
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  height: 48, // 48
                                  // width: MediaQuery.of(context).size.width,
                                  width: 350, // 350
                                  color: Colors.transparent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 350, // 350
                                  child: TextFormField(
                                    // style: TextStyle(color: Colors.red),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(
                                          RegExp(r'[,-]')),
                                    ],
                                    controller: DimmerStatusFan,
                                    onChanged: (String val) {
                                      setState(() {});
                                    },
                                    validator: (text) {
                                      if (text!.isEmpty) {
                                        return 'กรุณากรอกค่า PWM';
                                      } else if (double.parse(text) > 100) {
                                        return 'กรุณากรอกค่าPWMไม่เกินกว่า 100 %';
                                      } else if (double.parse(text) < 25) {
                                        return 'กรุณากรอกค่าPWMไม่ต่ำกว่า 0 %';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    // maxLines: null,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 14, // 14
                                        horizontal: 15, // 15
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      // filled: true,
                                      hintStyle: TextStyle(
                                        color: Colors.grey[800],
                                      ), // Colors.grey[800]
                                      labelText: "ระดับควบคุม : ",
                                      fillColor:
                                          Colors.white70, // Colors.white70,
                                      // alignLabelWithHint: true,
                                      isDense: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ////////////////////////////// end Dimmer /////////////////////////////////////
                          AlertErrorDimmerNullFan(),
                          AlertErrorDimmerMoreFan(),
                          AlertErrorDimmerLessFan(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ///////////////////////////////////////////////////////////////////////////////////////////
              ///
              ////////////////////////////////////////////////////////////////////////////////////////////
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: HeightWater, // 140
                      width: 374, // 374
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
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text("อุปกรณ์ควบคุมการรดน้ำ "),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: FlutterSwitch(
                                    showOnOff: true,
                                    activeTextColor: Colors.black,
                                    inactiveTextColor:
                                        Color.fromARGB(255, 23, 114, 180),
                                    value: Status.Water!,
                                    onToggle: (val) {
                                      Status.Water = val;
                                      setState(
                                        () {
                                          if (DimmerStatusWater.text.isEmpty) {
                                            HeightWater = 170;
                                            ErrorDimmerMoreWater = 0;
                                            ErrorDimmerLessWater = 0;
                                            ErrorDimmerNullWater = 1;
                                            Status.Water = false;
                                          } else if (!DimmerStatusWater
                                                  .text.isEmpty &&
                                              int.parse(
                                                      DimmerStatusWater.text) >
                                                  100) {
                                            HeightWater = 170;
                                            ErrorDimmerNullWater = 0;
                                            ErrorDimmerLessWater = 0;
                                            ErrorDimmerMoreWater = 1;
                                            Status.Water = false;
                                          } else if (!DimmerStatusWater
                                                  .text.isEmpty &&
                                              int.parse(
                                                      DimmerStatusWater.text) <
                                                  0) {
                                            HeightWater = 170;
                                            ErrorDimmerNullWater = 0;
                                            ErrorDimmerMoreWater = 0;
                                            ErrorDimmerLessWater = 1;
                                            Status.Water = false;
                                          } else {
                                            HeightWater = 140;
                                            ErrorDimmerNullWater = 0;
                                            ErrorDimmerMoreWater = 0;
                                            ErrorDimmerLessWater = 0;
                                            Status.Water == true
                                                ? _StateWaterRef.set(1)
                                                : _StateWaterRef.set(0);
                                            FirebaseDatabase.instance
                                                .ref(
                                                    '/StatusEquipment/Water/DimmerWater')
                                                .set(int.parse(
                                                    DimmerStatusWater.text));
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 10, // ระยะห่างของเส้น
                            color: Color.fromARGB(255, 130, 124, 124), // สีเส้น
                            thickness: 1, // ความหน้าของเส้น
                            indent: 10, // ให้เส้นสั้นลงจากข้างหน้า
                            endIndent: 10, // ให้เส้นสั้นลงจากข้างหลัง
                          ),
                          /////////////////////////////////////////////////////
                          SizedBox(height: 10),
                          ////////////////// Dimmer /////////////////////////
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  height: 48, // 48
                                  // width: MediaQuery.of(context).size.width,
                                  width: 350, // 350
                                  color: Colors.transparent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 350, // 350
                                  child: TextFormField(
                                    // style: TextStyle(color: Colors.red),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(
                                          RegExp(r'[,-]')),
                                    ],
                                    controller: DimmerStatusWater,
                                    onChanged: (String val) {
                                      setState(() {});
                                    },
                                    validator: (text) {
                                      if (text!.isEmpty) {
                                        return 'กรุณากรอกค่า PWM';
                                      } else if (double.parse(text) > 100) {
                                        return 'กรุณากรอกค่าPWMไม่เกินกว่า 100 %';
                                      } else if (double.parse(text) < 25) {
                                        return 'กรุณากรอกค่าPWMไม่ต่ำกว่า 0 %';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    // maxLines: null,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 14, // 14
                                        horizontal: 15, // 15
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      // filled: true,
                                      hintStyle: TextStyle(
                                        color: Colors.grey[800],
                                      ), // Colors.grey[800]
                                      labelText: "ระดับควบคุม : ",
                                      fillColor:
                                          Colors.white70, // Colors.white70,
                                      // alignLabelWithHint: true,
                                      isDense: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AlertErrorDimmerNullWater(),
                          AlertErrorDimmerMoreWater(),
                          AlertErrorDimmerLessWater(),
                          ////////////////////////////// end Dimmer /////////////////////////////////////
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ///////////////////////////////// SYSLocaltime//////////////////////////////////////////////////////////////////////////
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // height: HeightWater, // 140
                      height: 60, // 140
                      width: 374, // 374
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
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text("ระบบบันทึกเวลา"),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: FlutterSwitch(
                                    showOnOff: true,
                                    activeTextColor: Colors.black,
                                    inactiveTextColor:
                                        Color.fromARGB(255, 23, 114, 180),
                                    value: Status.SysLocalTime!,
                                    onToggle: (val) {
                                      Status.SysLocalTime = val;
                                      setState(
                                        () {
                                          Status.SysLocalTime == true
                                              ? _StateSYSLocalTime.set(1)
                                              : _StateSYSLocalTime.set(0);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Divider(
                          //   height: 10, // ระยะห่างของเส้น
                          //   color: Color.fromARGB(255, 130, 124, 124), // สีเส้น
                          //   thickness: 1, // ความหน้าของเส้น
                          //   indent: 10, // ให้เส้นสั้นลงจากข้างหน้า
                          //   endIndent: 10, // ให้เส้นสั้นลงจากข้างหลัง
                          // ),
                          /////////////////////////////////////////////////////
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10)
              /////////////////////////////////////// Container ปิดท้าย ////////////////////////////////////////////////////
              // Padding(
              //     padding: EdgeInsets.only(top: 10),
              //     child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Container(
              //               height: 5,
              //               width: 374,
              //               decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   borderRadius: BorderRadius.only(
              //                       topLeft: Radius.circular(10),
              //                       topRight: Radius.circular(10),
              //                       bottomLeft: Radius.circular(10),
              //                       bottomRight: Radius.circular(10)),
              //                   boxShadow: [
              //                     BoxShadow(
              //                         color: Colors.grey.withOpacity(0.5),
              //                         spreadRadius: 2,
              //                         blurRadius: 7,
              //                         offset: Offset(0, 1))
              //                   ]))
              //         ]))
              /////////////////////////////////////// Container ปิดท้าย ///////////////////////////////////////////////////
            ],
          ),
        ),
      ),
    );
  }

  // AlertErrorDimmerHeater
  Widget AlertErrorDimmerNullHeater() {
    if (ErrorDimmerNullHeater == 1) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 10,
        ),
        child: Text(
          "กรุณากอกค่าระดับควบคุม",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
    }
    return SizedBox(height: 0);
  }

  Widget AlertErrorDimmerMoreHeater() {
    if (ErrorDimmerMoreHeater == 1) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 10,
        ),
        child: Text(
          "กรุณากอกค่าระดับควบคุมไม่เกิน 100 %",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
    }
    return SizedBox(height: 0);
  }

  Widget AlertErrorDimmerLessHeater() {
    if (ErrorDimmerLessHeater == 1) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 10,
        ),
        child: Text(
          "กรุณากอกค่าระดับควบคุมไม่ต่ำกว่า 0 %",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
    }
    return SizedBox(height: 0);
  }

  // AlertErrorDimmerCreaterHum
  Widget AlertErrorDimmerNullCreaterHum() {
    if (ErrorDimmerNullCreateHum == 1) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 10,
        ),
        child: Text(
          "กรุณากอกค่าระดับควบคุม",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
    }
    return SizedBox(height: 0);
  }

  Widget AlertErrorDimmerMoreCreaterHum() {
    if (ErrorDimmerMoreCreateHum == 1) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 10,
        ),
        child: Text(
          "กรุณากอกค่าระดับควบคุมไม่เกิน 100 %",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
    }
    return SizedBox(height: 0);
  }

  Widget AlertErrorDimmerLessCreaterHum() {
    if (ErrorDimmerLessCreateHum == 1) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 10,
        ),
        child: Text(
          "กรุณากอกค่าระดับควบคุมไม่ต่ำกว่า 0 %",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
    }
    return SizedBox(height: 0);
  }

  // AlertErrorDimmerFan
  Widget AlertErrorDimmerNullFan() {
    if (ErrorDimmerNullFan == 1) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 10,
        ),
        child: Text(
          "กรุณากอกค่าระดับควบคุม",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
    }
    return SizedBox(height: 0);
  }

  Widget AlertErrorDimmerMoreFan() {
    if (ErrorDimmerMoreFan == 1) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 10,
        ),
        child: Text(
          "กรุณากอกค่าระดับควบคุมไม่เกิน 100 %",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
    }
    return SizedBox(height: 0);
  }

  Widget AlertErrorDimmerLessFan() {
    if (ErrorDimmerLessFan == 1) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 10,
        ),
        child: Text(
          "กรุณากอกค่าระดับควบคุมไม่ต่ำกว่า 0 %",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
    }
    return SizedBox(height: 0);
  }

  // AlertErrorDimmerWater
  Widget AlertErrorDimmerNullWater() {
    if (ErrorDimmerNullWater == 1) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 10,
        ),
        child: Text(
          "กรุณากอกค่าระดับควบคุม",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
    }
    return SizedBox(height: 0);
  }

  Widget AlertErrorDimmerMoreWater() {
    if (ErrorDimmerMoreWater == 1) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 10,
        ),
        child: Text(
          "กรุณากอกค่าระดับควบคุมไม่เกิน 100 %",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
    }
    return SizedBox(height: 0);
  }

  Widget AlertErrorDimmerLessWater() {
    if (ErrorDimmerLessWater == 1) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 10,
        ),
        child: Text(
          "กรุณากอกค่าระดับควบคุมไม่ต่ำกว่า 0 %",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
    }
    return SizedBox(height: 0);
  }
}
