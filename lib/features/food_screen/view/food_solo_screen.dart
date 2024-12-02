import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tt_28/core/colors.dart';
import 'package:tt_28/features/food_screen/model/recepi.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late bool isFavorite;
  late Box<Recipe> recipeBox;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.recipe.isFavorite;
    recipeBox = Hive.box<Recipe>('recipes');
  }

  Future<void> toggleFavorite() async {
    setState(() {
      isFavorite = !isFavorite;
    });

    final recipes = recipeBox.values.toList();
    final recipeIndex = recipes.indexWhere((r) => r.name == widget.recipe.name);

    if (recipeIndex != -1) {
      final updatedRecipe = Recipe(
        imagePath: widget.recipe.imagePath,
        name: widget.recipe.name,
        calories: widget.recipe.calories,
        cookingTime: widget.recipe.cookingTime,
        isFavorite: isFavorite,
        description: widget.recipe.description,
        foodType: widget.recipe.foodType,
        ingredients: widget.recipe.ingredients,
      );

      await recipeBox.putAt(recipeIndex, updatedRecipe);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(16)),
                child: Image.asset(
                  widget.recipe.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.recipe.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          toggleFavorite();
                        },
                        icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.timer,
                              color: AppColors.primary, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.recipe.cookingTime} min',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          const Icon(Icons.local_fire_department,
                              color: Colors.pink, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.recipe.calories} Kcal',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Раздел "Ingredients"
                  const Text(
                    'Ingredients (1 serving)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: widget.recipe.ingredients.map((ingredient) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ingredient.name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                '${ingredient.grams} g',
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Раздел "How to cook"
                  const Text(
                    'How to cook',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.recipe.description,
                    style: const TextStyle(color: Colors.white70, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
