class HealthPrompt {
  List<HealthConsideration>? healthConsiderations;

  HealthPrompt({
    this.healthConsiderations,
  });

  // Convert a JSON map to a HealthPrompt object
  factory HealthPrompt.fromMap(Map<String, dynamic> map) {
    return HealthPrompt(
      healthConsiderations: List<HealthConsideration>.from(
        map['health_considerations']
                ?.map((item) => HealthConsideration.fromMap(item)) ??
            [],
      ),
    );
  }

  // Convert a HealthPrompt object to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'health_considerations':
          healthConsiderations?.map((hc) => hc.toMap()).toList(),
    };
  }
}

class HealthConsideration {
  String ingredient;
  List<String> negative;
  List<String> positive;

  HealthConsideration({
    required this.ingredient,
    required this.negative,
    required this.positive,
  });

  // Convert a JSON map to a HealthConsideration object
  factory HealthConsideration.fromMap(Map<String, dynamic> map) {
    return HealthConsideration(
      ingredient: map['ingredient'] ?? '',
      negative: List<String>.from(map['negative'] ?? []),
      positive: List<String>.from(map['positive'] ?? []),
    );
  }

  // Convert a HealthConsideration object to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'ingredient': ingredient,
      'negative': negative,
      'positive': positive,
    };
  }
}
