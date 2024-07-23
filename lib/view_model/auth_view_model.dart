import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hospital_app/model/cache.dart';
import 'package:hospital_app/model/params.dart';
import 'package:http/http.dart' as http;

class AuthViewModel extends ChangeNotifier{

  String? token;
  String? doctorId;
  String? userId;
  DateTime? _expireDate;


  Future<void> getId(String email,String role)async{
    final url = Uri.parse(
        'https://hospital-8dbf0-default-rtdb.firebaseio.com//$role.json?auth=$token');

    final response = await http.get(url);
    final usersData = jsonDecode(response.body);
    print('------------------------------------------------ ');
    print(email);
    for (var entry in usersData.entries) {
      if (entry.value['email'] == email) {
        print(entry.value['email']);
        print("THIS IS THE ENTRY KEY: "+entry.key);
        return userId = entry.key;
      }
      notifyListeners();
    }
    throw '';
  }

  Future<void> _authenticate(String email, String password,
      String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyD2vsOJ_35k633rMqp9csx4EoqxYjk63Pk');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {'email': email, 'password': password, 'returnSecureToken': false},
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      print(responseData['idToken']);
      print('LOCAL ID: '+responseData['localId']);

      token = responseData['idToken'];
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> sendPatientDetails(PatientParams patient)async{
    final url = Uri.parse(
        'https://hospital-8dbf0-default-rtdb.firebaseio.com//patients.json?auth=$token');

    try{
     final response = await http.post(url,
          body: json.encode({
            'name': patient.name,
            'lastName': patient.lastName,
            'email': patient.email,
            'isDoctor': false,
          }));
      notifyListeners();
    }catch(e){
      throw e;
    }
  }
  Future<void> sendDoctorDetails(DoctorParams doctor)async{
    final url = Uri.parse(
        'https://hospital-8dbf0-default-rtdb.firebaseio.com//doctor.json?auth=$token');
    try{
     final response = await http.post(url,
          body: json.encode({
            'name': doctor.name,
            'lastName': doctor.lastName,
            'yearsOfExperience': doctor.yearsOfExperience,
            'major': doctor.major,
            'experience': doctor.experience,
            'email': doctor.email,
            'isDoctor': true,
          }));
      notifyListeners();
    }catch(e){
      throw e;
    }
  }

  Future<DoctorParams> getDoctorData()async{
    final url = Uri.parse(
        'https://hospital-8dbf0-default-rtdb.firebaseio.com//doctor/$userId.json?auth=$token');

    final response = await http.get(url);

    final docData = jsonDecode(response.body);

    return DoctorParams(
        name: docData['name'],
        lastName: docData['lastName'],
        yearsOfExperience:docData['yearsOfExperience'],
        major: docData['major'],
        experience: docData['experience'],
        email: docData['email'],
    );
  }
}

