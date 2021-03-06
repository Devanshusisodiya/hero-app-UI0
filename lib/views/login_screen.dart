import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:web_app2/views/home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _superpower = TextEditingController();

  Future postCreds(String name, String superpower) async {
    var response = await http.post(
        Uri.parse('http://127.0.0.1:8000/post-hero/'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(
            <String, String>{'name': name, 'superpower': superpower}));
    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 10),
          child: Text("Welcome,\nAdd Hero.",
              style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 60, right: 60),
          child: TextField(
            controller: _name,
            decoration: InputDecoration(hintText: "Hero"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 60, right: 60),
          child: TextField(
            controller: _superpower,
            decoration: InputDecoration(hintText: "Superpower"),
          ),
        ),
        Padding(padding: const EdgeInsets.only(top: 10)),
        ElevatedButton(
            onPressed: () {
              postCreds(_name.text, _superpower.text);
            },
            child: Text(
              "Submit",
              style: TextStyle(fontSize: 20),
            )),
        Padding(padding: const EdgeInsets.only(top: 10)),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Text(
              "See Heroes",
              style: TextStyle(fontSize: 20),
            ))
      ])),
    );
  }
}
