import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tt_28/core/app_fonts.dart';
import 'package:tt_28/core/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              const _AppBar(),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: AppColors.secondary),
                child: Column(
                  children: [
                    _SettingsItem(
                      title: 'Contact us',
                      onTap: () {},
                    ),
                    _SettingsItem(
                      title: 'Rate us',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: AppColors.secondary),
                child: Column(
                  children: [
                    _SettingsItem(
                      title: 'Privacy Policy',
                      onTap: () {},
                    ),
                    _SettingsItem(
                      title: 'Terms of Use',
                      onTap: () {},
                    ),
                    _SettingsItem(
                      title: 'Application version',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final String title;
  final Function onTap;
  const _SettingsItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        onTap();
      },
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppFonts.titleSmall.copyWith(color: AppColors.onPrimary),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: AppColors.primary,
            )
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          highlightColor: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          child: const Icon(
            Icons.close,
            color: Colors.white,
            size: 20,
          ),
        ),
        Text(
          'Settings',
          style: AppFonts.titleLarge.copyWith(
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }
}
