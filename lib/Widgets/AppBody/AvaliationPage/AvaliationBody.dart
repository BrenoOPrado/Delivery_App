import 'package:flutter/material.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Repository/UserRepository.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/User.dart';

class AvaliationBody extends StatefulWidget {
  final User user;
  final Function(int) alterPage;

  const AvaliationBody({
    super.key,
    required this.user,
    required this.alterPage,
  });

  @override
  State<AvaliationBody> createState() => _AvaliationBodyState();
}

class _AvaliationBodyState extends State<AvaliationBody> {
  UserRepository rep = UserRepository();
  late List<User> list;
  int? hoveredIndex;
  Map<int, int> ratings = {};

  @override
  void initState() {
    super.initState();
    list = List.from(rep.getAll());
  }

  void updateAssessment(User user, double rating) {
    rep.addAssessmentById(rating, user.id);
    setState(() {
      ratings[user.id] = rating.round();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Avaliação de ${user.name} atualizada')),
    );
  }

  @override
  Widget build(BuildContext context) {
    User baseUser = rep.getBaseUser();

    if (widget.user.id == baseUser.id) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock, size: 64, color: Colors.deepOrange),
              const SizedBox(height: 16),
              Text(
                'Por favor autentique-se para avaliar usuários.',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => widget.alterPage(2),
                icon: const Icon(Icons.login),
                label: const Text('Ir para Perfil'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      List<User> listUser = List.from(list);
      listUser.removeWhere(
        (u) => u.id == baseUser.id || u.id == widget.user.id,
      );

      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: listUser.length,
          itemBuilder: (BuildContext context, int index) {
            User thisUser = listUser[index];
            final int currentRating =
                ratings[thisUser.id] ?? thisUser.assessment.round();
            final int clampedRating = currentRating.clamp(0, 5);

            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepOrange.shade100,
                    child: Icon(
                      thisUser.id == 1 ? Icons.local_pizza : Icons.person,
                      color: Colors.deepOrange,
                    ),
                  ),
                  title: Text(
                    thisUser.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    '(${thisUser.dddNumber}) ${thisUser.foneNumeber}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Avaliação:',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(5, (starIndex) {
                        final isHovered =
                            hoveredIndex != null && starIndex <= hoveredIndex!;
                        final isSelected =
                            hoveredIndex == null && starIndex < clampedRating;

                        return MouseRegion(
                          onEnter:
                              (_) => setState(() => hoveredIndex = starIndex),
                          onExit: (_) => setState(() => hoveredIndex = null),
                          child: GestureDetector(
                            onTap:
                                () => updateAssessment(thisUser, starIndex + 1),
                            child: Icon(
                              Icons.star,
                              color:
                                  isHovered || isSelected
                                      ? Colors.amber
                                      : Colors.grey.shade400,
                              size: 32,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
