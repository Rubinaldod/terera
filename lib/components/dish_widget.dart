//import 'package:terera/screens/dish_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:terera/screens/playlist_page.dart';

class DishWidget extends StatelessWidget {
  final String title;
  final String ingredients;
  final String description;
  final String prevScreen;

  DishWidget(
      {@required this.title,
      @required this.ingredients,
      @required this.description,
      @required this.prevScreen});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Text(
            this.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            this.description.length >= 20
                ? this.description.substring(0, 20) + '...'
                : this.description.substring(0, this.description.length),
            style: TextStyle(color: Colors.grey),
          ),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return DishPage(dishWidget: this);
              }));
            },
          ),
        ),
      ),
    );
  }
}
