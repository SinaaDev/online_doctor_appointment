class DoctorParams{
  final String name;
  final String lastName;
  final String yearsOfExperience;
  final String major;
  final String experience;
  final String email;
  final String doctorId;

  DoctorParams(
      {
        required this.name,
        required this.lastName,
        required this.yearsOfExperience,
        required this.major,
        required this.experience,
        required this.email,
        this.doctorId = 'not assigned',
      });
}

class PatientParams{
  final String name;
  final String lastName;
  final String email;

  PatientParams({
    required this.name,
    required this.lastName,
    required this.email,
  });
}

class PrescriptionParams{
  final String id;
  final String docPreId;
  final String patientId;
  final String fullName;
  final String age;
  final String issue;
  final String medicine;
  final String advice;
  final String fee;

  PrescriptionParams(
      {
        required this.id,
        required this.fullName,
        required this.age,
        required this.issue,
        required this.medicine,
        required this.advice,
        required this.fee,
        this.patientId = '',
        this.docPreId = ''
      });
}
