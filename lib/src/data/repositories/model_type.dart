// Project imports:

import '../models/gallery_model.dart';

class ModelType {
  static dynamic getParseData<T>(Object? json) {
    if (json != null) {
      if (json is String || json is int || json is double || json is bool || json is List) {
        return json;
      } else if (json is Map<String, dynamic>) {
        var modelFactory = getModel<T>();
        if (modelFactory != null) {
          return modelFactory.call(json);
        }
        return json;
      }
    }
    return null;
  }

  static Function? getModel<T>() {
    switch (T) {
      case const (GalleryModel):
        return GalleryModel.fromJson;
      default:
        return null;
    }
  }
}
