import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class PickImageHelper {
  late final ImagePicker _picker;
  final Function(PlatformException) error;
  PickImageHelper({
    required this.error,
  }) {
    _picker = ImagePicker();
  }

  Future<XFile?> pick(ImageSource source) async {
    XFile? image;
    try {
      if (source == ImageSource.camera) {
        image = await _picker.pickImage(source: ImageSource.camera);
      } else if (source == ImageSource.gallery) {
        image = await _picker.pickImage(source: ImageSource.gallery);
      }
    } on PlatformException catch (e) {
      error.call(e);
    }
    return image;
  }
}
