import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();
  final Uuid _uuid = Uuid();
  
  // Pick an image from gallery
  Future<File?> pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 85,
    );
    
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    
    return null;
  }
  
  // Take a photo with camera
  Future<File?> takePhoto() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 85,
    );
    
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    
    return null;
  }
  
  // Save image to app directory and return the path
  Future<String> saveImage(File imageFile) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String imagesDir = path.join(appDir.path, 'chatmate_images');
    
    // Create the directory if it doesn't exist
    await Directory(imagesDir).create(recursive: true);
    
    // Generate a unique filename
    final String fileName = '${_uuid.v4()}.jpg';
    final String filePath = path.join(imagesDir, fileName);
    
    // Copy the image to the app directory
    await imageFile.copy(filePath);
    
    return filePath;
  }
  
  // Get a sample image for the AI character (for testing)
  Future<String> getSampleImage(int index) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String imagesDir = path.join(appDir.path, 'chatmate_sample_images');
    
    // Create the directory if it doesn't exist
    await Directory(imagesDir).create(recursive: true);
    
    // Sample image paths (these would be bundled with the app)
    final String fileName = 'sample_${index % 5}.jpg';
    final String filePath = path.join(imagesDir, fileName);
    
    // For a real implementation, we would include sample images in the assets
    // and copy them to the app directory on first run
    
    // For now, we'll just return the path and handle the case where the file doesn't exist
    return filePath;
  }
  
  // Delete an image
  Future<void> deleteImage(String imagePath) async {
    final File file = File(imagePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
