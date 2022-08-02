class Result<T> {
  Status status;
  T? data;
  String? message;

  Result({this.status = Status.loading, this.data, this.message});

  Result.loading() : status = Status.loading;
  Result.success({required this.data}) : status = Status.success;
  Result.error({required this.message}) : status = Status.error;
}

enum Status { loading, success, error }