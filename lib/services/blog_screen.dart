import 'package:flutter/material.dart';

class BlogScreenConstantProvider extends ChangeNotifier {
  Color bottomCoverColor = Color(0xffb03fa8);
  String profileDescription = 'i want to finish this project';
  String blogTitle = 'EsraaGamal';
  Color accent= Color(0xffffff00);


  void setBottomColor(Color bottomColor) {
    bottomCoverColor = bottomColor;
    notifyListeners();
  }

  Color getBottomColor() {
    return bottomCoverColor;
  }

  void setBlogDescription(String description) {
    profileDescription = description;
    notifyListeners();
  }

  String getDescription() {
    return profileDescription;
  }
   void setTitle(String title) {
    blogTitle =title;
    notifyListeners();
  }

  String getTitle() {
    return blogTitle;
  }
   void setaccent(Color accentcolor) {
    accent= accentcolor;
    notifyListeners();
  }

  Color geaccentColor() {
    return accent;
  }
  

}
