import 'package:mrasim_challenge/app/model/products_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductsController {
  static Database? _database;
  static const int _databaseVersion = 1;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'products.db');

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            imageUrl TEXT NOT NULL,
            price REAL NOT NULL,
            createdAt TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<bool> createProduct(String name, String imageUrl, double price) async {
    try {
      print('Creating product with URL: $imageUrl');
      if (!validateUrl(imageUrl)) {
        print('Invalid image URL format');
        return false;
      }

      final db = await database;
      final product = ProductsModel(
        name: name,
        imageUrl: imageUrl,
        price: price,
      );

      await db.insert('products', product.toMap());
      return true;
    } catch (e) {
      print('Error creating product: $e');
      return false;
    }
  }

  Future<List<ProductsModel>> getAllProducts() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('products', orderBy: 'createdAt DESC');
      return List.generate(maps.length, (i) => ProductsModel.fromMap(maps[i]));
    } catch (e) {
      print('Error getting products: $e');
      return [];
    }
  }

  Future<ProductsModel?> getProduct(int id) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'products',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return ProductsModel.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      print('Error getting product: $e');
      return null;
    }
  }

  Future<bool> updateProduct(int id, String name, String imageUrl, double price) async {
    try {
      if (!validateUrl(imageUrl)) {
        print('Invalid image URL format');
        return false;
      }

      final db = await database;
      final product = ProductsModel(
        id: id,
        name: name,
        imageUrl: imageUrl,
        price: price,
      );

      final rowsAffected = await db.update(
        'products',
        product.toMap(),
        where: 'id = ?',
        whereArgs: [id],
      );

      return rowsAffected > 0;
    } catch (e) {
      print('Error updating product: $e');
      return false;
    }
  }

  Future<bool> deleteProduct(int id) async {
    try {
      final db = await database;
      final rowsDeleted = await db.delete(
        'products',
        where: 'id = ?',
        whereArgs: [id],
      );
      return rowsDeleted > 0;
    } catch (e) {
      print('Error deleting product: $e');
      return false;
    }
  }

  bool validateName(String? name) {
    return name != null && name.trim().length >= 3;
  }

  bool validateUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    try {
      final uri = Uri.parse(url);
      if (!uri.isAbsolute) return false;

      final lowercasePath = uri.path.toLowerCase();
      final validImageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp'];

      if (url.contains('i.pinimg.com')) {
        return validImageExtensions.any((ext) => lowercasePath.endsWith(ext));
      }

      if (url.contains('pinterest.com')) {
        return false;
      }

      return validImageExtensions.any((ext) => lowercasePath.endsWith(ext));
    } catch (e) {
      return false;
    }
  }

  bool validatePrice(String? price) {
    if (price == null || price.isEmpty) return false;
    try {
      final priceValue = double.parse(price);
      return priceValue > 0;
    } catch (e) {
      return false;
    }
  }

  Future<bool> tableExists() async {
    try {
      final db = await database;
      final tables = await db.query(
        'sqlite_master',
        where: 'type = ? AND name = ?',
        whereArgs: ['table', 'products'],
      );
      return tables.isNotEmpty;
    } catch (e) {
      print('Error checking table existence: $e');
      return false;
    }
  }

  Future<void> clearTable() async {
    try {
      final db = await database;
      await db.delete('products');
    } catch (e) {
      print('Error clearing table: $e');
    }
  }
}
