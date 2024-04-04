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

class AddCenter extends StatefulWidget {
  static const routeName = '/addCenter';
  const AddCenter({super.key});

  @override
  State<AddCenter> createState() => _AddCenterState();
}

class _AddCenterState extends State<AddCenter> {
  String imageUrl = '';
  File? image;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var addressController = TextEditingController();
  var availableController = TextEditingController();

  Color color = Color(0xfff8a55f);

  Future pickImageFromDevice() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile == null) return;
    final tempImage = File(xFile.path);
    setState(() {
      image = tempImage;
      print(image!.path);
    });

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference refrenceImageToUpload = referenceDirImages.child(uniqueFileName);
    try {
      await refrenceImageToUpload.putFile(File(xFile.path));

      imageUrl = await refrenceImageToUpload.getDownloadURL();
    } catch (error) {}
    print(imageUrl);
  }

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
                        child: Stack(
                          children: [
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 30),
                                child: CircleAvatar(
                                  radius: 65,
                                  backgroundColor:
                                      Color.fromARGB(255, 235, 234, 234),
                                  backgroundImage:
                                      image == null ? null : FileImage(image!),
                                )),
                            Positioned(
                                top: 120,
                                left: 120,
                                child: SizedBox(
                                  width: 50,
                                  child: RawMaterialButton(
                                      // constraints: BoxConstraints.tight(const Size(45, 45)),
                                      elevation: 10,
                                      fillColor: Color(0xfff8a55f),
                                      child: const Align(
                                          // ignore: unnecessary_const
                                          child: Icon(Icons.add_a_photo,
                                              color: Colors.white, size: 22)),
                                      padding: const EdgeInsets.all(15),
                                      shape: const CircleBorder(),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Choose option',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xfff8a55f))),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            pickImageFromDevice();
                                                          },
                                                          splashColor: HexColor(
                                                              '#FA8072'),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Icon(
                                                                    Icons.image,
                                                                    color: Color(
                                                                        0xfff8a55f)),
                                                              ),
                                                              Text('Gallery',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ))
                                                            ],
                                                          )),
                                                      InkWell(
                                                          onTap: () {
                                                            // pickImageFromCamera();
                                                          },
                                                          splashColor: HexColor(
                                                              '#FA8072'),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Icon(
                                                                    Icons
                                                                        .camera,
                                                                    color: Color(
                                                                        0xfff8a55f)),
                                                              ),
                                                              Text('Camera',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ))
                                                            ],
                                                          )),
                                                      InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          },
                                                          splashColor: HexColor(
                                                              '#FA8072'),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Icon(
                                                                    Icons
                                                                        .remove_circle,
                                                                    color: Color(
                                                                        0xfff8a55f)),
                                                              ),
                                                              Text('Remove',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ))
                                                            ],
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      }),
                                )),
                          ],
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
                            borderSide: BorderSide(color: color, width: 2.0),
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
                            borderSide: BorderSide(color: color, width: 2.0),
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
                            borderSide: BorderSide(color: color, width: 2.0),
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
                            borderSide: BorderSide(color: color, width: 2.0),
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
                        controller: addressController,
                        decoration: InputDecoration(
                          fillColor: Color(0xfff8a55f),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: color, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: "العنوان",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: availableController,
                        decoration: InputDecoration(
                          fillColor: Color(0xfff8a55f),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: color, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: "التحاليل المتوفرة",
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
                          String address = addressController.text.trim();
                          String available = availableController.text.trim();

                          if (name.isEmpty ||
                              email.isEmpty ||
                              password.isEmpty ||
                              phoneNumber.isEmpty ||
                              address.isEmpty ||
                              available.isEmpty ||
                              imageUrl.isEmpty) {
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
                            user!.updateProfile(displayName: 'مركز');

                            if (userCredential.user != null) {
                              String uid = userCredential.user!.uid;

                              DatabaseReference userRef = FirebaseDatabase
                                  .instance
                                  .reference()
                                  .child('centers')
                                  .child(uid);
                              String? id = userRef.push().key;

                              await userRef.set({
                                'name': name,
                                'email': email,
                                'password': password,
                                'address': address,
                                'uid': uid,
                                'phoneNumber': phoneNumber,
                                'available': available,
                                'id': id,
                                'imageUrl': imageUrl,
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
    content: Text("تم أضافة المركز"),
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
