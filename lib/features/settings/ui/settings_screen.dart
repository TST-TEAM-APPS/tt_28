import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:forest_tinker_live/core/app_fonts.dart';
import 'package:forest_tinker_live/core/colors.dart';
import 'package:forest_tinker_live/core/services/mixins/config_mixin.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with MainConfig {
  void _support() => FlutterEmailSender.send(Email(
      recipients: ['timabakin1991@icloud.com'],
      body: '[We will check your message as soon as possible]'));

  void _showDocs({
    required BuildContext context,
    required String url,
  }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoPopupSurface(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            color: Colors.white,
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  Expanded(
                    child: WebViewWidget(
                      controller: WebViewController()
                        ..loadRequest(
                          Uri.parse(url),
                        ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    child: _DoneButton(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void _showVersion(BuildContext context) {
    final appInfo = AppInfo.of(context);

    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
        title: Text(
          appInfo.package.appName,
          style: const TextStyle(color: CupertinoColors.black),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/icon.png',
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Version: ${appInfo.package.version.major}.${appInfo.package.version.minor}.${appInfo.package.version.patch}',
              style: const TextStyle(color: CupertinoColors.black),
            ),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: Navigator.of(context).pop,
            child: Text(
              'OK',
              style:
                  const TextStyle().copyWith(color: CupertinoColors.activeBlue),
            ),
          ),
        ],
      ),
    );
  }

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
                      icon: Icons.settings_accessibility,
                      title: 'Support',
                      onTap: _support,
                    ),
                    _SettingsItem(
                      icon: Icons.rate_review_outlined,
                      title: 'Rate us',
                      onTap: InAppReview.instance.requestReview,
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
                      icon: Icons.edit_document,
                      title: 'Privacy Policy',
                      onTap: () => _showDocs(context: context, url: privacy),
                    ),
                    _SettingsItem(
                      icon: Icons.rule_sharp,
                      title: 'Terms of Use',
                      onTap: () => _showDocs(context: context, url: terms),
                    ),
                    _SettingsItem(
                      icon: Icons.app_settings_alt_outlined,
                      title: 'Application version',
                      onTap: () => _showVersion(context),
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
  final VoidCallback onTap;
  final IconData icon;
  const _SettingsItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      child: SizedBox(
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 30),
            Text(
              title,
              style: AppFonts.titleSmall.copyWith(color: AppColors.onPrimary),
            ),
            const Spacer(), 
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

class _DoneButton extends StatelessWidget {
  const _DoneButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: Navigator.of(context).pop,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CupertinoColors.lightBackgroundGray),
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: const Center(
          child: Text(
            'Done',
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
        ),
      ),
    );
  }
}
