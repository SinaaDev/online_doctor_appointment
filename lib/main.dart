import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/view/auth_screen.dart';
import 'package:hospital_app/view/body_status_screen.dart';
import 'package:hospital_app/view/doctor_home_screen.dart';
import 'package:hospital_app/view/doctor_signup_screen.dart';
import 'package:hospital_app/view/login_screen.dart';
import 'package:hospital_app/view/patient_home_screen.dart';
import 'package:hospital_app/view/patient_signup_screen.dart';
import 'package:hospital_app/view_model/appointment_view_model.dart';
import 'package:hospital_app/view_model/auth_view_model.dart';
import 'package:hospital_app/view_model/doctors_view_model.dart';
import 'package:hospital_app/view_model/patient_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => DoctorsViewModel()),
        ChangeNotifierProvider(create: (context) => AppointmentViewModel()),
        ChangeNotifierProvider(create: (context) => PatientViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.dmSans().fontFamily
        ),
        home: AuthScreen(),
      ),
    );
  }
}