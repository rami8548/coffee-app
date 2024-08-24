class CategoryModel {
  final String id;
  final String senderId;
  final String imageUrl;
  final String name;
  final String content;
  final String age;
  final String date;


  CategoryModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.content,
    required this.age,
    required this.senderId,
    required this.date,

  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      imageUrl: json['image'],
      name: json['name'],
      content: json['content'],
      age: json['age'],
      senderId: json['senderId'],
      date: json['date'],



    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': imageUrl,
      'name': name,
      'content': content,
      'age': age,
      'date': date,
      'senderId': senderId,

    };
  }
}
