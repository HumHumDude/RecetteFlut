import 'package:flutter/material.dart';
import 'package:mealapp/dummy_data.dart';
import 'package:mealapp/screens/filters_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/tabs_screen.dart';
import './models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };
  List<Meal>? _availableMeals = DUMMY_MEALS.cast<Meal>();
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS
          .where((meal) {
            if (_filters!['gluten'] && meal.isGlutenFree) {
              return false;
            }
            if (_filters!['lactose'] && meal.isLactoseFree) {
              return false;
            }
            if (_filters!['vegetarian'] && meal.isVegan) {
              return false;
            }
            if (_filters!['vegan'] && meal.isVegetarian) {
              return false;
            }
            return true;
          })
          .cast<Meal>()
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabScreen(),
        '/category-meals': (context) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        FilterScreen.routeName: (context) =>
            FilterScreen(_setFilters as Function()),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // if (settings.name = '/meal-detail'){
        //   return ...;
        // }else if (settings.name = '/meal-stuff'){
        //   return ...;
        // }

        // return MaterialPageRoute(builder: (ctx){
        //   return CategoriesScreen();
        // }
        // );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          return CategoriesScreen();
        });
      },
    );
  }
}
