import 'primary_image.dart';
import 'title_type.dart';
import 'title_text.dart';
import 'original_title_text.dart';
import 'release_year.dart';
import 'release_date.dart';

class Movie {
  Movie({
      this.id, 
      this.primaryImage, 
      this.titleType, 
      this.titleText, 
      this.originalTitleText, 
      this.releaseYear, 
      this.releaseDate,});

  Movie.fromJson(dynamic json) {
    id = json['id'];
    primaryImage = json['primaryImage'] != null ? PrimaryImage.fromJson(json['primaryImage']) : null;
    titleType = json['titleType'] != null ? TitleType.fromJson(json['titleType']) : null;
    titleText = json['titleText'] != null ? TitleText.fromJson(json['titleText']) : null;
    originalTitleText = json['originalTitleText'] != null ? OriginalTitleText.fromJson(json['originalTitleText']) : null;
    releaseYear = json['releaseYear'] != null ? ReleaseYear.fromJson(json['releaseYear']) : null;
    releaseDate = json['releaseDate'] != null ? ReleaseDate.fromJson(json['releaseDate']) : null;
  }
  String? id;
  PrimaryImage? primaryImage;
  TitleType? titleType;
  TitleText? titleText;
  OriginalTitleText? originalTitleText;
  ReleaseYear? releaseYear;
  ReleaseDate? releaseDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (primaryImage != null) {
      map['primaryImage'] = primaryImage?.toJson();
    }
    if (titleType != null) {
      map['titleType'] = titleType?.toJson();
    }
    if (titleText != null) {
      map['titleText'] = titleText?.toJson();
    }
    if (originalTitleText != null) {
      map['originalTitleText'] = originalTitleText?.toJson();
    }
    if (releaseYear != null) {
      map['releaseYear'] = releaseYear?.toJson();
    }
    if (releaseDate != null) {
      map['releaseDate'] = releaseDate?.toJson();
    }
    return map;
  }

}