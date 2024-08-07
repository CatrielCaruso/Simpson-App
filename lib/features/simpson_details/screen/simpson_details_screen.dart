import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:simpsons_app/core/preference/preference.dart';

import 'package:simpsons_app/core/theme/app_styles.dart';
import 'package:simpsons_app/features/settings/provider/setting_provider.dart';
import 'package:simpsons_app/features/simpson_details/provider/simpson_details_provider.dart';
import 'package:simpsons_app/features/simpson_details/widgets/custom_button_widget.dart';
import 'package:simpsons_app/features/simpsons/models/simpson_model.dart';

class SimpsonDetailsScreen extends StatefulWidget {
  final SimpsonModel simpson;
  final Function? onTap;

  const SimpsonDetailsScreen({
    super.key,
    required this.simpson,
    this.onTap,
  });

  @override
  State<SimpsonDetailsScreen> createState() => _SimpsonDetailsScreenState();
}

class _SimpsonDetailsScreenState extends State<SimpsonDetailsScreen> {
  late final simpsonProviderRead = context.read<SimpsonDetailsProvider>();
  late final simpsonProviderWatch = context.watch<SimpsonDetailsProvider>();
  late SettingProvider settingProviderRead = context.read<SettingProvider>();

  @override
  void initState() {
    try {
      simpsonProviderRead.initiliazeData(character: widget.simpson);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SettingProvider watchSettingProvider = context.watch<SettingProvider>();
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child: CustomButtonWidget(
              title: 'Jugá con tus amigos ', submitFunction: () {}),
        ),
        body: simpsonProviderWatch.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppStyles.lightGreen500Color,
                ),
              )
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: watchSettingProvider.isLight
                        ? AppStyles.gray200Color
                        : AppStyles.lightGreen500Color,
                    foregroundColor: watchSettingProvider.isLight
                        ? Colors.black
                        : AppStyles.whiteColor,
                    actions: [
                      Container(
                        alignment: Alignment.center,
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: AppStyles.whiteColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () => simpsonProviderRead.toggleFavorite(
                              character: widget.simpson, onTap: widget.onTap),
                          child: simpsonProviderWatch.simpson.isFavorite
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 20,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                  size: 20,
                                ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      )
                    ],
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Hero(
                          tag: widget.simpson.id!,
                          child: Image.network(widget.simpson.image)),
                    ),
                    expandedHeight: MediaQuery.of(context).size.height * 0.5,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.simpson.character,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          if (Preferences.isSpanish) ...[
                            const Text(
                              'Frase:',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.simpson.quoteTranslatedIntoSpanish!,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ] else ...[
                            const Text(
                              'Quote:',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.simpson.quote,
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                          const SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
