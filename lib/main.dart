import 'package:flutter/material.dart';
import 'package:mushrooms/Tab1.dart';
import 'package:mushrooms/Tab2.dart';
import 'package:mushrooms/Tab3.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MaterialApp(
      title: 'Flutter Database Example',
      home: MyHomePage(),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 50, 78),
        title: Text("โรงเรือนเพาะเห็ดฟาง"),
      ),
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: DefaultTabController(
            length: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    // container ทั้งหน้าที่เอาไว้รวมwidget TextFormField
                    padding: EdgeInsets.symmetric(horizontal: 0), // 47
                    child: Container(
                      child: Scaffold(
                        backgroundColor: Colors.white, // white
                        appBar: PreferredSize(
                          preferredSize: Size.fromHeight(
                              kMinInteractiveDimension), // kToolbarHeight
                          child: SafeArea(
                            child: Column(
                              children: [
                                TabBar(
                                  tabs: [
                                    Tab(
                                      icon: Icon(
                                        Icons.home,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Tab(
                                      icon: Icon(
                                        Icons.settings,
                                        color: Colors.black,
                                      ),
                                    ),
                                    // Tab(
                                    //   icon: Icon(
                                    //     Icons.timer,
                                    //     color: Colors.black,
                                    //   ),
                                    // ),
                                    Tab(
                                      icon: Icon(
                                        Icons.manage_accounts_sharp,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        body: TabBarView(
                          children: [
                            Tab1(),
                            Tab2(),
                            Tab3(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
