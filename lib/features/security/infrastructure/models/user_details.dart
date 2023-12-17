

class UserDetails {
    final int idUser;
    final Person person;
    final UserType userType;
    final String email;
    final String state;

    UserDetails({
        required this.idUser,
        required this.person,
        required this.userType,
        required this.email,
        required this.state,
    });

    factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        idUser: json["id_user"],
        person: Person.fromJson(json["person"]),
        userType: UserType.fromJson(json["userType"]),
        email: json["email"],
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "person": person.toJson(),
        "userType": userType.toJson(),
        "email": email,
        "state": state,
    };
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
        required this.lastName,
    });

    factory Person.fromJson(Map<String, dynamic> json) => Person(
        idPerson: json["id_person"],
        identification: json["identification"],
        names: json["names"],
        lastName: json["last_name"],
    );

    Map<String, dynamic> toJson() => {
        "id_person": idPerson,
        "identification": identification,
        "names": names,
        "last_name": lastName,
    };
}

class UserType {
    final int idUserType;
    final String userType;
    final String state;

    UserType({
        required this.idUserType,
        required this.userType,
        required this.state,
    });

    factory UserType.fromJson(Map<String, dynamic> json) => UserType(
        idUserType: json["id_user_type"],
        userType: json["user_type"],
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "id_user_type": idUserType,
        "user_type": userType,
        "state": state,
    };
}
