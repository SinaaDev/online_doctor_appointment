import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hospital_app/model/cache.dart' as cache;
import 'package:hospital_app/model/custom_snackbar.dart';
import 'package:hospital_app/model/params.dart';
import 'package:hospital_app/view_model/appointment_view_model.dart';
import 'package:hospital_app/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final String token;
  final DoctorParams doctorParams;
   DoctorDetailsScreen({super.key, required this.doctorParams, required this.token});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {

  bool loading = false;
  Future<void> sendAppointment(BuildContext context,String docId,PrescriptionParams params)async{
    try{
    await Provider.of<AppointmentViewModel>(context,listen: false).sendAppointment(token: widget.token, docId: docId, params: params,patientId:Provider.of<AuthViewModel>(context,listen: false).userId!);
    CustomSnackBar(contentText: 'Appointment Booked',backgroundColor: Colors.green).show(context);
      Navigator.pop(context);
    }catch(e){
      CustomSnackBar(contentText: 'Appointment Failed',backgroundColor: Colors.green).show(context);

    }
  }

  final fullNameController = TextEditingController();

  final ageController = TextEditingController();

  final issueController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    ageController.dispose();
    issueController.dispose();
  }

  Future<void> showIssueReportBottomSheet(BuildContext context) async{
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        // Wrap your form in a Padding widget to give it some space from the edges
        return Padding(
          padding: EdgeInsets.only(
            top: 24.0,
            left: 24.0,
            right: 24.0,
            bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust padding for keyboard
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Use minimum space needed
              children: <Widget>[
                Row(children: [
                  Expanded(
                    child: TextField(
                      controller: fullNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Full Name'
                      ),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: TextField(
                      controller: ageController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                          hintText: 'Age',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],),
                const Gap(24),
                TextField(
                  controller: issueController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                      hintText: 'Your Issue'
                  ),
                  maxLines: 5,
                ),
                const Gap(40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: ()async{
                   await sendAppointment(context, widget.doctorParams.doctorId, PrescriptionParams(
                      fullName: fullNameController.text,
                      age: ageController.text,
                      issue: issueController.text,
                      medicine: 'Waiting for the doctor response',
                      advice: 'Waiting for the doctor response',
                      fee: 'Waiting for the doctor response',
                      id: '',
                      patientId: Provider.of<AuthViewModel>(context,listen: false).userId!,
                    ));
                  }, child:loading? const Center(child: CircularProgressIndicator(),) : const Text('BOOK'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[100],
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                    ),
                  ),
                ),
                const Gap(50)
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          // doctor image
          Center(child: SvgPicture.asset('assets/images/surgeon.svg',height: 200,)),


          // doctor details
            const Gap(28),
          Text('Dr '+widget.doctorParams.name + ' ' +widget.doctorParams.lastName,style: const TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.blueAccent),),
          Text('Specialist: '+widget.doctorParams.major,style: const TextStyle(fontSize: 18,color: Colors.grey),),
          Text('Years of experience: '+widget.doctorParams.yearsOfExperience,style: const TextStyle(fontSize: 18,color: Colors.grey),),
          Text('Email address: '+widget.doctorParams.email,style: const TextStyle(fontSize: 18,color: Colors.grey),),
          const Gap(18),
          Text(widget.doctorParams.experience,style: const TextStyle(color: Colors.grey),),
          const Gap(24),
          Text('Appointment Fee: 500 AFN',style: TextStyle(color: Colors.blueAccent[100],fontSize: 24,fontWeight: FontWeight.bold),),
          // book button
            const Spacer(),
            SizedBox(
              height: 80,
              width: double.infinity,
              child: ElevatedButton(onPressed: ()async{
                setState(() {
                  loading = true;
                });
                await showIssueReportBottomSheet(context);
                setState(() {
                  loading = false;
                });

              }, child: const Text('Book Appointment',style: TextStyle(color: Colors.black54),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                ),
              ),
            ),
            const Gap(24)
        ],),
      ),
    );
  }
}
