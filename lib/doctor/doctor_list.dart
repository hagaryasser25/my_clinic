import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_clinic/doctor/doctor_home.dart';
import 'package:my_clinic/models/dbookings_model.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class DoctorList extends StatefulWidget {
  String name;
  static const routeName = '/doctorList';
  DoctorList({required this.name});

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<DBooking> bookingList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchBookings();
  }

  @override
  void fetchBookings() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("doctorsBookings").child(widget.name);
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      DBooking p = DBooking.fromJson(event.snapshot.value);
      bookingList.add(p);
      keyslist.add(event.snapshot.key.toString());
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
              body: Column(children: [
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
                          backgroundImage: AssetImage('assets/images/logo.png'),
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
                    "الحجوزات",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: ListView.builder(
                itemCount: bookingList.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, right: 15, left: 15, bottom: 10),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          'اسم المريض : ${bookingList[index].name.toString()}',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Cairo'),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          'رقم الهاتف : ${bookingList[index].phoneNumber.toString()}',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Cairo'),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          'تاريخ الحجز : ${bookingList[index].date.toString()}',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Cairo'),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          'الشكوى : ${bookingList[index].complain.toString()}',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Cairo'),
                                        ),
                                      ),
                                      bookingList[index].status == 'pending'
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(top: 15.h),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  ConstrainedBox(
                                                    constraints:
                                                        BoxConstraints.tightFor(
                                                            width: 120.w,
                                                            height: 35.h),
                                                    child: ElevatedButton(
                                                      child: Text(
                                                        'تأكيد الحجز',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xfff1665f)),
                                                      ),
                                                      onPressed: () async {
                                                        User? user =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser;

                                                        if (user != null) {
                                                          String uid = user.uid;
                                                          int date = DateTime
                                                                  .now()
                                                              .millisecondsSinceEpoch;

                                                          DatabaseReference
                                                              companyRef =
                                                              FirebaseDatabase
                                                                  .instance
                                                                  .reference()
                                                                  .child(
                                                                      'doctorsBookings')
                                                                  .child(widget
                                                                      .name);

                                                          await companyRef
                                                              .child(bookingList[
                                                                      index]
                                                                  .id
                                                                  .toString())
                                                              .update({
                                                            'status': 'accept',
                                                          });
                                                        }
                                                        showAlertDialog(
                                                            context);
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 50.w,
                                                  ),
                                                  ConstrainedBox(
                                                    constraints:
                                                        BoxConstraints.tightFor(
                                                            width: 120.w,
                                                            height: 35.h),
                                                    child: ElevatedButton(
                                                      child: Text(
                                                        "حذف الحجز",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xfff1665f)),
                                                      ),
                                                      onPressed: () async {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    super
                                                                        .widget));
                                                        base
                                                            .child(bookingList[
                                                                    index]
                                                                .id
                                                                .toString())
                                                            .remove();
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  EdgeInsets.only(top: 15.h),
                                              child: ConstrainedBox(
                                                constraints:
                                                    BoxConstraints.tightFor(
                                                        width: 120.w,
                                                        height: 35.h),
                                                child: ElevatedButton(
                                                  child: Text(
                                                    "حذف الحجز",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xfff1665f)),
                                                  ),
                                                  onPressed: () async {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                super.widget));
                                                    base
                                                        .child(
                                                            bookingList[index]
                                                                .id
                                                                .toString())
                                                        .remove();
                                                  },
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ])),
        ));
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: HexColor('#6bbcba'),
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, DoctorHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text('تم تأكيد الحجز'),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
