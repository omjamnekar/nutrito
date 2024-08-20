class InitialPrompt {
  String? allergenInformation;
  String? barcode;
  List<String>? certifications;
  String? countryOfOrigin;
  String? dietaryInformation;
  String? expiryDate;
  List<Ingredient>? ingredients;
  bool? isAddictive;
  String? price;
  Manufacturer? manufacturer;
  String? name;
  Map<String, String>? nutritionalInformation; // Changed to Map for flexibility
  String? productType;
  String? servingSize;
  String? storageInstructions;
  String? usageInstructions;
  String? weight;
  String? warnings;
  String? additionalInformation;
  String? link;
  String? website;

  // Constructor with optional or nullable fields
  InitialPrompt({
    this.allergenInformation,
    this.barcode,
    this.certifications,
    this.countryOfOrigin,
    this.dietaryInformation,
    this.expiryDate,
    this.ingredients,
    this.isAddictive,
    this.price,
    this.manufacturer,
    this.name,
    this.nutritionalInformation,
    this.productType,
    this.servingSize,
    this.storageInstructions,
    this.usageInstructions,
    this.weight,
    this.warnings,
    this.additionalInformation,
    this.link,
    this.website,
  });

  // Convert a JSON map to an InitialPrompt object
  factory InitialPrompt.fromMap(Map<String, dynamic>? map) {
    if (map == null) return InitialPrompt();

    return InitialPrompt(
      allergenInformation: map['allergenInformation'] ?? '',
      barcode: map['barcode'] ?? '',
      certifications: map['certifications'] != null
          ? List<String>.from(map['certifications'])
          : [],
      countryOfOrigin: map['countryOfOrigin'] ?? '',
      dietaryInformation: map['dietaryInformation'] ?? '',
      expiryDate: map['expiryDate'] ?? '',
      ingredients: map['ingredients'] != null
          ? List<Ingredient>.from(
              map['ingredients']?.map((item) => Ingredient.fromMap(item)))
          : [],
      isAddictive: map['isAddictive'] ?? false,
      price: map['price'] ?? '',
      manufacturer: map['manufacturer'] != null
          ? Manufacturer.fromMap(map['manufacturer'])
          : null,
      name: map['name'] ?? '',
      nutritionalInformation: map['nutritionalInformation'] != null
          ? Map<String, String>.from(map['nutritionalInformation'])
          : {},
      productType: map['productType'] ?? '',
      servingSize: map['servingSize'] ?? '',
      storageInstructions: map['storageInstructions'] ?? '',
      usageInstructions: map['usageInstructions'] ?? '',
      weight: map['weight'] ?? '',
      warnings: map['warnings'] ?? '',
      additionalInformation: map['additionalInformation'] ?? '',
      link: map['link'] ?? '',
      website: map['website'] ?? '',
    );
  }

  // Convert an InitialPrompt object to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'allergenInformation': allergenInformation ?? '',
      'barcode': barcode ?? '',
      'certifications': certifications ?? [],
      'countryOfOrigin': countryOfOrigin ?? '',
      'dietaryInformation': dietaryInformation ?? '',
      'expiryDate': expiryDate ?? '',
      'ingredients':
          ingredients?.map((ingredient) => ingredient.toMap()).toList() ?? [],
      'isAddictive': isAddictive ?? false,
      'price': price ?? '',
      'manufacturer': manufacturer?.toMap(),
      'name': name ?? '',
      'nutritionalInformation': nutritionalInformation ?? {},
      'productType': productType ?? '',
      'servingSize': servingSize ?? '',
      'storageInstructions': storageInstructions ?? '',
      'usageInstructions': usageInstructions ?? '',
      'weight': weight ?? '',
      'warnings': warnings ?? '',
      'additionalInformation': additionalInformation ?? '',
      'link': link ?? '',
      'website': website ?? '',
    };
  }
}

class Ingredient {
  String? name;
  String? quantity;

  Ingredient({
    this.name,
    this.quantity,
  });

  factory Ingredient.fromMap(Map<String, dynamic>? map) {
    if (map == null) return Ingredient();

    return Ingredient(
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name ?? '',
      'quantity': quantity ?? '',
    };
  }
}

class Manufacturer {
  String? name;
  String? address;

  Manufacturer({
    this.name,
    this.address,
  });

  factory Manufacturer.fromMap(Map<String, dynamic>? map) {
    if (map == null) return Manufacturer();

    return Manufacturer(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name ?? '',
      'address': address ?? '',
    };
  }
}
