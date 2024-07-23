import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hospital_app/model/params.dart';
import 'package:hospital_app/view/login_screen.dart';
import 'package:provider/provider.dart';

import '../model/custom_snackbar.dart';
import '../view_model/auth_view_model.dart';
import 'doctor_home_screen.dart';

class DoctorSignupScreen extends StatelessWidget {
  DoctorSignupScreen({super.key});

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final yearsOfExperienceController = TextEditingController();
  final majorController = TextEditingController();
  final experienceController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  Future<void> signUp(BuildContext context,DoctorParams doctor)async{
    try{
      await Provider.of<AuthViewModel>(context,listen: false).signup(emailController.text, passwordController.text);
      await Provider.of<AuthViewModel>(context,listen: false).sendDoctorDetails(doctor);
      await Provider.of<AuthViewModel>(context,listen: false).getId(emailController.text,'doctor');
      CustomSnackBar(contentText: 'Succeed',backgroundColor: Colors.green).show(context);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DoctorHomeScreen(),),(route) => false,);
    }catch(e){
      CustomSnackBar(contentText: 'Failed to Authenticate you',backgroundColor: Colors.red).show(context);
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: SvgPicture.asset('assets/images/profile.svg',width: 150,),),
              const Text('Sign Up',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
              const Gap(24),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Name'
                ),
              ),
                const Gap(12),
                TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                      hintText: 'Last name'
                  ),
                ),
                const Gap(12),
                TextField(
                  controller: yearsOfExperienceController,
                  decoration: const InputDecoration(
                      hintText: 'Years of Experience'
                  ),
                ),
                const Gap(12),
                TextField(
                  controller: majorController,
                  decoration: const InputDecoration(
                      hintText: 'Your Major'
                  ),
                ),
                const Gap(12),
                TextField(
                  controller: experienceController,
                  decoration: const InputDecoration(
                      hintText: 'Experience'
                  ),
                ),
                const Gap(12),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      hintText: 'Email'
                  ),
                ),
                const Gap(12),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      hintText: 'password'
                  ),
                ),
                const Gap(12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: ()async{
                    DoctorParams doctor = DoctorParams(
                        name: nameController.text,
                        lastName: lastNameController.text,
                        yearsOfExperience: yearsOfExperienceController.text,
                        major: majorController.text,
                        experience: experienceController.text,
                        email: emailController.text,
                    );
                    await signUp(context, doctor);
                  }, child: const Text('SIGNUP'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[100],
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                    ),
                  ),
                ),
                const Gap(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const Text('Already have an account?'),
                  CupertinoButton(child: Text('LOGIN',style: TextStyle(color: Colors.blue[300]),), onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(
                      loginAsDoctor: true,
                    ),));
                  })
                ],)
            ],),
          ),
        ),
      ),
    );
  }
}
