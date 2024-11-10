class MovesList {
  late int count;
  late String? next;
  late String? previous;
  late List<Results> results;

  MovesList({required this.count, required this.next, required this.previous, required this.results});

  MovesList.fromJson(Map<String, dynamic> json) {
    try {
      count = json['count'];
      next = json['next'];
      previous = json['previous'] ?? ''; // Default to an empty string if null
      if (json['results'] != null) {
        results = <Results>[];
        json['results'].forEach((v) {
          results.add(new Results.fromJson(v));
        });
      }
    } catch (error) {
      // Handle the parse error here
      print("Error parsing MovesList: $error");
      print("Error type: ${error.runtimeType}");
      if (error.runtimeType == FormatException) {
        print("Invalid format: $error");
      }
      // else if (error.runtimeType == DioError) {
      //   print("Dio error: ${error.response?.statusCode}");
      // }
      else {
        print("Unexpected error: $error");
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  late String name;
  late String url;

  Results({required this.name, required this.url});

  Results.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
