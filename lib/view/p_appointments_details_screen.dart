import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hospital_app/model/params.dart';
import 'package:hospital_app/view_model/appointment_view_model.dart';
import 'package:provider/provider.dart';

import '../model/custom_snackbar.dart';
import '../view_model/auth_view_model.dart';
import '../view_model/doctors_view_model.dart';

class PAppointmentsDetailsScreen extends StatelessWidget {
  final PrescriptionParams params;
  bool done;
  PAppointmentsDetailsScreen({super.key, required this.params, required this.done});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PRESCRIPTION'),
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
                readOnly: true,
                controller: TextEditingController(text: params.medicine),
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
                readOnly: true,
                controller: TextEditingController(text: params.advice),
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
                readOnly: true,
                controller: TextEditingController(text: params.fee),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Fee'
                ),
              ),
              const Gap(40),
            ],),
        ),
      ),
    );
  }
}
