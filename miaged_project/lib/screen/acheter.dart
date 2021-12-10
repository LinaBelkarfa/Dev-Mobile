import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miaged_project/model/product_model.dart';
import 'package:miaged_project/model/user_model.dart';
import 'package:miaged_project/screen/home_screen.dart';
import 'package:miaged_project/screen/panier_screen.dart';
import 'package:miaged_project/screen/products_details.dart';
import 'package:miaged_project/screen/produits_screen.dart';
import 'package:miaged_project/screen/profil_screen.dart';


import 'login_screen.dart';

class Acheter extends StatefulWidget {
  // récupère le snapchot de la collection products

  @override
  _AcheterState createState() => _AcheterState();
}

class _AcheterState extends State<Acheter> {
  var products = FirebaseFirestore.instance.collection("products").snapshots();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  ProductModel productsAvailable = ProductModel();


  @override
  void initState() {
    super.initState();
    FirebaseFirestore
        .instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
    });

    FirebaseFirestore
        .instance
        .collection("products")
        .doc()
        .get()
        .then((value) {
      this.productsAvailable = ProductModel.fromMap(value.data());
    });

    setState(() {});

  }


  @override
  Widget _buildList(snapshot) {
    return ListView.builder(
        itemCount: snapshot.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];
          return Card(
            child: InkWell(
              onTap: () {
                String urlImage = doc["urlImage"];
                String type = doc["type"];
                String brand = doc["brand"];
                String price = doc["price"];
                String title = doc["title"];
                String size = doc["size"];

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductsDetails(
                        urlImage: urlImage,
                        price: price,
                        type: type,
                        title: title,
                        brand: brand,
                        size: size,
                      )),
                );
              },
              child: Container(
                  height: 250,
                  width: 170,

                  // color: Colors.blue,
                  child: Column(
                    children: <Widget>[


                      Container(
                        height: 190,
                        width: 160,
                        decoration: BoxDecoration(
                          // color: Colors.blueGrey,
                          image: DecorationImage(
                            image: NetworkImage(
                              doc["urlImage"],
                            ),
                            fit: BoxFit.cover,
                            // color:Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        "${doc["price"]} euros",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.blueAccent),
                      ),
                      Text(doc["title"],
                          style: const TextStyle(fontSize: 17, color: Colors.black)),
                      Text("Taille ${doc["size"]}",
                          style: const TextStyle(fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  )),
            ),
          );
        });
  }



  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(

        child: Padding(padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                StreamBuilder<QuerySnapshot<Map<String,
                    dynamic>>>(
                    stream: products,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return LinearProgressIndicator();
                      return Expanded(child: _buildList(snapshot.data));
                    }),
                Row(),

              ],


            )


        ),
      ),







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
                image: const DecorationImage(
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




}