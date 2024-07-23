import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hospital_app/model/params.dart';
import 'package:hospital_app/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class DoctorProfileScreen extends StatefulWidget {
  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  DoctorParams? doctorParams;
  bool loading = false;

  Future<void> getData()async{
    setState(() {
      loading = true;
    });
    doctorParams = await Provider.of<AuthViewModel>(context,listen: false).getDoctorData();
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
        title: const Text('Doctor Profile'),
      ),
      body:loading? const Center(child: CircularProgressIndicator(),) : RefreshIndicator(
        onRefresh: () => getData(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 80,
                  child: SvgPicture.asset(
                    'assets/images/surgeon.svg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Dr. ${doctorParams?.name} ${doctorParams?.lastName}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Icon(Icons.email, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    doctorParams?.email ?? 'Unknown',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.school, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    '${doctorParams?.major} Specialist' ?? 'Unknown',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    '${doctorParams?.yearsOfExperience??'0'} years of experience',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Summary of Experience',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    doctorParams?.experience ?? 'Unknown',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}