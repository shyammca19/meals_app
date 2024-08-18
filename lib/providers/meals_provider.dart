import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

final mealsProvider = Provider((ref) {
  //this funcion will recive an object automaticaly, this function passed by provider will call by riverpod package
  return dummyMeals; //must return a value that want to provide
});

//this method only for the state not changes like dummymeals list....if you have more complex state change...you are not using provider() instead using statenotifierprovider() class

/*steps
1.create a provider object
2.use that provider object inside whichever widget you want
   import package
   replace statefulwidget => consumerstatefulwidget or statlesswidget => consumerwidget
   set up the listener using ref.watch(provider) then use it...whenever the provider value change it reexecute the build method
3.in main.dart where the runapp function wrap your app into ProviderScope() widget otherwise provider not working */
