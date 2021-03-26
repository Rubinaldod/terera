import 'package:terera/components/rounded_button.dart';
import 'package:terera/service.dart';
import 'login_screen.dart';
import 'package:at_commons/at_commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:terera/constants.dart' as constant;
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DishScreen extends StatelessWidget {
  static final String id = "add_dish";
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _title;
  String _description;

  ServerDemoService _serverDemoService = ServerDemoService.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add playlist '),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Name of the playlist',
                          labelText: 'playlist',
                        ),
                        validator: (value) => value.isEmpty
                            ? 'the name of the playlis is required'
                            : null,
                        onChanged: (value) {
                          _title = value;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'URL of the playlist',
                          labelText: 'URL of the playlist',
                        ),
                        maxLines: 3,
                        validator: (value) =>
                            value.isEmpty ? 'Provide a description' : null,
                        onChanged: (value) {
                          _description = value;
                        },
                      ),
                      RoundedButton(
                        text: 'Add playlist',
                        path: () => _update(context),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  /// Add a key/value pair to the logged-in secondary server.
  _update(BuildContext context) async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      String _values = _description + constant.splitter;

      AtKey atKey = AtKey();
      atKey.key = _title;
      atKey.sharedWith = atSign;
      await _serverDemoService.put(atKey, _values);
      Navigator.pop(context);
    } else {
      print('Not all text fields have been completed!');
    }
  }
}
