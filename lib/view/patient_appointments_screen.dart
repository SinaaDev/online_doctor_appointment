import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hospital_app/model/cache.dart';
import 'package:hospital_app/model/params.dart';
import 'package:hospital_app/view/appointment_details_screen.dart';
import 'package:hospital_app/view_model/appointment_view_model.dart';
import 'package:hospital_app/view_model/auth_view_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'p_appointments_details_screen.dart';

class PatientAppointmentsScreen extends StatefulWidget {
  const PatientAppointmentsScreen({super.key});

  @override
  State<PatientAppointmentsScreen> createState() => _PatientAppointmentsScreenState();
}

class _PatientAppointmentsScreenState extends State<PatientAppointmentsScreen> {

  bool loading = false;
  Future<void> getData()async{
    setState(() {
      loading = true;
    });
    final auth = Provider.of<AuthViewModel>(context,listen: false);
    final provider = Provider.of<AppointmentViewModel>(context,listen: false);
    await provider.getAppointments(auth.userId!,'patients' ,auth.token!);
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
    var appointments =  Provider.of<AppointmentViewModel>(context,listen: false).list;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Appointments",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body:loading? const Center(child: CircularProgressIndicator(),) : RefreshIndicator(
        onRefresh: () => getData(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: appointments.isNotEmpty? Consumer<AppointmentViewModel>(
            builder: (context, value, child) {
              return ListView.builder(itemBuilder: (context, i) {
                return appointmentItem(value.list[i],context);
              },
                itemCount: value.list.length,);
            },
          ):
          Center(child: ListView(
            children: [
              Gap(MediaQuery.of(context).size.height/3),
              const Center(child: Icon(Iconsax.bag_cross_1,size: 80,color: Colors.black54,)),
              const Gap(24),
              const Center(child: Text('You have no Appointments',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
            ],
          ),),
        ),
      ),
    );
  }
}

Widget appointmentItem(PrescriptionParams params,BuildContext context){
  bool done = params.advice != 'Waiting for the doctor response' || params.medicine != 'Waiting for the doctor response'  || params.fee != 'Waiting for the doctor response';
  print(params.docPreId);
  print(done);
  return GestureDetector(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PAppointmentsDetailsScreen(params: params,done: done),)),
    child: Container(
      margin: const EdgeInsets.only(top: 12),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          color: done? Colors.grey[100] : Colors.blue[100],
          borderRadius: BorderRadius.circular(12)
      ),
      child: Center(
        child: ListTile(
          leading: const Icon(Iconsax.hospital,size: 40,),
          title: Text(params.fullName,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
          subtitle: Text(done? 'Appointment Finished' : 'Waiting',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
          trailing: const Icon(Iconsax.export),
        ),
      ),
    ),
  );
}