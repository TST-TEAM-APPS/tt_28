import 'package:flutter/material.dart';
import 'package:tt_28/core/app_fonts.dart';
import 'package:tt_28/core/colors.dart';
import 'package:tt_28/features/food_screen/model/recepi.dart';
import 'package:tt_28/features/food_screen/view/food_solo_screen.dart';
import 'package:tt_28/features/home/model/food_model.dart';

class RecipeGridScreen extends StatefulWidget {
  final String title;
  final List<Recipe> recipes;
  final FoodType foodType;

  const RecipeGridScreen({
    super.key,
    required this.title,
    required this.recipes,
    required this.foodType,
  });

  @override
  State<RecipeGridScreen> createState() => _RecipeGridScreenState();
}

class _RecipeGridScreenState extends State<RecipeGridScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.recipes.isEmpty
          ? const Center(
              child: Text(
                'No recipes found!',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
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
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      Text(
                        widget.title,
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
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.999,
                      ),
                      itemCount: widget.recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = widget.recipes[index];
                        return RecipeCard(recipe: recipe);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class RecipeCard extends StatefulWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RecipeDetailScreen(
              recipe: widget.recipe,
            ),
          ),
        );
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                widget.recipe.imagePath,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recipe.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.recipe.calories} Kcal',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
