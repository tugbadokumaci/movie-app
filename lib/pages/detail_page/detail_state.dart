abstract class DetailState {}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {}

class DetailSuccess extends DetailState {
  bool isFav;
  bool isPlayerVisible;
  DetailSuccess(this.isFav, {this.isPlayerVisible = false});
}

class DetailError extends DetailState {}
