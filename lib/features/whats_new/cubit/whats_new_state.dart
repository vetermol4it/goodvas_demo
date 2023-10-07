import 'package:equatable/equatable.dart';

abstract class WhatsNewState extends Equatable {
  @override
  List<Object> get props => [];
}

class ShowSlideWhatsNewState extends WhatsNewState {
  final int slideNumber;

  ShowSlideWhatsNewState(this.slideNumber);

  @override
  List<Object> get props => [slideNumber];
}

class FinishWhatsNewState extends WhatsNewState {}

class PauseWhatsNewState extends WhatsNewState {}

class ResumeWhatsNewState extends WhatsNewState {}
