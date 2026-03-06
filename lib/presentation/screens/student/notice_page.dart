import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/notice_model.dart';
import '../../../logic/bloc/notice/notice_bloc.dart';
import '../../../logic/bloc/notice/notice_state.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    const darkBackground = Color(0xFF020617);

    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        backgroundColor: darkBackground,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Notices',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: BlocBuilder<NoticeBloc, NoticeState>(
            builder: (BuildContext context, NoticeState state) {
              if (state is NoticeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is NoticeError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 13,
                    ),
                  ),
                );
              }

              if (state is NoticeEmpty) {
                return const Center(
                  child: Text(
                    'No notices yet. Stay tuned!',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                );
              }

              if (state is NoticeLoaded) {
                final List<NoticeModel> notices = state.notices;
                if (notices.isEmpty) {
                  return const Center(
                    child: Text(
                      'No notices yet. Stay tuned!',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: notices.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (BuildContext context, int index) {
                    final notice = notices[index];
                    return _NoticeCard(notice: notice);
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class _NoticeCard extends StatelessWidget {
  const _NoticeCard({required this.notice});

  final NoticeModel notice;

  @override
  Widget build(BuildContext context) {
    final String subtitle = [
      if (notice.authority.isNotEmpty) notice.authority,
      if (notice.description.isNotEmpty) notice.description,
    ].join(' • ');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E293B), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF1E293B),
                ),
                child: const Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notice.subject.isNotEmpty ? notice.subject : 'Notice',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (notice.content.isNotEmpty &&
              notice.contentType == NoticeContentTypeModel.text) ...[
            const SizedBox(height: 8),
            Text(
              notice.content,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),
          ],
          if (notice.createdAt != null) ...[
            const SizedBox(height: 8),
            Text(
              'Posted on ${notice.createdAt}',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 11,
              ),
            ),
          ],
        ],
      ),
    );
  }
}


