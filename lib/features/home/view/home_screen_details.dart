import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:tt_28/components/custom_button.dart';
import 'package:tt_28/components/custom_text_field.dart';
import 'package:tt_28/core/app_fonts.dart';
import 'package:tt_28/core/colors.dart';
import 'package:tt_28/features/home/model/food_model.dart';
import 'package:tt_28/features/home/view/dish_details_screen.dart';
import 'package:tt_28/features/home/view_model/food_view_model.dart';

class Dish {
  final String name;
  final double calories;
  final double grams;
  final double protein;
  final double fats;
  final double carbs;
  final bool isFavorite;

  Dish(
      {required this.name,
      required this.calories,
      required this.grams,
      required this.protein,
      required this.fats,
      required this.carbs,
      required this.isFavorite});
}

class HomeScreenDetails extends StatefulWidget {
  final FoodType foodType;
  final FoodViewModel foodViewModel;
  final DateTime currentDateTime;
  const HomeScreenDetails(
      {super.key,
      required this.foodType,
      required this.foodViewModel,
      required this.currentDateTime});

  @override
  State<HomeScreenDetails> createState() => _HomeScreenDetailsState();
}

class _HomeScreenDetailsState extends State<HomeScreenDetails> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<FoodViewModel>();

    List<FoodModel?> dishes = model.state.dishesList;
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
                const _AppBar(),
                const SizedBox(
                  height: 24,
                ),
                const _SearchBar(),
                const SizedBox(
                  height: 24,
                ),
                _InformationWidget(widget.foodType),
                const SizedBox(
                  height: 24,
                ),
                const _DishTabBar(),
                const SizedBox(
                  height: 24,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              model
                                  .onDeleteDish(model.state.dishesList[index]!);
                            },
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'delete',
                          ),
                        ],
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(13),
                        color: AppColors.secondary,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(13),
                          highlightColor: Colors.white.withOpacity(0.5),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DishDetailsScreen(
                                        dishId: dishes[index]!.id,
                                        model: model,
                                      )),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: Colors.transparent,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          dishes[index]!.name,
                                          style: AppFonts.titleMedium.copyWith(
                                            color: AppColors.onPrimary,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          dishes[index]!
                                              .quantity
                                              .toInt()
                                              .toString(),
                                          style: AppFonts.titleSmall.copyWith(
                                            color: AppColors.onPrimary,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          'g',
                                          style: AppFonts.titleSmall.copyWith(
                                            color: AppColors.onPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          dishes[index]!
                                              .calories
                                              .toInt()
                                              .toString(),
                                          style: AppFonts.titleSmall.copyWith(
                                            color: AppColors.onPrimary,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Kcal',
                                          style: AppFonts.titleSmall.copyWith(
                                            color: AppColors.onPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Material(
                                  color: AppColors.primaryFixed,
                                  borderRadius: BorderRadius.circular(6),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(6),
                                    highlightColor:
                                        Colors.white.withOpacity(0.5),
                                    onTap: () {
                                      model.onFoodItemAdded(
                                        FoodModel(
                                            typeOfFood: widget.foodType,
                                            name: dishes[index]!.name,
                                            date: widget.currentDateTime,
                                            quantity: dishes[index]!.quantity,
                                            calories: dishes[index]!.calories,
                                            proteins: dishes[index]!.proteins,
                                            fats: dishes[index]!.fats,
                                            carbs: dishes[index]!.carbs,
                                            isFavorite:
                                                dishes[index]!.isFavorite),
                                      );
                                      widget.foodViewModel.loadData();
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: dishes.length,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DishTabBar extends StatefulWidget {
  const _DishTabBar();

  @override
  State<_DishTabBar> createState() => _DishTabBarState();
}

class _DishTabBarState extends State<_DishTabBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<FoodViewModel>();
    return Container(
      height: 38,
      decoration: BoxDecoration(
          color: AppColors.secondary, borderRadius: BorderRadius.circular(22)),
      child: Row(
        children: [
          Expanded(
              child: Material(
            color: selectedIndex == 0
                ? AppColors.primaryFixed
                : AppColors.secondary,
            borderRadius: BorderRadius.circular(22),
            child: InkWell(
              highlightColor: AppColors.primaryFixed.withOpacity(0.8),
              borderRadius: BorderRadius.circular(22),
              onTap: () {
                selectedIndex = 0;
                model.onChangeTab(false);
              },
              child: Container(
                height: 38,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(22)),
                child: Center(
                  child: Image.asset(
                    'assets/icons/recent.png',
                    height: 24,
                    width: 24,
                    color: selectedIndex == 0
                        ? AppColors.primary
                        : AppColors.primaryFixed,
                  ),
                ),
              ),
            ),
          )),
          Expanded(
              child: Material(
            color: selectedIndex == 1
                ? AppColors.primaryFixed
                : AppColors.secondary,
            borderRadius: BorderRadius.circular(22),
            child: InkWell(
                highlightColor: AppColors.primaryFixed.withOpacity(0.8),
                borderRadius: BorderRadius.circular(22),
                onTap: () {
                  selectedIndex = 1;
                  model.onChangeTab(true);
                },
                child: Container(
                  height: 38,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(22)),
                  child: Center(
                    child: Image.asset(
                      'assets/icons/heart.png',
                      height: 24,
                      width: 24,
                      color: selectedIndex == 1
                          ? AppColors.primary
                          : AppColors.primaryFixed,
                    ),
                  ),
                )),
          )),
        ],
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  const _SearchBar();

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  String? nameOfDish;
  double? calories;
  double? quantity;
  double? protein;
  double? fats;
  double? carbs;

  @override
  Widget build(BuildContext context) {
    final model = context.read<FoodViewModel>();
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            onChange: (value) {},
            textStyle: AppFonts.titleSmall,
            fillColor: AppColors.secondary,
            icon: const Icon(
              size: 24,
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          width: 38,
        ),
        Material(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(6),
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            highlightColor: Colors.white.withOpacity(0.5),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () {
                                    nameOfDish = null;
                                    calories = null;
                                    quantity = null;
                                    protein = null;
                                    fats = null;
                                    carbs = null;
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
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Name of dish',
                                style: AppFonts.titleMedium.copyWith(
                                  color: AppColors.onSurface,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              CustomTextField(
                                onChange: (value) {
                                  nameOfDish = value;
                                  setState(() {});
                                },
                                hintText: 'Name of dish',
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'How many calories',
                                        style: AppFonts.titleMedium.copyWith(
                                          color: AppColors.onSurface,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      CustomTextField(
                                        onChange: (value) {
                                          calories = double.tryParse(value);
                                          setState(() {});
                                        },
                                        hintText: '0',
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  )),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'How many grams',
                                        style: AppFonts.titleMedium.copyWith(
                                          color: AppColors.onSurface,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      CustomTextField(
                                        onChange: (value) {
                                          quantity = double.tryParse(value);
                                          setState(() {});
                                        },
                                        hintText: '0',
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'How many protein',
                                        style: AppFonts.titleMedium.copyWith(
                                          color: AppColors.onSurface,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      CustomTextField(
                                        onChange: (value) {
                                          protein = double.tryParse(value);
                                          setState(() {});
                                        },
                                        hintText: '0',
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  )),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'How many fats',
                                        style: AppFonts.titleMedium.copyWith(
                                          color: AppColors.onSurface,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      CustomTextField(
                                        onChange: (value) {
                                          fats = double.tryParse(value);
                                          setState(() {});
                                        },
                                        hintText: '0',
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'How many carbs',
                                          style: AppFonts.titleMedium.copyWith(
                                            color: AppColors.onSurface,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        CustomTextField(
                                          onChange: (value) {
                                            carbs = double.tryParse(value);
                                            setState(() {});
                                          },
                                          hintText: '0',
                                          keyboardType: TextInputType.number,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  const Expanded(child: SizedBox())
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              CustomButton(
                                title: 'Save',
                                isValid: nameOfDish != null &&
                                    nameOfDish != '' &&
                                    calories != null &&
                                    quantity != null &&
                                    protein != null &&
                                    fats != null &&
                                    carbs != null,
                                onTap: () async {
                                  await model.onDishItemAdded(FoodModel(
                                      typeOfFood: FoodType.breakfast,
                                      name: nameOfDish!,
                                      date: DateTime.now(),
                                      quantity: quantity!,
                                      calories: calories!,
                                      proteins: protein!,
                                      fats: fats!,
                                      carbs: carbs!,
                                      isFavorite: false));
                                  Navigator.pop(context);
                                },
                                backgroundColor: AppColors.primary,
                                titleStyle: AppFonts.titleLarge.copyWith(
                                  color: AppColors.onPrimary,
                                ),
                                borderRadius: BorderRadius.circular(22),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
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
        ),
      ],
    );
  }
}

class _InformationWidget extends StatelessWidget {
  final FoodType foodType;
  const _InformationWidget(this.foodType);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<FoodViewModel>();
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
                    switch (foodType) {
                      FoodType.breakfast =>
                        model.state.breakfastCalories.toInt().toString(),
                      FoodType.lunch =>
                        model.state.lunchCalories.toInt().toString(),
                      FoodType.dinner =>
                        model.state.dinnerCalories.toInt().toString(),
                      FoodType.snack =>
                        model.state.snackCalories.toInt().toString(),
                    },
                    style: AppFonts.titleLarge.copyWith(
                      color: AppColors.primary,
                    ),
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
              Row(
                children: [
                  Text(
                    'Protein',
                    style: AppFonts.titleSmall.copyWith(
                      color: AppColors.onPrimary,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    switch (foodType) {
                      FoodType.breakfast =>
                        model.state.totalBreakfastProteins.toInt().toString(),
                      FoodType.lunch =>
                        model.state.totalLunchProteins.toInt().toString(),
                      FoodType.dinner =>
                        model.state.totalDinnerProteins.toInt().toString(),
                      FoodType.snack =>
                        model.state.totalSnackProteins.toInt().toString(),
                    },
                    style: AppFonts.titleSmall.copyWith(
                      color: AppColors.onPrimary,
                    ),
                  ),
                ],
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
                    switch (foodType) {
                      FoodType.breakfast =>
                        model.state.totalBreakfastFats.toInt().toString(),
                      FoodType.lunch =>
                        model.state.totalLunchFats.toInt().toString(),
                      FoodType.dinner =>
                        model.state.totalDinnerFats.toInt().toString(),
                      FoodType.snack =>
                        model.state.totalSnackFats.toInt().toString(),
                    },
                    style: AppFonts.titleSmall.copyWith(
                      color: AppColors.onPrimary,
                    ),
                  ),
                ],
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
                    switch (foodType) {
                      FoodType.breakfast =>
                        model.state.totalBreakfastCarbs.toInt().toString(),
                      FoodType.lunch =>
                        model.state.totalLunchCarbs.toInt().toString(),
                      FoodType.dinner =>
                        model.state.totalDinnerCarbs.toInt().toString(),
                      FoodType.snack =>
                        model.state.totalSnackCarbs.toInt().toString(),
                    },
                    style: AppFonts.titleSmall.copyWith(
                      color: AppColors.onPrimary,
                    ),
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
          'Breakfast',
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
