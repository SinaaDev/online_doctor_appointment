import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hospital_app/model/custom_snackbar.dart';
import 'package:hospital_app/model/params.dart';
import 'package:hospital_app/view/patient_home_screen.dart';
import 'package:hospital_app/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class PatientSignupScreen extends StatefulWidget {

  PatientSignupScreen({super.key});

  @override
  State<PatientSignupScreen> createState() => _PatientSignupScreenState();
}

class _PatientSignupScreenState extends State<PatientSignupScreen> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  Future<void> signUp(BuildContext context,PatientParams patient)async{
    setState(() {
      loading = true;
    });
    try{
      await Provider.of<AuthViewModel>(context,listen: false).signup(emailController.text, passwordController.text);
      await Provider.of<AuthViewModel>(context,listen: false).sendPatientDetails(patient);
      await Provider.of<AuthViewModel>(context,listen: false).getId(emailController.text,'patients');
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const PatientHomeScreen(),),(route) => false);
      CustomSnackBar(contentText: 'Succeed',backgroundColor: Colors.green).show(context);
      setState(() {
        loading = false;
      });
    }catch(e){
      setState(() {
        loading = false;
      });
      CustomSnackBar(contentText: 'Failed to Authenticate you',backgroundColor: Colors.red).show(context);
      print(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
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
                Center(child: SvgPicture.asset('assets/images/patient.svg',width: 200,),),
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
                  child: ElevatedButton(onPressed: () async{
                    PatientParams newPatient = PatientParams(
                      name: nameController.text,
                      lastName: lastNameController.text,
                      email: emailController.text,
                    );
                    await signUp(context,newPatient);
                  }, child:loading? const Center(child: CircularProgressIndicator(),) : const Text('SIGNUP'),
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
                        loginAsDoctor: false,
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
