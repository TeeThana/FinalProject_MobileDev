import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './product_model.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference _productCollection =
        FirebaseFirestore.instance.collection('productStore');
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
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: productNameController,
                      decoration: InputDecoration(
                        label: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: Text(
                            'Product name',
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
                          return 'Please enter a Product name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                        label: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: Text(
                            'Price',
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
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            var productName = productNameController.text;
                            var price = priceController.text;

                            _productCollection.add(
                                {'productName': productName, 'price': price});

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
