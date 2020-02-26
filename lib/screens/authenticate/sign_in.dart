import 'package:flutter/material.dart';
import 'package:pict_library/screens/home/home.dart';
import 'package:pict_library/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin{

  final AuthService _auth = AuthService();

  //text field state

  String email = '';
  String password = '';

  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void initState(){
    super.initState();
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300)
    );
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.easeOut,
    );

  _iconAnimation.addListener(( (() => this.setState(() { }))));
  _iconAnimationController.forward();
    
  }
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        title: Text('Sign In TO Brew Crew'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: AssetImage("assets/Library.jpeg"),
            fit: BoxFit.cover,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
          ),

          Container(
            padding: const EdgeInsets.all(40.0),
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: new AssetImage("assets/logo.jpeg"),
                      height: _iconAnimation.value*150,
                      width: _iconAnimation.value*150,
                      colorBlendMode: BlendMode.lighten,
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "REG ID",
                        labelStyle: TextStyle(color: Colors.blue)
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                      onChanged: (val){
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Passoword",
                          labelStyle: TextStyle(color: Colors.blue)

                      ),
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0,),
                    RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        print(email);
                        print(password);

                      },
                      splashColor: Colors.grey,
                    )
                  ],
                ),
          ),


        ],
      ),
    );
  }
}

