import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/params.dart';

class DoctorsViewModel extends ChangeNotifier{

  List<DoctorParams> doctors = [];

  Future<void> getAllDoctors(String token)async{

    var url = Uri.parse(
        'https://hospital-8dbf0-default-rtdb.firebaseio.com/doctor.json?auth=$token');
    final response = await http.get(url);
    print(jsonDecode(response.body));

    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if(extractedData == null){
      return;
    }
    final List<DoctorParams> loadedProducts = [];
    extractedData.forEach(
          (docId, docData)
          {
            print(docId);
          return loadedProducts.insert(
            0,
            DoctorParams(
                name: docData['name'],
                lastName: docData['lastName'],
                major: docData['major'],
                experience: docData['experience'],
                yearsOfExperience: docData['yearsOfExperience'],
                email: docData['email'],
                doctorId: docId),
          );
        });
    doctors = loadedProducts;
    print(doctors.length);
    notifyListeners();
  }

}
