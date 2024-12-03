import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:forest_tinker_live/components/custom_button.dart';
import 'package:forest_tinker_live/core/app_fonts.dart';
import 'package:forest_tinker_live/core/colors.dart';
import 'package:forest_tinker_live/features/onb/onb_pages/onb_page_widget.dart';
import 'package:forest_tinker_live/features/parent_screen/parent_screen.dart';

class Onb extends StatefulWidget {
  const Onb({super.key});

  @override
  State<Onb> createState() => _OnbState();
}

class _OnbState extends State<Onb> {
  late PageController _onbPageController;
  bool isLastPage = false;
  @override
  void initState() {
    _onbPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _onbPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            'assets/images/onb-back.png',
          ),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: PageView(
                controller: _onbPageController,
                onPageChanged: (index) {
                  setState(() => isLastPage = index == 2);
                },
                children: const [
                  OnbPageWidget(
                    image: 'assets/images/onb1.png',
                    title: 'Fuel your goals with smart meal planning',
                  ),
                  OnbPageWidget(
                    image: 'assets/images/onb2.png',
                    title:
                        'Fuel your goals with smart meal planning\nOrganize your diet, control calories, and enjoy cooking ',
                  ),
                  OnbPageWidget(
                    image: 'assets/images/onb3.png',
                    title: 'Plan, track, and enjoy every meal',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                title: 'Continue',
                borderRadius: BorderRadius.circular(12),
                highlightColor: AppColors.onPrimary.withOpacity(0.5),
                backgroundColor: AppColors.primary,
                titleStyle:
                    AppFonts.headlineMedium.copyWith(color: Colors.white),
                onTap: () {
                  if (isLastPage) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const ParentScreen()),
                        (_) => false);
                  }
                  _onbPageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
