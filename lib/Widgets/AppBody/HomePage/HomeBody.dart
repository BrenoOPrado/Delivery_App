import 'package:flutter/material.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/Pizza.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Repository/ListPizzaRepository.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final ListPizzaRepository pizzaRep = ListPizzaRepository();
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    final List<Pizza> pizzaList = pizzaRep.getAll();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Pizzas'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount =
                constraints.maxWidth > 800
                    ? 4
                    : constraints.maxWidth > 600
                    ? 3
                    : 2;

            return GridView.builder(
              itemCount: pizzaList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                final pizza = pizzaList[index];
                final isSelected = _selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = isSelected ? null : index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color:
                            isSelected
                                ? Colors.deepOrange
                                : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.local_pizza,
                          size: isSelected ? 80 : 60,
                          color: Colors.deepOrange,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          pizza.name,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          pizza.ingredients.join(', '),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Spacer(),
                        if (isSelected)
                          ElevatedButton.icon(
                            onPressed: () {
                              print(
                                'Pizza selecionada: ID = ${pizza.id}', // Editar a funcionalidade!!!!
                              );
                            },
                            icon: const Icon(Icons.add_shopping_cart),
                            label: const Text("Adicionar"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              foregroundColor: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
