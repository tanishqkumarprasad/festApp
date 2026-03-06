import 'package:equatable/equatable.dart';

import '../../../data/models/notice_model.dart';

sealed class NoticeState extends Equatable {
  const NoticeState();

  @override
  List<Object?> get props => [];
}

class NoticeLoading extends NoticeState {
  const NoticeLoading();
}

class NoticeEmpty extends NoticeState {
  const NoticeEmpty();
}

class NoticeLoaded extends NoticeState {
  final List<NoticeModel> notices;

  const NoticeLoaded(this.notices);

  @override
  List<Object?> get props => [notices];
}

class NoticeError extends NoticeState {
  final String message;

  const NoticeError(this.message);

  @override
  List<Object?> get props => [message];
}

