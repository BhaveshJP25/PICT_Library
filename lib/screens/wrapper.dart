import 'package:flutter/material.dart';
import 'package:pict_library/models/user.dart';
import 'package:pict_library/screens/authenticate/authenticate.dart';
import 'package:pict_library/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    final user = Provider.of<User>(context);
    print(user);
    // returns home or authenticate
    if(user == null){
      return Authenticate();
    } else {
      return Home();
    }
  }
}
