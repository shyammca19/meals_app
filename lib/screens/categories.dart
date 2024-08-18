import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  //explicit animation
  late AnimationController
      _animationController; //late =>this lets dart this isnt variable which will have a value as soon as being used for first time, but not yet when the class created
  //with late you tell dart you will be defined once this property used it will have value
  //singletickerproviderstatemixin must weitten for explisite animation...used by with keyword it tell another class also shared its properties here

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this, //this tells the framerate depends upon this class build
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
      //at default lowerbound 0 and upperbound 1...animation done depend upon these values..you can change it
    );

    _animationController.forward(); //it starts the animation
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //2 coloums next to each other..horizondaly
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            for (final category in availableCategories)
              CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                },
              )
          ],
        ),
        builder: (context, child) => SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.3), //(xaxis,yaxis)
                end: const Offset(0, 0),
              ).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeInOut,
                ),
              ),
              // _animationController.drive(
              //   Tween(
              //     begin: const Offset(0, 0.3), //(xaxis,yaxis)
              //     end: const Offset(0, 0),
              //   ),
              // ),
              child: child,
            )

        // Padding(
        //       padding:
        //           EdgeInsets.only(top: 100 - _animationController.value * 100),
        //       child: child,
        //     )
        );
  }
}
