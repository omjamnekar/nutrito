class RatioSpecifiedPrompt {
  List<IngredientAnalysis>? ingredientAnalysis;
  Map<String, NutritionalFeedback>? nutritionalAnalysis;

  RatioSpecifiedPrompt({
    this.ingredientAnalysis,
    this.nutritionalAnalysis,
  });

  // Convert a JSON map to a RatioSpecifiedPrompt object
  factory RatioSpecifiedPrompt.fromMap(Map<String, dynamic> map) {
    return RatioSpecifiedPrompt(
      ingredientAnalysis: List<IngredientAnalysis>.from(
        map['ingredientAnalysis']
                ?.map((item) => IngredientAnalysis.fromMap(item)) ??
            [],
      ),
      nutritionalAnalysis: map['nutritionalAnalysis'] != null
          ? Map<String, NutritionalFeedback>.from(
              map['nutritionalAnalysis'].map(
                (key, value) => MapEntry(
                  key,
                  NutritionalFeedback.fromMap(value),
                ),
              ),
            )
          : {},
    );
  }

  // Convert a RatioSpecifiedPrompt object to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'ingredientAnalysis':
          ingredientAnalysis?.map((ingredient) => ingredient.toMap()).toList(),
      'nutritionalAnalysis': nutritionalAnalysis?.map(
        (key, value) => MapEntry(key, value.toMap()),
      ),
    };
  }
}

class IngredientAnalysis {
  String comment;
  int healthRating;
  String ingredient;

  IngredientAnalysis({
    required this.comment,
    required this.healthRating,
    required this.ingredient,
  });

  factory IngredientAnalysis.fromMap(Map<String, dynamic> map) {
    return IngredientAnalysis(
      comment: map['comment'] ?? '',
      healthRating: map['healthRating'] ?? 0,
      ingredient: map['ingredient'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'healthRating': healthRating,
      'ingredient': ingredient,
    };
  }
}

class NutritionalFeedback {
  int feedbackRatio;
  String value;

  NutritionalFeedback({
    required this.feedbackRatio,
    required this.value,
  });

  factory NutritionalFeedback.fromMap(Map<String, dynamic> map) {
    return NutritionalFeedback(
      feedbackRatio: map['feedbackRatio'] ?? 0,
      value: map['value'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'feedbackRatio': feedbackRatio,
      'value': value,
    };
  }
}
