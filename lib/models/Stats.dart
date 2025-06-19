class Stats {
  int id;
  int pokemonId;
  int hp;
  int attack;
  int defense;
  int spAttack;
  int spDefense;
  int speed;

  Stats({
    required this.id,
    required this.pokemonId,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.spAttack,
    required this.spDefense,
    required this.speed,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      id: json['id'],
      pokemonId: json['pokemon_id'],
      hp: json['hp'],
      attack: json['attack'],
      defense: json['defense'],
      spAttack: json['sp_attack'],
      spDefense: json['sp_defense'],
      speed: json['speed'],
    );
  }
}
