class ProductModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final num review;
  final num price;
  final String flavorNotes;
  final List<String> origin;
  final List<String> ingredients;
  final List<String> contains;
  final String caffeineContent;
  final List<String> sizes;
  int ?quantity;



  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.review,
    required this.flavorNotes,
    required this.origin,
    required this.ingredients,
    required this.caffeineContent,
    required this.sizes,
    required this.contains,
     this.quantity,

  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      review: json['review'],
      imageUrl: json['image'],
      price: json['price'],
      flavorNotes: json['flavorNotes'],
      origin: List<String>.from(json['origin']),
      ingredients: List<String>.from(json['ingredients']),
      contains: List<String>.from(json['contain']),
      caffeineContent: json['caffeineContent'],
      sizes: List<String>.from(json['sizes']),
      quantity: json['quantity'] ?? 1, // Handle null quantity from JSON


    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': imageUrl,
      'price': price,
      'flavorNotes': flavorNotes,
      'origin': origin,
      'ingredients': ingredients,
      'caffeineContent': caffeineContent,
      'sizes': sizes,
      'contain': contains,
      'review': review,
      'quantity': quantity,


    };
  }
}
