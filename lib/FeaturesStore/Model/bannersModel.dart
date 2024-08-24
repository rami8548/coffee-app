class BannersModel {
   String? id;
   String? image;
   String? name;
  // final String price;
  // final String type;
  // final String addFlavor;

  BannersModel(
      {required this.id, required this.image,
        // required this.addFlavor,

      // required this.age,
      required this.name,
      // required this.type,

      });

  factory BannersModel.fromJson(Map<String, dynamic> json) {
    return BannersModel(
      id: json['id'],
      image: json['image'],
      name: json["name"]
      // addFlavor: json['addflavor'],
        // age: json["age"],
        // type: json["type"],
        // price: json["price"],
    );
  }
}
