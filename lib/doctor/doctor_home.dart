import 'package:animated_flip_card/animated_flip_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_clinic/admin/add_center.dart';
import 'package:my_clinic/admin/add_doctor.dart';
import 'package:my_clinic/admin/add_pharmacy.dart';
import 'package:my_clinic/admin/admin_centers.dart';
import 'package:my_clinic/admin/admin_doctors.dart';
import 'package:my_clinic/admin/admin_pharmacy.dart';
import 'package:my_clinic/auth/login_page.dart';
import 'package:my_clinic/doctor/doctor_list.dart';
import 'package:my_clinic/doctor/doctor_profile.dart';
import 'package:my_clinic/models/users_model.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class DoctorHome extends StatefulWidget {
  static const routeName = '/doctorHome';
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late Users currentUser;

  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = Users.fromSnapshot(snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
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
                                Icons.logout,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('تأكيد'),
                                      content:
                                          Text('هل انت متأكد من تسجيل الخروج'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            FirebaseAuth.instance.signOut();
                                            Navigator.pushNamed(
                                                context, LoginPage.routeName);
                                          },
                                          child: Text('نعم'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('لا'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    'الصفحة الرئيسية',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/Doc.png',
              height: 330.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DoctorProfile(
                        email: currentUser.email,
                        password: currentUser.password,
                        name: '${currentUser.fullName}',
                        phoneNumber: '${currentUser.phoneNumber}',
                        uid: FirebaseAuth.instance.currentUser!.uid,
                      );
                    }));
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.w, left: 10.w),
                      child: Center(
                        child: Column(children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Image.asset('assets/images/doctor2.png',
                              width: 100.w, height: 70.h),
                          SizedBox(
                            height: 10.h,
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "الملف الشخصى",
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30.w,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DoctorList(
                        name: '${currentUser.fullName}',
                      );
                    }));
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.w, left: 10.w),
                      child: Center(
                        child: Column(children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Image.asset('assets/images/list.jpg',
                              width: 100.w, height: 70.h),
                          SizedBox(
                            height: 10.h,
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "الحجوزات",
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
