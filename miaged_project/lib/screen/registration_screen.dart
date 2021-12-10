import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miaged_project/model/user_model.dart';
import 'package:miaged_project/screen/home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final auth = FirebaseAuth.instance;
  // our form key
  final formKey = GlobalKey<FormState>();

  // editing controller
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();


  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final birthdayEditingControler = new TextEditingController();
  final adressEditingControler = new TextEditingController();
  final postalCodeEditingControler = new TextEditingController();
  final cityEditingControler = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    //firstName field
    final firstNameField = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if(value!.isEmpty){
            return("Le prénom ne peut être vide");
          }

          if(!regex.hasMatch(value))
          {
            return("Entrez un prénom valide (Min. 3 caractères)");
          }
          return null;



        },
        onSaved: (value)
        {
          firstNameEditingController.text = value! ;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Prénom",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        )
    );

    //second Name field
    final secondNameField = TextFormField(
        autofocus: false,
        controller: secondNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if(value!.isEmpty){
            return("Le Nom ne peut être vide");
          }
          return null;
        },
        onSaved: (value)
        {
          secondNameEditingController.text = value! ;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Nom",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        )
    );

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
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
        },        onSaved: (value)
        {
          emailEditingController.text = value! ;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        )
    );

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
          obscureText: true,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if(value!.isEmpty){
            return("Le mot de passe est nécessaire pour se connecter.");
          }

          if(!regex.hasMatch(value))
          {
            return("Entrez un mot de passe valide (Min. 6 caractères)");
          }


        },
        onSaved: (value)
        {
          passwordEditingController.text = value! ;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Mot de passe",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        )
    );

    //Confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value)
        {
          if(confirmPasswordEditingController.text != passwordEditingController.text)
            {
              return('Les mots de passe sont différents');
            }
          return null;
        },
        onSaved: (value)
        {
          confirmPasswordEditingController.text = value! ;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Confirmez le mot de passe",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        )
    );

    //Birthday field
    final birthdayField = TextFormField(
        autofocus: false,
        controller: birthdayEditingControler,
        keyboardType: TextInputType.datetime,
        validator: (value)
        {
          if(value!.isEmpty)
          {
            return "Entrez votre date de naissance";
          }
        },        onSaved: (value)
    {
      birthdayEditingControler.text = value! ;
    },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.card_giftcard_rounded),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Date de naissance",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        )
    );

    //Adress Field
    final adressField = TextFormField(
        autofocus: false,
        controller: adressEditingControler,
        keyboardType: TextInputType.streetAddress,
        validator: (value)
        {
          if(value!.isEmpty)
          {
            return "Entrez votre adresse";
          }
        },        onSaved: (value)
    {
      adressEditingControler.text = value! ;
    },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.house),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Adresse",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        )
    );


    //City Field
    final cityField = TextFormField(
        autofocus: false,
        controller: cityEditingControler,
        keyboardType: TextInputType.streetAddress,
        validator: (value)
        {
          if(value!.isEmpty)
          {
            return "Entrez le nom de votre ville";
          }
        },        onSaved: (value)
    {
      cityEditingControler.text = value! ;
    },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.location_on_rounded),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Ville",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        )
    );

    //Postal Code Field
    final postalCodeField = TextFormField(
        autofocus: false,
        controller: postalCodeEditingControler,
        keyboardType: TextInputType.number,
        validator: (value)
        {
          if(value!.isEmpty)
          {
            return "Entrez votre code postal";
          }
        },        onSaved: (value)
    {
      postalCodeEditingControler.text = value! ;
    },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.map),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Code postal",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        )
    );

    // SignUp Button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,

      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),

        minWidth:  MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child:
        const Text(
          "Créer le compte",
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading : IconButton(
            icon : Icon(Icons.arrow_back, color: Colors.lightBlue),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    key: formKey,
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
                        SizedBox(height: 20),
                        firstNameField,
                        SizedBox(height: 20),
                        secondNameField,
                        SizedBox(height: 20),
                        birthdayField,
                        SizedBox(height: 20),
                        adressField,
                        SizedBox(height: 20),
                        cityField,
                        SizedBox(height: 20),
                        postalCodeField,
                        SizedBox(height: 20),
                        emailField,
                        SizedBox(height: 20),
                        passwordField,
                        SizedBox(height: 20),
                        confirmPasswordField,
                        SizedBox(height: 20),
                        signUpButton,
                        SizedBox(height: 15)
                      ],
                    ),
                  ),
                ),
              ),
            )
        )


    );
  }



  void signUp(String email, String password) async
  {
    if(formKey.currentState!.validate())
    {

      await auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
            postDetailstoFirestore()
      }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailstoFirestore() async{
    // calling our firestore
    // calling our user model
    // sending theses values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;

    UserModel userModel = UserModel();

    // writting all the values

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;
    userModel.birthday = birthdayEditingControler.text;
    userModel.adress = adressEditingControler.text;
    userModel.city = cityEditingControler.text;
    userModel.postalCode = postalCodeEditingControler.text;




    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Compte créé avec succès ! ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder : (context) => HomeScreen()),
        (route) => false);
  }
}
