import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/theme.dart';
import 'package:simpsons_app/features/simpsons/models/simpson_model.dart';
import 'package:simpsons_app/features/simpsons/providers/simpson_provider.dart';
import 'package:simpsons_app/features/simpsons/screens/simpson_details/simpson_details_screen.dart';

class SimpsonListScreen extends StatefulWidget {
  static String routeName = 'simpsonListScreen';
  const SimpsonListScreen({super.key});

  @override
  State<SimpsonListScreen> createState() => _SimpsonListScreenState();
}

class _SimpsonListScreenState extends State<SimpsonListScreen> {
  late final simpsonProviderRead = context.read<SimpsonProvider>();
  late final simpsonProviderWatch = context.watch<SimpsonProvider>();
  @override
  void initState() {
    initData();
    super.initState();
  }

  Future<void> initData() async {
    await simpsonProviderRead.getSimponsList();
  }

  @override
  Widget build(BuildContext context) {
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
                          _CharacterCard(
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
                        _CharacterCard(
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

class _CharacterCard extends StatelessWidget {
  const _CharacterCard({
    Key? key,
    required this.character,
  }) : super(key: key);

  final SimpsonModel character;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, SimpsonDetailsScreen.routeName),
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
        child: FadeInImage(
          placeholder: const AssetImage('assets/img/simpson_title.png'),
          image: NetworkImage(character.image),
        ),
      ),
    );
  }
}
