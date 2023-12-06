// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reload_profile_button_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reloadProfileButtonControllerHash() =>
    r'cc151ca7e2e1f34a60af2ebd6e6eb44588a10fef';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ReloadProfileButtonController
    extends BuildlessAutoDisposeNotifier<ReloadProfileButtonControllerState> {
  late final ProfileScreenController parentViewModel;

  ReloadProfileButtonControllerState build(
    ProfileScreenController parentViewModel,
  );
}

/// See also [ReloadProfileButtonController].
@ProviderFor(ReloadProfileButtonController)
const reloadProfileButtonControllerProvider =
    ReloadProfileButtonControllerFamily();

/// See also [ReloadProfileButtonController].
class ReloadProfileButtonControllerFamily
    extends Family<ReloadProfileButtonControllerState> {
  /// See also [ReloadProfileButtonController].
  const ReloadProfileButtonControllerFamily();

  /// See also [ReloadProfileButtonController].
  ReloadProfileButtonControllerProvider call(
    ProfileScreenController parentViewModel,
  ) {
    return ReloadProfileButtonControllerProvider(
      parentViewModel,
    );
  }

  @override
  ReloadProfileButtonControllerProvider getProviderOverride(
    covariant ReloadProfileButtonControllerProvider provider,
  ) {
    return call(
      provider.parentViewModel,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'reloadProfileButtonControllerProvider';
}

/// See also [ReloadProfileButtonController].
class ReloadProfileButtonControllerProvider
    extends AutoDisposeNotifierProviderImpl<ReloadProfileButtonController,
        ReloadProfileButtonControllerState> {
  /// See also [ReloadProfileButtonController].
  ReloadProfileButtonControllerProvider(
    ProfileScreenController parentViewModel,
  ) : this._internal(
          () => ReloadProfileButtonController()
            ..parentViewModel = parentViewModel,
          from: reloadProfileButtonControllerProvider,
          name: r'reloadProfileButtonControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$reloadProfileButtonControllerHash,
          dependencies: ReloadProfileButtonControllerFamily._dependencies,
          allTransitiveDependencies:
              ReloadProfileButtonControllerFamily._allTransitiveDependencies,
          parentViewModel: parentViewModel,
        );

  ReloadProfileButtonControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.parentViewModel,
  }) : super.internal();

  final ProfileScreenController parentViewModel;

  @override
  ReloadProfileButtonControllerState runNotifierBuild(
    covariant ReloadProfileButtonController notifier,
  ) {
    return notifier.build(
      parentViewModel,
    );
  }

  @override
  Override overrideWith(ReloadProfileButtonController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ReloadProfileButtonControllerProvider._internal(
        () => create()..parentViewModel = parentViewModel,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        parentViewModel: parentViewModel,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ReloadProfileButtonController,
      ReloadProfileButtonControllerState> createElement() {
    return _ReloadProfileButtonControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReloadProfileButtonControllerProvider &&
        other.parentViewModel == parentViewModel;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, parentViewModel.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ReloadProfileButtonControllerRef
    on AutoDisposeNotifierProviderRef<ReloadProfileButtonControllerState> {
  /// The parameter `parentViewModel` of this provider.
  ProfileScreenController get parentViewModel;
}

class _ReloadProfileButtonControllerProviderElement
    extends AutoDisposeNotifierProviderElement<ReloadProfileButtonController,
        ReloadProfileButtonControllerState>
    with ReloadProfileButtonControllerRef {
  _ReloadProfileButtonControllerProviderElement(super.provider);

  @override
  ProfileScreenController get parentViewModel =>
      (origin as ReloadProfileButtonControllerProvider).parentViewModel;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
