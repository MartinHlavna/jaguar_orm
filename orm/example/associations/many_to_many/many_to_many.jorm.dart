// GENERATED CODE - DO NOT MODIFY BY HAND

part of example.many_to_many;

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _TodoListBean implements Bean<TodoList> {
  final id = new StrField('id');
  final description = new StrField('description');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        description.name: description,
      };
  TodoList fromMap(Map map) {
    TodoList model = TodoList();

    model.id = adapter.parseValue(map['id']);
    model.description = adapter.parseValue(map['description']);

    return model;
  }

  List<SetColumn> toSetColumns(TodoList model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(id.set(model.id));
      ret.add(description.set(model.description));
    } else {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(description.name))
        ret.add(description.set(model.description));
    }

    return ret;
  }

  Future<void> createTable() async {
    final st = Sql.create(tableName);
    st.addStr(id.name, primary: true, length: 50, isNullable: false);
    st.addStr(description.name, length: 50, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(TodoList model, {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    var retId = await adapter.insert(insert);
    if (cascade) {
      TodoList newModel;
      if (model.categories != null) {
        newModel ??= await find(model.id);
        for (final child in model.categories) {
          await categoryBean.insert(child);
          await pivotBean.attach(model, child);
        }
      }
    }
    return retId;
  }

  Future<void> insertMany(List<TodoList> models, {bool cascade: false}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(insert(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
      final List<List<SetColumn>> data =
          models.map((model) => toSetColumns(model)).toList();
      final InsertMany insert = inserters.addAll(data);
      await adapter.insertMany(insert);
      return;
    }
  }

  Future<int> update(TodoList model,
      {bool cascade: false, bool associate: false, Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    final ret = adapter.update(update);
    if (cascade) {
      TodoList newModel;
      if (model.categories != null) {
        for (final child in model.categories) {
          await await categoryBean.update(child);
        }
      }
    }
    return ret;
  }

  Future<void> updateMany(List<TodoList> models, {bool cascade: false}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(update(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
      final List<List<SetColumn>> data = [];
      final List<Expression> where = [];
      for (var i = 0; i < models.length; ++i) {
        var model = models[i];
        data.add(toSetColumns(model).toList());
        where.add(this.id.eq(model.id));
      }
      final UpdateMany update = updaters.addAll(data, where);
      await adapter.updateMany(update);
      return;
    }
  }

  Future<TodoList> find(String id,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    final TodoList model = await findOne(find);
    if (preload) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(String id, [bool cascade = false]) async {
    if (cascade) {
      final TodoList newModel = await find(id);
      await pivotBean.detachTodoList(newModel);
    }
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<TodoList> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<TodoList> preload(TodoList model, {bool cascade: false}) async {
    model.categories = await pivotBean.fetchByTodoList(model);
    return model;
  }

  Future<List<TodoList>> preloadAll(List<TodoList> models,
      {bool cascade: false}) async {
    for (TodoList model in models) {
      var temp = await pivotBean.fetchByTodoList(model);
      if (model.categories == null)
        model.categories = temp;
      else {
        model.categories.clear();
        model.categories.addAll(temp);
      }
    }
    return models;
  }

  PivotBean get pivotBean;

  CategoryBean get categoryBean;
}

abstract class _CategoryBean implements Bean<Category> {
  final id = new StrField('id');
  final name = new StrField('name');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        name.name: name,
      };
  Category fromMap(Map map) {
    Category model = Category();

    model.id = adapter.parseValue(map['id']);
    model.name = adapter.parseValue(map['name']);

    return model;
  }

  List<SetColumn> toSetColumns(Category model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(id.set(model.id));
      ret.add(name.set(model.name));
    } else {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(name.name)) ret.add(name.set(model.name));
    }

    return ret;
  }

  Future<void> createTable() async {
    final st = Sql.create(tableName);
    st.addStr(id.name, primary: true, length: 50, isNullable: false);
    st.addStr(name.name, length: 50, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Category model, {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    var retId = await adapter.insert(insert);
    if (cascade) {
      Category newModel;
      if (model.todolists != null) {
        newModel ??= await find(model.id);
        for (final child in model.todolists) {
          await todoListBean.insert(child);
          await pivotBean.attach(child, model);
        }
      }
    }
    return retId;
  }

  Future<void> insertMany(List<Category> models, {bool cascade: false}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(insert(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
      final List<List<SetColumn>> data =
          models.map((model) => toSetColumns(model)).toList();
      final InsertMany insert = inserters.addAll(data);
      await adapter.insertMany(insert);
      return;
    }
  }

  Future<int> update(Category model,
      {bool cascade: false, bool associate: false, Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    final ret = adapter.update(update);
    if (cascade) {
      Category newModel;
      if (model.todolists != null) {
        for (final child in model.todolists) {
          await await todoListBean.update(child);
        }
      }
    }
    return ret;
  }

  Future<void> updateMany(List<Category> models, {bool cascade: false}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(update(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
      final List<List<SetColumn>> data = [];
      final List<Expression> where = [];
      for (var i = 0; i < models.length; ++i) {
        var model = models[i];
        data.add(toSetColumns(model).toList());
        where.add(this.id.eq(model.id));
      }
      final UpdateMany update = updaters.addAll(data, where);
      await adapter.updateMany(update);
      return;
    }
  }

  Future<Category> find(String id,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    final Category model = await findOne(find);
    if (preload) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(String id, [bool cascade = false]) async {
    if (cascade) {
      final Category newModel = await find(id);
      await pivotBean.detachCategory(newModel);
    }
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Category> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<Category> preload(Category model, {bool cascade: false}) async {
    model.todolists = await pivotBean.fetchByCategory(model);
    return model;
  }

  Future<List<Category>> preloadAll(List<Category> models,
      {bool cascade: false}) async {
    for (Category model in models) {
      var temp = await pivotBean.fetchByCategory(model);
      if (model.todolists == null)
        model.todolists = temp;
      else {
        model.todolists.clear();
        model.todolists.addAll(temp);
      }
    }
    return models;
  }

  PivotBean get pivotBean;

  TodoListBean get todoListBean;
}

abstract class _PivotBean implements Bean<Pivot> {
  final todolistId = new StrField('todolist_id');
  final categoryId = new StrField('category_id');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        todolistId.name: todolistId,
        categoryId.name: categoryId,
      };
  Pivot fromMap(Map map) {
    Pivot model = Pivot();

    model.todolistId = adapter.parseValue(map['todolist_id']);
    model.categoryId = adapter.parseValue(map['category_id']);

    return model;
  }

  List<SetColumn> toSetColumns(Pivot model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(todolistId.set(model.todolistId));
      ret.add(categoryId.set(model.categoryId));
    } else {
      if (only.contains(todolistId.name))
        ret.add(todolistId.set(model.todolistId));
      if (only.contains(categoryId.name))
        ret.add(categoryId.set(model.categoryId));
    }

    return ret;
  }

  Future<void> createTable() async {
    final st = Sql.create(tableName);
    st.addStr(todolistId.name,
        foreignTable: todoListBean.tableName,
        foreignCol: 'id',
        length: 50,
        isNullable: false);
    st.addStr(categoryId.name,
        foreignTable: categoryBean.tableName,
        foreignCol: 'id',
        length: 50,
        isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Pivot model) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<Pivot> models) async {
    final List<List<SetColumn>> data =
        models.map((model) => toSetColumns(model)).toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<void> updateMany(List<Pivot> models) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(toSetColumns(model).toList());
      where.add(null);
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<List<Pivot>> findByTodoList(String todolistId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.todolistId.eq(todolistId));
    return findMany(find);
  }

  Future<List<Pivot>> findByTodoListList(List<TodoList> models,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder;
    for (TodoList model in models) {
      find.or(this.todolistId.eq(model.id));
    }
    return findMany(find);
  }

  Future<int> removeByTodoList(String todolistId) async {
    final Remove rm = remover.where(this.todolistId.eq(todolistId));
    return await adapter.remove(rm);
  }

  void associateTodoList(Pivot child, TodoList parent) {
    child.todolistId = parent.id;
  }

  Future<int> detachTodoList(TodoList model) async {
    final dels = await findByTodoList(model.id);
    await removeByTodoList(model.id);
    final exp = new Or();
    for (final t in dels) {
      exp.or(categoryBean.id.eq(t.categoryId));
    }
    return await categoryBean.removeWhere(exp);
  }

  Future<List<Category>> fetchByTodoList(TodoList model) async {
    final pivots = await findByTodoList(model.id);
    final exp = new Or();
    for (final t in pivots) {
      exp.or(categoryBean.id.eq(t.categoryId));
    }
    return await categoryBean.findWhere(exp);
  }

  Future<List<Pivot>> findByCategory(String categoryId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.categoryId.eq(categoryId));
    return findMany(find);
  }

  Future<List<Pivot>> findByCategoryList(List<Category> models,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder;
    for (Category model in models) {
      find.or(this.categoryId.eq(model.id));
    }
    return findMany(find);
  }

  Future<int> removeByCategory(String categoryId) async {
    final Remove rm = remover.where(this.categoryId.eq(categoryId));
    return await adapter.remove(rm);
  }

  void associateCategory(Pivot child, Category parent) {
    child.categoryId = parent.id;
  }

  Future<int> detachCategory(Category model) async {
    final dels = await findByCategory(model.id);
    await removeByCategory(model.id);
    final exp = new Or();
    for (final t in dels) {
      exp.or(todoListBean.id.eq(t.todolistId));
    }
    return await todoListBean.removeWhere(exp);
  }

  Future<List<TodoList>> fetchByCategory(Category model) async {
    final pivots = await findByCategory(model.id);
    final exp = new Or();
    for (final t in pivots) {
      exp.or(todoListBean.id.eq(t.todolistId));
    }
    return await todoListBean.findWhere(exp);
  }

  Future<dynamic> attach(TodoList one, Category two) async {
    final ret = new Pivot();
    ret.todolistId = one.id;
    ret.categoryId = two.id;
    return insert(ret);
  }

  TodoListBean get todoListBean;
  CategoryBean get categoryBean;
}
