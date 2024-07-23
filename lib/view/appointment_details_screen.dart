import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hospital_app/model/params.dart';
import 'package:hospital_app/view_model/appointment_view_model.dart';
import 'package:provider/provider.dart';

import '../model/custom_snackbar.dart';
import '../view_model/auth_view_model.dart';
import '../view_model/doctors_view_model.dart';


class AppointmentDetailsScreen extends StatelessWidget {
  final PrescriptionParams params;
  bool done;
  AppointmentDetailsScreen({super.key, required this.params, required this.done});

  final medicineController = TextEditingController();
  final adviceController = TextEditingController();
  final feeController = TextEditingController();

  Future<void> updateAppointment(BuildContext context,PrescriptionParams params)async{
    try{
      final auth = Provider.of<AuthViewModel>(context,listen: false);
      final provider = Provider.of<AppointmentViewModel>(context,listen: false);
      await provider.updateAppointment(auth.token!, params.patientId, auth.userId!,params);
      CustomSnackBar(contentText: 'Sent',backgroundColor: Colors.green).show(context);
      print('Doctor ID: ${auth.userId}');
      print('Prescription ID: ${params.docPreId}');

      Navigator.pop(context);
    }catch(e){
      CustomSnackBar(contentText: 'Failed',backgroundColor: Colors.red).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          print(Provider.of<AuthViewModel>(context,listen: false).userId);
          print(params.docPreId);
        },icon: const Icon(Icons.add),),
        title: const Text('PRESCRIPTION'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            const Gap(24),
              const Text('Patient Details',style: TextStyle(fontWeight: FontWeight.bold),),
            const Gap(8),
            Row(children: [
              Expanded(child: TextField(
                readOnly: true,
                controller: TextEditingController(text: params.fullName),
                decoration: const InputDecoration(
                  border: OutlineInputBorder()
                ),
              )),
              const Gap(12),
              Expanded(child: TextField(
                readOnly: true,
                controller: TextEditingController(text: params.age),
                decoration: const InputDecoration(
                    border: OutlineInputBorder()
                ),
              )),
            ],),
            const Gap(24),
            const Text('Patient Issue',style: TextStyle(fontWeight: FontWeight.bold),),
              const Gap(8),
              TextField(
                readOnly: true,
                controller: TextEditingController(text: params.issue),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              const Gap(24),
              const Text('Medicines',style: TextStyle(fontWeight: FontWeight.bold),),
              const Gap(8),
              TextField(
                controller: done? TextEditingController(text: params.medicine) : medicineController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Give your Patient some Medicines'
                ),
                maxLines: 5,
              ),

              const Gap(24),
              const Text('Your Advice',style: TextStyle(fontWeight: FontWeight.bold),),
              const Gap(8),
              TextField(
                controller: done? TextEditingController(text: params.advice) :  adviceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Give your Patient Some Advice'
                ),
                maxLines: 5,
              ),

              const Gap(24),
              const Text('Visit Fee',style: TextStyle(fontWeight: FontWeight.bold),),
              const Gap(8),
              TextField(
                controller: done? TextEditingController(text: params.fee) :  feeController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Fee'
                ),
              ),
              const Gap(24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: ()async{
                  PrescriptionParams prescription = PrescriptionParams(
                      id: params.id,
                      docPreId: params.docPreId,
                      patientId: params.patientId,
                      fullName: params.fullName,
                      age: params.age,
                      issue: params.issue,
                      medicine: medicineController.text,
                      advice: adviceController.text,
                      fee: feeController.text,
                  );
                  updateAppointment(context,prescription);
                }, child: const Text('SEND'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[100],
                      foregroundColor: Colors.black,
                      textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                  ),
                ),
              ),
              const Gap(40),
          ],),
        ),
      ),
    );
  }
}
