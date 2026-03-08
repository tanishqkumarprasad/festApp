import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CloudinaryService {
  final String _cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
  final String _uploadPreset = dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? '';

  Future<String?> uploadToCloudinary(File file, String folderName) async {

    if (_cloudName.isEmpty || _uploadPreset.isEmpty) {
      return null;
    }

    try {
      final url = Uri.parse('https://api.cloudinary.com/v1_1/$_cloudName/auto/upload');

      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = _uploadPreset
        ..fields['folder'] = folderName
        ..files.add(await http.MultipartFile.fromPath('file', file.path));

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(responseData);
        return jsonResponse['secure_url'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}