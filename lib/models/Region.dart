class Region {
  int id;
  String name;

  Region({required this.id, required this.name});

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(id: json['id'], name: json['name']);
  }
}
