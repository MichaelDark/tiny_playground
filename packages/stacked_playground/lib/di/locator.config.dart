// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i3;

import '../services/rick_and_morty_service.dart' as _i4;
import 'modules/third_party_module.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initDependencies(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final thirdPartyModule = _$ThirdPartyModule();
  gh.lazySingleton<_i3.BottomSheetService>(
      () => thirdPartyModule.bottomSheetService);
  gh.lazySingleton<_i3.DialogService>(() => thirdPartyModule.dialogService);
  gh.lazySingleton<_i3.NavigationService>(
      () => thirdPartyModule.navigationService);
  gh.lazySingleton<_i4.RickAndMortyService>(() => _i4.RickAndMortyService());
  gh.lazySingleton<_i3.SnackbarService>(() => thirdPartyModule.snackBarService);
  return get;
}

class _$ThirdPartyModule extends _i5.ThirdPartyModule {
  @override
  _i3.BottomSheetService get bottomSheetService => _i3.BottomSheetService();
  @override
  _i3.DialogService get dialogService => _i3.DialogService();
  @override
  _i3.NavigationService get navigationService => _i3.NavigationService();
  @override
  _i3.SnackbarService get snackBarService => _i3.SnackbarService();
}
