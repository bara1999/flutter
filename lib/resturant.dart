
class Resrturant {
  int id;
  String name;
  String city;
  String lat;
  String lng;
  String phone;
  String image;
  int rating;

  Resrturant({this.id, this.name, this.city, this.lat, this.lng, this.phone,this.image, this.rating});

  factory Resrturant.fromJson(dynamic json) {
    String s=json['image'] ;
    return Resrturant(
      id:json['id'] ,
      name: json['name'] ,
      city: json['city'] ,
      lat: json['lat'] ,
      lng: json['lng'],
      phone: json['phone'] ,
      image: "http://appback.ppu.edu/static/$s",
      rating: json['rating'] ,

    );

  }

  @override
  String toString() {
    return 'Resrturant{id: $id, name: $name, city: $city, lat: $lat, lng: $lng, phone: $phone, image: $image, rating: $rating}';
  }
}