import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:simpsons_app/features/simpsons/models/simpson_model.dart';

import '../../../../core/theme/theme.dart';
import 'package:simpsons_app/features/simpson_details/screen/simpson_details_screen.dart';
import 'package:simpsons_app/features/simpsons/providers/simpson_provider.dart';

class SimpsonListScreen extends StatelessWidget {
  static String routeName = 'simpsonListScreen';
  const SimpsonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late final simpsonProviderRead = context.read<SimpsonProvider>();
    late final simpsonProviderWatch = context.watch<SimpsonProvider>();
    return SafeArea(
      child: Scaffold(
        body: simpsonProviderWatch.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppStyles.lightGreen500Color,
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 10,
                  left: 10,
                ),
                child: MasonryGridView.count(
                  itemCount: simpsonProviderRead.characters.length,
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  itemBuilder: (context, index) {
                    if (index == 1) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          _SimpsonCardWidget(
                            character: simpsonProviderRead.characters[index],
                          ),
                          if (index ==
                              simpsonProviderRead.characters.length - 1)
                            const SizedBox(
                              height: 10,
                            )
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _SimpsonCardWidget(
                          character: simpsonProviderRead.characters[index],
                        ),
                        if (index == simpsonProviderRead.characters.length - 1)
                          const SizedBox(
                            height: 10,
                          )
                      ],
                    );
                  },
                ),
              ),
      ),
    );
  }
}

class _SimpsonCardWidget extends StatelessWidget {
  const _SimpsonCardWidget({
    Key? key,
    required this.character,
  }) : super(key: key);

  final SimpsonModel character;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SimpsonDetailsScreen(
            simpson: character,
          ),
        ),
      ),
      child: Container(
        height: 200,
        decoration: const BoxDecoration(
          color: AppStyles.gray200Color,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: AppStyles.gray500Color,
              spreadRadius: 0.1,
              blurRadius: 0.1,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Align(
          alignment: Alignment.center,
          child: Hero(
            tag: character.id!,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: FadeInImage(
                placeholder: const AssetImage('assets/img/simpson_title.png'),
                image: NetworkImage(character.image),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
