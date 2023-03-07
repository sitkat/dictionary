// Класс, отвечающий за запросы к БД
abstract class DataBaseRequest {
  /// Запрос для создания таблицы Role
  // static const String _createTableRole =
  //     'CREATE TABLE "$tableRole" ("id" INTEGER,"role" TEXT NOT NULL UNIQUE, PRIMARY KEY("id" AUTOINCREMENT))';

  /// Запрос для создания таблицы Users
  // static const String _createTableUser =
  //     'CREATE TABLE "$tableUser" ("id"	INTEGER,"login"	TEXT NOT NULL UNIQUE,"password"	TEXT NOT NULL,"id_role"	INTEGER,FOREIGN KEY("id_role") REFERENCES "Role"("id"),PRIMARY KEY("id"))';

  /// Запрос для создания таблицы Category
  // static const String _createTableCategory =
  //     'CREATE TABLE "$tableCategory" ("id" INTEGER,"category" TEXT NOT NULL UNIQUE, PRIMARY KEY("id" AUTOINCREMENT))';

  /// Запрос для создания таблицы Product
  // static const String _createTableProduct =
  //     'CREATE TABLE "$tableProduct" ("id" INTEGER NOT NULL, "name" TEXT NOT NULL, "cost"	INTEGER NOT NULL, "id_category"	INTEGER NOT NULL, "id_size"	INTEGER NOT NULL,  "id_brand"	INTEGER NOT NULL, "id_color" INTEGER NOT NULL, "id_season"	INTEGER NOT NULL, PRIMARY KEY("id" AUTOINCREMENT), FOREIGN KEY("id_category") REFERENCES "Category"("id"), FOREIGN KEY("id_size") REFERENCES "Size"("id"), FOREIGN KEY("id_brand") REFERENCES "Brand"("id"), FOREIGN KEY("id_color") REFERENCES "Color"("id"), FOREIGN KEY("id_season") REFERENCES "Season"("id"))';
  //
  // /// Запрос для создания таблицы Basket
  // static const String _createTableBasket =
  //     'CREATE TABLE "$tableBasket" ("id" INTEGER,"id_product" INTEGER NOT NULL, "id_user" INTEGER NOT NULL, PRIMARY KEY("id" AUTOINCREMENT), FOREIGN KEY("id_product") REFERENCES "Product"("id"), FOREIGN KEY("id_user") REFERENCES "Users"("id"))';

  /// Запрос для создания таблицы Orders
  // static const String _createTableOrder =
  //     'CREATE TABLE "$tableOrder" ("id"	INTEGER,"cost" INTEGER NOT NULL,"address" TEXT NOT NULL,"id_basket" INTEGER NOT NULL, PRIMARY KEY("id" AUTOINCREMENT), FOREIGN KEY("id_basket") REFERENCES "Basket"("id"))';
  //ON DELETE CASCADE

  /// Запрос для создания таблицы Words
  static const String _createTableWord =
      'CREATE TABLE "$tableWord" ("id" INTEGER,"wordName" TEXT NOT NULL, "wordDescription" TEXT NOT NULL, "edition" DATE, PRIMARY KEY("id" AUTOINCREMENT))';

  static String deleteTable(String table) => 'DROP TABLE $table';

  /// Таблица Роли
  ///
  /// Поля таблицы: Название роли

  // static const String tableRole = 'Role';

  /// Таблица Пользователи
  ///
  /// Поля таблицы: Логин, Пароль, Роль

  // static const String tableUser = 'User';
  // static const String tableCategory = 'Category';
  // static const String tableProduct = 'Product';
  // static const String tableBasket = 'Basket';
  // static const String tableOrder = 'Order';

  /// Таблица Слов
  ///
  /// Поля таблицы: id, Название, Описание, Редакция

  static const String tableWord = 'Word';


  static const List<String> tableList = [
    // tableRole,
    // tableUser,
    // tableCategory,
    // tableProduct,
    // tableBasket,
    // tableOrder,
    tableWord,
  ];

  static const List<String> tableCreateList = [
    // _createTableRole,
    // _createTableUser,
    // _createTableCategory,
    // _createTableProduct,
    // _createTableBasket,
    // _createTableOrder,
    _createTableWord,
  ];
}
