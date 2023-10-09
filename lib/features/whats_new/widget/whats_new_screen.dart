import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodvas_demo/di/get_it.dart';
import 'package:goodvas_demo/features/whats_new/cubit/whats_new_cubit.dart';
import 'package:goodvas_demo/features/whats_new/cubit/whats_new_state.dart';
import 'package:goodvas_demo/features/whats_new/model/whats_new_slide_model.dart';
import 'package:goodvas_demo/features/whats_new/widget/whats_new_progress_indicator.dart';
import 'package:goodvas_demo/ui_kit/app_text_style.dart';

class WhatsNewScreen extends StatelessWidget {
  const WhatsNewScreen({super.key});

  static const _animationDuration = Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => getIt<WhatsNewCubit>(),
        child: BlocConsumer<WhatsNewCubit, WhatsNewState>(
            listener: (_, state) {},
            buildWhen: (prevState, currentState) => currentState is ShowSlideWhatsNewState,
            builder: (context, state) {
              if (state is ShowSlideWhatsNewState) {
                final currentSlide = state.slides[state.slideNumber];

                return GestureDetector(
                  onTapUp: (details) {
                    if (details.localPosition.direction > 1.0) {
                      context.read<WhatsNewCubit>().prevSlide();
                    }
                    if (details.localPosition.direction < 1.0) {
                      if (state.slideNumber == state.slides.length - 1) {
                        _closeApp();
                      } else {
                        context.read<WhatsNewCubit>().nextSlide();
                      }
                    }
                  },
                  onLongPressStart: (_) {
                    context.read<WhatsNewCubit>().pause();
                  },
                  onLongPressEnd: (_) {
                    context.read<WhatsNewCubit>().resume();
                  },
                  child: AnimatedContainer(
                    duration: _animationDuration,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: List.generate(
                          currentSlide.colorsValues.length,
                          (index) => Color(currentSlide.colorsValues[index]),
                        ),
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 30,
                              right: 10,
                              top: 10,
                            ),
                            child: Row(
                              children: [
                                const Expanded(child: WhatsNewProgressIndicator()),
                                const SizedBox(width: 10),
                                _CloseButton(
                                  onTap: _closeApp,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          _ImagesPageView(slides: state.slides),
                          const Spacer(),
                          _Title(text: currentSlide.title),
                          if (currentSlide.subtitle == null &&
                              currentSlide.functionalElements.isEmpty)
                            const SizedBox(height: 96),
                          _Subtitle(text: currentSlide.subtitle),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }

  void _closeApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else {
      exit(0);
    }
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 32,
        height: 32,
        child: SvgPicture.asset(
          'assets/icons/close.svg',
        ),
      ),
    );
  }
}

class _ImagesPageView extends StatefulWidget {
  const _ImagesPageView({
    required this.slides,
  });

  final List<WhatsNewSlideModel> slides;

  @override
  State<_ImagesPageView> createState() => _ImagesPageViewState();
}

class _ImagesPageViewState extends State<_ImagesPageView> {
  static const _animationDuration = Duration(seconds: 1);

  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WhatsNewCubit, WhatsNewState>(
      listener: (_, state) {
        if (state is ShowSlideWhatsNewState) {
          _controller.animateToPage(
            state.slideNumber,
            duration: _animationDuration,
            curve: Curves.linear,
          );
        }
      },
      child: SizedBox(
        height: 311,
        child: PageView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            widget.slides.length,
            (index) => Image.asset(
              widget.slides[index].imagePath,
              height: 311,
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.text,
  });

  static const _animationDuration = Duration(milliseconds: 500);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: AnimatedSwitcher(
        duration: _animationDuration,
        child: Text(
          key: ValueKey(text),
          text,
          textAlign: TextAlign.left,
          style: AppTextStyle.title,
        ),
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle({
    this.text,
  });

  static const _animationDuration = Duration(milliseconds: 500);

  final String? text;

  @override
  Widget build(BuildContext context) {
    final textVar = text;
    if (textVar != null) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 13,
          left: 32,
          right: 32,
          bottom: 20,
        ),
        child: AnimatedSwitcher(
          duration: _animationDuration,
          child: Text(
            key: ValueKey(text),
            textVar,
            textAlign: TextAlign.left,
            style: AppTextStyle.body,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
