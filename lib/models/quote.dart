/// A model representing an inspirational quote.
class Quote {
  final String text;
  final String author;

  const Quote({
    required this.text,
    required this.author,
  });

  /// Factory constructor to create a [Quote] from a JSON map.
  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      text: json['text'] as String,
      author: json['author'] as String,
    );
  }

  /// Converts this [Quote] instance into a JSON-compatible map.
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'author': author,
    };
  }
}
