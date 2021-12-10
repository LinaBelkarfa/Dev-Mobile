import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miaged_project/model/user_model.dart';
import 'package:miaged_project/screen/panier_screen.dart';
import 'package:miaged_project/screen/produits_screen.dart';
import 'package:miaged_project/screen/profil_screen.dart';

import 'acheter.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

// Pour les widgets de la bottomNavigationBar
  int selectedIndex = 0;


// Variable pour la connections à la firebase
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();


// Récupération des données
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


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text("Bienvenue ${loggedInUser.firstName}"),
        centerTitle: true,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                  onTap: ()=>
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProfilScreen()))
                  ,
                  child: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                      'https://previews.123rf.com/images/djvstock/djvstock1608/djvstock160808006/61244681-femme-fille-f%C3%A9minine-robe-ic%C3%B4ne-de-personnes-avatar-personne-illustration-isol%C3%A9e-et-plane-.jpg',
                    ),
                  )
              )
          ),
        ],
      ),
      body: Acheter(),


      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this.selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Acheter',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'Panier',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',

          ),
        ],
        backgroundColor: Colors.blueGrey,
        selectedItemColor: Colors.lightBlueAccent,
        onTap: (int index) {
      onTapHandler(index);
      },
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




  // --------------- FUNCTIONS ------------------------------ //


  // Changer l'index (à connecter en tapant sur l'icone )
  void onTapHandler(int index)  {
    this.setState(() {
      this.selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductScreen()),
        );      break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PanierScreen()),
        );
        break;
      case 2: Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilScreen()),
      );
    }
  }
}






  // LogOut Function
  Future<void> logout(BuildContext context ) async
  {
    await FirebaseAuth.instance.signOut(); 
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
  }



