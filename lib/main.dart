import 'package:flutter/material.dart';
import 'package:pict_library/models/user.dart';
import 'package:pict_library/screens/wrapper.dart';
import 'package:pict_library/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:pict_library/api/api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

