import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/theme.dart';
import 'package:simpsons_app/features/settings/provider/setting_provider.dart';
import 'package:simpsons_app/features/simpson_details/screen/simpson_details_screen.dart';
import 'package:simpsons_app/features/simpsons/models/simpson_model.dart';
import 'package:simpsons_app/features/simpsons/providers/simpson_provider.dart';
import 'package:simpsons_app/features/simpsons/widgets/input_search_widget.dart';

class SimpsonListScreen extends StatefulWidget {
  static String routeName = 'simpsonListScreen';
  const SimpsonListScreen({super.key});

  @override
  State<SimpsonListScreen> createState() => _SimpsonListScreenState();
}

class _SimpsonListScreenState extends State<SimpsonListScreen> {
  late final simpsonProviderRead = context.read<SimpsonProvider>();
  late final simpsonProviderWatch = context.watch<SimpsonProvider>();
  late SettingProvider settingProviderRead = context.read<SettingProvider>();
  late SettingProvider settingProviderWatch = context.watch<SettingProvider>();

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  Future<void> initializeData() async {
    try {
      await simpsonProviderRead.getSimponsList();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppStyles.error500Color,
          duration: const Duration(seconds: 3),
          content: SizedBox(
            width: double.infinity,
            child: Text(settingProviderRead.isSpanish
                ? 'Error al cargar los datos, intentelo más tarde.'
                : 'Error loading data, please try again later.'),
          ),
        ),
      );
    }
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
                child: Column(
                  children: [
                    InputSearchWidget(
                      onSearch: simpsonProviderRead.onSearchClient,
                      focusNode: simpsonProviderRead.focusNode,
                      constroller: simpsonProviderWatch.textController,
                      onTapOutside: (event) =>
                          simpsonProviderRead.focusNode.unfocus(),
                      hint: settingProviderRead.isSpanish
                          ? 'Buscar personaje...'
                          : 'Search character...',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (simpsonProviderWatch.searchSimpsons.isEmpty) ...[
                      Text(
                        settingProviderWatch.isSpanish
                            ? 'No se encontró ningún personaje'
                            : 'No character found',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: AppStyles.gray500Color,
                              spreadRadius: 0.1,
                              blurRadius: 0.1,
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Image.asset('assets/img/error-image.jpg'),
                      )
                    ],
                    Expanded(
                      child: MasonryGridView.count(
                        itemCount: simpsonProviderWatch.searchSimpsons.length,
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
                                  character: simpsonProviderWatch
                                      .searchSimpsons[index],
                                ),
                                if (index ==
                                    simpsonProviderWatch.searchSimpsons.length -
                                        1)
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
                                character:
                                    simpsonProviderWatch.searchSimpsons[index],
                              ),
                              if (index ==
                                  simpsonProviderWatch.searchSimpsons.length -
                                      1)
                                const SizedBox(
                                  height: 10,
                                )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
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
    SettingProvider watchSettingProvider = context.watch<SettingProvider>();
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
        decoration: BoxDecoration(
          color: watchSettingProvider.isLight
              ? AppStyles.gray200Color
              : AppStyles.lightGreen500Color,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: const [
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
