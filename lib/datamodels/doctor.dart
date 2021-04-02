import 'package:firebase_database/firebase_database.dart';

class Doctor {
  String fullName;
  String email;
  String phone;
  String id;
  String gender;
  String date;
  String time;
  String update;
  String uptime;
  String university;
  String address;
  String dob;
  String yog;
  String vcn;
  String nin;
  String certUrl;
  String identUrl;
  String imageUrl;
  String role;
  int comp;
  String prof;
  String pfl;

  Doctor({
    this.fullName,
    this.email,
    this.phone,
    this.id,
    this.gender,
    this.date,
    this.time,
    this.university,
    this.address,
    this.dob,
    this.yog,
    this.vcn,
    this.nin,
    this.certUrl,
    this.identUrl,
    this.imageUrl,
    this.role,
    this.comp,
    this.prof,
    this.pfl,
  });

  Doctor.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.key;
    phone = snapshot.value['phone'];
    email = snapshot.value['email'];
    gender = snapshot.value['gender'];
    fullName = snapshot.value['fullName'];
    date = snapshot.value['date'];
    time = snapshot.value['time'];
    update = snapshot.value['doctor_info']['date'];
    uptime = snapshot.value['doctor_info']['time'];
    university = snapshot.value['doctor_info']['university'];
    address = snapshot.value['doctor_info']['address'];
    dob = snapshot.value['doctor_info']['dob'];
    yog = snapshot.value['doctor_info']['yog'];
    vcn = snapshot.value['doctor_info']['vcn'];
    nin = snapshot.value['doctor_info']['nin'];
    certUrl = snapshot.value['doctor_info']['certUrl'];
    identUrl = snapshot.value['doctor_info']['identUrl'];
    imageUrl = snapshot.value['doctor_info']['imageUrl'];
    role = snapshot.value['doctor_info']['role'];
    comp = snapshot.value['doctor_info']['comp'];
    prof = snapshot.value['doctor_info']['prof'];
    pfl = snapshot.value['doctor_info']['pfl'];
  }
}
