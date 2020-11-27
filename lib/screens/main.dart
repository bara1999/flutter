import 'package:flutter/material.dart';
import 'loading.dart';
import '../menu.dart';
import 'menuList.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../resturant.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MaterialApp(
        home: Loading(),
      ),
    );
  }
}

class Main extends StatefulWidget {

   final List<Resrturant> resturents;

   Main(this.resturents);

  @override
  _MainState createState() => _MainState(resturents);
}

class _MainState extends State<Main> {

  double rate;
  List<Menu> order=[];
  List<Resrturant> resturents;
  List<Resrturant> resturentsFiltter;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resturents.sort((a, b) => a.rating.compareTo(b.rating));
   resturents= resturents.reversed.toList();

    resturentsFiltter=resturents;
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        color: Colors.white70,
        child: TextField(

          decoration: InputDecoration(
              hintText: 'Search...'
          ),
          onChanged: (text) {
            text = text.toLowerCase();
            setState(() {
              resturentsFiltter = resturents.where((e) {
                var cityTitle = e.city.toLowerCase();
                return cityTitle.contains(text);
              }).toList();
            });
          },
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.yellowAccent[700],
        title: Text('Restaurants',style: GoogleFonts.varela(color: Colors.black,letterSpacing: 1,fontSize:25,fontWeight: FontWeight.bold ),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
                  child: ListView.builder(
                    itemCount: resturentsFiltter.length+1,
                    itemBuilder: (context, index) {
                      if(resturentsFiltter.isNotEmpty) {
                        return index == 0 ? _searchBar() : _listItem(index - 1,rate);
                      }
                      else
                        return Text("There are no resturants yet!");
                      },),
                ),




        ],
      ),
    );
  }

  _listItem(index,rate) {
    rate=double.parse(resturentsFiltter[index].rating.toString())/2;

    return Container(
      height: 150,
      margin: EdgeInsets.all(4.0),
      child:Card(
        shadowColor: Colors.black,
        color: Colors.white,

        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(2.0,0,0,0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 144,
                  minHeight: 500,
                  maxWidth: 145,
                  maxHeight: 500,
                ),
                child: Image.network(resturentsFiltter[index].image,fit: BoxFit.scaleDown),
              ),
            ),

            Expanded(
              child: ListTile(
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly ,

                    children: [
                      Text(resturentsFiltter[index].name,style: TextStyle(fontSize: 25.0,color: Colors.black,fontWeight:FontWeight.bold),),
                      Text(resturentsFiltter[index].city,style: TextStyle(fontSize: 18.0,color: Colors.grey[900]),),
                      SmoothStarRating(
                          allowHalfRating: false,
                          onRated: (v) {
                          },
                          starCount: 5,
                          rating:rate,
                          size: 20.0,
                          isReadOnly:true,

                          color: Colors.yellowAccent[700],
                          borderColor: Colors.yellowAccent[700],
                          spacing:0.0
                      ),
                      Text('Ratting:${rate}/5',style: TextStyle(fontSize: 18.0,color: Colors.grey[900]),)

                    ],

                  ),
              ),


            ),

                   Padding(
                     padding: const EdgeInsets.fromLTRB(0,0,5.1,0),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         ButtonTheme(
                           child: RaisedButton(

                            color: Colors.yellowAccent[700],
                            onPressed: () {
                              fetch(resturentsFiltter[index].id);
                            },
                            child: Text("menu",style: TextStyle(fontSize: 20,color: Colors.black),),
                  ),
                         ),
                         ButtonTheme(
                           child: RaisedButton(
                             color: Colors.yellowAccent[700],
                             onPressed: () {
                               _showDialog(context,rate,resturentsFiltter[index].rating,index);

                             },
                             child: Text("Rate  ",style: TextStyle(fontSize: 20,color: Colors.black)),
                           ),
                         ),
                       ],
                     ),
                   ),

          ],
        ),
      ),
    );

}
  void _showDialog(BuildContext context,double rate ,int r,index) {
    List<TextEditingController> controls=[];
    for(int i=0;i<1;i++)
      controls.add(TextEditingController());
    showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Rate'),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controls[0],
                  decoration: InputDecoration(
                      hintText: 'Rate'
                  ),
                ),

              ],
            ),
          ),
          actions: [
            RaisedButton(
              child: Text('submit'),
              onPressed: () {
                print(r);
                setState(() {

                  resturentsFiltter[index].rating=int.parse(((r+double.parse(controls[0].text))~/2).toString());
                  rate=resturentsFiltter[index].rating/1;
                  print( rate);
                  print( resturentsFiltter[index].rating);


                });
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
      context: context,
    );
  }

  _MainState(this.resturents);


  List<Menu>menus=[];


  void fetch(int id) async {
    http.Response response = await http.get('http://appback.ppu.edu/menus/$id');


    if(response.statusCode == 200) {
      var jsonArray = jsonDecode(response.body) as List;
      menus= jsonArray.map((element) => Menu.fromJson(element)).toList();
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => MenuList(menus,resturents),));


  }
}


