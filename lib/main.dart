import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_clinic/admin/add_center.dart';
import 'package:my_clinic/admin/add_doctor.dart';
import 'package:my_clinic/admin/add_pharmacy.dart';
import 'package:my_clinic/admin/admin_centers.dart';
import 'package:my_clinic/admin/admin_complains.dart';
import 'package:my_clinic/admin/admin_doctors.dart';
import 'package:my_clinic/admin/admin_home.dart';
import 'package:my_clinic/admin/admin_pharmacy.dart';
import 'package:my_clinic/admin/admin_requests.dart';
import 'package:my_clinic/auth/admin_login.dart';
import 'package:my_clinic/auth/center_login.dart';
import 'package:my_clinic/auth/doctor-login.dart';
import 'package:my_clinic/auth/login_page.dart';
import 'package:my_clinic/auth/signup_page.dart';
import 'package:my_clinic/center/center_home.dart';
import 'package:my_clinic/doctor/doctor_home.dart';
import 'package:my_clinic/user/donation_request.dart';
import 'package:my_clinic/user/user_centers.dart';
import 'package:my_clinic/user/user_doctors.dart';
import 'package:my_clinic/user/user_home.dart';
import 'package:my_clinic/user/user_pharmacy.dart';
import 'package:my_clinic/user/user_replays.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginPage()
          : FirebaseAuth.instance.currentUser!.email == 'admin@gmail.com'
              ? const AdminHome()
              : FirebaseAuth.instance.currentUser!.displayName == "طبيب"
                  ? const DoctorHome()
                  : FirebaseAuth.instance.currentUser!.displayName == "مركز"
                  ? const CenterHome()
                  :UserHome(),
      routes: {
        SignUpPage.routeName: (ctx) => SignUpPage(),
        LoginPage.routeName: (ctx) => LoginPage(),
        AdminLogin.routeName: (ctx) => AdminLogin(),
        CenterLogin.routeName: (ctx) => CenterLogin(),
        DoctorLogin.routeName: (ctx) => DoctorLogin(),
        AdminHome.routeName: (ctx) => AdminHome(),
        AdminDoctors.routeName: (ctx) => AdminDoctors(),
        AdminCenters.routeName: (ctx) => AdminCenters(),
        AdminPharmacy.routeName: (ctx) => AdminPharmacy(),
        AddDoctor.routeName: (ctx) => AddDoctor(),
        AddPharamcy.routeName: (ctx) => AddPharamcy(),
        AddCenter.routeName: (ctx) => AddCenter(),
        DoctorHome.routeName: (ctx) => DoctorHome(),
        CenterHome.routeName: (ctx) => CenterHome(),
        UserHome.routeName: (ctx) => UserHome(),
        UserDoctors.routeName: (ctx) => UserDoctors(),
        UserCenters.routeName: (ctx) => UserCenters(),
        UserPharmacy.routeName: (ctx) => UserPharmacy(),
        AdminComplains.routeName: (ctx) => AdminComplains(),
        AdminRequests.routeName: (ctx) => AdminRequests(),
        UserReplays.routeName: (ctx) => UserReplays(),
        DonationRequest.routeName: (ctx) => DonationRequest(),
      },
    );
  }
}
