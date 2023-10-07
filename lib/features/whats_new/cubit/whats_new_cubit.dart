import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodvas_demo/features/whats_new/cubit/whats_new_state.dart';
import 'package:goodvas_demo/features/whats_new/model/whats_new_slide_model.dart';
import 'package:goodvas_demo/features/whats_new/repository/base_whats_new_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class WhatsNewCubit extends Cubit<WhatsNewState> {
  WhatsNewCubit(BaseWhatsNewRepository repository)
      : slides = repository.getSlides(),
        super(ShowSlideWhatsNewState(0));

  final List<WhatsNewSlideModel> slides;

  int _currentSlide = 0;

  void nextSlide() {
    if (_currentSlide == slides.length - 1) {
      emit(FinishWhatsNewState());
    } else {
      _currentSlide++;
      emit(ShowSlideWhatsNewState(_currentSlide));
    }
  }

  void prevSlide() {
    if (_currentSlide > 0) {
      _currentSlide--;
    }

    emit(ShowSlideWhatsNewState(_currentSlide));
  }

  void pause() {
    emit(PauseWhatsNewState());
  }

  void resume() {
    emit(ResumeWhatsNewState());
  }
}
