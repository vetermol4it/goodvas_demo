import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        child: BlocBuilder<WhatsNewCubit, WhatsNewState>(
            buildWhen: (prevState, currentState) => currentState is ShowSlideWhatsNewState,
            builder: (context, state) {
              if (state is ShowSlideWhatsNewState) {
                final currentSlide = state.slides[state.slideNumber];
                final subtitle = currentSlide.subtitle;

                return AnimatedContainer(
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
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: WhatsNewProgressIndicator(),
                        ),
                        const SizedBox(height: 29),
                        _ImagesPageView(slides: state.slides),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: AnimatedSwitcher(
                            duration: _animationDuration,
                            child: Text(
                              key: ValueKey(state.slideNumber),
                              currentSlide.title,
                              style: AppTextStyle.title,
                            ),
                          ),
                        ),
                        if (subtitle == null && currentSlide.functionalElements.isEmpty)
                          const SizedBox(height: 96),
                        if (subtitle != null)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 13,
                              left: 32,
                              right: 32,
                              bottom: 20,
                            ),
                            child: AnimatedSwitcher(
                              duration: _animationDuration,
                              child: Text(
                                key: ValueKey(state.slideNumber),
                                subtitle,
                                style: AppTextStyle.body,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
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
  static const _animationDuration = Duration(milliseconds: 500);

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
      child: PageView(
        controller: _controller,
        children: List.generate(
          widget.slides.length,
          (index) => Image.asset(widget.slides[index].imagePath),
        ),
      ),
    );
  }
}
