import 'dart:convert';

import 'package:moke_app/model/image.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define a StateNotifier to manage multiple ImageData instances
class ImageDataNotifier extends StateNotifier<Map<String, ImageData>> {
  ImageDataNotifier() : super({}) {
    loadAllImageData();
  }

  Future<void> loadAllImageData() async {
    final prefs = await SharedPreferences.getInstance();
    final imageDataKeys = prefs.getKeys();

    final Map<String, ImageData> imageDataMap = {};
    for (String key in imageDataKeys) {
      final imageDataJson = prefs.getString(key);
      if (imageDataJson != null) {
        final Map<String, dynamic> imageMap = jsonDecode(imageDataJson);
        imageDataMap[key] = ImageData.fromMap(imageMap);
      }
    }
    state = imageDataMap;
  }

  Future<void> saveImageData(ImageData imageData) async {
    final prefs = await SharedPreferences.getInstance();
    final String key =
        DateTime.now().toIso8601String(); // Use current time as key
    final String imageDataJson = jsonEncode(imageData.toMap());
    await prefs.setString(key, imageDataJson);

    final updatedMap = Map<String, ImageData>.from(state);
    updatedMap[key] = imageData;
    state = updatedMap;
  }

  Future<void> clearImageData() async {
    final prefs = await SharedPreferences.getInstance();
    final imageDataKeys = prefs.getKeys();

    for (String key in imageDataKeys) {
      await prefs.remove(key);
    }

    state = {};
  }
}

// Define a provider
final imageDataProvider =
    StateNotifierProvider<ImageDataNotifier, Map<String, ImageData>>((ref) {
  return ImageDataNotifier();
});
