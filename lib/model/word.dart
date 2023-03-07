class Word{
  final int? id;
  final String wordName;
  final String wordDescription;

  Word({this.id, required this.wordName, required this.wordDescription});

  factory Word.fromMap(Map<String, dynamic> json) => new Word(
    id: json['id'],
    wordName: json['wordName'],
    wordDescription: json['wordDescription']
  );

  Map<String, dynamic> toMap() {
    return{
      'id': id,
      'wordName' : wordName,
      'wordDescription' : wordDescription,
    };
  }
}