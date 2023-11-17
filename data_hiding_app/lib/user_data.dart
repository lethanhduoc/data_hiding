import 'dart:io';

import 'package:flutter/foundation.dart';

class UserData extends ChangeNotifier {
  String username = '';
  String content = '';
  File? images;

  void setUserData(String newUsername, File? newImages, String newContent) {
    content = newContent;
    username = newUsername;
    images = newImages;
    notifyListeners();
  }
}
