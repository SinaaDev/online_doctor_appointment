import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hospital_app/model/params.dart';
import 'package:hospital_app/view/doctor_details_screen.dart';
import 'package:hospital_app/view/information_screen.dart';
import 'package:hospital_app/view/patient_appointments_screen.dart';
import 'package:hospital_app/view_model/auth_view_model.dart';
import 'package:hospital_app/view_model/doctors_view_model.dart';
import 'package:hospital_app/widgets/app_drawer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:hospital_app/model/cache.dart'as cache;

import 'body_status_screen.dart';


class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {

  bool loading = false;
  Future<void> getData()async{
    setState(() {
      loading = true;
    });
    final auth = Provider.of<AuthViewModel>(context,listen: false);
    final provider = Provider.of<DoctorsViewModel>(context,listen: false);
    await provider.getAllDoctors(auth.token!);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        actions: [
          IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const PatientAppointmentsScreen(),));}, icon: const Icon(Iconsax.task)),
          IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => FirstAidListScreen(),));}, icon: const Icon(Icons.medical_information_outlined)),
          IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => BodyStatusScreen(),));}, icon: const Icon(Icons.monitor_heart_outlined)),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => getData(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // greeting
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(24),bottomLeft: Radius.circular(24))
              ),
              child: const SafeArea(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hi there',style: TextStyle(color: Colors.white,fontSize: 20),),
                  Gap(20),
                  Text('Your Health is Our\nFirst Priority',style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold),),
                  Text('Start with having an Appointment',style: TextStyle(color: Colors.white,fontSize: 20),),
                ],
              )),
            ),

            // categories
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text('Categories',style: TextStyle(color: Colors.black,fontSize: 20),),
            ),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  categoryItem('Dental','tooth'),
                  categoryItem('Heart','heart'),
                  categoryItem('Eye','eye'),
                  categoryItem('Brain','brain'),
                  categoryItem('Ear','ear'),
                ],
              ),
            ),
              const Gap(28),
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text('Recommended Doctors',style: TextStyle(color: Colors.black,fontSize: 20),),
              ),
              SizedBox(
                height: 390,
                child: loading? const Center(child: CircularProgressIndicator(),) : Consumer<DoctorsViewModel>(
                  builder: (context, doc, child) {
                    final doctor = doc.doctors;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) => doctorItem(doctor[i],context),
                      itemCount: doctor.length,
                    );
                  },
                ),
              ),
              const Gap(100)
          ],),
        ),
      ),
    );
  }
}

Widget categoryItem(String title,String icon){
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(100)
        ),
        child: SvgPicture.asset('assets/images/$icon.svg',color: Colors.blueAccent,),
      ),
      const Gap(8),
      Text(title)
    ],
  );
}

Widget doctorItem(DoctorParams params,BuildContext context){
  final auth = Provider.of<AuthViewModel>(context,listen: false);
  return GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorDetailsScreen(doctorParams: params,token: auth.token!,),));
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200]
      ),
      child: Column(children: [
        SvgPicture.asset('assets/images/surgeon.svg',height: 250,),
        const Gap(24),
        Container(
          width: double.infinity,
          height: 100,
          decoration: const BoxDecoration(
            color: Colors.white
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('Dr ${params.name}',style: const TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold),),
                Text(params.major,style: const TextStyle(color: Colors.grey,fontSize: 16),),
                const Row(children: [Icon(Icons.star,color: Colors.amber,),Gap(8), Text('7.9',style: TextStyle(color: Colors.grey),)],)
            ],),
          ),
        )
      ],),
    ),
  );
}