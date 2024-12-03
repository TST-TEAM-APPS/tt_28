import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tt_28/core/app_fonts.dart';
import 'package:tt_28/core/colors.dart';
import 'package:tt_28/features/food_screen/model/recepi.dart';
import 'package:tt_28/features/food_screen/view/food_screen.dart';

class FoodFavoriteScreen extends StatefulWidget {
  const FoodFavoriteScreen({super.key});

  @override
  State<FoodFavoriteScreen> createState() => _FoodFavoriteScreenState();
}

class _FoodFavoriteScreenState extends State<FoodFavoriteScreen> {
  late Future<void> _initializeFuture;
  @override
  void initState() {
    _initializeFuture = _initializeApp();

    super.initState();
  }

  Future<void> _initializeApp() async {
    await Hive.openBox<Recipe>('recipes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _initializeFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final box = Hive.box<Recipe>('recipes');
              final recipes = box.values.toList();

              final favorite =
                  recipes.where((r) => r.isFavorite == true).toList();

              return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Favorites',
                          style: AppFonts.titleLarge.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const Icon(
                          Icons.close,
                          color: Colors.transparent,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    favorite.isEmpty
                        ? SizedBox(
                            height: 500,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/empty.png',
                                  height: 250,
                                  width: 250,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  'You haven\'t favorites a dish yet',
                                  style: AppFonts.titleMedium.copyWith(
                                    color: AppColors.onPrimary,
                                  ),
                                )
                              ],
                            ),
                          )
                        : Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 0.999,
                              ),
                              itemCount: favorite.length,
                              itemBuilder: (context, index) {
                                final recipe = favorite[index];
                                return RecipeCard(
                                  recipe: recipe,
                                  onUpdate: () {},
                                );
                              },
                            ),
                          ),
                  ]));
            }));
  }
}
