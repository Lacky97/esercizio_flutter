abstract class ApiStatus{
  const ApiStatus();
}

class InitialApi extends ApiStatus{
  const InitialApi();
}

class ApiLoading extends ApiStatus{}

class ApiLoaded extends ApiStatus{}

class ApiError extends ApiStatus{
}