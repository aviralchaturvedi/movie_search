import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

var cmd, url, r, data, fdata, m;
var qwe = "\n";

void main() {
  runApp(movie());
}

// ignore: camel_case_types
class movie extends StatefulWidget {
  movie({Key key}) : super(key: key);

  @override
  _movieState createState() => _movieState();
}

// ignore: camel_case_types
class _movieState extends State<movie> {
  web(cmd) async {
    print(cmd);
    if (cmd == null || cmd == "") {
      m = "please enter something";
      print(m);
    } else {
      url = "http://www.omdbapi.com/?apikey=ed4c11a2&s=$cmd";
      r = await http.get(url);

      data = r.body;

      fdata = jsonDecode(data);
      fdata["Search"].forEach((mov) {
        qwe = qwe + mov['Title'] + "     Year-" + mov['Year'] + "\n";
      });

      setState(() {
        m = qwe.toString();
      });
    }
    setState(() {
      return m;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("movie/series search"),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1535016120720-40c646be5580?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
                  fit: BoxFit.fill),
            ),
            child: Column(children: <Widget>[
              Card(
                child: TextField(
                  onChanged: (val) {
                    cmd = val;
                  },
                  autofocus: true,
                  cursorColor: Colors.blueGrey,
                  decoration: InputDecoration(
                      hintText: 'Enter Text',
                      border: const OutlineInputBorder()),
                ),
              ),
              Card(
                child: FlatButton(
                    onPressed: () {
                      web(cmd);
                      qwe = " ";
                    },
                    child: Text('search')),
              ),
              Expanded(
                child: VxSwiper(
                  scrollDirection: Axis.vertical,
                  items: [
                    Text(
                      "here are your searched results \n \n$m" ??
                          "loading...",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ).p16()
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
