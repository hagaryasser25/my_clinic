import 'dart:io';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_clinic/admin/admin_home.dart';
import 'package:ndialog/ndialog.dart';

class AddDoctor extends StatefulWidget {
  static const routeName = '/addDoctor';
  const AddDoctor({super.key});

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var degreeController = TextEditingController();
  var specialityController = TextEditingController();
  var feesController = TextEditingController();

  Color color = Color(0xfff8a55f);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              top: 20.h,
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 10.w, left: 10.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 70.h),
                      child: Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/images/logo.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          fillColor: Color(0xfff8a55f),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: color, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'الأسم',
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          fillColor: Color(0xfff8a55f),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: color, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'البريد الالكترونى',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          fillColor: Color(0xfff8a55f),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: color, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'كلمة المرور',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          fillColor: Color(0xfff8a55f),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: color, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'رقم الهاتف',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: degreeController,
                        decoration: InputDecoration(
                          fillColor: Color(0xfff8a55f),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: color, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: "الدرجة العلمية",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: specialityController,
                        decoration: InputDecoration(
                          fillColor: Color(0xfff8a55f),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: color, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: "التخصص",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: feesController,
                        decoration: InputDecoration(
                          fillColor: Color(0xfff8a55f),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: color, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: "رسوم الكشف",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          width: double.infinity, height: 65.h),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: color,
                        ),
                        onPressed: () async {
                          String name = nameController.text.trim();
                          String email = emailController.text.trim();
                          String phoneNumber =
                              phoneNumberController.text.trim();
                          String password = passwordController.text.trim();
                          String speciality = specialityController.text.trim();
                          String degree = degreeController.text.trim();
                          String fees = feesController.text.trim();

                          if (name.isEmpty ||
                              email.isEmpty ||
                              password.isEmpty ||
                              phoneNumber.isEmpty ||
                              speciality.isEmpty ||
                              degree.isEmpty ||
                              fees.isEmpty) {
                            CherryToast.info(
                              title: Text('Please Fill all Fields'),
                              actionHandler: () {},
                            ).show(context);
                            return;
                          }

                          if (password.length < 6) {
                            // show error toast
                            CherryToast.info(
                              title: Text(
                                  'Weak Password, at least 6 characters are required'),
                              actionHandler: () {},
                            ).show(context);

                            return;
                          }

                          ProgressDialog progressDialog = ProgressDialog(
                              context,
                              title: Text('Signing Up'),
                              message: Text('Please Wait'));
                          progressDialog.show();

                          try {
                            FirebaseAuth auth = FirebaseAuth.instance;

                            UserCredential userCredential =
                                await auth.createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            User? user = userCredential.user;
                            user!.updateProfile(displayName: 'طبيب');

                            if (userCredential.user != null) {
                              String uid = userCredential.user!.uid;

                              DatabaseReference userRef = FirebaseDatabase
                                  .instance
                                  .reference()
                                  .child('doctors')
                                  .child(uid);
                              String? id = userRef.push().key;

                              await userRef.set({
                                'name': name,
                                'email': email,
                                'password': password,
                                'speciality': speciality,
                                'uid': uid,
                                'phoneNumber': phoneNumber,
                                'degree': degree,
                                'fees': fees,
                                'id': id,
                              });
                              DatabaseReference doctorRef = FirebaseDatabase
                                  .instance
                                  .reference()
                                  .child('users');

                              int dt = DateTime.now().millisecondsSinceEpoch;

                              await doctorRef.child(uid).set({
                                'name': name,
                                'email': email,
                                'password': password,
                                'uid': uid,
                                'dt': dt,
                                'phoneNumber': phoneNumber,
                              });
                              FirebaseAuth.instance.signOut();
                              Navigator.canPop(context)
                                  ? Navigator.pop(context)
                                  : null;
                            } else {
                              CherryToast.info(
                                title: Text('Failed'),
                                actionHandler: () {},
                              ).show(context);
                            }
                            progressDialog.dismiss();
                          } on FirebaseAuthException catch (e) {
                            progressDialog.dismiss();
                            if (e.code == 'email-already-in-use') {
                              CherryToast.info(
                                title: Text('Email is already exist'),
                                actionHandler: () {},
                              ).show(context);
                            } else if (e.code == 'weak-password') {
                              CherryToast.info(
                                title: Text('Password is weak'),
                                actionHandler: () {},
                              ).show(context);
                            }
                          } catch (e) {
                            progressDialog.dismiss();
                            CherryToast.info(
                              title: Text('Something went wrong'),
                              actionHandler: () {},
                            ).show(context);
                          }
                        },
                        child: Text(
                          'حفظ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: HexColor('#6bbcba'),
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, AdminHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم اضافة الطبيب"),
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
