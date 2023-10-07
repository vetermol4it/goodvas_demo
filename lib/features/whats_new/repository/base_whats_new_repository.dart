import 'package:goodvas_demo/features/whats_new/model/whats_new_slide_model.dart';

abstract interface class BaseWhatsNewRepository {
  List<WhatsNewSlideModel> getSlides();
}
