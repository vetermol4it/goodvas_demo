import 'package:goodvas_demo/features/whats_new/model/functional_element_type.dart';
import 'package:goodvas_demo/features/whats_new/model/whats_new_slide_model.dart';
import 'package:goodvas_demo/features/whats_new/repository/base_whats_new_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BaseWhatsNewRepository)
class WhatsNewRepository implements BaseWhatsNewRepository {
  @override
  List<WhatsNewSlideModel> getSlides() => [
        WhatsNewSlideModel(
          imagePath: 'assets/images/slide0.png',
          title: 'Нам важно ваше мнение! Оцените изменения в Simpler',
        ),
        WhatsNewSlideModel(
          imagePath: 'assets/images/slide1.png',
          title: 'Включите тёмную тему',
          subtitle:
              'Занимайтесь английским даже ночью или просто посмотрите как изменится ваш интерфейс!',
          functionalElements: [FunctionalElementType.likeDislikeButtons],
        ),
        WhatsNewSlideModel(
          imagePath: 'assets/images/slide2.png',
          title: 'Соревнуйтесь в рейтинге космонавтов',
          subtitle:
              'Зарабатывайте очки и продвигайтесь к вершине! Займите место в ракете и изучите новые созвездия',
          functionalElements: [FunctionalElementType.likeDislikeButtons],
        ),
        WhatsNewSlideModel(
          imagePath: 'assets/images/slide3.png',
          title: 'Раскройте преступления и станьте комиссаром',
          subtitle:
              'Обновлённые детективные истории дают вам новый опыт в расследовании детективных дел',
          functionalElements: [FunctionalElementType.likeDislikeButtons],
        ),
        WhatsNewSlideModel(
          imagePath: 'assets/images/slide4.png',
          title: 'Тренируйте язык с помощью новых заданий',
          subtitle:
              'Чем больше уроков вы пройдёте, тем больше уникальных заданий станет доступно для тренировки ваших навыков',
          functionalElements: [FunctionalElementType.likeDislikeButtons],
        ),
      ];
}