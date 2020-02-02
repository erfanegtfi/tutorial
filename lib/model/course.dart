class Course {
  int id;
  int userCreatorId;
  int languageId;
  String title;
  String indexImg;
  String description;
  Null createdAt;
  Null updatedAt;
  int courseUserCount;

  Course(
      {this.id,
      this.userCreatorId,
      this.languageId,
      this.title,
      this.indexImg,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.courseUserCount});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userCreatorId = json['user_creator_id'];
    languageId = json['language_id'];
    title = json['title'];
    indexImg = json['index_img'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courseUserCount = json['course_user_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_creator_id'] = this.userCreatorId;
    data['language_id'] = this.languageId;
    data['title'] = this.title;
    data['index_img'] = this.indexImg;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['course_user_count'] = this.courseUserCount;
    return data;
  }
}
