import 'package:goodvas_demo/features/whats_new/model/functional_element_type.dart';

class WhatsNewSlideModel {
  final String imagePath;
  final String title;
  final String? subtitle;
  final List<FunctionalElementType> functionalElements;

  WhatsNewSlideModel({
    required this.imagePath,
    required this.title,
    this.subtitle,
    List<FunctionalElementType>? functionalElements,
  }) : functionalElements = functionalElements ?? [];
}
