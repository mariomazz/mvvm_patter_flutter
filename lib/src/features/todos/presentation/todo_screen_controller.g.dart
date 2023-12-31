// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_screen_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoScreenControllerHash() =>
    r'997c280dfa2e61a7f9e87d708664fc08b29aeca6';

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

abstract class _$TodoScreenController
    extends BuildlessAutoDisposeNotifier<TodoScreenControllerState> {
  late final int todoId;

  TodoScreenControllerState build(
    int todoId,
  );
}

/// See also [TodoScreenController].
@ProviderFor(TodoScreenController)
const todoScreenControllerProvider = TodoScreenControllerFamily();

/// See also [TodoScreenController].
class TodoScreenControllerFamily extends Family<TodoScreenControllerState> {
  /// See also [TodoScreenController].
  const TodoScreenControllerFamily();

  /// See also [TodoScreenController].
  TodoScreenControllerProvider call(
    int todoId,
  ) {
    return TodoScreenControllerProvider(
      todoId,
    );
  }

  @override
  TodoScreenControllerProvider getProviderOverride(
    covariant TodoScreenControllerProvider provider,
  ) {
    return call(
      provider.todoId,
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
  String? get name => r'todoScreenControllerProvider';
}

/// See also [TodoScreenController].
class TodoScreenControllerProvider extends AutoDisposeNotifierProviderImpl<
    TodoScreenController, TodoScreenControllerState> {
  /// See also [TodoScreenController].
  TodoScreenControllerProvider(
    int todoId,
  ) : this._internal(
          () => TodoScreenController()..todoId = todoId,
          from: todoScreenControllerProvider,
          name: r'todoScreenControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$todoScreenControllerHash,
          dependencies: TodoScreenControllerFamily._dependencies,
          allTransitiveDependencies:
              TodoScreenControllerFamily._allTransitiveDependencies,
          todoId: todoId,
        );

  TodoScreenControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.todoId,
  }) : super.internal();

  final int todoId;

  @override
  TodoScreenControllerState runNotifierBuild(
    covariant TodoScreenController notifier,
  ) {
    return notifier.build(
      todoId,
    );
  }

  @override
  Override overrideWith(TodoScreenController Function() create) {
    return ProviderOverride(
      origin: this,
      override: TodoScreenControllerProvider._internal(
        () => create()..todoId = todoId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        todoId: todoId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TodoScreenController,
      TodoScreenControllerState> createElement() {
    return _TodoScreenControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TodoScreenControllerProvider && other.todoId == todoId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, todoId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TodoScreenControllerRef
    on AutoDisposeNotifierProviderRef<TodoScreenControllerState> {
  /// The parameter `todoId` of this provider.
  int get todoId;
}

class _TodoScreenControllerProviderElement
    extends AutoDisposeNotifierProviderElement<TodoScreenController,
        TodoScreenControllerState> with TodoScreenControllerRef {
  _TodoScreenControllerProviderElement(super.provider);

  @override
  int get todoId => (origin as TodoScreenControllerProvider).todoId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
