import './addProduct.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import './editProduct.dart';
import 'package:line_icons/line_icons.dart';

class productList extends StatefulWidget {
  @override
  State<productList> createState() => _productListState();
}

class _productListState extends State<productList> {
  final formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  CollectionReference _productCollection =
      FirebaseFirestore.instance.collection('productStore');

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
                    'List of Product \n ',
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
              stream: _productCollection.snapshots(),
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
                    var productIndex = snapshot.data!.docs[index];
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productIndex['productName'],
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
                                        builder: (context) => const EditForm(),
                                        settings: RouteSettings(
                                            arguments:
                                                productIndex.reference.id)),
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
                                                  await _productCollection
                                                      .doc(productIndex
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
                            productIndex['price'],
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Text(' Baht'),
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
                      MaterialPageRoute(builder: (context) => const AddForm()),
                    );
                  },
                  child: Text(
                    'Add Product',
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
