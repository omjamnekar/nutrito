import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moke_app/network/auth.dart';
import 'package:moke_app/network/bloc/auth_bloc.dart';
import 'package:moke_app/network/bloc/data_bloc.dart';
import 'package:moke_app/network/getx/dataRander.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moke_app/network/getx/image_host.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PromptBuilder promptBuilder = PromptBuilder();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthBloc(promptBuilder)),
          BlocProvider(create: (_) => DataBloc(promptBuilder)),
        ],
        child: Scaffold(
          appBar: AppBar(title: Text('JWT Authentication')),
          body: AuthWidget(),
        ),
      ),
    );
  }
}

class AuthWidget extends StatefulWidget {
  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final PromptBuilder promptBuilder = PromptBuilder();
  final ImageHost _imageHost = ImageHost();

  Future<void> _login() async {
    try {
      await promptBuilder.login(
          _usernameController.text, _passwordController.text);
      print('Login successful');
    } catch (e) {
      print('Login failed: $e');
    }
  }

  Future<File> _loadImage(String path) async {
    // Simulate a slight delay for image loading
    if (path.isNotEmpty) {
      _imageHost.sendImage(path);
    }
    return await File(path);
  }

  // Map<String, dynamic> initialData = {};
  // Map<String, dynamic> ratioData = {};
  // Map<String, dynamic> dathealthData = {};
  // Map<String, dynamic> conclusionData = {};

  // Future<void> _dataimagePrompt() async {
  //   try {
  //     // Execute all prompts concurrently using Future.wait
  //     List<void> results = await Future.wait([
  //       promptBuilder.promptExecution((p0) {
  //         setState(() {
  //           initialData = p0;
  //         });
  //       }, PromptEvent.initialPrompt),
  //       promptBuilder.promptExecution((p0) {
  //         setState(() {
  //           ratioData = p0;
  //         });
  //       }, PromptEvent.initialPrompt),
  //       promptBuilder.promptExecution((p0) {
  //         setState(() {
  //           dathealthData = p0;
  //         });
  //       }, PromptEvent.initialPrompt),
  //       promptBuilder.promptExecution((p0) {
  //         setState(() {
  //           conclusionData = p0;
  //         });
  //       }, PromptEvent.initialPrompt),
  //     ]);
  //   } catch (e) {
  //     print('Fetch data failed: $e');
  //   }
  // }

  AuthController _auth = new AuthController();
  XFile _image = XFile("");
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _auth,
        builder: (ctrl) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Gap(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          await ctrl.onCameraOpen(
                            (_imageXfile, isTaken) {
                              if (isTaken) {
                                setState(() {
                                  _image = _imageXfile;
                                });
                              }
                            },
                          );
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(137, 209, 209, 209)),
                          child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(221, 165, 165, 165),
                            child: Icon(
                              Icons.camera,
                              color: const Color.fromARGB(255, 113, 113, 113),
                            ),
                          ),
                        ),
                      ),
                      FutureBuilder<File>(
                        future: _loadImage(_image.path),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // Show loading indicator while waiting
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            // Handle error
                            return Center(child: Text('Error loading image'));
                          } else if (snapshot.hasData &&
                              snapshot.data!.path.isNotEmpty) {
                            // Show the image when loaded
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(snapshot.data!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            // Show placeholder if no image found
                            return Center(child: Text('No Image Selected'));
                          }
                        },
                      ),
                    ],
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ctrl.login(
                          _usernameController.text, _passwordController.text);
                    },
                    child: Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ctrl.dataimagePrompt(
                          _usernameController.text, _passwordController.text);
                    },
                    child: Text('Fetch Data'),
                  ),
                  Obx(() => Text(ctrl.initialData.toString())),
                  Obx(() => Text(ctrl.ratrioData.toString())),
                  Obx(() => Text(ctrl.healthData.toString())),
                  Obx(() => Text(ctrl.conclusionData.toString())),
                ],
              ),
            ),
          );
        });
  }
}

    // initial_prompt ="/initialPrompt"
    // ratio_prompt = "/ratioPrompt"
    // health_prompt = "/healthPrompt"
    // conclusion_prompt ="/conclusionPrompt"
    // check_Server = "/checkServerRunning"
  