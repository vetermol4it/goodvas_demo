import 'package:goodvas_demo/features/whats_new/model/functional_element_type.dart';

class WhatsNewSlideModel {
  final String imagePath;
  final List<int> colorsValues;
  final String title;
  final String? subtitle;
  final List<FunctionalElementType> functionalElements;

  WhatsNewSlideModel({
    required this.imagePath,
    required List<int> colorsValues,
    required this.title,
    this.subtitle,
    List<FunctionalElementType>? functionalElements,
  })  : colorsValues = colorsValues.length == 1 ? [colorsValues[0], colorsValues[0]] : colorsValues,
        functionalElements = functionalElements ?? [];
}
