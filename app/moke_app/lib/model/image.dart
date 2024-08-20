import 'package:image_picker/image_picker.dart';
import 'package:moke_app/model/conclusion.dart';
import 'package:moke_app/model/healthPrompt.dart';
import 'package:moke_app/model/intialPrompt.dart';
import 'package:moke_app/model/ratioPrompt.dart';

class ImageData {
  String? id;
  String? imageName;
  XFile? image;
  InitialPrompt? initialPrompt;
  HealthPrompt? healthPrompt;
  RatioSpecifiedPrompt? ratioSpecifiedPrompt;
  ConclusionPrompt? conclusionPrompt;
  ImageData({
    this.id,
    this.image,
    this.imageName,
    this.initialPrompt,
    this.healthPrompt,
    this.ratioSpecifiedPrompt,
    this.conclusionPrompt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageName': imageName ?? "",
      'image': image?.path,
      'initialPrompt': initialPrompt?.toMap() ?? "",
      'healthPrompt': healthPrompt?.toMap() ?? "",
      'ratioSpecifiedPrompt': ratioSpecifiedPrompt?.toMap() ?? "",
      'ratioPrompt': ratioSpecifiedPrompt?.toMap() ?? "",
      'conclusionPrompt': conclusionPrompt?.toMap() ?? "",
    };
  }

  static ImageData fromMap(Map<String, dynamic> map) {
    return ImageData(
        id: map['id'],
        imageName: map['imageName'],
        image: map['image'] != null ? XFile(map['image']) : null,
        initialPrompt: map['initialPrompt'] != null
            ? InitialPrompt.fromMap(map['initialPrompt'])
            : InitialPrompt(),
        healthPrompt: map["healthPrompt"] != null
            ? HealthPrompt.fromMap(map["healthPrompt"])
            : HealthPrompt(),
        ratioSpecifiedPrompt: map["ratioSpecifiedPrompt"] != null
            ? RatioSpecifiedPrompt.fromMap(map["ratioSpecifiedPrompt"])
            : RatioSpecifiedPrompt(),
        conclusionPrompt: map["coo"] != null
            ? ConclusionPrompt.fromMap(map["conclusionPrompt"])
            : ConclusionPrompt());
  }
}
