class Thought {
  final String categoryName;
  Thought({required this.categoryName});
  factory Thought.fromJson(String category) {
    return Thought(categoryName: category);
  }
  Map<String, dynamic> toJson() {
    return {
      'categoryName': categoryName,
    };
  }
}
