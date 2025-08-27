// lib/models/folio.dart

enum FolioType {
    fixed, // e.g. pdf,
    reflowable // e.g. epub
}

class SeriesInfo {
  final String name;
  final int number;

  SeriesInfo({required this.name, required this.number});

  Map<String, dynamic> toMap() => {'name': name, 'number': number};
  factory SeriesInfo.fromMap(Map<String, dynamic> map) {
    return SeriesInfo(name: map['name'], number: map['number']);
  }
}
class Bookmark {
  final String location; // The anchor
  final String? note;    // An optional note from the user

  Bookmark({required this.location, this.note});

  Map<String, dynamic> toMap() => {'location': location, 'note': note};
  factory Bookmark.fromMap(Map<String, dynamic> map) {
    return Bookmark(location: map['location'], note: map['note']);
  }
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

    Map<String, dynamic> toMap() {
        return {
            'id': id,
            'filePath': filePath,
            'originalFileName': originalFileName,
            'title': title,
            'author': author,
            'coverImage': coverImage,
            'description': description,
            'seriesInfoJson': seriesInfo != null ? jsonEncode(seriesInfo!.toMap()) : null,
            'layoutType': layoutType,
            'progressJson': jsonEncode(progress),
            'dateAdded': dateAdded.toIso8601String(),
            'lastOpened': lastOpened.toIso8601String(),
            'shelfIDsJson': jsonEncode(shelfIDs),
            'tagsJson': jsonEncode(tags),
            'rating': rating,
            'bookmarksJson': jsonEncode(bookmarks.map((b) => b.toMap()).toList()),
        };
    }

    factory Folio.fromMap(Map<String, dynamic> map) {
        return Folio(
            id: map['id'],
            filePath: map['filePath'],
            originalFileName: map['originalFileName'],
            title: map['title'],
            author: map['author'],
            coverImage: map['coverImage'],
            description: map['description'],
            seriesInfo: map['seriesInfoJson'] != null ? SeriesInfo.fromMap(jsonDecode(map['seriesInfoJson'])) : null,
            layoutType: map['layoutType'],
            progress: jsonDecode(map['progressJson']),
            dateAdded: DateTime.parse(map['dateAdded']),
            lastOpened: DateTime.parse(map['lastOpened']),
            shelfIDs: List<String>.from(jsonDecode(map['shelfIDsJson'])),
            tags: List<String>.from(jsonDecode(map['tagsJson'])),
            rating: map['rating'],
            bookmarks: (jsonDecode(map['bookmarksJson']) as List).map((b) => Bookmark.fromMap(b)).toList(),
        );
    }
}