import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditForm extends StatefulWidget {
  const EditForm({super.key});

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final priceController = TextEditingController();

  CollectionReference _productCollection =
      FirebaseFirestore.instance.collection('productStore');

  @override
  Widget build(BuildContext context) {
    final productIndex = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: _productCollection.doc(productIndex.toString()).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var productDetail = snapshot.data;
          final productNameController =
              TextEditingController(text: productDetail!.get('productName'));
          final priceController =
              TextEditingController(text: productDetail.get('price'));
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
                        'Add Product details \n ',
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
                          controller: productNameController,
                          decoration: InputDecoration(
                            label: Text('Product Name'),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Product name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: priceController,
                          decoration: InputDecoration(
                            label: Text('Price'),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Price value';
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
                              var productName = productNameController.text;
                              var price = priceController.text;

                              //แก้ไขข้อมูลใน DB
                              if (formKey.currentState!.validate()) {
                                var productName = productNameController.text;
                                var price = priceController.text;

                                await _productCollection
                                    .doc(productIndex.toString())
                                    .set({
                                  'productName': productName,
                                  'price': price,
                                });
                                formKey.currentState?.reset();
                              } else {}

                              Navigator.pop(context);
                            },
                            child: Text(
                              'Edit Product details',
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
