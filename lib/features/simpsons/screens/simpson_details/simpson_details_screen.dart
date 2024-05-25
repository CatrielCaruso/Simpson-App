import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:simpsons_app/core/theme/app_styles.dart';
import 'package:simpsons_app/features/simpsons/models/simpson_model.dart';
import 'package:simpsons_app/features/simpsons/providers/simpson_provider.dart';

class SimpsonDetailsScreen extends StatelessWidget {
  final SimpsonModel simpson;

  const SimpsonDetailsScreen({super.key, required this.simpson});

  @override
  Widget build(BuildContext context) {
    late final simpsonProviderRead = context.read<SimpsonProvider>();

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppStyles.gray200Color,
          onPressed: () => null,
          child: Image.asset('assets/img/ic_whatsApp.png'),
        ),
        body: CustomScrollView(
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
                  child: const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  width: 5,
                )
              ],
              flexibleSpace: Hero(
                  tag: simpson.index!, child: Image.network(simpson.image)),
              expandedHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      simpson.character,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Frase:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      simpson.quoteTranslatedIntoSpanish!,
                      style: const TextStyle(fontSize: 20),
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
