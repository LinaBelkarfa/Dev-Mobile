import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miaged_project/model/user_model.dart';
import 'package:miaged_project/screen/panier_screen.dart';
import 'package:miaged_project/screen/produits_screen.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {


  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final formKey = GlobalKey<FormState>();


  final firstNameModifyController = new TextEditingController();
  final secondNameModifyController = new TextEditingController();
  final birthdayModifyControler = new TextEditingController();
  final adressModifyControler = new TextEditingController();
  final postalCodeModifyControler = new TextEditingController();
  final cityModifyControler = new TextEditingController();
  final passwordModifyControler = new TextEditingController();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore
        .instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value){
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});

    });
  }


  @override
  Widget build(BuildContext context) {
    //Modifcation First Name Field
    final firstNameModifField = TextFormField(
        autofocus: false,
        controller: firstNameModifyController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if(value!.isEmpty){
            value = loggedInUser.firstName;
          }
          else if(!regex.hasMatch(value))
          {
            return("Entrez un prénom valide (Min. 3 caractères)");
          }
          return null;
        },
        onSaved: (value)
        {
          firstNameModifyController.text = value! ;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "${loggedInUser.firstName}",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        )
    );

    //Modification Second Name Field
    final secondNameModifField = TextFormField(
        autofocus: false,
        controller: secondNameModifyController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if(value!.isEmpty){
            value = loggedInUser.secondName;
          }
          return null;
        },
        onSaved: (value)
        {
          secondNameModifyController.text = value! ;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "${loggedInUser.secondName}",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        )
    );

    //Modification Birthday Field
    final birthdayModifField = TextFormField(
        autofocus: false,
        controller: birthdayModifyControler,
        keyboardType: TextInputType.datetime,
        validator: (value) {
          if(value!.isEmpty){
            value = loggedInUser.birthday;
          }
          return null;



        },
        onSaved: (value)
    {
      birthdayModifyControler.text = value! ;
    },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.card_giftcard_rounded),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "${loggedInUser.birthday}",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        )
    );


    //Modification Adress Field
    final adressModifField = TextFormField(
        autofocus: false,
        controller: adressModifyControler,
        keyboardType: TextInputType.streetAddress,
        validator: (value)
        {
          if(value!.isEmpty)
          {
            value = loggedInUser.adress;
          }
        },
        onSaved: (value)
    {
      adressModifyControler.text = value! ;
    },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.house),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "${loggedInUser.adress}",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        )
    );


    //Modification City Field
    final cityModifField = TextFormField(
        autofocus: false,
        controller: cityModifyControler,
        keyboardType: TextInputType.streetAddress,
        validator: (value)
        {
          if(value!.isEmpty)
          {
            value = loggedInUser.city;
          }
        },
        onSaved: (value)
    {
      cityModifyControler.text = value! ;
    },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.location_on_rounded),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "${loggedInUser.city}",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        )
    );

    //Modification Postal Code Field
    final postalCodeModifField = TextFormField(
        autofocus: false,
        controller: postalCodeModifyControler,
        keyboardType: TextInputType.number,
        validator: (value)
        {
          if(value!.isEmpty)
          {
            value = loggedInUser.postalCode;
          }
        },
        onSaved: (value)
    {
      postalCodeModifyControler.text = value! ;
    },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.map),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "${loggedInUser.postalCode}",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        )
    );


    final passwordModifField = TextFormField(
        autofocus: false,
        controller: passwordModifyControler,
        obscureText: true,
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if(value!.isEmpty){
            value = loggedInUser.password;
          }
          if(!regex.hasMatch(value!))
          {
            return("Entrez un mot de passe valide (Min. 6 caractères)");
          }


        },
        onSaved: (value)
        {
          passwordModifyControler.text = value! ;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "**************",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        )
    );



    // Modify Button
    final modifyButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,

      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),

        minWidth:  MediaQuery.of(context).size.width,
        onPressed: () {
          pushModification();
        },
        child:
        const Text(
          "Valider les modifications",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );


    return Scaffold(
      appBar: AppBar(
        title : Text("Profil"),
        centerTitle: true,
        actions: const [
          Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(
                  'https://previews.123rf.com/images/djvstock/djvstock1608/djvstock160808006/61244681-femme-fille-f%C3%A9minine-robe-ic%C3%B4ne-de-personnes-avatar-personne-illustration-isol%C3%A9e-et-plane-.jpg',
                ),
              )
          ),
        ],
      ),

      body: Center(

    child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
              <Widget>[
                Text(
                  "${loggedInUser.firstName}",
                  style : TextStyle(
                      fontSize :20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),

                SizedBox(
                  height: 80,
                  child: Image.network(
                    'https://previews.123rf.com/images/djvstock/djvstock1608/djvstock160808006/61244681-femme-fille-f%C3%A9minine-robe-ic%C3%B4ne-de-personnes-avatar-personne-illustration-isol%C3%A9e-et-plane-.jpg',
                  fit: BoxFit.contain,
                  ),
                ),

                //Information Profil
                // Email non modifiable
                Text("${loggedInUser.email}",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w500,)),


                //Prénom modifiable
                SizedBox(height: 1),
                firstNameModifField,

                //Nom modifiable
                SizedBox(height: 1),
                secondNameModifField,

                //Mot de passe modifiable
                SizedBox(height: 1),
                passwordModifField,

                //Birthday modifiable
                SizedBox(height: 1),
                birthdayModifField,

                //Adress modifiable
                SizedBox(height: 1),
                adressModifField,

                //City modifiable
                SizedBox(height: 1),
                cityModifField,

                //Postal code modifiable
                SizedBox(height: 1),
                postalCodeModifField,

                SizedBox(height: 20),
                modifyButton,
                SizedBox(height: 15),

                SizedBox(height: 15,),
                ActionChip(label: Text("Déconnexion"),
                    onPressed:()
                    {
                      logout(context);
                    } ),
              ],
            )
        ),
    ),
      ),




      // SIDE BAR
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child:
              Text('${loggedInUser.firstName} ${loggedInUser.secondName}',
                  style:
                  TextStyle(color : Colors.indigo)),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://previews.123rf.com/images/djvstock/djvstock1608/djvstock160808006/61244681-femme-fille-f%C3%A9minine-robe-ic%C3%B4ne-de-personnes-avatar-personne-illustration-isol%C3%A9e-et-plane-.jpg',
                  ),
                ),
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 20,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),


            ListTile(
              title: const Text('Accueil'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),


            ListTile(
              title: const Text('Profil'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProfilScreen()));
              },
            ),


            ListTile(
              title: const Text('Produits'),
              onTap: () {
                // Update the state of the app
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProductScreen()));
                // Then close the drawer
              },
            ),

            ListTile(
              title: const Text('Panier'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PanierScreen()));
              },
            ),



            SizedBox(height: 200,),

            ListTile(
              title: const Text('Déconnexion'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                logout(context);},

            ),
          ],
        ),
      ),
    );
  }



  // LogOut Function
  Future<void> logout(BuildContext context ) async
  {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
  }






// Push Modif Function

 void pushModification() async
  {
    var collection = FirebaseFirestore.instance.collection('users');

    if(firstNameModifyController.text.isEmpty){
      firstNameModifyController.text = loggedInUser.firstName!;
    };
    if(secondNameModifyController.text.isEmpty){
      secondNameModifyController.text = loggedInUser.secondName!;
    };
    if(birthdayModifyControler.text.isEmpty){
      birthdayModifyControler.text = loggedInUser.birthday!;
    };
    if(adressModifyControler.text.isEmpty){
      adressModifyControler.text = loggedInUser.adress!;
    };
    if(cityModifyControler.text.isEmpty){
      cityModifyControler.text = loggedInUser.city!;
    };
    if(postalCodeModifyControler.text.isEmpty){
      postalCodeModifyControler.text = loggedInUser.postalCode!;
    };
    if(passwordModifyControler.text.isEmpty){
      passwordModifyControler.text = loggedInUser.password!;
    }



    collection
          .doc(loggedInUser.uid)
          .update(
          {'firstName' : firstNameModifyController.text,
            'secondName': secondNameModifyController.text,
            'birthday' : birthdayModifyControler.text,
            'adress' : adressModifyControler.text,
            'city': cityModifyControler.text,
            'postalCode' : postalCodeModifyControler.text,
            'password' : passwordModifyControler.text,
          }).then((value) => {
            postModiftoFirestore()
          }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
      });

    _changePassword(passwordModifyControler.text);

  }



  void _changePassword(String password) async{
    //Pass in the password to updatePassword.
    user!.updatePassword(password).then((_){
      print("Successfully changed password");
    }).catchError((error){
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }



  postModiftoFirestore() async{
    // calling our firestore
    // calling our user model
    // sending theses values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    UserModel userModel = UserModel();

    // writting all the values that does not change
    userModel.email = loggedInUser.email;
    userModel.uid = loggedInUser.uid;

    //changing value
    userModel.firstName = firstNameModifyController.text;
    userModel.secondName = secondNameModifyController.text;
    userModel.adress = adressModifyControler.text;
    userModel.city = cityModifyControler.text;
    userModel.postalCode = postalCodeModifyControler.text;
    userModel.password = passwordModifyControler.text;
    userModel.birthday = birthdayModifyControler.text;


  await firebaseFirestore
        .collection('users')
        .doc(user!.uid)
        .update(userModel.toMap());
    Fluttertoast.showToast(msg: "Compte modifié avec succès ! ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder : (context) => HomeScreen()),
            (route) => false);
  }

}
