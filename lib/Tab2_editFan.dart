import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Tab2_editFan extends StatefulWidget {
  const Tab2_editFan({Key? key}) : super(key: key);

  @override
  State<Tab2_editFan> createState() => _Tab2_editFanState();
}

class _Tab2_editFanState extends State<Tab2_editFan> {
  final formKey = GlobalKey<FormState>();
  late TimeOfDay FanStartTime;
  late TimeOfDay FanEndTime;
  final DimmerFan = TextEditingController();

  void initState() {
    init();
    super.initState();
    FanStartTime = TimeOfDay.now();
    FanEndTime = TimeOfDay.now();
  }

  Future<void> init() async {}

  final List<String> items = [
    'ควบคุมตามเวลา',
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 50, 78),
        title: const Text('ตั้งค่าควบคุมพัดลมระบายอากาศ'),
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
                                  dropdownWidth: 200, //200
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

                        SizedBox(height: 10), //20
                        /////////////////// time Start ////////////////////
                        Stack(children: <Widget>[
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
                                  "${FanStartTime.hour}:${FanStartTime.minute}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          Color.fromARGB(255, 123, 119, 119)),
                                ),
                                trailing: Icon(Icons.keyboard_arrow_down),
                                onTap: _pickTimeFanStart,
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(height: 10), //20
                        ///////////////////// Time End ///////////////////////
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
                                    "${FanEndTime.hour}:${FanEndTime.minute}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 123, 119, 119)),
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_down),
                                  onTap: _pickTimeFanEnd,
                                ),
                              ),
                            ),
                          ],
                        ),
                        /////////////////////////////////////////////////////////
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
                                controller: DimmerFan,
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
                        ///
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
                                            String CombineData = '';

                                            if (FanStartTime.hour < 10) {
                                              CombineData += ('0' +
                                                  FanStartTime.hour.toString() +
                                                  ':');
                                            } else {
                                              CombineData += (FanStartTime.hour
                                                      .toString() +
                                                  ':');
                                            }
                                            if (FanStartTime.minute < 10) {
                                              CombineData += ('0' +
                                                  FanStartTime.minute
                                                      .toString() +
                                                  ':');
                                            } else {
                                              CombineData += (FanStartTime
                                                      .minute
                                                      .toString() +
                                                  ':');
                                            }
                                            CombineData += '00/';

                                            if (FanEndTime.hour < 10) {
                                              CombineData += ('0' +
                                                  FanEndTime.hour.toString() +
                                                  ':');
                                            } else {
                                              CombineData +=
                                                  (FanEndTime.hour.toString() +
                                                      ':');
                                            }
                                            if (FanEndTime.minute < 10) {
                                              CombineData += ('0' +
                                                  FanEndTime.minute.toString() +
                                                  ':');
                                            } else {
                                              CombineData += (FanEndTime.minute
                                                      .toString() +
                                                  ':');
                                            }
                                            CombineData += '00';
                                            FirebaseDatabase.instance
                                                .ref('/Fan/CombineData')
                                                .set(CombineData);
                                            FirebaseDatabase.instance
                                                .ref('/Fan/PWM')
                                                .set(int.parse(DimmerFan.text));

                                            // send Mode
                                            if (selectedValue ==
                                                'ควบคุมตามเวลา') {
                                              FirebaseDatabase.instance
                                                  .ref('/Fan/mode')
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

  _pickTimeFanStart() async {
    TimeOfDay? t =
        await showTimePicker(context: context, initialTime: FanStartTime);

    if (t != null) {
      setState(() {
        FanStartTime = t;
      });
    }
  }

  _pickTimeFanEnd() async {
    TimeOfDay? ti =
        await showTimePicker(context: context, initialTime: FanEndTime);

    if (ti != null) {
      setState(() {
        FanEndTime = ti;
      });
    }
  }
}
