
import 'package:flutter/material.dart';
import '../models/cart.dart';
import 'package:provider/provider.dart';
import 'menuList.dart';
import '../resturant.dart';



class Favorite extends StatefulWidget {
  final List<Resrturant> resturentsFiltter;
  Favorite(this.resturentsFiltter);

  @override
  _FavoriteState createState() => _FavoriteState(resturentsFiltter);
}

class _FavoriteState extends State<Favorite> {
  List<Resrturant> resturentsFiltter;
  List<Resrturant> res;

  _FavoriteState(this.resturentsFiltter);

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.grey[800],
                title: Text('Favorite Page',style: TextStyle(color: Colors.orange)),
            ),
            body: cart.favorite.length == 0
                ? Text('There are no items')
                : ListView.builder(
              itemCount: cart.favorite.length,
              itemBuilder: (context, index) {
                res=resturentsFiltter.where((element) => element.id==cart.favorite[index].rest_id).toList();
                return Container(

                  margin: EdgeInsets.all(4),
                  color: Colors.orange,
                  height: 110,

                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(

                          leading: Text(res[0].name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          title: Text("meal:${cart.favorite[index].name}",textAlign: TextAlign.center,style: TextStyle(fontSize: 18, ),),

                        ),
                      ),
                      Column(
                        children: [
                          IconButton(icon: Icon(Icons.add),
                            onPressed: () {
                              print(cart.count);

                              cart.add(cart.favorite[index]);

                            },),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              cart.removefav(cart.favorite[index]);
                            },
                          ),

                        ],
                      ),

                    ],

                  ),
                );
              },
            ));
      },
    );
  }
}
