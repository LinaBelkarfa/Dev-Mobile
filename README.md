# Dev-Mobile
Create a Flutter App for shopping in the style of Vinted


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
     <li>
      <a href="#Utilisations">Conclusions</a>
      <ul>
        <li><a href="#mot-de-passe-et-login">Mot de passe et Login</a></li>
      </ul>
      <ul>
        <li><a href="#ajout-et-manquement">Ajouts et manquements</a></li>
      </ul>
    </li>
    <li>
      <a href="#developpement">Développement</a>
      <ul>
        <li><a href="#us1">US#1 : [MVP] Interface de login</a></li>
      </ul>
      <ul>
        <li><a href="#us2">US#2 : [MVP] Liste de vêtements </a></li>
      </ul>
       <ul>
        <li><a href="#us3">US#3 : [MVP] Détail d’un vêtement</a></li>
      </ul>
      <ul>
        <li><a href="#us4">US#4 : [MVP] Le panier</a></li>
      </ul>
      <ul>
        <li><a href="#us5"> US#5 : [MVP] Profil utilisateur </a></li>
      </ul>
      <ul>
        <li><a href="#us6">US#6 : Filtrer sur la liste des vêtements </a></li>
      </ul>
      <ul>
        <li><a href="#us7">US#7 : Laisser libre cours à son imagination</a></li>
      </ul>
    </li>
  </ol>
</details>




<!-- UTILISATIONS -->
## utilisation
* Dans le fichier lib se trouve mes code .dart : le main, ainsi que les différents screens et les modeles pour les users et les produits.

### mot de passe et login
* Login : test@test.com
* Mot de passe : linalina

### ajout et manquement
* **Ajout** :
*   Tout est modifiable dans le profil utilisateur, on peut modifier une ou plusieurs informations, sans que cela n'impacte les autres infos.
*   Un petit logo avec une image permet d'accéder rapidement au profil en haut à droite de la botom bar
*   Il y a également une sidebar qui permet de naviguer de manière plus interactive avec toutes les pages et également de se déconnecter à tout moment.
* **Manquement** : 
*   Je n'ai pas eu le temps de faire la suppression du panier un par un, j'ai eu le temps de faire une fonction qui supprime tout dans le panier ainsi que les boutons pour sélectionner les élements, mais eux aussi ils sélectionnent tout le panier.
*   Je n'ai pas eu le temps pour les filtres également, c'est dommage car c'est juste une ou deux lignes de code mais je suis à la minute près!

<!-- ABOUT THE PROJECT -->
## About The Project
L’objectif de ce second TP consiste à développer une version light de l’application Vinted (https://www.vinted.fr/). Celle-ci s’appellera « MIAGED ».

### Developpement

### US#1 : [MVP] Interface de login
#### us1

* En tant qu’utilisateur, je souhaite pouvoir me connecter à l’application afin d’accéder à la page suivante.
    * :heavy_check_mark: Critère d’acceptance #1 : Au lancement de l’application, une interface de login composée d’un headerBar qui contient le nom de l’application, de deux champs et d’un bouton m’est proposée
    * :heavy_check_mark: Critère d’acceptance #2 : Les deux champs de saisie sont : Login et Password
    * :heavy_check_mark: Critère d’acceptance #3 : Le champ de saisie du password est obfusqué
    * :heavy_check_mark: Critère d’acceptance #4 : Le label du bouton est : Se connecter
    * :heavy_check_mark: Critère d’acceptance #5 : Au clic sur le bouton « Se connecter », une vérification en base est réalisée. Si l’utilisateur existe, celui-ci est redirigé sur la page suivante. Si celui-ci n’existe pas, à minima un log est affiché dans la console et l’application reste fonctionnelle
    * :heavy_check_mark: Critère d’acceptance #6 : Au clic sur le bouton « Se connecter » avec les deux champs vides, l’application doit rester fonctionnelle


#### US#2 : [MVP] Liste de vêtements 
#### us2

* En tant qu’utilisateur connecté, je souhaite voir la liste des vêtements afin de choisir ceux qui m’intéressent
    * :heavy_check_mark: Critère d’acceptance #1 : Une fois connecté, l’utilisateur arrive sur cette page composée du contenu principal et d’une BottomNavigationBar composée de trois entrées et leurs icones correspondantes : Acheter, Panier et Profil
    * :heavy_check_mark: Critère d’acceptance #2 : La page actuelle est la page Acheter. Son icone et son texte sont d’une couleur  différente des autres entrées
    * :heavy_check_mark: Critère d’acceptance #3 : Une liste déroulante de tous les vêtements m’est proposé à l’écran
    * :heavy_check_mark: Critère d’acceptance #4 : Chaque vêtement affiche les informations suivantes : Une image (ne pas gérer les images dans l’application, seulement insérer des liens vers des images d’internet) - Un titre - La taille - Le prix
    * :heavy_check_mark: Critère d’acceptance #5 :Au clic sur une entrée de la liste, le détail est affiché (voir US#3)
    * :heavy_check_mark: Critère d’acceptance #6 : Cette liste de vêtements est récupérée de la base de données



#### US#3 : [MVP] Détail d’un vêtement 
#### us3

* En tant qu’utilisateur connecté, je souhaite voir le détail d’un vêtement afin de pouvoir vérifier s’il me convient et l’ajouter dans mon panier
    * :heavy_check_mark: Critère d’acceptance #1 : La page de détail est composée des informations suivantes :Une image - Un titre - La taille - La marque - Le prix
    * :heavy_check_mark: Critère d’acceptance #2 : La page est également composée d’un bouton « Retour » pour retourner à la liste des vétements et d’un bouton «Ajouter au panier», ajoutant le vêtement dans le panier de l’utilisateur (ajout en base)



#### US#4 : [MVP] Le panier
#### us4

* En tant qu’utilisateur connecté, je souhaite voir mon panier afin de le vérifier avant achat
  * :heavy_check_mark: Critère d’acceptance #1 : Au clic sur le bouton « Panier », la liste des vêtements du panier de l’utilisateur 
est affichée avec les informations suivantes : Une image (ne pas gérer les images dans l’application, seulement insérer des liens vers des images d’internet) - Un titre - La taille - La marque - Le prix 
  * :x: Critère d’acceptance #2 : Un total général est affiché à l’utilisateur (somme de tous les vêtements du panier)
  * :x: Critère d’acceptance #3 : A droite de chaque vetement, une croix permet à l’utilisateur de retirer un produit. Au clic sur celle-ci, le produit est retiré de la liste et le total général mis à jour
  * :heavy_check_mark: Critère d’acceptance #4 : Aucun autre bouton d’action n’est présent sur la page (pas de paiement pour le moment)


#### US#5 : [MVP] Profil utilisateur 
#### us5

* En tant qu’utilisateur connecté, je souhaite accéder aux informations de mon profil afin d’en vérifier l’exactitude et de les modifier sur besoin
  * :heavy_check_mark: Critère d’acceptance #1 : Au clic sur le bouton « Profil », les informations de l’utilisateur s’affichent (récupérées en base de données) 
  * :heavy_check_mark: Critère d’acceptance #2 : Les informations sont : Le login (readonly) - Le password (offusqué) - L’anniversaire - L’adresse - Le code postale (affiche le clavier numérique et n’accepte que les chiffres) - La ville
  * :heavy_check_mark: Critère d’acceptance #3 : Un bouton « Valider » permet de sauvegarder les données (en base de données)
  * :heavy_check_mark: Critère d’acceptance #4 : Un bouton « Se déconnecter » permet de revenir à la page de login

#### US#6 : Filtrer sur la liste des vêtements 
#### us6

* En tant qu’utilisateur connecté, je souhaite pouvoir filtrer la liste des vêtements pour afficher seulement une catégorie
  * :x: Critère d’acceptance #1 : Critère d’acceptance #1 : Sur la page « Acheter », une TabBar (https://flutter.dev/docs/cookbook/design/tabs) est présente, listant les différentes catégories de vêtements 
  * :x: Critère d’acceptance #2 : Critère d’acceptance #3 : Au clic sur une des entrées, la liste est filtrée pour afficher seulement les vêtements correspondants à la catégorie sélectionné


#### US#7 : Laisser libre cours à son imagination 
#### us7

* Pour cette partie là, vous avez la liberté de choisir ce que vous souhaitez rajouter dans l’application


