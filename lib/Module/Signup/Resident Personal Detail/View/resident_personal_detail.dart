import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:userapp/Routes/set_routes.dart';
import '../../../../Constants/constants.dart';
import '../../../../Widgets/My Button/my_button.dart';
import '../../../../Widgets/My Password TextForm Field/my_password_textform_field.dart';
import '../../../../Widgets/My TextForm Field/my_textform_field.dart';
import '../Controller/resident_personal_detail_controller.dart';

class ResidentPersonalDetail extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<ResidentPersonalDetailController>(
            init: ResidentPersonalDetailController(),
            builder: (controller) {
              return
                Center(
                  child: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Stack(
                          children: <Widget>[
                            FittedBox(
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 50.0,
                                backgroundColor: Colors.white,
                                backgroundImage: controller.imageFile == null
                                    ? AssetImage('assets/user.png') as ImageProvider
                                    : FileImage(
                                        File(controller.imageFile!.path),
                                      ),
                              ),
                            ),
                            Positioned(
                              left: 70,
                              top: 70,
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: 100.0,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                'Choose Profile Photo',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                  ElevatedButton.icon(
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor: primaryColor),
                                                    icon: Icon(
                                                      Icons.camera,
                                                    ),
                                                    onPressed: () {
                                                      controller.getFromCamera(
                                                          ImageSource.camera);
                                                    },
                                                    label: Text('Camera'),
                                                  ),
                                                  ElevatedButton.icon(
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor: primaryColor),
                                                    icon: Icon(Icons.image),
                                                    onPressed: () {
                                                      controller.getFromGallery(
                                                          ImageSource.gallery);
                                                    },
                                                    label: Text('Gallery'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  color: primaryColor,
                                  size: 28,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:20,
                        ),


                        MyTextFormField(
                          controller: controller.firstnameController,
                          validator: emptyStringValidator,
                          hintText: 'First Name',
                          labelText: 'Enter First Name',

                        ),
                        MyTextFormField(
                            controller: controller.lastnameController,
                            validator: emptyStringValidator,
                            hintText: 'Last Name',
                            labelText: 'Enter Last Name',


                        ),
                        MyTextFormField(
                            controller: controller.cnicController,
                            validator: emptyStringValidator,
                            hintText: 'Cnic',
                            labelText: 'Enter Cnic',
                          textInputType: TextInputType.number,


                        ),

                        MyTextFormField(
                            controller: controller.mobileNoController,
                            validator: emptyStringValidator,
                            hintText: 'Mobile No',
                            labelText: 'Enter Mobile No',
                          textInputType: TextInputType.number,


                        ),
                        MyPasswordTextFormField(
                          maxLines: 1,
                          controller: controller.passwordController,
                          obscureText: controller.isHidden,
                          togglePasswordView: controller.togglePasswordView,
                          validator: emptyStringValidator,
                          hintText: 'Enter Password',
                          labelText: 'Password',

                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        MyButton(
                          onPressed: controller.isLoading
                              ? null
                              : () {
                                  if (controller.formKey.currentState!.validate()) {
                                    // if (controller.imageFile?.path == null) {
                                    //   Get.snackbar('Warning', 'Select an image !');
                                    // } else {
                                    //   //User user = controller.user;
                                    //
                                    //   controller.signUpApi(
                                    //       firstName: controller.firstnameController.text,
                                    //       lastName: controller.lastnameController.text,
                                    //       cnic: controller.cnicController.text,
                                    //       address: controller.addressController.text,
                                    //       mobileno: controller.mobileNoController.text,
                                    //       password: controller.passwordController.text,
                                    //       file: controller.imageFile);
                                    //
                                    //
                                    //
                                    // }

                                    controller.signUpApi(
                                        firstName: controller.firstnameController.text,
                                        lastName: controller.lastnameController.text,
                                        cnic: controller.cnicController.text,
                                        address: controller.addressController.text,
                                        mobileno: controller.mobileNoController.text,
                                        password: controller.passwordController.text,
                                        file: controller.imageFile);

                                  }

                                },
                          textColor: Colors.white,
                          color: primaryColor,
                          name: 'Sign Up',
                          outlinedBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),

                        ),
                        SizedBox(height:18,),
                        Wrap(
                          children: [
                            const Text(

                              "Have an Account ?",
                              style:
                              TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                                onTap: () {

                                  Get.offAllNamed(loginscreen);

                                },
                                child: Text(
                                  "Login",
                                  style:    GoogleFonts.montserrat(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500
                                  ),
                                )),
                          ],
                        )

                      ],
                    ),
                  ),
              ),
                );
            }),
      ),
    );
  }
}