import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodvas_demo/features/whats_new/cubit/whats_new_cubit.dart';
import 'package:goodvas_demo/ui_kit/app_colors.dart';

class WhatsNewLikeDislikeButtons extends StatelessWidget {
  const WhatsNewLikeDislikeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: Row(
        children: [
          Expanded(
            child: _Button(
              icon: SvgPicture.asset(
                'assets/icons/dislike.svg',
              ),
              onTap: () {
                context.read<WhatsNewCubit>().nextSlide();
              },
            ),
          ),
          const SizedBox(width: 17),
          Expanded(
            child: _Button(
              icon: SvgPicture.asset(
                'assets/icons/like.svg',
              ),
              onTap: () {
                context.read<WhatsNewCubit>().nextSlide();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.icon,
    required this.onTap,
  });

  final SvgPicture icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: double.maxFinite,
          height: 54,
          decoration: ShapeDecoration(
            color: AppColors.buttonPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Center(
            child: icon,
          )),
    );
  }
}
