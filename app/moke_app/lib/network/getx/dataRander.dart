import 'dart:ui';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moke_app/model/conclusion.dart';
import 'package:moke_app/model/healthPrompt.dart';
import 'package:moke_app/model/intialPrompt.dart';
import 'package:moke_app/model/ratioPrompt.dart';
import 'package:moke_app/network/bloc/data_event.dart';
import 'package:moke_app/util/enums/Prompt.dart';

import '../auth.dart';

class AuthController extends GetxController {
  final ImagePicker picker = ImagePicker();
  final storage = FlutterSecureStorage();

  final PromptBuilder promptBuilder = PromptBuilder();
  var initialData = <String, dynamic>{}.obs;

  var ratrioData = <String, dynamic>{}.obs;
  var healthData = <String, dynamic>{}.obs;
  var conclusionData = <String, dynamic>{}.obs;
  var imageXfile = Rx<XFile?>(null);
  Future<void> login(String username, String password) async {
    try {
      await promptBuilder.login(username, password);
      print('Login successful');
    } catch (e) {
      print('Login failed: $e');
    }
  }

  Future<void> dataimagePrompt(String user, String password) async {
    if (await storage.read(key: 'jwt_token2') == null) {
      await login(user, password);
    }
    try {
      final List<void> results = await Future.wait([
        promptBuilder.promptExecution((p0) {
          initialData.value = p0;
        }, PromptEvent.initialPrompt),
        promptBuilder.promptExecution((p0) {
          ratrioData.value = p0;
        }, PromptEvent.ratioPrompt),
        promptBuilder.promptExecution((p0) {
          healthData.value = p0;
        }, PromptEvent.healthPrompt),
        promptBuilder.promptExecution((p0) {
          conclusionData.value = p0;
        }, PromptEvent.conclusionPrompt),
      ]);

      // storing data to history imagedata
      // RatioSpecifiedPrompt initialPrompt = await RatioSpecifiedPrompt.fromMap(
      //     ratrioData.call()["ratioSpecified"]);
      ConclusionPrompt initialPrompt = await ConclusionPrompt.fromMap(
          conclusionData.call()["conclusionData"]);

      print("model data ${initialPrompt.toMap().toString()}");
    } catch (e) {
      print('Fetch data failed: $e');
    }
  }

  Future<void> onCameraOpen(Function(XFile, bool) onPickingUp) async {
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      imageXfile.value = photo;
      onPickingUp(photo, true);
    } else {
      onPickingUp(photo ?? XFile(""), false);
    }
  }
}
