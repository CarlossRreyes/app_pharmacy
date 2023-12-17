

class User {

  final int? idUser;
  final String email;
  final Map<String, dynamic> person;
  final Map<String, dynamic> userType;
  final String status;



  User({
    required this.idUser, 
    required this.email, 
    required this.person,
    required this.userType,
    required this.status
  });

}
/*
class User {

  final int? idUser;
  final String? email;
  final Person? person;
  final UserType? userType;
  final String? status;



  User({
    required this.idUser, 
    required this.email, 
    required this.person,
    required this.userType,
    required this.status
  });

}

class Person {
  final int idPerson;
  final String identification;
  final String names;
  final String lastName;

  Person({
    required this.idPerson, 
    required this.identification, 
    required this.names, 
    required this.lastName
  });
}

class UserType {
  final String idUserType;
  final String userType;
  final String state;

  UserType({
    required this.idUserType, 
    required this.userType, 
    required this.state
  });
}
*/