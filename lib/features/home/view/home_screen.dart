import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:forest_tinker_live/components/custom_current_date_widget.dart';
import 'package:forest_tinker_live/core/app_fonts.dart';
import 'package:forest_tinker_live/core/colors.dart';
import 'package:forest_tinker_live/features/home/model/food_model.dart';
import 'package:forest_tinker_live/features/home/model/water_model.dart';
import 'package:forest_tinker_live/features/home/view/home_screen_details.dart';
import 'package:forest_tinker_live/features/home/view_model/food_view_model.dart';
import 'package:forest_tinker_live/features/settings/ui/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<FoodViewModel>();
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              const _AppBar(),
              const _StatisticWidget(),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      tabIndex = 0;
                      setState(() {});
                    },
                    borderRadius: BorderRadius.circular(10),
                    highlightColor: Colors.white.withOpacity(0.5),
                    child: Container(
                      width: 100,
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Text(
                            'Food',
                            style: AppFonts.titleLarge.copyWith(
                              color: tabIndex == 0
                                  ? AppColors.primary
                                  : AppColors.primaryFixed,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Container(
                              height: 1,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: tabIndex == 0
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      tabIndex = 1;
                      setState(() {});
                    },
                    borderRadius: BorderRadius.circular(10),
                    highlightColor: Colors.white.withOpacity(0.5),
                    child: Container(
                      width: 100,
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Text(
                            'Water',
                            style: AppFonts.titleLarge.copyWith(
                              color: tabIndex == 1
                                  ? AppColors.primary
                                  : AppColors.primaryFixed,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Container(
                              height: 1,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: tabIndex == 1
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.secondary,
                  ),
                  child: tabIndex == 0
                      ? const _MealList()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${0.25 * model.state.totalGlass} L',
                                  style: AppFonts.titleLarge
                                      .copyWith(color: Colors.white),
                                ),
                                Row(
                                  children: [
                                    Material(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(6),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(6),
                                        highlightColor:
                                            Colors.white.withOpacity(0.5),
                                        onTap: () {
                                          model.onWaterAdded(
                                            WaterModel(
                                                createdDate:
                                                    model.state.currentDateTime,
                                                quantity: 1),
                                          );
                                        },
                                        child: Container(
                                          height: 32,
                                          width: 32,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: Colors.transparent,
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Material(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(6),
                                        highlightColor:
                                            Colors.white.withOpacity(0.5),
                                        onTap: () {
                                          model.onWaterRemoved();
                                        },
                                        child: Container(
                                          height: 32,
                                          width: 32,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: AppColors.primary,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: Colors.transparent,
                                          ),
                                          child: const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            GlassWidget(
                              filledGlasses: model.state.totalGlass,
                            ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 19),
                            //   child: Center(
                            //     child: Wrap(
                            //       crossAxisAlignment: WrapCrossAlignment.center,
                            //       spacing: 16,
                            //       runSpacing: 25,
                            //       alignment: WrapAlignment.end,
                            //       children: [
                            //         Image.asset(
                            //           'assets/icons/glass.png',
                            //           width: 50,
                            //           height: 50,
                            //           fit: BoxFit.cover,
                            //         ),
                            //         Image.asset(
                            //           'assets/icons/glass.png',
                            //           width: 50,
                            //           height: 50,
                            //           fit: BoxFit.cover,
                            //         ),
                            //         Image.asset(
                            //           'assets/icons/glass.png',
                            //           width: 50,
                            //           height: 50,
                            //           fit: BoxFit.cover,
                            //         ),
                            //         Image.asset(
                            //           'assets/icons/glass.png',
                            //           width: 50,
                            //           height: 50,
                            //           fit: BoxFit.cover,
                            //         ),
                            //         Image.asset(
                            //           'assets/icons/glass.png',
                            //           width: 50,
                            //           height: 50,
                            //           fit: BoxFit.cover,
                            //         ),
                            //         Image.asset(
                            //           'assets/icons/glass.png',
                            //           width: 50,
                            //           height: 50,
                            //           fit: BoxFit.cover,
                            //         ),
                            //         Image.asset(
                            //           'assets/icons/glass.png',
                            //           width: 50,
                            //           height: 50,
                            //           fit: BoxFit.cover,
                            //         ),
                            //         Image.asset(
                            //           'assets/icons/glass.png',
                            //           width: 50,
                            //           height: 50,
                            //           fit: BoxFit.cover,
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // )
                          ],
                        ))
            ],
          ),
        ),
      ),
    ));
  }
}

class GlassWidget extends StatelessWidget {
  final int filledGlasses;

  const GlassWidget({Key? key, required this.filledGlasses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int displayCount = filledGlasses.clamp(0, 8);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 8,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
          ),
          itemBuilder: (context, index) {
            bool isFilled = index < displayCount;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              width: 24,
              height: 24,
              child: Image.asset(
                'assets/icons/glass.png',
                color: isFilled ? AppColors.primary : AppColors.primaryFixed,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _MealList extends StatefulWidget {
  const _MealList();

  @override
  State<_MealList> createState() => _MealListState();
}

class _MealListState extends State<_MealList> {
  List<FoodType> foodType = [
    FoodType.breakfast,
    FoodType.lunch,
    FoodType.dinner,
    FoodType.snack,
  ];

  List<String> foodTypeString = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];

  @override
  Widget build(BuildContext context) {
    final model = context.watch<FoodViewModel>();
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final List<double> calories = [
          model.state.breakfastCalories,
          model.state.lunchCalories,
          model.state.dinnerCalories,
          model.state.snackCalories,
        ];
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foodTypeString[index],
                  style: AppFonts.titleLarge.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${calories[index].toInt()} Kcal',
                  style: AppFonts.titleSmall.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
              ],
            ),
            Material(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(6),
              child: InkWell(
                borderRadius: BorderRadius.circular(6),
                highlightColor: Colors.white.withOpacity(0.5),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                            create: (context) {
                              final viewModel = FoodViewModel();
                              viewModel
                                  .onUpdatedDate(model.state.currentDateTime);
                              return viewModel;
                            },
                            child: HomeScreenDetails(
                              foodType: foodType[index],
                              foodViewModel: model,
                              currentDateTime: model.state.currentDateTime,
                            )),
                      ));
                },
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.transparent,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            const SizedBox(
              height: 13,
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: AppColors.primaryFixed,
            ),
            const SizedBox(
              height: 13,
            ),
          ],
        );
      },
      itemCount: foodType.length,
    );
  }
}

class _StatisticWidget extends StatelessWidget {
  const _StatisticWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<FoodViewModel>();

    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 55),
      child: Row(
        children: [
          SizedBox(
              height: 170,
              width: 170,
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          model.state.totalCalories.toInt().toString(),
                          style: AppFonts.headlineMedium
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          'Kcal',
                          style: AppFonts.headlineMedium
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  PieChart(
                    data: [
                      if (model.state.totalProteins == 0 &&
                          model.state.totalFats == 0 &&
                          model.state.totalCarbs == 0)
                        PieChartData(AppColors.secondary, 100,
                            'Protein ${model.state.totalProteins}'),
                      PieChartData(
                          AppColors.primary,
                          model.state.totalProteins == 0
                              ? 0
                              : (model.state.totalProteins /
                                      (model.state.totalProteins +
                                          model.state.totalCarbs +
                                          model.state.totalFats)) *
                                  100,
                          'Protein ${model.state.totalProteins}'),
                      PieChartData(
                          AppColors.orange,
                          model.state.totalFats == 0
                              ? 0
                              : (model.state.totalFats /
                                      (model.state.totalProteins +
                                          model.state.totalCarbs +
                                          model.state.totalFats)) *
                                  100,
                          'Fats ${model.state.totalFats}'),
                      PieChartData(
                          AppColors.tertiary,
                          model.state.totalCarbs == 0
                              ? 0
                              : (model.state.totalCarbs /
                                      (model.state.totalProteins +
                                          model.state.totalCarbs +
                                          model.state.totalFats)) *
                                  100,
                          'Carbs ${model.state.totalCarbs}'),
                    ],
                    radius: 150,
                  ),
                ],
              )),
          const SizedBox(
            width: 50,
          ),
          SizedBox(
            height: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LegendItem(
                    color: AppColors.primary,
                    label: 'Protein ${model.state.totalProteins.toInt()}'),
                LegendItem(
                    color: AppColors.orange,
                    label: 'Fats ${model.state.totalFats.toInt()}'),
                LegendItem(
                    color: AppColors.tertiary,
                    label: 'Carbs ${model.state.totalCarbs.toInt()}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<FoodViewModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CurrentDateWIdget(
            value: [
              model.state.currentDateTime,
            ],
            onChangeDate: (value) {
              model.onUpdatedDate(value);
            }),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()));
          },
          highlightColor: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/icons/settings.png',
            height: 20,
          ),
        )
      ],
    );
  }
}

class PieChartData {
  const PieChartData(this.color, this.percent, this.label);

  final Color color;
  final double percent;
  final String label;
}

class PieChart extends StatelessWidget {
  PieChart({
    required this.data,
    required this.radius,
    this.strokeWidth = 20,
    this.arcStartAngle = -225,
    this.arcSweepAngle = 270,
    this.child,
    super.key,
  }) : assert(data.fold<double>(0, (sum, data) {
              return sum + data.percent;
            }) <=
            100);

  final List<PieChartData> data;
  final double radius;
  final double strokeWidth;
  final double arcStartAngle;
  final double arcSweepAngle;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Painter(
        strokeWidth,
        data,
        arcStartAngle,
        arcSweepAngle,
      ),
      size: Size.square(radius),
      child: SizedBox.square(
        dimension: radius * 2,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

class _PainterData {
  const _PainterData(this.paint, this.radians);

  final Paint paint;
  final double radians;
}

class _Painter extends CustomPainter {
  _Painter(
    double strokeWidth,
    List<PieChartData> data,
    double arcStartAngle,
    double arcSweepAngle,
  )   : _startAngleRadians = _degreesToRadians(arcStartAngle),
        _sweepAngleRadians = _degreesToRadians(arcSweepAngle) {
    dataList = data
        .map((e) => _PainterData(
              Paint()
                ..color = e.color
                ..style = PaintingStyle.stroke
                ..strokeWidth = strokeWidth
                ..strokeCap = StrokeCap.round,
              (e.percent / 100) * _sweepAngleRadians,
            ))
        .toList();
  }

  static double _degreesToRadians(double degrees) {
    return degrees * (3.141592653589793 / 180);
  }

  final double _startAngleRadians;
  final double _sweepAngleRadians;

  late final List<_PainterData> dataList;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    double startAngle = _startAngleRadians;

    for (final data in dataList) {
      final path = Path()..addArc(rect, startAngle, data.radians);

      startAngle += data.radians;

      canvas.drawPath(path, data.paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class LegendItem extends StatelessWidget {
  const LegendItem({
    required this.color,
    required this.label,
    super.key,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(width: 4, color: AppColors.primaryFixed),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
