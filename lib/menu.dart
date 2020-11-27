class Menu{
  int id;
  int rest_id;
  String name;
  String descr;
  int price;
  String image;
  int rating;

  Menu({this.id, this.rest_id, this.name, this.descr, this.price, this.image,
    this.rating});
  factory Menu.fromJson(dynamic json) {
    String s=json['image'] ;
    return Menu(
      id:json['id'] ,
      rest_id:json['rest_id'] ,
      name: json['name'] ,
      descr: json['descr'],
      price: json['price'],

      image: "http://appback.ppu.edu/static/$s",
      rating: json['rating'] ,

    );

  }
}