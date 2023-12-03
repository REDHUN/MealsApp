import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/providers/meals_providers.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegitarian,
  vegan,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegitarian: false,
        });
  void setFilters(Map<Filter, bool> choosenFilters) {
    state = choosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
    (ref) => FilterNotifier());

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);

  final activeFilters = ref.watch(filterProvider);
  return meals.where((mea) {
    if (activeFilters[Filter.glutenFree]! && !mea.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !mea.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !mea.isVegan) {
      return false;
    }
    if (activeFilters[Filter.vegitarian]! && !mea.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
