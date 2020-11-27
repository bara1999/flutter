import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'favorite.dart';
import '../menu.dart';
import 'orderPage.dart';
import '../resturant.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
class MenuList extends StatefulWidget {
  final List<Menu> menu;

  List<Resrturant> resturentsFiltter;
  MenuList(this.menu,this.resturentsFiltter);

  @override

  _MenuListState createState() => _MenuListState(menu,resturentsFiltter);
}

class _MenuListState extends State<MenuList> {

  List<Menu> menu;
  List<Menu> order=[];
  double rate;

  List<Resrturant> resturentsFiltter;

  _MenuListState(this.menu,this.resturentsFiltter);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, cart, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent[700],
          title: Text('List Menu Items',style: GoogleFonts.varela(color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 1,fontSize: 20),),

          actions: <Widget>[
      Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
      children: <Widget>[
      IconButton(
      icon: Icon(
      Icons.shopping_cart,
      color: Colors.black,
      ),
      onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => OrderPage(resturentsFiltter)));
      },
      ),
        IconButton(
          icon: Icon(
            Icons.favorite,
            color: Colors.black,
          ),
          onPressed: () {
             Navigator.of(context).push(MaterialPageRoute(
               builder: (context) => Favorite(resturentsFiltter)));
          },
        ),

      ],
      ),
      )
      ],
      centerTitle: true,
      ),

        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: menu.length,
                itemBuilder: (context, index) {
                  if(menu!=null) {
                    if(menu[index].rating==null){
                      rate=0;

                    }
                    else
                      rate=double.parse(menu[index].rating.toString())/2;

                    return  Container(
                      height: 200,
                      child: Card(

                        color: Colors.yellowAccent[700],

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
                                child: Image.network(menu[index].image,height: 400,width: 400,),
                              ),
                            ),

                            Expanded(
                              child: ListTile(
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:MainAxisAlignment.spaceEvenly ,

                                  children: [
                                    Text(menu[index].name,style: TextStyle(fontSize: 25.0,fontWeight:FontWeight.bold),),
                                    Text(menu[index].descr,style: TextStyle(fontSize: 18.0,color: Colors.grey[900]),),
                                    Text('price: ${menu[index].price}',style: TextStyle(fontSize: 18.0,color: Colors.grey[900]),),
                                    SmoothStarRating(
                                        allowHalfRating: false,
                                        onRated: (v) {
                                        },
                                        starCount: 5,
                                        rating:rate ,
                                        size: 20.0,
                                        isReadOnly:true,

                                        color: Colors.yellowAccent[700],
                                        borderColor: Colors.yellowAccent[700],
                                        spacing:0.0
                                    ),

                                  ],

                                ),


                              ),
                            ),
                            Column(
                              children: [
                                IconButton(icon: Icon(Icons.add),
                                  onPressed: () {
                                    print(cart.count);

                                    cart.add(menu[index]);

                                  },),
                                IconButton(icon: Icon(Icons.favorite_border),
                                  onPressed: () {
                                    print(cart.countf);

                                    cart.addfav(menu[index]);

                                  },),

                              ],
                            ),


                          ],
                        ),
                      ),
                    )

                    ;
                  }
                  else
                    return Text("There are no items yet!");
                },),
            ),

          ],
        ),



      );
    });
  }





  _listItem(index) {


    return Container(
                  height: 200,
                  child: Card(

                    color: Colors.yellowAccent[700],

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
                            child: Image.network(menu[index].image,height: 400,width: 400,),
                          ),
                        ),

                        Expanded(
                          child: ListTile(
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:MainAxisAlignment.spaceEvenly ,

                              children: [
                                Text(menu[index].name,style: TextStyle(fontSize: 25.0,fontWeight:FontWeight.bold),),
                                Text(menu[index].descr,style: TextStyle(fontSize: 12.0,color: Colors.grey[600]),),
                                Text('price: ${menu[index].price}',style: TextStyle(fontSize: 18.0,color: Colors.grey[600]),),
                                SmoothStarRating(
                                    allowHalfRating: false,
                                    onRated: (v) {
                                    },
                                    starCount: 5,
                                    rating:rate ,
                                    size: 20.0,
                                    isReadOnly:true,

                                    color: Colors.yellowAccent[700],
                                    borderColor: Colors.yellowAccent[700],
                                    spacing:0.0
                                ),


                              ],

                            ),

                            trailing:
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0.0,20,0,0),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(

                                  minWidth: 60,
                                  minHeight: 144,
                                  maxWidth: 70,
                                  maxHeight: 144,

                                ),
                                child:SizedBox(
                                  width: 80,
                                  child: RaisedButton(

                                      color: Colors.orangeAccent,

                                      onPressed: () {
                                        setState(() {
                                          order.add(menu[index]);

                                        });


                                      },
                                      child: Text("✔"),
                                    ),
                                ),

                              ),
                            ),


                          ),


                        ),
                      ],
                    ),
                  ),
                )

      ;

  }
}
