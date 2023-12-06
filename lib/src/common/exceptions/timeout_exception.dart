class TimeoutException implements Exception {
  @override
  String toString() {
    return "TimeoutException";
  }
}

class ConnectionTimeoutException extends TimeoutException {
  @override
  String toString() {
    return "ConnectionTimeoutException";
  }
}

class RequestTimeoutException extends TimeoutException {
  @override
  String toString() {
    return "RequestTimeoutException";
  }
}

class ResponseTimeoutException extends TimeoutException {
  @override
  String toString() {
    return "ResponseTimeoutException";
  }
}
