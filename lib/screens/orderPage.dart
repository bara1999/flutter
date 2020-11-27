import '../menu.dart';
import 'package:flutter/material.dart';
import '../models/cart.dart';
import 'package:provider/provider.dart';
import 'menuList.dart';
import '../resturant.dart';
import 'package:confirm_dialog/confirm_dialog.dart';



class OrderPage extends StatefulWidget {
 final List<Resrturant> resturentsFiltter;

  OrderPage(this.resturentsFiltter);

  @override
  _OrderPageState createState() => _OrderPageState(resturentsFiltter);
}

class _OrderPageState extends State<OrderPage> {
  List<Resrturant> resturentsFiltter;
  List<Resrturant> res;


  _OrderPageState(this.resturentsFiltter);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return Scaffold(
            appBar: AppBar(
             backgroundColor: Colors.grey[800],

              title: Text('Checkout Page [\$ ${cart.totalPrice}]',style: TextStyle(color: Colors.orange)),
              actions: [
                FlatButton(
                  child: Text('Confirm ',style: TextStyle(color: Colors.orange,fontSize: 20)),
                  onPressed: () async {
                    if (await confirm(context,title: Text('Send'),
                        content: Text('Are you sure to send your order?'),textOK: Text('Yes'),
                      textCancel: Text('No'),)) {
                      cart.clear();
                      return print('pressedOK');



                    }
                    return print('pressedCancel');
                  },
                ),
              ],
            ),
            body: cart.basketItems.length == 0
                ? Text('no items in your cart')
                : Container(
              margin: EdgeInsets.all(4),
              
                  child: ListView.builder(
              itemCount: cart.basketItems.length,
              itemBuilder: (context, index) {
                  res=resturentsFiltter.where((element) => element.id==cart.basketItems[index].rest_id).toList();
                  return Container(
                    color: Colors.orange,
                    height: 80,

                     child: ListTile(

                        leading: Text(res[0].name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        title: Text("meal:${cart.basketItems[index].name}",textAlign: TextAlign.center,style: TextStyle(fontSize: 18, ),),
                        subtitle:
                        Text("price:${cart.basketItems[index].price.toString()}",textAlign: TextAlign.center),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            cart.remove(cart.basketItems[index]);


                          },
                        ),
                      ),
                  );
              },
            ),
                ));
      },
    );
  }
}

