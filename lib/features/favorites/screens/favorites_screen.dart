import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import 'package:simpsons_app/core/theme/app_styles.dart';
import 'package:simpsons_app/features/favorites/provider/favorite_provider.dart';
import 'package:simpsons_app/features/simpson_details/screen/simpson_details_screen.dart';
import 'package:simpsons_app/features/simpsons/models/simpson_model.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late final favoriteProviderRead = context.read<FavoriteProvider>();
  late final favoriteProviderWatch = context.watch<FavoriteProvider>();

  @override
  void initState() {
    favoriteProviderRead.initiliazeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: favoriteProviderWatch.isLoading
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
                    itemCount: favoriteProviderRead.characters.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SimpsonFavoriteCardWidget(
                            character: favoriteProviderRead.characters[index],
                          ),
                        ],
                      );
                    }),
              ),
      ),
    );
  }
}

class SimpsonFavoriteCardWidget extends StatelessWidget {
  const SimpsonFavoriteCardWidget({
    Key? key,
    required this.character,
  }) : super(key: key);

  final SimpsonModel character;

  @override
  Widget build(BuildContext context) {
    late final favoriteProviderRead = context.read<FavoriteProvider>();
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SimpsonDetailsScreen(
            simpson: character,
            onTap: favoriteProviderRead.onTap,
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
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/img/simpson_title.png'),
                  image: NetworkImage(character.image),
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: Container(
                alignment: Alignment.center,
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: AppStyles.whiteColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
