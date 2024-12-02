import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tt_28/core/app_fonts.dart';
import 'package:tt_28/core/colors.dart';
import 'package:tt_28/features/food_screen/model/recepi.dart';
import 'package:tt_28/features/food_screen/view/food_detail_screen.dart';
import 'package:tt_28/features/food_screen/view/food_solo_screen.dart';
import 'package:tt_28/features/home/model/food_model.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  late Future<void> _initializeFuture;
  Future<void> initializeRecipes() async {
    final box = await Hive.openBox<Recipe>('recipes');

    if (box.isEmpty) {
      List<Recipe> recipes = [
        Recipe(
          imagePath: 'assets/images/breakfast1.jpg',
          name: 'Pancakes with Syrup',
          calories: 350,
          cookingTime: 20,
          isFavorite: false,
          description:
              'Mix flour, eggs, milk, and sugar to make batter. Fry in a pan and serve with syrup.',
          foodType: FoodType.breakfast,
          ingredients: [
            Ingredient(name: 'Flour', grams: 100),
            Ingredient(name: 'Eggs', grams: 50),
            Ingredient(name: 'Milk', grams: 200),
            Ingredient(name: 'Sugar', grams: 30),
            Ingredient(name: 'Syrup', grams: 50),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/breakfast2.jpeg',
          name: 'Avocado Toast',
          calories: 250,
          cookingTime: 10,
          isFavorite: false,
          description:
              'Toast bread and spread mashed avocado. Sprinkle with salt and pepper.',
          foodType: FoodType.breakfast,
          ingredients: [
            Ingredient(name: 'Bread', grams: 80),
            Ingredient(name: 'Avocado', grams: 100),
            Ingredient(name: 'Salt', grams: 2),
            Ingredient(name: 'Pepper', grams: 2),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/breakfast3.jpg',
          name: 'Omelette with Veggies',
          calories: 300,
          cookingTime: 15,
          isFavorite: false,
          description:
              'Whisk eggs and cook with chopped vegetables in a frying pan.',
          foodType: FoodType.breakfast,
          ingredients: [
            Ingredient(name: 'Eggs', grams: 120),
            Ingredient(name: 'Bell Pepper', grams: 50),
            Ingredient(name: 'Onion', grams: 30),
            Ingredient(name: 'Spinach', grams: 40),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/lunch1.jpg',
          name: 'Grilled Chicken Salad',
          calories: 420,
          cookingTime: 25,
          isFavorite: false,
          description:
              'Grill chicken breast and serve with lettuce, tomatoes, and vinaigrette.',
          foodType: FoodType.lunch,
          ingredients: [
            Ingredient(name: 'Chicken Breast', grams: 200),
            Ingredient(name: 'Lettuce', grams: 50),
            Ingredient(name: 'Tomatoes', grams: 30),
            Ingredient(name: 'Vinaigrette', grams: 20),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/lunch2.jpg',
          name: 'Pasta with Tomato Sauce',
          calories: 450,
          cookingTime: 30,
          isFavorite: false,
          description:
              'Boil pasta and mix with homemade tomato sauce and parmesan cheese.',
          foodType: FoodType.lunch,
          ingredients: [
            Ingredient(name: 'Pasta', grams: 150),
            Ingredient(name: 'Tomato Sauce', grams: 100),
            Ingredient(name: 'Parmesan Cheese', grams: 20),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/lunch3.jpg',
          name: 'Quinoa Bowl with Veggies',
          calories: 350,
          cookingTime: 25,
          isFavorite: false,
          description:
              'Cook quinoa and mix with roasted vegetables and a drizzle of olive oil.',
          foodType: FoodType.lunch,
          ingredients: [
            Ingredient(name: 'Quinoa', grams: 100),
            Ingredient(name: 'Zucchini', grams: 50),
            Ingredient(name: 'Carrots', grams: 50),
            Ingredient(name: 'Olive Oil', grams: 10),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/dinner1.jpg',
          name: 'Grilled Salmon with Rice',
          calories: 500,
          cookingTime: 30,
          isFavorite: false,
          description:
              'Grill salmon fillet and serve with steamed rice and lemon slices.',
          foodType: FoodType.dinner,
          ingredients: [
            Ingredient(name: 'Salmon Fillet', grams: 200),
            Ingredient(name: 'Rice', grams: 150),
            Ingredient(name: 'Lemon', grams: 20),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/dinner2.jpg',
          name: 'Vegetable Stir-Fry',
          calories: 350,
          cookingTime: 20,
          isFavorite: false,
          description:
              'Stir-fry mixed vegetables in a wok with soy sauce and garlic.',
          foodType: FoodType.dinner,
          ingredients: [
            Ingredient(name: 'Broccoli', grams: 80),
            Ingredient(name: 'Carrots', grams: 50),
            Ingredient(name: 'Bell Pepper', grams: 50),
            Ingredient(name: 'Soy Sauce', grams: 10),
            Ingredient(name: 'Garlic', grams: 5),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/dinner3.jpg',
          name: 'Beef Steak with Potatoes',
          calories: 600,
          cookingTime: 35,
          isFavorite: false,
          description:
              'Grill beef steak and serve with mashed potatoes and gravy.',
          foodType: FoodType.dinner,
          ingredients: [
            Ingredient(name: 'Beef Steak', grams: 250),
            Ingredient(name: 'Potatoes', grams: 200),
            Ingredient(name: 'Gravy', grams: 50),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/snack1.jpg',
          name: 'Fruit Salad',
          calories: 200,
          cookingTime: 10,
          isFavorite: false,
          description:
              'Chop various fruits and mix in a bowl. Optionally, add honey.',
          foodType: FoodType.snack,
          ingredients: [
            Ingredient(name: 'Apple', grams: 50),
            Ingredient(name: 'Banana', grams: 50),
            Ingredient(name: 'Grapes', grams: 50),
            Ingredient(name: 'Honey', grams: 10),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/snack2.jpg',
          name: 'Yogurt with Granola',
          calories: 220,
          cookingTime: 5,
          isFavorite: false,
          description: 'Mix plain yogurt with granola and fresh berries.',
          foodType: FoodType.snack,
          ingredients: [
            Ingredient(name: 'Yogurt', grams: 150),
            Ingredient(name: 'Granola', grams: 50),
            Ingredient(name: 'Berries', grams: 50),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/snack3.jpg',
          name: 'Peanut Butter Toast',
          calories: 250,
          cookingTime: 5,
          isFavorite: false,
          description:
              'Spread peanut butter on toasted bread. Optionally, top with banana slices.',
          foodType: FoodType.snack,
          ingredients: [
            Ingredient(name: 'Bread', grams: 80),
            Ingredient(name: 'Peanut Butter', grams: 30),
            Ingredient(name: 'Banana', grams: 50),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/breakfast4.jpg',
          name: 'Smoothie Bowl',
          calories: 320,
          cookingTime: 10,
          isFavorite: false,
          description:
              'Blend frozen fruits with milk, pour into a bowl, and top with granola and fresh berries.',
          foodType: FoodType.breakfast,
          ingredients: [
            Ingredient(name: 'Frozen Berries', grams: 150),
            Ingredient(name: 'Banana', grams: 100),
            Ingredient(name: 'Milk', grams: 100),
            Ingredient(name: 'Granola', grams: 50),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/breakfast5.jpg',
          name: 'Scrambled Eggs with Toast',
          calories: 290,
          cookingTime: 10,
          isFavorite: false,
          description:
              'Cook scrambled eggs with butter and serve with toasted bread.',
          foodType: FoodType.breakfast,
          ingredients: [
            Ingredient(name: 'Eggs', grams: 100),
            Ingredient(name: 'Butter', grams: 20),
            Ingredient(name: 'Bread', grams: 80),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/breakfast6.jpg',
          name: 'Greek Yogurt with Honey',
          calories: 200,
          cookingTime: 5,
          isFavorite: false,
          description:
              'Serve Greek yogurt with a drizzle of honey and chopped nuts.',
          foodType: FoodType.breakfast,
          ingredients: [
            Ingredient(name: 'Greek Yogurt', grams: 150),
            Ingredient(name: 'Honey', grams: 10),
            Ingredient(name: 'Nuts', grams: 20),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/breakfast7.jpeg',
          name: 'Berry Muffins',
          calories: 380,
          cookingTime: 25,
          isFavorite: false,
          description:
              'Bake muffins with fresh berries, flour, sugar, and eggs.',
          foodType: FoodType.breakfast,
          ingredients: [
            Ingredient(name: 'Flour', grams: 150),
            Ingredient(name: 'Sugar', grams: 80),
            Ingredient(name: 'Eggs', grams: 100),
            Ingredient(name: 'Berries', grams: 100),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/lunch4.jpg',
          name: 'Caesar Salad',
          calories: 370,
          cookingTime: 15,
          isFavorite: false,
          description:
              'Mix lettuce with Caesar dressing, croutons, and grilled chicken slices.',
          foodType: FoodType.lunch,
          ingredients: [
            Ingredient(name: 'Lettuce', grams: 100),
            Ingredient(name: 'Chicken', grams: 150),
            Ingredient(name: 'Croutons', grams: 30),
            Ingredient(name: 'Caesar Dressing', grams: 50),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/lunch5.jpeg',
          name: 'Vegetable Soup',
          calories: 220,
          cookingTime: 30,
          isFavorite: false,
          description:
              'Boil mixed vegetables in broth and blend for a smooth texture.',
          foodType: FoodType.lunch,
          ingredients: [
            Ingredient(name: 'Carrots', grams: 50),
            Ingredient(name: 'Potatoes', grams: 80),
            Ingredient(name: 'Onion', grams: 30),
            Ingredient(name: 'Broth', grams: 300),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/lunch6.jpg',
          name: 'Chicken Wrap',
          calories: 400,
          cookingTime: 20,
          isFavorite: false,
          description:
              'Fill a tortilla with grilled chicken, lettuce, and mayonnaise. Wrap tightly.',
          foodType: FoodType.lunch,
          ingredients: [
            Ingredient(name: 'Tortilla', grams: 80),
            Ingredient(name: 'Chicken', grams: 150),
            Ingredient(name: 'Lettuce', grams: 50),
            Ingredient(name: 'Mayonnaise', grams: 20),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/lunch7.jpg',
          name: 'Risotto with Mushrooms',
          calories: 450,
          cookingTime: 35,
          isFavorite: false,
          description: 'Cook rice with broth, mushrooms, and parmesan cheese.',
          foodType: FoodType.lunch,
          ingredients: [
            Ingredient(name: 'Rice', grams: 150),
            Ingredient(name: 'Mushrooms', grams: 100),
            Ingredient(name: 'Broth', grams: 200),
            Ingredient(name: 'Parmesan Cheese', grams: 30),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/dinner4.jpg',
          name: 'Roasted Chicken with Vegetables',
          calories: 520,
          cookingTime: 40,
          isFavorite: false,
          description:
              'Roast chicken and vegetables in the oven with olive oil and spices.',
          foodType: FoodType.dinner,
          ingredients: [
            Ingredient(name: 'Chicken', grams: 200),
            Ingredient(name: 'Carrots', grams: 50),
            Ingredient(name: 'Potatoes', grams: 100),
            Ingredient(name: 'Olive Oil', grams: 20),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/dinner5.jpeg',
          name: 'Stuffed Bell Peppers',
          calories: 400,
          cookingTime: 35,
          isFavorite: false,
          description:
              'Fill bell peppers with rice, ground beef, and tomato sauce. Bake in the oven.',
          foodType: FoodType.dinner,
          ingredients: [
            Ingredient(name: 'Bell Peppers', grams: 150),
            Ingredient(name: 'Rice', grams: 100),
            Ingredient(name: 'Ground Beef', grams: 150),
            Ingredient(name: 'Tomato Sauce', grams: 50),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/dinner6.jpeg',
          name: 'Spaghetti Bolognese',
          calories: 530,
          cookingTime: 30,
          isFavorite: false,
          description: 'Cook spaghetti and serve with meat-based tomato sauce.',
          foodType: FoodType.dinner,
          ingredients: [
            Ingredient(name: 'Spaghetti', grams: 150),
            Ingredient(name: 'Ground Beef', grams: 150),
            Ingredient(name: 'Tomato Sauce', grams: 100),
            Ingredient(name: 'Parmesan Cheese', grams: 20),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/dinner7.jpg',
          name: 'Grilled Vegetables with Hummus',
          calories: 300,
          cookingTime: 20,
          isFavorite: false,
          description:
              'Grill mixed vegetables and serve with hummus on the side.',
          foodType: FoodType.dinner,
          ingredients: [
            Ingredient(name: 'Zucchini', grams: 50),
            Ingredient(name: 'Eggplant', grams: 50),
            Ingredient(name: 'Bell Pepper', grams: 50),
            Ingredient(name: 'Hummus', grams: 100),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/snack4.jpg',
          name: 'Trail Mix',
          calories: 200,
          cookingTime: 5,
          isFavorite: false,
          description: 'Mix nuts, dried fruits, and chocolate chips.',
          foodType: FoodType.snack,
          ingredients: [
            Ingredient(name: 'Nuts', grams: 50),
            Ingredient(name: 'Dried Fruits', grams: 50),
            Ingredient(name: 'Chocolate Chips', grams: 30),
          ],
        ),
        Recipe(
          imagePath: 'assets/images/snack5.jpg',
          name: 'Apple with Peanut Butter',
          calories: 150,
          cookingTime: 5,
          isFavorite: false,
          description: 'Slice an apple and spread peanut butter on top.',
          foodType: FoodType.snack,
          ingredients: [
            Ingredient(name: 'Apple', grams: 150),
            Ingredient(name: 'Peanut Butter', grams: 30),
          ],
        ),
      ];

      for (var recipe in recipes) {
        await box.add(recipe);
      }
    }
  }

  @override
  void initState() {
    _initializeFuture = _initializeApp();

    super.initState();
  }

  Future<void> _initializeApp() async {
    await Hive.openBox<Recipe>('recipes');
    await initializeRecipes();
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

          final breakfast =
              recipes.where((r) => r.foodType == FoodType.breakfast).toList();
          final lunch =
              recipes.where((r) => r.foodType == FoodType.lunch).toList();
          final dinner =
              recipes.where((r) => r.foodType == FoodType.dinner).toList();
          final snack =
              recipes.where((r) => r.foodType == FoodType.snack).toList();

          return Padding(
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
                      onTap: () async {},
                      child: Image.asset(
                        'assets/icons/heartfiiled.png',
                        height: 20,
                        width: 20,
                        color: AppColors.primary,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'Recipes',
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
                  child: ListView(
                    children: [
                      RecipeList(
                        title: 'Breakfast',
                        recipes: breakfast,
                        foodType: FoodType.breakfast,
                        onUpdate: () {
                          setState(() {});
                        },
                      ),
                      RecipeList(
                        title: 'Lunch',
                        recipes: lunch,
                        foodType: FoodType.lunch,
                        onUpdate: () {
                          setState(() {});
                        },
                      ),
                      RecipeList(
                        title: 'Dinner',
                        recipes: dinner,
                        foodType: FoodType.dinner,
                        onUpdate: () {
                          setState(() {});
                        },
                      ),
                      RecipeList(
                        title: 'Snack',
                        recipes: snack,
                        foodType: FoodType.snack,
                        onUpdate: () {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class RecipeList extends StatefulWidget {
  final String title;
  final List<Recipe> recipes;
  final FoodType foodType;
  final Function onUpdate;

  const RecipeList(
      {super.key,
      required this.title,
      required this.recipes,
      required this.foodType,
      required this.onUpdate});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => RecipeGridScreen(
                                title: widget.title,
                                foodType: widget.foodType,
                                recipes: widget.recipes,
                              )));
                },
                child: const Text('See all',
                    style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 172,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.recipes.length,
            itemBuilder: (context, index) {
              final recipe = widget.recipes[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RecipeCard(
                  recipe: recipe,
                  onUpdate: widget.onUpdate,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class RecipeCard extends StatefulWidget {
  final Recipe recipe;
  final Function onUpdate;
  const RecipeCard({super.key, required this.recipe, required this.onUpdate});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => RecipeDetailScreen(
                      recipe: widget.recipe,
                    ))).then((_) {
          widget.onUpdate();
        });
      },
      child: Container(
        width: 172,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                widget.recipe.imagePath,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.recipe.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '${widget.recipe.calories} Kcal',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
