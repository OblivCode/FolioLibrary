// lib/services/database.dart
import 'dart:io';

class DatabaseService {
    // Singleton instance
    static final DatabaseService _instance = DatabaseService._privateConstructor();
    // Private constructor
    DatabaseService._privateConstructor();

    static Database? _database;
    Future<Database> get database async => _database ??= await _initDatabase();
    
    Future<Database> _initDatabase() async {
        // Get the path to the documents directory.
        final documentsDirectory = await getApplicationDocumentsDirectory();
        final path = join(documentsDirectory.path, 'folio_library.db');
        
        // Open the database and create the table if it doesn't exist
        return await openDatabase(
            path,
            version: 1,
            onCreate: _onCreate,
        );
    }

    // Called when database is first created
    Future _onCreate(Database db, int version) async {
        await db.execute('''
            CREATE TABLE folios (
                id TEXT PRIMARY KEY,
            filePath TEXT NOT NULL,
            originalFileName TEXT NOT NULL,
            title TEXT NOT NULL,
            author TEXT NOT NULL,
            coverImage TEXT NOT NULL,
            description TEXT,
            seriesInfoJson TEXT,
            layoutType TEXT NOT NULL,
            progressJson TEXT NOT NULL,
            dateAdded TEXT NOT NULL,
            lastOpened TEXT NOT NULL,
            shelfIDsJson TEXT NOT NULL,
            tagsJson TEXT,
            rating INTEGER,
            bookmarksJson TEXT
            )
        ''');
    }
}