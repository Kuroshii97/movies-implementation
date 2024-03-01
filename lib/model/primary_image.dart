import 'caption.dart';

class PrimaryImage {
  PrimaryImage({
      this.id, 
      this.width, 
      this.height, 
      this.url, 
      this.caption, 
      this.typename,});

  PrimaryImage.fromJson(dynamic json) {
    id = json['id'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    caption = json['caption'] != null ? Caption.fromJson(json['caption']) : null;
    typename = json['__typename'];
  }
  String? id;
  num? width;
  num? height;
  String? url;
  Caption? caption;
  String? typename;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['width'] = width;
    map['height'] = height;
    map['url'] = url;
    if (caption != null) {
      map['caption'] = caption?.toJson();
    }
    map['__typename'] = typename;
    return map;
  }

}