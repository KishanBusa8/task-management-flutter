enum TaskStatus {
  todo,
  inProgress,
  done,
}

class Task {
  String? title;
  String? description;
  String? status;
  String? dueDate;
  String? dueTime;
  String? user;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Task({
    this.title,
    this.description,
    this.status,
    this.dueDate,
    this.dueTime,
    this.user,
    this.sId,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Task.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    status = json['status'];
    dueDate = json['dueDate'];
    dueTime = json['dueTime'];
    user = json['user'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['dueDate'] = dueDate;
    data['dueTime'] = dueTime;
    data['user'] = user;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
