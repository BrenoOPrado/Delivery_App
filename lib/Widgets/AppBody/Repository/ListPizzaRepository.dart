import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/ListPizza.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/Pizza.dart';

class ListPizzaRepository {
  List<Pizza> getAll() {
    return listPizza;
  }

  Pizza getByid(int id) {
    return listPizza.firstWhere((Pizza) => Pizza.id == id);
  }
}
