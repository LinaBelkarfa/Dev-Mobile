import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? birthday;
  String? adress;
  String? postalCode;
  String? city;
  String? password;


  UserModel({this.uid, this.email, this.firstName, this.secondName, this.birthday, this.adress, this.postalCode, this.city, this.password});

  // receiving data from server
  factory UserModel.fromMap(map)
  {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      birthday : map['birthday'],
      adress : map['adress'],
      city : map['city'],
      postalCode: map['postalCode'],
      password: map['password']
    );
  }
  // sending data to our server

  Map<String, dynamic> toMap() {
    return{
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName':secondName,
      'birthday' : birthday,
      'adress' : adress,
      'city' : city,
      'postalCode' : postalCode,
      'password': password,
    };
  }


}