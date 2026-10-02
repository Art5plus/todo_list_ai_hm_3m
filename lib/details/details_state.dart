enum DetailsStatus { initial, edited, saved }

class DetailsState {
  final DetailsStatus status;

  const DetailsState({required this.status});

  DetailsState copyWith({DetailsStatus? status}) {
    return DetailsState(status: status ?? this.status);
  }
}
