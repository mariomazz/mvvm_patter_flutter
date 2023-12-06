class HttpFailure400 implements Exception {
  final dynamic data;
  final String? message;
  HttpFailure400({
    this.message,
    this.data,
  });

  String? parsedData() => _parseData(data);

  String? _parseData(dynamic data) {
    if (data != null) {
      if (data is Map) {
        return _parseData(data["errors"]);
      } else if (data is List) {
        return data.join(", ");
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  String toString() {
    return message ?? "Http Request Failure";
  }
}
