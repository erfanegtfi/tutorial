class File {
  int id;
  int courseListId;
  String url;
  String type;

  File({this.id, this.courseListId, this.url, this.type});

  File.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseListId = json['course_list_id'];
    url = json['url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_list_id'] = this.courseListId;
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }
}