import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodvas_demo/features/whats_new/cubit/whats_new_state.dart';
import 'package:goodvas_demo/features/whats_new/model/whats_new_slide_model.dart';
import 'package:goodvas_demo/features/whats_new/repository/base_whats_new_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class WhatsNewCubit extends Cubit<WhatsNewState> {
  WhatsNewCubit(this._repository) : super(InitialWhatsNewState()) {
    _init();
  }

  final BaseWhatsNewRepository _repository;
  late final List<WhatsNewSlideModel> _slides;

  int _currentSlide = 0;

  void _init() {
    _slides = _repository.getSlides();
    emit(ShowSlideWhatsNewState(slides: _slides, slideNumber: 0));
  }

  void nextSlide() {
    if (_currentSlide < _slides.length - 1) {
      _currentSlide++;
      emit(ShowSlideWhatsNewState(slides: _slides, slideNumber: _currentSlide));
    }
  }

  void prevSlide() {
    if (_currentSlide > 0) {
      _currentSlide--;
      emit(ShowSlideWhatsNewState(slides: _slides, slideNumber: _currentSlide));
    } else {
      emit(RestartWhatsNewState(slides: _slides));
    }
  }

  void pause() {
    emit(PauseWhatsNewState());
  }

  void resume() {
    emit(ResumeWhatsNewState());
  }
}
