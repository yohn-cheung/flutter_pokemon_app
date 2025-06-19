class Description {
  int id;
  int pokemonId;
  String description;

  Description({
    required this.id,
    required this.pokemonId,
    required this.description,
  });

  factory Description.fromJson(Map<String, dynamic> json) {
    return Description(
      id: json['id'],
      pokemonId: json['pokemon_id'],
      description: json['description'],
    );
  }
}
