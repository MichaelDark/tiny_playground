import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_playground/view_models/home_view_model.dart';

import '../models/rick_and_morty/models.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        return const Scaffold(
          body: SafeArea(
            child: CharacterListView(),
          ),
        );
      },
    );
  }
}

class CharacterListAppBar extends ViewModelWidget<HomeViewModel> {
  const CharacterListAppBar({super.key});

  @override
  bool get reactive => true;

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    final list = viewModel.characterPagingController.itemList;
    final countSuffix = list != null ? ' (${list.length})' : '';
    return Text('Characters$countSuffix');
  }
}

class CharacterListView extends ViewModelWidget<HomeViewModel> {
  const CharacterListView({super.key});

  @override
  bool get reactive => false;

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return CustomScrollView(
      slivers: [
        SliverAppBar.medium(title: const CharacterListAppBar()),
        PagedSliverGrid<int, Character>(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.5,
          ),
          pagingController: viewModel.characterPagingController,
          builderDelegate: PagedChildBuilderDelegate<Character>(
            animateTransitions: true,
            itemBuilder: (context, item, index) => CharacterView(item),
          ),
        ),
      ],
    );
  }
}

class CharacterView extends StatelessWidget {
  final Character character;

  const CharacterView(this.character, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: ShapeDecoration(
        color: Colors.blue.shade50,
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 24,
            cornerSmoothing: 1,
          ),
        ),
        shadows: const [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black26,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            height: 64,
            width: 64,
            child: ClipRRect(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 24,
                cornerSmoothing: 1,
              ),
              child: CachedNetworkImage(
                imageUrl: character.image,
                placeholder: (_, __) => const CircularProgressIndicator(),
                errorWidget: (_, __, ___) => const Icon(Icons.error),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 4,
                  ),
                  child: Text(
                    character.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 4,
                  ),
                  child: Text(
                    character.type,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
