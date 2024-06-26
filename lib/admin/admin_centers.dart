import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_clinic/admin/add_center.dart';
import 'package:my_clinic/models/center_model.dart';

class AdminCenters extends StatefulWidget {
  static const routeName = '/adminCenters';
  const AdminCenters({
    super.key,
  });

  @override
  State<AdminCenters> createState() => _AdminCentersState();
}

class _AdminCentersState extends State<AdminCenters> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Centers> centersList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchPlaces();
  }

  @override
  void fetchPlaces() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("centers");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Centers p = Centers.fromJson(event.snapshot.value);
      centersList.add(p);
      keyslist.add(event.snapshot.key.toString());
      print(keyslist);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddCenter.routeName);
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // circular shape
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff1bccba),
                      Color(0xff22e2ab),
                    ],
                  ),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            body: Column(
              children: [
                Container(
                  height: 150.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [.01, .25],
                      colors: [
                        Color(0xfff8a55f),
                        Color(0xfff1665f),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  AssetImage('assets/images/logo.png'),
                            ),
                            SizedBox(
                              width: 250.w,
                            ),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Color(0xfff8a55f), //<-- SEE HERE
                              child: IconButton(
                                icon: Center(
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        "مراكز التحليل",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Expanded(
                    flex: 8,
                    child: ListView.builder(
                        itemCount: centersList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 20.w, left: 20.w),
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 200.h,
                                            width: double.infinity,
                                            child: Image.network(
                                              '${centersList[index].imageUrl}',
                                              
                                            ),
                                          ),
                                          Text(
                                            '${centersList[index].name}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Cairo',
                                                fontSize: 19,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            '${centersList[index].email}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Cairo',
                                                fontSize: 19,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            '${centersList[index].password}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Cairo',
                                                fontSize: 19,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            '${centersList[index].phoneNumber}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Cairo',
                                                fontSize: 19,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          super.widget));
                                              FirebaseDatabase.instance
                                                  .reference()
                                                  .child('centers')
                                                  .child(
                                                      '${centersList[index].uid}')
                                                  .remove();
                                            },
                                            child: Icon(Icons.delete,
                                                color: Color.fromARGB(
                                                    255, 122, 122, 122)),
                                          )
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
