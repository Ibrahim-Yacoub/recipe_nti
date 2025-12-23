import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../../shared/widgets/error_state_widget.dart';
import '../../shared/widgets/favorite_icon_button.dart';
import '../../shared/widgets/info_tag.dart';
import '../../shared/widgets/loading_indicator.dart';
import 'cubit/meal_details_cubit.dart';
import 'cubit/meal_details_state.dart';

class MealDetailsView extends StatelessWidget {
  const MealDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MealDetailsCubit, MealDetailsState>(
        builder: (context, state) {
          if (state is MealDetailsLoading) {
            return const LoadingIndicator();
          }

          if (state is MealDetailsError) {
            return ErrorStateWidget(message: state.message);
          }

          if (state is MealDetailsLoaded) {
            final meal = state.meal;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: meal.strMealThumb,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    FavoriteIconButton(
                      isFavorite: state.isFavorite,
                      onPressed: () {
                        context.read<MealDetailsCubit>().toggleFavorite();
                      },
                      showBackground: false,
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.white),
                      onPressed: () {
                        if (meal.strSource != null && meal.strSource!.isNotEmpty) {
                          Share.share('Check out this recipe: ${meal.strMeal}\n${meal.strSource}');
                        } else if (meal.strYoutube != null && meal.strYoutube!.isNotEmpty) {
                          Share.share('Check out this recipe: ${meal.strMeal}\n${meal.strYoutube}');
                        } else {
                          Share.share('Check out this recipe: ${meal.strMeal}');
                        }
                      },
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meal.strMeal,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 16),

                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            if (meal.strCategory != null)
                              InfoTag(
                                text: meal.strCategory!,
                                icon: Icons.category,
                                color: Colors.orange,
                              ),
                            if (meal.strArea != null)
                              InfoTag(
                                text: meal.strArea!,
                                icon: Icons.public,
                                color: Colors.blue,
                              ),
                             if (meal.strTags != null && meal.strTags!.isNotEmpty)
                              ...meal.strTags!.split(',').map(
                                (tag) => InfoTag(
                                  text: tag.trim(),
                                  icon: Icons.label,
                                  color: Colors.green,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        const Text(
                          'Ingredients',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...meal.ingredients.map((ingredient) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.deepOrange,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    '${ingredient.name} - ${ingredient.measure}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: 24),

                        const Text(
                          'Instructions',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (meal.strInstructions != null)
                          Text(
                            meal.strInstructions!,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.6,
                            ),
                          ),
                        const SizedBox(height: 24),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (meal.strYoutube != null && meal.strYoutube!.isNotEmpty)
                              ElevatedButton.icon(
                                onPressed: () {
                                  _launchUrl(meal.strYoutube!);
                                },
                                icon: const Icon(Icons.play_circle_fill, color: Colors.white),
                                label: const Text('Watch on YouTube'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            if (meal.strYoutube != null && meal.strYoutube!.isNotEmpty)
                              const SizedBox(height: 12),
                            if (meal.strSource != null && meal.strSource!.isNotEmpty)
                              OutlinedButton.icon(
                                onPressed: () {
                                  _launchUrl(meal.strSource!);
                                },
                                icon: const Icon(Icons.link),
                                label: const Text('View Source'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.deepOrange,
                                  side: const BorderSide(color: Colors.deepOrange),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }


  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $urlString');
    }
  }
}
