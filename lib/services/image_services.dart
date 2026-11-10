import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageServices {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source, imageQuality: 90);
    if (picked == null) return null;
    return File(picked.path);
  }
}