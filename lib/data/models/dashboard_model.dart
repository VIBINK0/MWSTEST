class DashboardModel {
  int? id;
  String? brand;
  String? name;
  String? price;
  String? imageLink;
  String? description;
  double? rating;

  DashboardModel({
    this.id,
    this.brand,
    this.name,
    this.price,
    this.imageLink,
    this.description,
    this.rating,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    id: json["id"],
    brand: json["brand"],
    name: json["name"],
    price: json["price"],
    imageLink: json["image_link"],
    description: json["description"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "brand": brand,
    "name": name,
    "price": price,
    "image_link": imageLink,
    "description": description,
    "rating": rating,
  };
}
