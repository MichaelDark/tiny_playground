import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_playground/services/rick_and_morty_service.dart';

import '../di/locator.dart';
import '../generated/generated.logger.dart';
import '../models/rick_and_morty/models.dart';
import '../models/rick_and_morty/paginated_response.dart';

typedef PagingListener = void Function(int pageKey);

class HomeViewModel extends BaseViewModel {
  final log = getStackedLogger('HomeViewModel');
  final service = locator<RickAndMortyService>();
  final characterPagingController =
      PagingController<int, Character>(firstPageKey: 1);

  HomeViewModel() {
    characterPagingController.addPageRequestListener(_createCharactersPage());
  }

  PagingListener _createCharactersPage() {
    return createPageRequestListener(
      characterPagingController,
      (page) => service.restApi.getCharacters(page),
    );
  }

  PagingListener createPageRequestListener<T>(
    PagingController<int, T> controller,
    Future<PaginatedResponse<T>> Function(int? pageKey) loader,
  ) {
    return (int pageKey) async {
      try {
        final page = pageKey < 2 ? null : pageKey;
        final response = await loader(page);
        final newItems = response.results;
        final isLastPage = response.info.next == null;
        if (isLastPage) {
          controller.appendLastPage(newItems);
        } else {
          controller.appendPage(newItems, pageKey + 1);
        }
      } catch (error) {
        controller.error = error;
      }
      notifyListeners();
    };
  }
}
