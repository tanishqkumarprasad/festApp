import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CloudinaryService {
  final String _cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
  final String _uploadPreset = dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? '';

  Future<String?> uploadToCloudinary(File file, String folderName) async {
    print('\n=============================================');
    print('☁️ CLOUDINARY UPLOAD DEBUG START');
    print('=============================================');

    // 1. Check if the .env file loaded correctly
    print('🔍 Checking Credentials:');
    print('   -> Cloud Name: "$_cloudName"');
    print('   -> Upload Preset: "$_uploadPreset"');

    if (_cloudName.isEmpty || _uploadPreset.isEmpty) {
      print('🛑 FATAL ERROR: Credentials are empty!');
      print('   Fix: Ensure your .env file is in the root folder, contains these keys, and is added to pubspec.yaml under assets.');
      return null;
    }

    // 2. Log file and folder details
    print('📁 File Details:');
    print('   -> File Path: ${file.path}');
    print('   -> Target Folder: $folderName');

    try {
      final url = Uri.parse('https://api.cloudinary.com/v1_1/$_cloudName/auto/upload');
      print('🌐 Request URL: $url');

      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = _uploadPreset
        ..fields['folder'] = folderName
        ..files.add(await http.MultipartFile.fromPath('file', file.path));

      print('🚀 Sending request to Cloudinary...');

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      // 3. Log the exact response from Cloudinary
      print('📥 Response Status Code: ${response.statusCode}');
      print('📜 Response Body (RAW):');
      print(responseData);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(responseData);
        print('✅ SUCCESS! Secure URL: ${jsonResponse['secure_url']}');
        print('=============================================\n');
        return jsonResponse['secure_url'];
      } else {
        print('🛑 UPLOAD REJECTED BY CLOUDINARY');
        print('=============================================\n');
        return null;
      }
    } catch (e) {
      print('🛑 APP CRASH DURING UPLOAD: $e');
      print('=============================================\n');
      return null;
    }
  }
}