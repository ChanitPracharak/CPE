import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:mushrooms/model/DHT22.dart';

class Tab2_editTemp extends StatefulWidget {
  const Tab2_editTemp({Key? key}) : super(key: key);

  @override
  State<Tab2_editTemp> createState() => _Tab2_editTempState();
}

class _Tab2_editTempState extends State<Tab2_editTemp> {
  final formKey = GlobalKey<FormState>();
  final StartTemp = TextEditingController();
  final EndTemp = TextEditingController();
  final DimmerTemp = TextEditingController();
  late TimeOfDay HeaterStartTime;
  late TimeOfDay HeaterEndTime;

  DHT22 dht22 = new DHT22();

  void initState() {
    init();
    super.initState();
    HeaterStartTime = TimeOfDay.now();
    HeaterEndTime = TimeOfDay.now();
  }

  Future<void> init() async {}

  final List<String> items = [
    'ควบคุมตามเวลา',
    'ควบคุมตามเวลาและค่าควบคุม',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 50, 78),
        title: const Text('ตั้งค่าควบคุมอุณหภูมิ'),
      ),
      body: Container(
        color: Color.fromARGB(255, 244, 242, 242),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 10,
                      right: MediaQuery.of(context).size.width / 10,
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        //////////////////////// Dropdown ////////////////////////////
                        Stack(
                          children: [
                            Container(
                              height: 48, // 48
                              width: MediaQuery.of(context).size.width,
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
                            Center(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  hint: Row(
                                    children: const [
                                      // Icon(
                                      //   Icons.list,
                                      //   size: 16,
                                      //   color: Colors.yellow, //
                                      // ),
                                      // SizedBox(
                                      //   width: 0,
                                      // ),
                                      Expanded(
                                        child: Text(
                                          'ควบคุมตามเวลา',
                                          style: TextStyle(
                                            fontSize: 16,
                                            // fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 117, 112, 112), //
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  items: items
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 16, // 16
                                                // fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 117, 112, 112), //
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value as String;
                                      print('${selectedValue}');
                                    });
                                  },
                                  icon: const Icon(
                                    // Icons.arrow_forward_ios_outlined,
                                    Icons.arrow_drop_down, //
                                  ),
                                  iconSize: 30, // 30
                                  iconEnabledColor: Colors.black, //
                                  iconDisabledColor: Colors.grey, //
                                  buttonHeight: 48, //48
                                  buttonWidth:
                                      MediaQuery.of(context).size.width, //160
                                  buttonPadding:
                                      // const EdgeInsets.only(left: 14, right: 14),
                                      const EdgeInsets.only(
                                    left: 10, // 10
                                    right: 10, // 10
                                  ),
                                  buttonDecoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(10), // 10
                                    border: Border.all(
                                      color: Colors.black26, //
                                    ),
                                    color: Colors.white, //
                                  ),
                                  buttonElevation: 2, //2
                                  itemHeight: 40, //40
                                  // itemPadding: const EdgeInsets.only(left: 14, right: 14),
                                  itemPadding: const EdgeInsets.only(
                                    left: 14, // 14
                                    right: 14, // 14
                                  ),
                                  dropdownMaxHeight: 100, //200
                                  dropdownWidth: 250, //200
                                  dropdownPadding: null,
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white, //
                                  ),
                                  dropdownElevation: 8, //8
                                  scrollbarRadius:
                                      const Radius.circular(40), //40
                                  scrollbarThickness: 10, //6
                                  scrollbarAlwaysShow: true,
                                  // offset: const Offset(-20, 0), //
                                  offset: const Offset(5, 0), //
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        //////////////////////// จุดเริ่ม ////////////////////////////////////
                        /////////////////////// เริ่มการควบคุมเวลา : 15:5  ///////////////////////
                        Stack(
                          children: <Widget>[
                            Container(
                              height: 48, // 48
                              width: MediaQuery.of(context).size.width,
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
                            Container(
                              height: 48,
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
                                child: ListTile(
                                  title: Text(
                                    "เริ่มการควบคุมเวลา: "
                                    "${HeaterStartTime.hour}:${HeaterStartTime.minute}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 123, 119, 119)),
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_down),
                                  onTap: _pickTimeHeaterStart,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ///////////////////////////////////////////////////////////////////
                        SizedBox(
                          height: 10,
                        ),
                        //////////////////////// สิ้นสุดการควบคุมเวลา /////////////////////////
                        Stack(
                          children: <Widget>[
                            Container(
                              height: 48, // 48
                              width: MediaQuery.of(context).size.width,
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
                            Container(
                              color: Colors.transparent,
                              height: 48,
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
                                child: ListTile(
                                  title: Text(
                                    "สิ้นสุดการควบคุมเวลา: "
                                    "${HeaterEndTime.hour}:${HeaterEndTime.minute}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 123, 119, 119)),
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_down),
                                  onTap: _pickTimeHeaterEnd,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ///////////////////////////////////////////////////
                        SizedBox(height: 10),
                        ////////////////// Dimmer /////////////////////////
                        Stack(
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
                                controller: DimmerTemp,
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
                                keyboardType: TextInputType.numberWithOptions(),
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
                                  labelText: 'ระดับควบคุม',
                                  fillColor: Colors.white70, // Colors.white70,
                                  // alignLabelWithHint: true,
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),

                        ///////////////////////////////////////////////////////////////////

                        SizdeBox1(),
                        SetTemp(),

                        //////////////////////// Button Send ///////////////////////
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 150),
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    child: Container(
                                      height: 52,
                                      width: double.infinity,
                                      // child: RaisedButton(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            // Create Alert
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: Text("Alert"),
                                                content:
                                                    Text("ส่งข้อมูลเรียบร้อย"),
                                                actions: <Widget>[],
                                              ),
                                            );

                                            /////////////////////////////////////////////////
                                            // Send data to firebase
                                            if (selectedValue ==
                                                'ควบคุมตามเวลาและค่าควบคุม') {
                                              // data temp
                                              String CombineData =
                                                  StartTemp.text +
                                                      '/' +
                                                      EndTemp.text +
                                                      '/';
                                              if (HeaterStartTime.hour < 10) {
                                                CombineData += ('0' +
                                                    HeaterStartTime.hour
                                                        .toString() +
                                                    ':');
                                              } else {
                                                CombineData += (HeaterStartTime
                                                        .hour
                                                        .toString() +
                                                    ':');
                                              }
                                              if (HeaterStartTime.minute < 10) {
                                                CombineData += ('0' +
                                                    HeaterStartTime.minute
                                                        .toString() +
                                                    ':');
                                              } else {
                                                CombineData += (HeaterStartTime
                                                        .minute
                                                        .toString() +
                                                    ':');
                                              }
                                              CombineData += '00/';

                                              if (HeaterEndTime.hour < 10) {
                                                CombineData += ('0' +
                                                    HeaterEndTime.hour
                                                        .toString() +
                                                    ':');
                                              } else {
                                                CombineData += (HeaterEndTime
                                                        .hour
                                                        .toString() +
                                                    ':');
                                              }
                                              if (HeaterEndTime.minute < 10) {
                                                CombineData += ('0' +
                                                    HeaterEndTime.minute
                                                        .toString() +
                                                    ':');
                                              } else {
                                                CombineData += (HeaterEndTime
                                                        .minute
                                                        .toString() +
                                                    ':');
                                              }
                                              CombineData += '00';

                                              FirebaseDatabase.instance
                                                  .ref(
                                                      '/DHT22/Temp/CombineData')
                                                  .set(CombineData);
                                              FirebaseDatabase.instance
                                                  .ref('/DHT22/Temp/PWM')
                                                  .set(int.parse(
                                                      DimmerTemp.text));
                                            } else {
                                              String CombineData =
                                                  '0' + '/' + '0' + '/';
                                              if (HeaterStartTime.hour < 10) {
                                                CombineData += ('0' +
                                                    HeaterStartTime.hour
                                                        .toString() +
                                                    ':');
                                              } else {
                                                CombineData += (HeaterStartTime
                                                        .hour
                                                        .toString() +
                                                    ':');
                                              }
                                              if (HeaterStartTime.minute < 10) {
                                                CombineData += ('0' +
                                                    HeaterStartTime.minute
                                                        .toString() +
                                                    ':');
                                              } else {
                                                CombineData += (HeaterStartTime
                                                        .minute
                                                        .toString() +
                                                    ':');
                                              }
                                              CombineData += '00/';

                                              if (HeaterEndTime.hour < 10) {
                                                CombineData += ('0' +
                                                    HeaterEndTime.hour
                                                        .toString() +
                                                    ':');
                                              } else {
                                                CombineData += (HeaterEndTime
                                                        .hour
                                                        .toString() +
                                                    ':');
                                              }
                                              if (HeaterEndTime.minute < 10) {
                                                CombineData += ('0' +
                                                    HeaterEndTime.minute
                                                        .toString() +
                                                    ':');
                                              } else {
                                                CombineData += (HeaterEndTime
                                                        .minute
                                                        .toString() +
                                                    ':');
                                              }
                                              CombineData += '00';

                                              FirebaseDatabase.instance
                                                  .ref(
                                                      '/DHT22/Temp/CombineData')
                                                  .set(CombineData);
                                              FirebaseDatabase.instance
                                                  .ref('/DHT22/Temp/PWM')
                                                  .set(int.parse(
                                                      DimmerTemp.text));
                                            }

                                            //////////////////////////////////////////////////////////////

                                            //////////////////////////////////////////////////////////////
                                            // send Mode
                                            if (selectedValue ==
                                                'ควบคุมตามเวลาและค่าควบคุม') {
                                              FirebaseDatabase.instance
                                                  .ref('/DHT22/Temp/mode')
                                                  .set(
                                                      'ควบคุมตามเวลาและค่าควบคุม/ControllTimeAndDataControll');
                                            } else {
                                              FirebaseDatabase.instance
                                                  .ref('/DHT22/Temp/mode')
                                                  .set(
                                                      'ควบคุมตามเวลา/ControllTime');
                                            }
                                            //////////////////////////////////////////////////////////////
                                          }
                                          // Navigator.pop(context);
                                        },
                                        // elevation: 5,
                                        // shape: RoundedRectangleBorder(
                                        //   borderRadius:
                                        //       BorderRadius.circular(15),
                                        //   side: BorderSide(
                                        //     color: Colors.purple,
                                        //   ),
                                        // ),
                                        // color: Colors.white,
                                        // padding: EdgeInsets.all(10),
                                        child: Text(
                                          "Send",
                                        ),
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
      ),
    );
  }

  _pickTimeHeaterStart() async {
    TimeOfDay? t =
        await showTimePicker(context: context, initialTime: HeaterStartTime);

    if (t != null) {
      setState(() {
        HeaterStartTime = t;
      });
    }
  }

  _pickTimeHeaterEnd() async {
    TimeOfDay? ti =
        await showTimePicker(context: context, initialTime: HeaterEndTime);

    if (ti != null) {
      setState(() {
        HeaterEndTime = ti;
      });
    }
  }

  Widget SizdeBox1() {
    if (selectedValue == 'ควบคุมตามเวลาและค่าควบคุม') {
      return SizedBox(height: 10);
    }
    return SizedBox(height: 1);
  }

  Widget SetTemp() {
    if (selectedValue == 'ควบคุมตามเวลาและค่าควบคุม') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Container(
                height: 48, // 48
                // width: MediaQuery.of(context).size.width,
                width: 140,
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
                width: 140,
                child: TextFormField(
                  // style: TextStyle(color: Colors.red),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'[,-]')),
                  ],
                  controller: StartTemp,
                  onChanged: (String val) {
                    setState(() {});
                  },
                  validator: (text) {
                    if (text!.isEmpty) {
                      return 'กรุณากรอกค่าอุณหภูมิ';
                    } else if (double.parse(text) > 40) {
                      return 'กรุณากรอกค่าอุณหภูมิไม่เกินกว่า 40 °C';
                    } else if (double.parse(text) < 25) {
                      return 'กรุณากรอกค่าอุณหภูมิไม่ต่ำกว่า 25 °C';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.numberWithOptions(),
                  // maxLines: null,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    // filled: true,
                    hintStyle: TextStyle(
                      color: Colors.grey[800],
                    ), // Colors.grey[800]
                    labelText: 'อุณหภูมิ',
                    fillColor: Colors.white70, // Colors.white70,
                    // alignLabelWithHint: true,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "ถึง",
            style: TextStyle(fontSize: 16),
          ),
          Stack(
            children: [
              Container(
                height: 48, // 48
                // width: MediaQuery.of(context).size.width,
                width: 140,
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
                width: 140,
                child: TextFormField(
                  // style: TextStyle(color: Colors.red),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'[,-]')),
                  ],
                  controller: EndTemp,
                  onChanged: (String val) {
                    setState(() {});
                  },
                  validator: (text) {
                    if (text!.isEmpty) {
                      return 'กรุณากรอกค่าอุณหภูมิ';
                    } else if (double.parse(text) > 40) {
                      return 'กรุณากรอกค่าอุณหภูมิไม่เกินกว่า 40 °C';
                    } else if (double.parse(text) < 25) {
                      return 'กรุณากรอกค่าอุณหภูมิไม่ต่ำกว่า 25 °C';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.numberWithOptions(),
                  // maxLines: null,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    // filled: true,
                    hintStyle: TextStyle(
                      color: Colors.grey[800],
                    ), // Colors.grey[800]
                    labelText: 'อุณหภูมิ',
                    fillColor: Colors.white70, // Colors.white70,
                    // alignLabelWithHint: true,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }
    return SizedBox(height: 1);
  }

  // Widget SetTimeStart() {
  //   if (selectedValue == 'ตามเวลาที่กำหนด') {
  //     return
  //   }
  //   return SizedBox(height: 1);
  // }

  // Widget SizdeBox1() {
  //   if (selectedValue == 'ตามเวลาที่กำหนด') {
  //     return SizedBox(height: 20);
  //   }
  //   return SizedBox(height: 1);
  // }

  // Widget SizdeBox2() {
  //   if (selectedValue == 'ตามเวลาที่กำหนด') {
  //     return SizedBox(height: 20);
  //   }
  //   return SizedBox(height: 1);
  // }

  // Widget SetTimeEnd() {
  //   if (selectedValue == 'ตามเวลาที่กำหนด') {
  //     return
  //   }
  //   return SizedBox(height: 1);
  // }
}
