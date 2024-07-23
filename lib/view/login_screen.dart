import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hospital_app/view/doctor_home_screen.dart';
import 'package:hospital_app/view/patient_home_screen.dart';
import 'package:hospital_app/view_model/auth_view_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../model/custom_snackbar.dart';

class LoginScreen extends StatefulWidget {
  bool? loginAsDoctor;
   LoginScreen({super.key,this.loginAsDoctor});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool loading = false;
  Future<void> login (BuildContext context)async{
    setState(() {
      loading = true;
    });
     if(widget.loginAsDoctor!){
       try{
         print('LOGGED IN AS A DOCTOR');
         await Provider.of<AuthViewModel>(context,listen: false).login(emailController.text, passwordController.text);
         await Provider.of<AuthViewModel>(context,listen: false).getId(emailController.text,'doctor');
         CustomSnackBar(contentText: 'Succeed',backgroundColor: Colors.green).show(context);
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DoctorHomeScreen(),),(route) => false,);
         setState(() {
           loading = false;
         });
       }catch(e){
         CustomSnackBar(contentText: "You Don't have a Doctor account!",backgroundColor: Colors.red).show(context);
         setState(() {
           loading = false;
         });
       }
        }else{
       try{
         print('LOGGED IN AS A PATIENT');
         await Provider.of<AuthViewModel>(context,listen: false).login(emailController.text, passwordController.text);
         await Provider.of<AuthViewModel>(context,listen: false).getId(emailController.text,'patients');
         CustomSnackBar(contentText: 'Succeed',backgroundColor: Colors.green).show(context);
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const PatientHomeScreen(),),(route) => false);
         setState(() {
           loading = false;
         });
       }catch(e){
         setState(() {
           loading = false;
         });
         CustomSnackBar(contentText: "You Don't have a Patient account!",backgroundColor: Colors.red).show(context);
       }}
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(child: Center(child: Icon(Iconsax.profile_circle,size: width * 0.5,))),
            const Gap(38),
            const Text('Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
            const Gap(38),
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
            const Gap(38),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: ()async{
                await login(context);
              }, child:loading? const Center(child: CircularProgressIndicator(),) : const Text('LOGIN'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                ),
              ),
            ),

        ],),
      ),),
    );
  }
}
