import 'package:flutter/material.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/Order.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/Pizza.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/User.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Repository/MotoboyRepository.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Repository/PizzaRepository.dart';

class HomeBody extends StatefulWidget {
  final User user;
  final Function(int) alterPage;

  const HomeBody({super.key, required this.user, required this.alterPage});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final PizzaRepository pizzaRep = PizzaRepository();
  MotoboyRepository motoboyRep = MotoboyRepository();
  int? _selectedIndex;
  Order? order;

  @override
  Widget build(BuildContext context) {
    final List<Pizza> pizzaList = pizzaRep.getAll();

    void createOrder() {
      order = Order(
        id: widget.user.orders.length,
        idUser: widget.user.id,
        pizza: [],
        delivered: false,
      );
    }

    void addPizzaInOrder(int? pizzaId) {
      if (pizzaId == null) return;

      if (widget.user.id <= 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor realizar o Login')),
        );
        widget.alterPage(2);
        return;
      }

      if (order == null) {
        createOrder();
      }

      final selectedPizza = pizzaList.firstWhere(
        (pizza) => pizza.id == pizzaId,
        orElse: () => throw Exception('Pizza com ID $pizzaId não encontrada.'),
      );

      order!.pizza.add(
        Pizza(
          id: pizzaId,
          name: selectedPizza.name,
          ingredients: selectedPizza.ingredients,
        ),
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Adicionado ao carrinho')));
    }

    void showCart() {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Seu Pedido',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ...order!.pizza.map(
                    (pizza) => ListTile(
                      leading: const Icon(Icons.local_pizza),
                      title: Text(pizza.name),
                      subtitle: Text(pizza.ingredients.join(', ')),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Pedido enviado!')),
                      );
                      motoboyRep.sendOrderMotoUser(order!);
                      setState(() {
                        order = null;
                      });
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Finalizar Pedido'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(48),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Pizzas'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Ver carrinho',
            onPressed: () {
              if (order == null || order!.pizza.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('O carrinho está vazio')),
                );
              } else {
                showCart();
              }
            },
          ),
        ],
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
                            color: Colors.orange.withValues(),
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
                              addPizzaInOrder(pizza.id);
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
