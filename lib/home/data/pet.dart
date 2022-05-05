class Pet {
  final String imageUrl;

  Pet({required this.imageUrl});

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(imageUrl: json['url']);
  }
}
