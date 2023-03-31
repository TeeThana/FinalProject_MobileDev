import 'addLocation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import './editLocation.dart';
import 'package:line_icons/line_icons.dart';

class locationList extends StatefulWidget {
  @override
  State<locationList> createState() => _locationListState();
}

class _locationListState extends State<locationList> {
  final formKey = GlobalKey<FormState>();
  final locationNameController = TextEditingController();
  final locationDetailController = TextEditingController();

  CollectionReference _locationCollection =
      FirebaseFirestore.instance.collection('locationList');

  @override
  Widget build(BuildContext context) {
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
                top: 50,
                left: 15,
              ),
              child: Stack(
                children: [
                  Text(
                    'List of Location \n ',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: _locationCollection.snapshots(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length, //นับจำนวนข้อมูลทั้งหมด
                  itemBuilder: ((context, index) {
                    var locationIndex = snapshot.data!.docs[index];
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            locationIndex['locationName'],
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                child: Container(
                                  child: Icon(LineIcons.edit),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EditLocation(),
                                        settings: RouteSettings(
                                            arguments:
                                                locationIndex.reference.id)),
                                  );
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                  child: Icon(LineIcons.alternateTrashAlt),
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: ((context) => AlertDialog(
                                          title: Text('ยืนยัน'),
                                          content:
                                              Text('คุณต้องการลบข้อมูลหรือไม่'),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('ยกเลิก')),
                                            TextButton(
                                                onPressed: () async {
                                                  await _locationCollection
                                                      .doc(locationIndex
                                                          .reference.id)
                                                      .delete();
                                                  Navigator.pop(context);
                                                },
                                                child: Text('ลบข้อมูล')),
                                          ],
                                        )),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            locationIndex['locationDetail'],
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    );
                  }),
                );
              }),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(327, 50),
                      backgroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddLocation()),
                    );
                  },
                  child: Text(
                    'Add location',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
            ))
          ],
        ));
  }
}
