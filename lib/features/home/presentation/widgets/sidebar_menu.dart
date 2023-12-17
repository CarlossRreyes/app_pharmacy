import 'package:app_pharmacy/features/security/presentation/providers/user/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/provider.dart';
import '../../../shared/widgets/widgets.dart';



class SidebarMenu extends ConsumerStatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;
  
  const SidebarMenu({ super.key, required this.scaffoldKey });

  @override
  SidebarMenuState createState() => SidebarMenuState();
}

class SidebarMenuState extends ConsumerState<SidebarMenu> {

  int navDrawerIndex = 0;


  @override
  Widget build(BuildContext context) {
    final userState = ref.watch( userDetailsProvider );    
    // print(userState.user?.person["identification"]);
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    

    return NavigationDrawer(
      elevation: 1,
      selectedIndex: navDrawerIndex,

      children: [


        
        Padding(
          padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 0),
          child: const Text(
            'Menú principal',
            textAlign: TextAlign.center,
            style: TextStyle( fontWeight: FontWeight.normal, fontSize: 15 ),
            
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text( 
            "${userState.user?.person['names']} ${userState.user?.person['last_name']}",
            textAlign: TextAlign.center,
            style: const TextStyle( fontWeight: FontWeight.bold, fontSize: 20 ),
          ),
        ),

        

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomFilledButton(
            onPressed: () {
              ref.read( authProvider.notifier ).logout();
            },
            text: 'Cerrar sesión'
          ),
        ),



      ],
    );
  }
}