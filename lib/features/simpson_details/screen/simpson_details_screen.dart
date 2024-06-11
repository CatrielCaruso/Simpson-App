import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:simpsons_app/core/preference/preference.dart';

import 'package:simpsons_app/core/theme/app_styles.dart';
import 'package:simpsons_app/features/simpson_details/provider/simpson_details_provider.dart';
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

  @override
  void initState() {
    simpsonProviderRead.initiliazeData(character: widget.simpson);
    super.initState();
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
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: AppStyles.gray200Color,
                    foregroundColor: AppStyles.whiteColor,
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
                            )
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
                          ]
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
