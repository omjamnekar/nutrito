class ConclusionPrompt {
  String? allergenInformation;
  String? conclusion;
  int? overallHealthRating;
  String? recommendations;
  String? servingSize;

  ConclusionPrompt({
    this.allergenInformation,
    this.conclusion,
    this.overallHealthRating,
    this.recommendations,
    this.servingSize,
  });

  // Convert a JSON map to a ConclusionPrompt object
  factory ConclusionPrompt.fromMap(Map<String, dynamic> map) {
    return ConclusionPrompt(
      allergenInformation: map['allergenInformation'] ?? '',
      conclusion: map['conclusion'] ?? '',
      overallHealthRating: map['overallHealthRating'] ?? 0,
      recommendations: map['recommendations'] ?? '',
      servingSize: map['servingSize'] ?? '',
    );
  }

  // Convert a ConclusionPrompt object to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'allergenInformation': allergenInformation,
      'conclusion': conclusion,
      'overallHealthRating': overallHealthRating,
      'recommendations': recommendations,
      'servingSize': servingSize,
    };
  }
}
