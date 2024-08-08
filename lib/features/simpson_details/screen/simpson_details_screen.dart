import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:simpsons_app/core/theme/app_styles.dart';
import 'package:simpsons_app/features/settings/provider/setting_provider.dart';
import 'package:simpsons_app/features/simpson_details/bottom_sheet/bottom_sheet.dart';
import 'package:simpsons_app/features/simpson_details/provider/simpson_details_provider.dart';
import 'package:simpsons_app/features/simpson_details/widgets/custom_button_widget.dart';
import 'package:simpsons_app/features/simpson_details/widgets/outline_button_widget.dart';
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
  late SettingProvider settingProviderWatch = context.watch<SettingProvider>();

  @override
  void initState() {
    try {
      simpsonProviderRead.initiliazeData(character: widget.simpson);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppStyles.error500Color,
          duration: const Duration(seconds: 3),
          content: SizedBox(
            width: double.infinity,
            child: Text(settingProviderWatch.isSpanish
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
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Visibility(
          visible: !simpsonProviderWatch.isLoading,
          child: Container(
            width: double.infinity,
            color: Theme.of(context).colorScheme.primaryContainer,
            // padding: const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButtonWidget(
                  colorText: settingProviderWatch.isLight
                      ? AppStyles.blackColor
                      : AppStyles.whiteColor,
                  title: settingProviderWatch.isSpanish
                      ? 'Jugá con tus amigos '
                      : 'Play with friends',
                  submitFunction: () => BottomMenuTheme.showMenu(
                      context: context,
                      isScrollControlled: true,
                      autoHeight: true,
                      content: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 24),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Spacer(),
                                    InkWell(
                                      // ignore: prefer_if_null_operators
                                      onTap: () => Navigator.of(context).pop(),
                                      child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Image.asset(
                                          'assets/img/ic_close.png',
                                          color: settingProviderWatch.isLight
                                              ? AppStyles.blackColor
                                              : AppStyles.whiteColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  settingProviderWatch.isSpanish
                                      ? '¡Juga con tus amigos compartiendo la frase del personaje de los Simpson a ver si la adivinan!'
                                      : 'Play with your friends by sharing the Simpsons character\'s phrase to see if they can guess it!',
                                  style: TextStyle(
                                      color: settingProviderWatch.isLight
                                          ? AppStyles.blackColor
                                          : AppStyles.whiteColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: OutlineButtonWidget(
                                            colorText: settingProviderWatch
                                                    .isLight
                                                ? AppStyles.blackColor
                                                : AppStyles.whiteColor,
                                            colorBg: settingProviderWatch
                                                    .isLight
                                                ? AppStyles.whiteColor
                                                : AppStyles.lightGreen500Color,
                                            title:
                                                settingProviderWatch.isSpanish
                                                    ? 'Compartir pregunta'
                                                    : 'Share ask',
                                            submitFunction: () =>
                                                simpsonProviderRead.shareText(
                                                    isSpanish:
                                                        settingProviderWatch
                                                            .isSpanish,
                                                    text: settingProviderWatch
                                                            .isSpanish
                                                        ? '*¿Qué personaje de los Simpson dijo la siguiente frase?*\n${widget.simpson.quoteTranslatedIntoSpanish!}'
                                                        : '*Which Simpsons character said the following phrase?*\n${widget.simpson.quote}',
                                                    context: context))),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: OutlineButtonWidget(
                                            colorText: settingProviderWatch
                                                    .isLight
                                                ? AppStyles.blackColor
                                                : AppStyles.whiteColor,
                                            colorBg: settingProviderWatch
                                                    .isLight
                                                ? AppStyles.whiteColor
                                                : AppStyles.lightGreen500Color,
                                            title:
                                                settingProviderWatch.isSpanish
                                                    ? 'Compartir respuesta'
                                                    : 'Share response',
                                            submitFunction: () =>
                                                simpsonProviderRead.shareText(
                                                    isSpanish:
                                                        settingProviderWatch
                                                            .isSpanish,
                                                    text: settingProviderWatch
                                                            .isSpanish
                                                        ? '*${widget.simpson.character} dijo la frase:*\n${widget.simpson.quoteTranslatedIntoSpanish!}.'
                                                        : '*${widget.simpson.character} said the phrase:*\n${widget.simpson.quote}.',
                                                    context: context)))
                                  ],
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))),
            ),
          ),
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
                    backgroundColor: settingProviderWatch.isLight
                        ? AppStyles.gray200Color
                        : AppStyles.lightGreen500Color,
                    foregroundColor: settingProviderWatch.isLight
                        ? AppStyles.blackColor
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
                                  color: AppStyles.error500Color,
                                  size: 20,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  color: AppStyles.error500Color,
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
                          if (settingProviderWatch.isSpanish) ...[
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
