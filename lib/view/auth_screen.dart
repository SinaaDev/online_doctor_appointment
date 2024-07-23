import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hospital_app/view/doctor_signup_screen.dart';
import 'package:hospital_app/view/login_screen.dart';
import 'package:hospital_app/view/patient_signup_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

          // doctor icon
            Center(child: SvgPicture.asset('assets/images/doctor.svg',width: width*0.6,)),


          // greeting text
            const Gap(24),
            const Text('Welcome\nto your Private Doctor app',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
            ),
            const Gap(38),
            const Text('Continue as',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
            const Gap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Flexible(
                child: SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PatientSignupScreen(),));
                  }, child: const Text('PATIENT'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[100],
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))

                    ),
                  ),
                ),
              ),
              const Gap(10),
              Flexible(
                child: SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorSignupScreen(),));
                  }, child: const Text('DOCTOR'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[100],
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))

                    ),
                  ),
                ),
              ),
            ],),
            const Gap(40),
        ],),
      ),
    );
  }
}
