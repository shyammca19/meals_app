import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealNotifier()
      : super(
            []); //here we must create which type of data going to notifi and initialy put it empty

  bool toggleMealFavoriteStatus(Meal meal) {
    //then create a method which going to change that data
    //here you cannot add or remove like state.add or state.remove()....because add or remove in list not create list it edit the existing list and the address of that list not change
    final mealIsFavorite = state.contains(meal); //here only check the list

    if (mealIsFavorite) {
      //where() create a new list not edit existing list
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [
        ...state,
        meal
      ]; //... this spread operator => to pullout all the elements that stored on that list and them at individual elements to new list and then , we add new element after the ,
      return true;
    } //state has a data of list of meal
  }
}

//this statenotifierprover class works with another class like statefulwidget works with state class that is statenotifier() class
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealNotifier, List<Meal>>((ref) {
  return FavoriteMealNotifier();
});
