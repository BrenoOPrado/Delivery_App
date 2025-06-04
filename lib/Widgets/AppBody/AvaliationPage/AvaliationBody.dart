import 'package:flutter/material.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Repository/ListUserRepositorie.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/User.dart';

class AvaliationBody extends StatefulWidget {
  final User user;
  final Function(int) onItemSelected;

  const AvaliationBody({
    super.key,
    required this.user,
    required this.onItemSelected,
  });

  @override
  State<AvaliationBody> createState() => _AvaliationBodyState();
}

class _AvaliationBodyState extends State<AvaliationBody> {
  ListUserRepositorie rep = ListUserRepositorie();
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
  }

  @override
  Widget build(BuildContext context) {
    User baseUser = rep.getBaseUser();

    if (widget.user.id == baseUser.id) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Por favor autenticar antes de realizar avaliações'),
          TextButton(
            onPressed: () => widget.onItemSelected(2),
            child: Text('Perfil'),
          ),
        ],
      );
    } else {
      List<User> listUser = List.from(list);
      listUser.removeWhere(
        (u) => u.id == baseUser.id || u.id == widget.user.id,
      );

      return ListView.builder(
        itemCount: listUser.length,
        itemBuilder: (BuildContext context, int index) {
          User thisUser = listUser[index];
          final int currentRating =
              ratings[thisUser.id] ?? thisUser.assessment.round();
          final int clampedRating = currentRating.clamp(0, 5);

          return ExpansionTile(
            leading: Icon(Icons.person),
            title: Text(thisUser.name),
            subtitle: Text(
              '(${thisUser.dddNumber}) ${thisUser.foneNumeber}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            children: [
              Text('Avaliação:', style: Theme.of(context).textTheme.bodyMedium),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (starIndex) {
                  final isHovered =
                      hoveredIndex != null && starIndex <= hoveredIndex!;
                  final isSelected =
                      hoveredIndex == null && starIndex < clampedRating;

                  return MouseRegion(
                    onEnter: (_) => setState(() => hoveredIndex = starIndex),
                    onExit: (_) => setState(() => hoveredIndex = null),
                    child: GestureDetector(
                      onTap: () => updateAssessment(thisUser, starIndex + 1),
                      child: Icon(
                        Icons.star,
                        color:
                            isHovered || isSelected
                                ? Colors.amber
                                : Colors.grey,
                        size: 32,
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      );
    }
  }
}
