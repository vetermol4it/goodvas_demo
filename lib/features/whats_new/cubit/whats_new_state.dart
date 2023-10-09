import 'package:equatable/equatable.dart';
import 'package:goodvas_demo/features/whats_new/model/whats_new_slide_model.dart';

abstract class WhatsNewState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialWhatsNewState extends WhatsNewState {}

class ShowSlideWhatsNewState extends WhatsNewState {
  final int slideNumber;
  final List<WhatsNewSlideModel> slides;

  ShowSlideWhatsNewState({
    required this.slides,
    required this.slideNumber,
  });

  @override
  List<Object> get props => [slideNumber, slides];
}

class RestartWhatsNewState extends ShowSlideWhatsNewState {
  RestartWhatsNewState({required super.slides}) : super(slideNumber: 0);
}

class PauseWhatsNewState extends WhatsNewState {}

class ResumeWhatsNewState extends WhatsNewState {}
