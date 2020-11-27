import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import '../resturant.dart';
import 'main.dart';
import 'package:google_fonts/google_fonts.dart';
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  List<Resrturant> resturents=[];


  void fetch() async {
    http.Response response = await http.get('http://appback.ppu.edu/restaurants');


    if(response.statusCode == 200) {
      var jsonArray = jsonDecode(response.body) as List;
      resturents= jsonArray.map((element) => Resrturant.fromJson(element)).toList();
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Main(resturents),));


  }
  @override
  void initState() {
    super.initState();
    fetch();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(0.5),
          margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
          child: Column(
            children: [

              SizedBox(height: 120.0),
              Text('DELIVERY FOOD',style:GoogleFonts.indieFlower(fontSize: 40.0,fontWeight: FontWeight.bold, letterSpacing: 5.0,color: Colors.black),),
              SizedBox(height: 10.0),
              Image.network('https://images.app.goo.gl/1uBbcEBuZMgYfF297',height:300 ,width:300 ,),
              SizedBox(height: 20.0),
              Text('Best app to deliver your food in a fast and trusty way.',style:GoogleFonts.varela(fontSize: 13.0,fontWeight: FontWeight.bold,color: Colors.black)),
              SizedBox(height: 20.0),
              SpinKitWave(
                color: Colors.amber[300],
                size: 60.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}