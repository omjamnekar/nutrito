import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:moke_app/util/urls/python_Serv.dart';

class ImageHost extends GetxController {
  Future<void> sendImage(String _imagePath) async {
    // Read the image file as bytes

    File imageFile = File(_imagePath);
    List<int> imageBytes = await imageFile.readAsBytes();

    // Create the request
    var url = Uri.parse(URLS.imageToBase64Host);
    var request = http.MultipartRequest('POST', url);

    // Add the image to the request body
    var imagePart = http.MultipartFile.fromBytes(
      'image',
      imageBytes,
      filename: 'image.jpg',
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(imagePart);

    // Send the request and get the response
    var response = await request.send();

    // handleResponse(response);
    var responseText = await response.stream.bytesToString();

    // Check for successful response
    if (response.statusCode == 200) {
      try {
        // Parse JSON response
        var jsonData = jsonDecode(responseText);

        if (jsonData['status'] == 'Ok') {
          // Extract Base64 string from the 'url' field
          String base64Image = jsonData['url'];

          // Debug: Print the full response and Base64 string
          print('Full response: $jsonData');
          print('Extracted Base64 string: $base64Image');

          // Check if the string is a valid data URL
          if (base64Image.startsWith('data:image/')) {
            // Extract the Base64 part
            String base64String = base64Image.split(',')[1];

            // Debug: Print the Base64 string before decoding
            print('Base64 part: $base64String');

            // Decode the Base64 string to bytes
            var imageBytes = base64Decode(base64String);

            // Successfully decoded image data
            print('Successfully decoded image.');
          } else {
            print('Invalid image format in the response.');
          }
        } else {
          print('Server returned status: ${jsonData['status']}');
        }
      } catch (e) {
        // Handle parsing or decoding errors
        print('Error: $e');
        print('Response text: $responseText');
      }
    } else {
      // Handle error response
      print('Error: ${response.statusCode}');
      print('Response body: $responseText');
    }
  }

  void handleResponse(http.StreamedResponse response) async {
    // Read the response as a string
    var responseText = await response.stream.bytesToString();

    // Print response headers for debugging
    print('Response Headers: ${response.headers}');

    // Check for successful response
    if (response.statusCode == 200) {
      // Print the raw response text for debugging
      print('Raw Response: $responseText');

      // Check the content type of the response
      var contentType = response.headers['content-type'];

      if (contentType != null && contentType.contains('application/json')) {
        // Parse JSON if applicable
        try {
          var jsonData = jsonDecode(responseText);
          print(jsonData);
        } catch (e) {
          print('Error parsing JSON: $e');
        }
      } else if (contentType != null && contentType.contains('image')) {
        // Handle base64-encoded image
        if (responseText.startsWith('data:image/')) {
          var base64String = responseText.split(',')[1]; // Extract base64 part
          print('Base64 Image Data: $base64String');
          // You can now decode the base64 string and handle the image
        } else {
          print('Invalid image data');
        }
      } else {
        // Handle other types of data (like plain text)
        print('Received data: $responseText');
      }
    } else {
      // Handle errors
      print('Error: ${response.statusCode}');
      print('Response body: $responseText');
    }
  }
}
