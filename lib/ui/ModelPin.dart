import 'package:firebase_database/firebase_database.dart';

class ModelPin {
  String key;
  String title;
  String body;
  String tag;
  String pic;

  ModelPin(this.title, this.body, this.tag, this.pic);
  ModelPin.fromSnapshot(DataSnapshot snapshot) :
      key = snapshot.key,
      title = snapshot.value["title"],
      body = snapshot.value["body"],
        tag = snapshot.value["tag"],
  pic = snapshot.value["pic"];
  toJson() {
    return {
      "title": title,
      "body": body,
      "tag": tag,
      "pic": pic,
    };
  }

}