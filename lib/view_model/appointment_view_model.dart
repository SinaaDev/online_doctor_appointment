import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/params.dart';

class AppointmentViewModel extends ChangeNotifier{

  List<PrescriptionParams> list = [];

  Future<void> sendAppointment({required String token,required String docId,required String patientId,required PrescriptionParams params})async{
    final url2 = Uri.parse(
        'https://hospital-8dbf0-default-rtdb.firebaseio.com/patients/$patientId/appointment.json?auth=$token');

    final response2 = await http.post(url2,
        body: json.encode({
          'name':params.fullName,
          'age':params.age,
          'issue':params.issue,
          'medicine':params.medicine,
          'advice':params.advice,
          'fee':params.fee
        }));
    print('This is the response 2: ${jsonDecode(response2.body)['name']}');

    final url = Uri.parse(
        'https://hospital-8dbf0-default-rtdb.firebaseio.com/doctor/$docId/appointment.json?auth=$token');

    final response = await http.post(url,
        body: json.encode({
          'id':jsonDecode(response2.body)['name'],
          'patientId': patientId,
          'name':params.fullName,
          'age':params.age,
          'issue':params.issue,
          'medicine':params.medicine,
          'advice':params.advice,
          'fee':params.fee
        }));
    print('===========================================\n');
    print(jsonDecode(response.body));
    print('DOC ID:  '+docId);
    print('TOKEN:  '+token);
    print('===========================================');



  }

  Future<void> getAppointments(String userId,String role,String token)async{
    var url = Uri.parse(
        'https://hospital-8dbf0-default-rtdb.firebaseio.com/$role/$userId/appointment.json?auth=$token');

    final response = await http.get(url);
    print(jsonDecode(response.body));

    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if(extractedData == null){
      return;
    }
    final List<PrescriptionParams> loadedData = [];
    extractedData.forEach(
            (preId, preData)
        {
          return role == 'doctor'? loadedData.insert(
            0,
            PrescriptionParams(
                docPreId: preId,
                id: preData['id'],
                patientId: preData['patientId'],
                fullName: preData['name'],
                age: preData['age'],
                issue: preData['issue'],
                medicine: preData['medicine'],
                advice: preData['advice'],
                fee: preData['fee'],
            ),
          ) :
          loadedData.insert(
            0,
            PrescriptionParams(
              docPreId: preId,
              id: '',
              fullName: preData['name'],
              age: preData['age'],
              issue: preData['issue'],
              medicine: preData['medicine'],
              advice: preData['advice'],
              fee: preData['fee'],
            ),
          )
          ;
        });
    list = loadedData;
    print(list.length);
  }

  Future<void> updateAppointment(String token,String patientId,String doctorId,PrescriptionParams params,)async{
    final url = Uri.parse(
        'https://hospital-8dbf0-default-rtdb.firebaseio.com/patients/$patientId/appointment/${params.id}.json?auth=$token');

    final response = await http.patch(url,
        body: json.encode({
          'medicine':params.medicine,
          'advice':params.advice,
          'fee':params.fee
        }));
    print(jsonDecode(response.body));

    final url2 = Uri.parse(
        'https://hospital-8dbf0-default-rtdb.firebaseio.com/doctor/$doctorId/appointment/${params.docPreId}.json?auth=$token');

    final response2 = await http.patch(url2,
        body: json.encode({
          'medicine':params.medicine,
          'advice':params.advice,
          'fee':params.fee
        }));
  }

}