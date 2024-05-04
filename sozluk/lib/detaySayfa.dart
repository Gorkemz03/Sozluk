import 'package:flutter/material.dart';

class detaySayfa extends StatefulWidget {


  @override
  State<detaySayfa> createState() => _detaySayfaState();
}

class _detaySayfaState extends State<detaySayfa> {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: Text("Detay Sayfası"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

          ],
        ),
      ),

    );
  }
}
