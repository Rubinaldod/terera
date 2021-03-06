import 'package:at_commons/at_commons.dart';
import 'package:terera/components/dish_widget.dart';
import 'package:terera/constants.dart' as constant;
import 'package:terera/service.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class OtherScreen extends StatelessWidget {
  static final String id = 'other';
  final _serverDemoService = ServerDemoService.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello, ' + atSign,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: FutureBuilder(
                  future: _getSharedRecipes(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      // Returns a map that has a dish's title as its key and
                      // a dish's attributes for its value.
                      Map dishAttributes = snapshot.data;
                      print(snapshot.data);
                      List<DishWidget> dishWidgets = [];
                      dishAttributes.forEach((key, value) {
                        List<String> valueArr = value.split(constant.splitter);
                        dishWidgets.add(
                          DishWidget(
                            title: key,
                            description: valueArr[0],
                            ingredients:
                                valueArr[1].length == 3 ? valueArr[2] : null,
                            //  prevScreen: OtherScreen.id,
                          ),
                        );
                      });
                      return SafeArea(
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.keyboard_arrow_left,
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, HomeScreen.id);
                                  },
                                ),
                                Text(
                                  'Shared Playlists',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    color: Colors.black87,
                                  ),
                                )
                              ]),
                            ),
                            Column(
                              children: dishWidgets,
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('An error has occurred: ' +
                          snapshot.error.toString());
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns the list of Shared Recipes keys.
  _getSharedKeys() async {
    await _serverDemoService.sync();
    return await _serverDemoService.getAtKeys(regex: 'cached.*cookbook');
  }

  /// Returns a map of Shared recipes key and values.
  _getSharedRecipes() async {
    List<AtKey> sharedKeysList = await _getSharedKeys();
    Map recipesMap = {};
    AtKey atKey = AtKey();
    Metadata metadata = Metadata()..isCached = true;
    sharedKeysList.forEach((element) async {
      atKey
        ..key = element.key
        ..sharedWith = element.sharedWith
        ..sharedBy = element.sharedBy
        ..metadata = metadata;
      String response = await _serverDemoService.get(atKey);
      recipesMap.putIfAbsent('${element.key}', () => response);
    });
    return recipesMap;
  }
}
