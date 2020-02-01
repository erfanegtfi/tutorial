class Language {
  int id;
  String name;


  Language({this.id, this.name});

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
  
    return data;
  }

  @override
  String toString() {
    
    return name;
  }
}