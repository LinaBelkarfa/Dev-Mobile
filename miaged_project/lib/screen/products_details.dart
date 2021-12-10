import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaged_project/screen/produits_screen.dart';

class ProductsDetails extends StatefulWidget {
  final String urlImage;
  final String title;
  final String brand;
  final String price;
  final String type;
  final String size;

  ProductsDetails({
    required this.urlImage,
    required this.title,
    required this.brand,
    required this.price,
    required this.type,
    required this.size,
  });

  @override
  _ProductsDetailsState createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final addButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          addProductToPanier();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductScreen()
            ),
          );
        },
        child: const Text("Ajoutez au panier",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: Text("Details Article"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
            height: 450,
            width: 250,
            // color: Colors.blue,
            child: Column(
              children: <Widget>[
                Container(
                  height: 190,
                  width: 160,
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.urlImage,
                      ),
                      fit: BoxFit.cover,
                      // color:Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(widget.title,
                    style: const TextStyle(fontSize: 17, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                Text("Marque : ${widget.brand}",
                    style: const TextStyle(fontSize: 17, color: Colors.black)),
                Text("Catégorie : ${ widget.type}",
                    style: const TextStyle(fontSize: 17, color: Colors.black)),
                Text("Prix : ${ widget.price} euros",
                  style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black),
                ),
                const SizedBox(height: 5),
                Text("Taille ${widget.size}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.blueAccent),
                ),
                const SizedBox(height: 15),
                addButton,
              ],
            )),
      ),
    );
  }


  void addProductToPanier() async {
    await FirebaseFirestore.instance.collection("panier").add({
      'title': widget.title,
      'price': widget.price,
      'type': widget.type,
      'urlImage': widget.urlImage,
      'brand': widget.brand,
      'size': widget.size,
    });
    Fluttertoast.showToast(msg: "Article Ajouté");
  }
}
