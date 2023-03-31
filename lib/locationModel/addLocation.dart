import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../homePage.dart';
import 'location_model.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final formKey = GlobalKey<FormState>();
  final locationNameController = TextEditingController();
  final locationDetailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference _locationCollection =
        FirebaseFirestore.instance.collection('locationList');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
            width: double.infinity,
            height: 120,
            padding: EdgeInsets.only(
              top: 55,
              left: 0,
            ),
            margin: EdgeInsets.only(bottom: 0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: IconButton(
                      onPressed: (() => Navigator.pop(context)),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Text(
                    'Add Location details \n ',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            ),
          ),
          Form(
            key: formKey,
            child: Center(
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: locationNameController,
                      decoration: InputDecoration(
                        label: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: Text(
                            'Location name',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Location name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: locationDetailController,
                      decoration: InputDecoration(
                        label: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: Text(
                            'Location',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Location details';
                        }
                        return null;
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(327, 50),
                            backgroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            )),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            var locationName = locationNameController.text;
                            var locationDetail = locationDetailController.text;

                            _locationCollection.add({
                              'locationName': locationName,
                              'locationDetail': locationDetail
                            });

                            formKey.currentState?.reset();
                            Navigator.pop(context);
                          } else {}
                        },
                        child: Text(
                          'Add Details',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
