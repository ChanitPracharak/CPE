import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:mushrooms/model/DHT22.dart';

class Tab2_editHum extends StatefulWidget {
  const Tab2_editHum({Key? key}) : super(key: key);

  @override
  State<Tab2_editHum> createState() => _Tab2_editHumState();
}

class _Tab2_editHumState extends State<Tab2_editHum> {
  final formKey = GlobalKey<FormState>();
  final StartHum = TextEditingController();
  final EndHum = TextEditingController();
  final DimmerHum = TextEditingController();
  late TimeOfDay HumStartTime;
  late TimeOfDay HumEndTime;

  DHT22 dht22 = new DHT22();

  void initState() {
    init();
    super.initState();
    HumStartTime = TimeOfDay.now();
    HumEndTime = TimeOfDay.now();
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
        title: const Text('ตั้งค่าควบคุมความชื้นสัมพัทธ์ '),
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
                                                fontSize: 16,
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
                                  iconSize: 30,
                                  iconEnabledColor: Colors.black, //
                                  iconDisabledColor: Colors.grey, //
                                  buttonHeight: 48, //50
                                  buttonWidth:
                                      MediaQuery.of(context).size.width, //160
                                  buttonPadding:
                                      // const EdgeInsets.only(left: 14, right: 14),
                                      const EdgeInsets.only(
                                          left: 10, right: 10),
                                  buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black26, //
                                    ),
                                    color: Colors.white, //
                                  ),
                                  buttonElevation: 2, //2
                                  itemHeight: 40, //40
                                  // itemPadding: const EdgeInsets.only(left: 14, right: 14),
                                  itemPadding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  dropdownMaxHeight: 200, //200
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

                        //////////////////////// จุดเริ่มต้น ////////////////////////////
                        /////////////////////// เริ่มควบคุมเวลา ////////////////////////
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
                                    "${HumStartTime.hour}:${HumStartTime.minute}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 123, 119, 119)),
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_down),
                                  onTap: _pickTimeHumStart,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ///////////////////////////////////////////////////////////
                        SizedBox(height: 10),
                        ///////////////////////// สิ้นสุดการควบคุมเวลา //////////////////
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
                                    "${HumEndTime.hour}:${HumEndTime.minute}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 123, 119, 119)),
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_down),
                                  onTap: _pickTimeHumEnd,
                                ),
                              ),
                            ),
                          ],
                        ),
                        /////////////////////////////////////////////////////////////
                        SizedBox(height: 10),
                        //////////////////////// Dimmer ////////////////////////
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
                                controller: DimmerHum,
                                onChanged: (String val) {
                                  setState(() {});
                                },
                                validator: (text) {
                                  if (text!.isEmpty) {
                                    return 'กรุณากรอกค่า PWM';
                                  } else if (double.parse(text) > 100) {
                                    return 'กรุณากรอกค่าคPWMไม่เกินกว่า 100 %';
                                  } else if (double.parse(text) < 0) {
                                    return 'กรุณากรอกค่าPWMไม่ต่ำกว่า 0 %';
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.numberWithOptions(),
                                // maxLines: null,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 15),
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
                        ///////////////////////////////////////////////////////
                        SizdeBox1(),
                        SetHum(),

                        //////////////////////// Button ///////////////////////
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
                                            // Send data to firebase
                                            if (selectedValue ==
                                                'ควบคุมตามเวลาและค่าควบคุม') {
                                              String CombineData =
                                                  StartHum.text +
                                                      '/' +
                                                      EndHum.text +
                                                      '/';
                                              if (HumStartTime.hour < 10) {
                                                CombineData += ('0' +
                                                    HumStartTime.hour
                                                        .toString() +
                                                    ':');
                                              } else {
                                                CombineData += (HumStartTime
                                                        .hour
                                                        .toString() +
                                                    ':');
                                              }
                                              if (HumStartTime.minute < 10) {
                                                CombineData += ('0' +
                                                    HumStartTime.minute
                                                        .toString() +
                                                    ':');
                                              } else {
                                                CombineData += (HumStartTime
                                                        .minute
                                                        .toString() +
                                                    ':');
                                              }
                                              CombineData += '00/';

                                              if (HumEndTime.hour < 10) {
                                                CombineData += ('0' +
                                                    HumEndTime.hour.toString() +
                                                    ':');
                                              } else {
                                                CombineData += (HumEndTime.hour
                                                        .toString() +
                                                    ':');
                                              }
                                              if (HumEndTime.minute < 10) {
                                                CombineData += ('0' +
                                                    HumEndTime.minute
                                                        .toString() +
                                                    ':');
                                              } else {
                                                CombineData += (HumEndTime
                                                        .minute
                                                        .toString() +
                                                    ':');
                                              }
                                              CombineData += '00';
                                              FirebaseDatabase.instance
                                                  .ref('/DHT22/Hum/CombineData')
                                                  .set(CombineData);
                                              FirebaseDatabase.instance
                                                  .ref('/DHT22/Hum/PWM')
                                                  .set(int.parse(
                                                      DimmerHum.text));
                                            } else {
                                              String CombineData =
                                                  '0' + '/' + '0' + '/';
                                              if (HumStartTime.hour < 10) {
                                                CombineData += ('0' +
                                                    HumStartTime.hour
                                                        .toString() +
                                                    ':');
                                              } else {
                                                CombineData += (HumStartTime
                                                        .hour
                                                        .toString() +
                                                    ':');
                                              }
                                              if (HumStartTime.minute < 10) {
                                                CombineData += ('0' +
                                                    HumStartTime.minute
                                                        .toString() +
                                                    ':');
                                              } else {
                                                CombineData += (HumStartTime
                                                        .minute
                                                        .toString() +
                                                    ':');
                                              }
                                              CombineData += '00/';

                                              if (HumEndTime.hour < 10) {
                                                CombineData += ('0' +
                                                    HumEndTime.hour.toString() +
                                                    ':');
                                              } else {
                                                CombineData += (HumEndTime.hour
                                                        .toString() +
                                                    ':');
                                              }
                                              if (HumEndTime.minute < 10) {
                                                CombineData += ('0' +
                                                    HumEndTime.minute
                                                        .toString() +
                                                    ':');
                                              } else {
                                                CombineData += (HumEndTime
                                                        .minute
                                                        .toString() +
                                                    ':');
                                              }
                                              CombineData += '00';
                                              FirebaseDatabase.instance
                                                  .ref('/DHT22/Hum/CombineData')
                                                  .set(CombineData);
                                              FirebaseDatabase.instance
                                                  .ref('/DHT22/Hum/PWM')
                                                  .set(int.parse(
                                                      DimmerHum.text));
                                            }

                                            // send Mode
                                            if (selectedValue ==
                                                'ควบคุมตามเวลาและค่าควบคุม') {
                                              FirebaseDatabase.instance
                                                  .ref('/DHT22/Hum/mode')
                                                  .set(
                                                      'ควบคุมตามเวลาและค่าควบคุม/ControllTimeAndDataControll');
                                            } else {
                                              FirebaseDatabase.instance
                                                  .ref('/DHT22/Hum/mode')
                                                  .set(
                                                      'ควบคุมตามเวลา/ControllTime');
                                            }
                                          }
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

  _pickTimeHumStart() async {
    TimeOfDay? t =
        await showTimePicker(context: context, initialTime: HumStartTime);

    if (t != null) {
      setState(() {
        HumStartTime = t;
      });
    }
  }

  _pickTimeHumEnd() async {
    TimeOfDay? ti =
        await showTimePicker(context: context, initialTime: HumEndTime);

    if (ti != null) {
      setState(() {
        HumEndTime = ti;
      });
    }
  }

  Widget SizdeBox1() {
    if (selectedValue == 'ควบคุมตามเวลาและค่าควบคุม') {
      return SizedBox(height: 10);
    }
    return SizedBox(height: 1);
  }

  Widget SetHum() {
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
                  controller: StartHum,
                  onChanged: (String val) {
                    setState(() {});
                  },
                  validator: (text) {
                    if (text!.isEmpty) {
                      return 'กรุณากรอกค่าความชื้นสัมพัทธ์';
                    } else if (double.parse(text) > 100) {
                      return 'กรุณากรอกค่าความชื้นสัมพัทธ์ไม่เกินกว่า 100 %';
                    } else if (double.parse(text) < 50) {
                      return 'กรุณากรอกค่าความชื้นสัมพัทธ์ไม่ต่ำกว่า 50 %';
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
                    labelText: 'ความชื้นสัมพัทธ์',
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
                  controller: EndHum,
                  onChanged: (String val) {
                    setState(() {});
                  },
                  validator: (text) {
                    if (text!.isEmpty) {
                      return 'กรุณากรอกค่าความชื้นสัมพัทธ์ ';
                    } else if (double.parse(text) > 100) {
                      return 'กรุณากรอกค่าความชื้นสัมพัทธ์ไม่เกินกว่า 100 %';
                    } else if (double.parse(text) < 50) {
                      return 'กรุณากรอกค่าความชื้นสัมพัทธ์ไม่ต่ำกว่า 50 %';
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
                    labelText: 'ความชื้นสัมพัทธ์',
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
