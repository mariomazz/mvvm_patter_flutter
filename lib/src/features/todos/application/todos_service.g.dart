// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todosServiceHash() => r'e5d9cd7e5856d73d5dc114615631f6f8d414113d';

/// See also [todosService].
@ProviderFor(todosService)
final todosServiceProvider = AutoDisposeProvider<TodosService>.internal(
  todosService,
  name: r'todosServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todosServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TodosServiceRef = AutoDisposeProviderRef<TodosService>;
String _$todosHash() => r'3b7fac2585c52300da50bc6690225edbc77f984f';

/// See also [todos].
@ProviderFor(todos)
final todosProvider = AutoDisposeStreamProvider<List<Todo>>.internal(
  todos,
  name: r'todosProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TodosRef = AutoDisposeStreamProviderRef<List<Todo>>;
String _$todoHash() => r'cbc92aaeda333d78133cae44e14e08b12f50c44c';

/// See also [todo].
@ProviderFor(todo)
final todoProvider = AutoDisposeStreamProvider<Todo>.internal(
  todo,
  name: r'todoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TodoRef = AutoDisposeStreamProviderRef<Todo>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
