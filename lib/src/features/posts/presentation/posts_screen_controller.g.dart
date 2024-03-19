// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_screen_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postsHash() => r'a3a58f6a15fdbf04142211c6f17bbc7052475452';

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

/// See also [posts].
@ProviderFor(posts)
const postsProvider = PostsFamily();

/// See also [posts].
class PostsFamily extends Family<AsyncValue<List<Post>>> {
  /// See also [posts].
  const PostsFamily();

  /// See also [posts].
  PostsProvider call({
    int? pageNumber,
    int? itemsPerPage,
  }) {
    return PostsProvider(
      pageNumber: pageNumber,
      itemsPerPage: itemsPerPage,
    );
  }

  @override
  PostsProvider getProviderOverride(
    covariant PostsProvider provider,
  ) {
    return call(
      pageNumber: provider.pageNumber,
      itemsPerPage: provider.itemsPerPage,
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
  String? get name => r'postsProvider';
}

/// See also [posts].
class PostsProvider extends AutoDisposeFutureProvider<List<Post>> {
  /// See also [posts].
  PostsProvider({
    int? pageNumber,
    int? itemsPerPage,
  }) : this._internal(
          (ref) => posts(
            ref as PostsRef,
            pageNumber: pageNumber,
            itemsPerPage: itemsPerPage,
          ),
          from: postsProvider,
          name: r'postsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postsHash,
          dependencies: PostsFamily._dependencies,
          allTransitiveDependencies: PostsFamily._allTransitiveDependencies,
          pageNumber: pageNumber,
          itemsPerPage: itemsPerPage,
        );

  PostsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pageNumber,
    required this.itemsPerPage,
  }) : super.internal();

  final int? pageNumber;
  final int? itemsPerPage;

  @override
  Override overrideWith(
    FutureOr<List<Post>> Function(PostsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PostsProvider._internal(
        (ref) => create(ref as PostsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pageNumber: pageNumber,
        itemsPerPage: itemsPerPage,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Post>> createElement() {
    return _PostsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostsProvider &&
        other.pageNumber == pageNumber &&
        other.itemsPerPage == itemsPerPage;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pageNumber.hashCode);
    hash = _SystemHash.combine(hash, itemsPerPage.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostsRef on AutoDisposeFutureProviderRef<List<Post>> {
  /// The parameter `pageNumber` of this provider.
  int? get pageNumber;

  /// The parameter `itemsPerPage` of this provider.
  int? get itemsPerPage;
}

class _PostsProviderElement extends AutoDisposeFutureProviderElement<List<Post>>
    with PostsRef {
  _PostsProviderElement(super.provider);

  @override
  int? get pageNumber => (origin as PostsProvider).pageNumber;
  @override
  int? get itemsPerPage => (origin as PostsProvider).itemsPerPage;
}

String _$postsScreenControllerHash() =>
    r'0dd323ff8a9d9f6be264a8f4c4ec788cc16cddb1';

/// See also [PostsScreenController].
@ProviderFor(PostsScreenController)
final postsScreenControllerProvider = AutoDisposeNotifierProvider<
    PostsScreenController, PostsScreenControllerState>.internal(
  PostsScreenController.new,
  name: r'postsScreenControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$postsScreenControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PostsScreenController
    = AutoDisposeNotifier<PostsScreenControllerState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
