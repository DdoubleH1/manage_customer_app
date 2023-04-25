import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/customer.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'Customerss.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Customers(
          id INTEGER PRIMARY KEY,
          name TEXT,
          email TEXT,
          phone TEXT,
          gender TEXT
      )
      ''');
  }

  Future<List<Customer>> getCustomer() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> customers =
        await db.query('Customers', orderBy: 'name');
    // print(customers);
    List<Customer> customerList = customers.isNotEmpty
        ? customers.map((c) => Customer.frommap(c)).toList()
        : [];
    return customerList;
  }

  Future<int> add(Customer customer) async {
    Database db = await instance.database;
    return await db.insert('Customers', customer.toMap());
  }

  Future<List<Customer>> searchCustomer(String keyWord) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> allRows = await db
        .query('Customers', where: 'phone LIKE ?', whereArgs: ['$keyWord%']);
    List<Customer> customerSearchList =
        allRows.map((c) => Customer.frommap(c)).toList();
    return customerSearchList;
  }
}
