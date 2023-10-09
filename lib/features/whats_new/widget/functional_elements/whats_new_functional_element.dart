import 'package:flutter/material.dart';
import 'package:goodvas_demo/features/whats_new/model/functional_element_type.dart';
import 'package:goodvas_demo/features/whats_new/widget/functional_elements/whats_new_like_dislike_buttons.dart';

class WhatsNewFunctionalElement extends StatelessWidget {
  const WhatsNewFunctionalElement.fromType({
    required this.type,
    super.key,
  });

  final FunctionalElementType type;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      FunctionalElementType.likeDislikeButtons => const WhatsNewLikeDislikeButtons(),
    };
  }
}
