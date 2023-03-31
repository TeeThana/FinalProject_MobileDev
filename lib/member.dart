import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class member extends StatefulWidget {
  const member({super.key});

  @override
  State<member> createState() => _memberState();
}

class _memberState extends State<member> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 135),
          child: Align(
            child: Text(
              'MEMBER\n GROUP',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 40,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ),
        Container(
          child: Stack(children: [
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 70.0,
              width: 70.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/otys_white.png'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
              ),
            )
          ]),
        ),
        Container(
          margin: EdgeInsets.only(top: 25, right: 25, left: 25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(color: Color.fromARGB(255, 0, 0, 0), spreadRadius: 1)
              ],
              color: Color.fromARGB(255, 255, 255, 255)),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Align(
              child: Text(
                'THANA SUKONTHABUT',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20, right: 25, left: 25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(color: Color.fromARGB(255, 0, 0, 0), spreadRadius: 1)
              ],
              color: Color.fromARGB(255, 255, 255, 255)),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Align(
              child: Text(
                'PARITA REERANON',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20, right: 25, left: 25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(color: Color.fromARGB(255, 0, 0, 0), spreadRadius: 1)
              ],
              color: Color.fromARGB(255, 255, 255, 255)),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Align(
              child: Text(
                'PIYATIDA CHONLAMAS',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
