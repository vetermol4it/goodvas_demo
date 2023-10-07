import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodvas_demo/features/whats_new/cubit/whats_new_cubit.dart';
import 'package:goodvas_demo/features/whats_new/cubit/whats_new_state.dart';
import 'package:goodvas_demo/ui_kit/app_colors.dart';

class WhatsNewProgressIndicator extends StatefulWidget {
  const WhatsNewProgressIndicator({
    required this.slidesCount,
    required this.currentSlideIndex,
    super.key,
  });

  final int slidesCount;
  final int currentSlideIndex;

  @override
  State<WhatsNewProgressIndicator> createState() => _WhatsNewProgressIndicatorState();
}

class _WhatsNewProgressIndicatorState extends State<WhatsNewProgressIndicator>
    with SingleTickerProviderStateMixin {
  static const _animationDuration = Duration(seconds: 7);

  late final _animationController = AnimationController(
    vsync: this,
    duration: _animationDuration,
  );

  @override
  void initState() {
    super.initState();
    _animationController
      ..reset()
      ..animateTo(1)
      ..addListener(_animationControllerListener);
  }

  @override
  void dispose() {
    _animationController
      ..removeListener(_animationControllerListener)
      ..dispose();
    super.dispose();
  }

  void _animationControllerListener() {
    if (_animationController.isCompleted) {
      context.read<WhatsNewCubit>().nextSlide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WhatsNewCubit, WhatsNewState>(
      listener: (context, state) {
        if (state is PauseWhatsNewState) {
          _animationController.stop();
        }
        if (state is ResumeWhatsNewState) {
          _animationController.animateTo(1);
        }
        if (state is ShowSlideWhatsNewState) {
          _animationController
            ..reset()
            ..animateTo(1);
        }
      },
      child: Row(
        children: List.generate(
          widget.slidesCount,
          (index) {
            if (index == widget.currentSlideIndex) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index < widget.slidesCount ? 4 : 0),
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, _) {
                      return LinearProgressIndicator(
                        value: _animationController.value,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.progressWhite),
                        backgroundColor: AppColors.progressWhite.withOpacity(0.2),
                      );
                    },
                  ),
                ),
              );
            }

            return Expanded(
              child: Container(
                width: double.maxFinite,
                height: 4,
                margin: EdgeInsets.only(right: index < widget.slidesCount ? 4 : 0),
                decoration: BoxDecoration(
                  color: widget.currentSlideIndex > index
                      ? AppColors.progressWhite
                      : AppColors.progressWhite.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
