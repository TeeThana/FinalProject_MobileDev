import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditLocation extends StatefulWidget {
  const EditLocation({super.key});

  @override
  State<EditLocation> createState() => _EditLocationState();
}

class _EditLocationState extends State<EditLocation> {
  final formKey = GlobalKey<FormState>();
  final locationNameController = TextEditingController();
  final locationDetailController = TextEditingController();

  CollectionReference _locationCollection =
      FirebaseFirestore.instance.collection('locationList');

  @override
  Widget build(BuildContext context) {
    final locationIndex = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: _locationCollection.doc(locationIndex.toString()).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var locationDetail = snapshot.data;
          final locationNameController =
              TextEditingController(text: locationDetail!.get('locationName'));
          final locationDetailController =
              TextEditingController(text: locationDetail.get('locationDetail'));
          return Column(
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
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: locationNameController,
                          decoration: InputDecoration(
                            label: Text('Location Name'),
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
                            label: Text('Location Detail'),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a location Detail';
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
                            onPressed: () async {
                              //สร้างตัวแปรสำหรับเก็บข้อมูลจาก TextFormField
                              var locationName = locationNameController.text;
                              var locationDetail =
                                  locationDetailController.text;

                              //แก้ไขข้อมูลใน DB
                              await _locationCollection
                                  .doc(locationIndex.toString())
                                  .set({
                                'locationName': locationName,
                                'locationDetail': locationDetail,
                              });
                              formKey.currentState?.reset();

                              Navigator.pop(context);
                            },
                            child: Text(
                              'Edit Location details',
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
          );
        },
      ),
    );
  }
}
