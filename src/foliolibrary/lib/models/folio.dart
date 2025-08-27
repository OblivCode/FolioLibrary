// lib/models/folio.dart

enum FolioType {
    fixed, // e.g. pdf,
    reflowable // e.g. epub
}

class SeriesInfo {
  final String name;
  final int number;

  SeriesInfo({required this.name, required this.number});
}
class Bookmark {
  final String location; // The anchor
  final String? note;    // An optional note from the user

  Bookmark({required this.location, this.note});
}

class Folio {
    // Core Identification
    final String id;
    final String filePath;
    final String originalFileName;
    // Display
    final String title;
    final String? description;
    final String coverImage;
    final String author;
    final SeriesInfo? seriesInfo;
    // App-specific data
    final FolioType type;
    final Map<String, dynamic> progress; // Stores page number or percentage/anchor
    final DateTime dateAdded;
    final DateTime lastOpened;
    // User-generated data
    final List<String> shelfIDs;
    final List<String>? tags;
    final int? rating; // 1 to 5
    final List<Bookmark>? bookmarks;
    
    // Constructor
    Folio({
      required this.id,
      required this.filePath,
      required this.originalFileName,
      required this.title,
      this.description,
      required this.coverImage,
      required this.author,
      this.seriesInfo,
      required this.type,
      required this.progress,
      required this.dateAdded,
      required this.lastOpened,
      required this.shelfIDs,
      this.tags,
      this.rating,
      this.bookmarks,
    });
}