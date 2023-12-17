
import 'package:app_pharmacy/features/security/infrastructure/models/user_details.dart';

import '../../domain/domain.dart';

class UserMapper {

  static User userDetailsToEntity ( UserDetails userDetails ) => User(
    idUser: userDetails.idUser, 
    email: userDetails.email, 
    person: userDetails.person.toJson(), 
    userType: userDetails.userType.toJson(),
    status: userDetails.state, 
  );
}