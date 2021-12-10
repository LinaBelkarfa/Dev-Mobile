import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miaged_project/screen/home_screen.dart';
import 'package:miaged_project/screen/registration_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final auth = FirebaseAuth.instance;




  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value)
      {
        if(value!.isEmpty)
        {
          return "Entrez votre adresse mail";
        }
        // reg expression for email validation
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
            .hasMatch(value)) {
          return("S'il vous plaît, entrez une adresse mail valide");
        }
        return null;
      },
      onSaved: (value)
        {
          emailController.text = value! ;
        },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Login",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      )
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,

      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if(value!.isEmpty){
          return("Le mot de passe est nécessaire pour se connecter.");
        }

        if(!regex.hasMatch(value))
        {
          return("Entrez un mot de passe valide (Min. 3 caractères)");
        }


      },
      onSaved: (value) {
        passwordController.text = value! ;
      },
      textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        )
    );


    //Login Button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,

      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth:  MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(emailController.text, passwordController.text);
          cleanPanier();
        },
        child:
          const Text(
            "Se connecter",
            textAlign: TextAlign.center,
            style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            ),
        ),
      ),
    );



    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: <Widget>[
                      SizedBox(
                        height: 150,
                        child: Image.asset("assets/logo_miaged.jpg",
                        fit: BoxFit.contain,
                        )
                      ),
                      SizedBox(height: 45),
                      emailField,
                      SizedBox(height: 45),
                      passwordField,
                      SizedBox(height: 45),
                      loginButton,
                      SizedBox(height: 45),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Vous n'avez pas de compte? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                         RegistrationScreen()
                                )
                              );
                            },
                            child: const Text("Créez un compte",
                              style:
                              TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight:  FontWeight.w600,
                                  fontSize: 15
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
              ),
            ),
          ),
        )
      )
    );
  }


  void cleanPanier() async {
    var snapshot = await FirebaseFirestore.instance.collection("panier").get();
    snapshot.docs.forEach((element) {
      element.reference.delete();
    });
  }

  void signIn(String email, String password) async
  {
    if(_formKey.currentState!.validate())
    {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((ui) => { 
            Fluttertoast.showToast(msg: "Auhentification réussie"),
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen())),
      }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
