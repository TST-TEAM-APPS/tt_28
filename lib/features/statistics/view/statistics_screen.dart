import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt_28/components/custom_current_date_statistic.dart';
import 'package:tt_28/core/app_fonts.dart';
import 'package:tt_28/core/colors.dart';

import 'package:tt_28/features/statistics/view_model/statistic_view_model.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    final model = context.watch<StatisticViewModel>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const _AppBar(),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CurrentDateWIdgetStatistic(
                      value: model.state.currentDate,
                      onChangeWeek: (value, value1) {
                        model.onUpdatedDate(value);
                      }),
                ),
                const _StatisticWidget(),
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
                        ? const WeeklyFoodChart()
                        : const WeeklyWaterChart()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WeeklyFoodChart extends StatefulWidget {
  const WeeklyFoodChart({super.key});

  @override
  State<WeeklyFoodChart> createState() => _WeeklyFoodChartState();
}

class _WeeklyFoodChartState extends State<WeeklyFoodChart> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<StatisticViewModel>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: 400,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.white.withOpacity(0.2),
                  strokeWidth: 1,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.white.withOpacity(0.2),
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  interval: 300,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '${value.toInt()} K',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.right,
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    if (value.toInt() >= 0 &&
                        value.toInt() < model.state.waterList.length) {
                      final date = model.state.waterList[value.toInt()].date;
                      return Text(
                        '${date.day}.${date.month.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(
              border: const Border(
                bottom: BorderSide(
                  width: 2,
                  color: Colors.white,
                ),
                left: BorderSide(
                  width: 2,
                  color: Colors.white,
                ),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(model.state.foodList.length, (index) {
                  final data = model.state.foodList[index];
                  return FlSpot(index.toDouble(), data!.totalWater.toDouble());
                }),
                color: Colors.purple,
                barWidth: 4,
                belowBarData: BarAreaData(show: false),
                dotData: const FlDotData(show: false),
              ),
            ],
            minX: 0,
            minY: 0,
          ),
        ),
      ),
    );
  }
}

class WeeklyWaterChart extends StatefulWidget {
  const WeeklyWaterChart({super.key});

  @override
  State<WeeklyWaterChart> createState() => _WeeklyWaterChartState();
}

class _WeeklyWaterChartState extends State<WeeklyWaterChart> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<StatisticViewModel>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: 1,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.white.withOpacity(0.2),
                  strokeWidth: 1,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.white.withOpacity(0.2),
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  interval: 3,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '${value.toInt()} L',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.right,
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    if (value.toInt() >= 0 &&
                        value.toInt() < model.state.foodList.length) {
                      final date = model.state.foodList[value.toInt()]!.date;
                      return Text(
                        '${date.day}.${date.month.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(
              border: const Border(
                bottom: BorderSide(
                  width: 2,
                  color: Colors.white,
                ),
                left: BorderSide(
                  width: 2,
                  color: Colors.white,
                ),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(model.state.foodList.length, (index) {
                  final data = model.state.waterList[index];
                  return FlSpot(index.toDouble(), data.totalWater.toDouble());
                }),
                color: Colors.purple,
                barWidth: 4,
                belowBarData: BarAreaData(show: false),
                dotData: const FlDotData(show: false),
              ),
            ],
            minX: 0,
            minY: 0,
          ),
        ),
      ),
    );
  }
}

class _StatisticWidget extends StatelessWidget {
  const _StatisticWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<StatisticViewModel>();

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

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        Text(
          'Statistics',
          style: AppFonts.titleLarge.copyWith(color: AppColors.onPrimary),
        ),
        const SizedBox()
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
