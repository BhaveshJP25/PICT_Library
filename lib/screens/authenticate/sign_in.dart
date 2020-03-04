import 'package:flutter/material.dart';
import 'package:pict_library/services/auth.dart';
import 'package:pict_library/shared/loading.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin{

  final TextEditingController _passwordController = TextEditingController();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  //text field state
  String email = '';
  String password = '';
  String error = '';
  bool _showPassword = false;

  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750)
    );
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.easeInExpo,
    );

  _iconAnimation.addListener(( (() => this.setState(() { }))));
  _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text('Sign In TO PICT Library'),
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

          SingleChildScrollView(
            child: Container(

              padding: const EdgeInsets.all(9.0),
              child: Form(
                key: _formKey,
                child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        SizedBox(height: 100.0,),
                        TextFormField(
                            validator: (val) => val.isEmpty ? 'Enter an email' : null,
                            decoration: InputDecoration(
                            labelText: "Reg.ID No.",
                            labelStyle: TextStyle(color: Colors.blue[400]),
                              prefixIcon: Icon(
                                  Icons.perm_identity,
                                color: Colors.blue[400],
                              )
                          ),
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                          onChanged: (val){
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 20.0,),
                        TextFormField(
                          controller: _passwordController,
                          validator: (val) => val.length < 6 ? "Enter a 6+ char password" : null,
                          decoration: InputDecoration(
                            labelText: "Passoword",
                              labelStyle: TextStyle(color: Colors.blue[400]),
                              prefixIcon: Icon(
                                  Icons.lock,
                                color: Colors.blue[400],
                              ),
                            suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              child: Icon(
                                _showPassword ? Icons.visibility : Icons.visibility_off,
                                color: Colors.blue[400],
                              )
                            )

                          ),
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                          obscureText: !_showPassword,
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
                            if(_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error = 'Invalid Credentials';
                                  loading = false;
                                }
                                );

                              }
                            }
                          },
                          splashColor: Colors.grey,
                        ),
                        SizedBox(height: 12.0,),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                      ],
                    ),
              ),
            ),
          ),


        ],
      ),

    );
  }
}

