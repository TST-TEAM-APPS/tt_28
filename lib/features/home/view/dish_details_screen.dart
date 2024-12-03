import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:forest_tinker_live/core/app_fonts.dart';
import 'package:forest_tinker_live/core/colors.dart';
import 'package:forest_tinker_live/features/home/model/food_model.dart';
import 'package:forest_tinker_live/features/home/view_model/food_view_model.dart';

class DishDetailsScreen extends StatefulWidget {
  final FoodViewModel model;
  final int dishId;
  const DishDetailsScreen(
      {super.key, required this.dishId, required this.model});

  @override
  State<DishDetailsScreen> createState() => _DishDetailsScreenState();
}

class _DishDetailsScreenState extends State<DishDetailsScreen> {
  late final FoodModel dish;

  @override
  void initState() {
    dish = widget.model.state.dishesList.firstWhere(
      (e) => e!.id == widget.dishId,
      orElse: () {
        throw Exception("GoalModel with ID ${widget.dishId} not found.");
      },
    )!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Row(
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
                      'Breakfast',
                      style: AppFonts.titleLarge.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await widget.model.onUpdatedFood(
                          FoodModel(
                            id: dish.id,
                            typeOfFood: dish.typeOfFood,
                            name: dish.name,
                            date: DateTime.now(),
                            quantity: dish.quantity,
                            calories: dish.calories,
                            proteins: dish.proteins,
                            fats: dish.fats,
                            carbs: dish.carbs,
                            isFavorite: !dish.isFavorite,
                            portion: dish.portion,
                          ),
                        );
                        setState(() {});
                      },
                      child: Image.asset(
                        dish.isFavorite
                            ? 'assets/icons/heartfiiled.png'
                            : 'assets/icons/heart.png',
                        height: 20,
                        width: 20,
                        color: AppColors.primary,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 33,
                ),
                Row(
                  children: [
                    Material(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(9),
                      child: InkWell(
                        highlightColor: Colors.white.withOpacity(0.5),
                        onTap: () async {
                          await widget.model.onUpdatedFood(
                            FoodModel(
                              id: dish.id,
                              typeOfFood: dish.typeOfFood,
                              name: dish.name,
                              date: DateTime.now(),
                              quantity: dish.quantity * (dish.portion + 1),
                              calories: dish.calories,
                              proteins: dish.proteins,
                              fats: dish.fats,
                              carbs: dish.carbs,
                              isFavorite: dish.isFavorite,
                              portion: (dish.portion + 1),
                            ),
                          );
                          print(dish.quantity * (dish.portion + 1));
                          setState(() {});
                        },
                        borderRadius: BorderRadius.circular(9),
                        child: Container(
                          height: 52,
                          width: 52,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Center(
                            child: Text(
                              dish.portion.toString(),
                              style: AppFonts.titleLarge
                                  .copyWith(color: AppColors.onPrimary),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    Expanded(
                      child: Container(
                        height: 52,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '(${dish.quantity} g)',
                            style: AppFonts.titleMedium
                                .copyWith(color: AppColors.onPrimary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 33,
                ),
                _InformationWidget(dish)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InformationWidget extends StatelessWidget {
  final FoodModel dish;
  const _InformationWidget(this.dish);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.secondary,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Consumption per day',
                style: AppFonts.titleMedium.copyWith(
                  color: AppColors.onPrimary,
                ),
              ),
              Row(
                children: [
                  Text(
                    dish.calories.toInt().toString(),
                    style: AppFonts.titleLarge.copyWith(
                      color: AppColors.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Kcal',
                    style: AppFonts.titleLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.primaryFixed,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    child: CircularPercentIndicator(
                      radius: 40,
                      lineWidth: 4.0,
                      percent: (dish.proteins /
                          (dish.proteins + dish.carbs + dish.fats)),
                      center: Text(
                        '${((dish.proteins / (dish.proteins + dish.carbs + dish.fats)) * 100).toInt()}%',
                        style: AppFonts.titleSmall.copyWith(
                          color: AppColors.onPrimary,
                        ),
                      ),
                      progressColor: Colors.purple,
                      backgroundColor: Colors.grey.shade800,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Protein',
                            style: AppFonts.titleSmall.copyWith(
                              color: AppColors.onPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        dish.proteins.toInt().toString(),
                        style: AppFonts.titleSmall.copyWith(
                          color: AppColors.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    child: CircularPercentIndicator(
                      radius: 40,
                      lineWidth: 4.0,
                      percent: (dish.fats /
                          (dish.proteins + dish.carbs + dish.fats)),
                      center: Text(
                        '${((dish.fats / (dish.proteins + dish.carbs + dish.fats)) * 100).toInt()}%',
                        style: AppFonts.titleSmall.copyWith(
                          color: AppColors.onPrimary,
                        ),
                      ),
                      progressColor: Colors.purple,
                      backgroundColor: Colors.grey.shade800,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      Text(
                        'Fats',
                        style: AppFonts.titleSmall.copyWith(
                          color: AppColors.onPrimary,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        dish.fats.toInt().toString(),
                        style:
                            AppFonts.titleSmall.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    child: CircularPercentIndicator(
                      radius: 40,
                      lineWidth: 4.0,
                      percent: (dish.carbs /
                          (dish.proteins + dish.carbs + dish.fats)),
                      center: Text(
                        '${((dish.carbs / (dish.proteins + dish.carbs + dish.fats)) * 100).toInt()}%',
                        style: AppFonts.titleSmall.copyWith(
                          color: AppColors.onPrimary,
                        ),
                      ),
                      progressColor: Colors.purple,
                      backgroundColor: Colors.grey.shade800,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      Text(
                        'Carbs',
                        style: AppFonts.titleSmall.copyWith(
                          color: AppColors.onPrimary,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        dish.carbs.toInt().toString(),
                        style: AppFonts.titleSmall.copyWith(
                          color: AppColors.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
