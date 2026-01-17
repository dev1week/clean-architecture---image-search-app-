sealed class HomeUiEvent<T>{
  factory HomeUiEvent.showSnackBar(T data) = ShowSnackBar;
}

class ShowSnackBar<T> implements HomeUiEvent<T>{
  final T data;

  ShowSnackBar(this.data);
}
