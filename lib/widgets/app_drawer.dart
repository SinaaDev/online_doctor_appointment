import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hospital_app/view/patient_appointments_screen.dart';
import 'package:iconsax/iconsax.dart';

import '../view/body_status_screen.dart';
import '../view/information_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            // profile
            const Gap(58),
            const Row(children: [
              CircleAvatar(backgroundColor: Colors.white,minRadius: 24,child: Icon(Icons.person,color: Colors.black54,),),
              Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Welcome Back !',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              ],)

            ],),
            const Gap(24),
            const Divider(),
            const Gap(24),
            // options
            Option(icon: Iconsax.task, title: 'Your Appointments', onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PatientAppointmentsScreen(),));
            }),
            const Gap(12),
            Option(icon: Iconsax.status, title: 'Your Body System Status', onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => BodyStatusScreen(),));
            }),
            const Gap(12),
            Option(icon: Iconsax.hospital, title: 'First Aid & Primary Care', onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => FirstAidListScreen(),));
            }),
          ],

          ),
        ),
      ),
    );
  }
}

class Option extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function() onPressed;
  const Option({
    super.key, required this.icon, required this.title, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon,color: Colors.black87,),
      CupertinoButton(child: Text(title,style: const TextStyle(color: Colors.black87),), onPressed:onPressed ),
    ],);
  }
}
