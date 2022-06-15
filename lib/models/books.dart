class Books {
  String status;
  int code;
  int total;
  List<Book> data;

  Books({this.status, this.code, this.total, this.data});

  Books.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    total = json['total'];
    if (json['data'] != null) {
      data = <Book>[];
      json['data'].forEach((v) {
        data.add(new Book.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Book {
  int id;
  String title;
  String author;
  String genre;
  String description;
  String isbn;
  String image;
  String published;
  String publisher;

  Book(
      {this.id,
      this.title,
      this.author,
      this.genre,
      this.description,
      this.isbn,
      this.image,
      this.published,
      this.publisher});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    genre = json['genre'];
    description = json['description'];
    isbn = json['isbn'];
    image = json['image'];
    published = json['published'];
    publisher = json['publisher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author'] = this.author;
    data['genre'] = this.genre;
    data['description'] = this.description;
    data['isbn'] = this.isbn;
    data['image'] = this.image;
    data['published'] = this.published;
    data['publisher'] = this.publisher;
    return data;
  }
}
