class CurrentLine {
  final int order;
  final String tag;
  final String name;
  final String hour;

  CurrentLine({this.order, this.tag, this.name, this.hour});

  factory CurrentLine.fromJson(Map<String, dynamic> json) {
    return CurrentLine(
        order: json['ID'],
        tag: json['UName'],
        name: json['Email'],
        hour: json['password']);
  }
}
