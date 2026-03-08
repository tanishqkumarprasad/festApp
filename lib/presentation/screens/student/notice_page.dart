import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          'Campus Notices',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<NoticeBloc, NoticeState>(
          builder: (BuildContext context, NoticeState state) {
            if (state is NoticeLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.blueAccent),
              );
            }

            if (state is NoticeError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.redAccent, fontSize: 14),
                ),
              );
            }

            if (state is NoticeEmpty) {
              return const Center(
                child: Text(
                  'No notices yet. Stay tuned!',
                  style: TextStyle(color: Colors.white54, fontSize: 15),
                ),
              );
            }

            if (state is NoticeLoaded) {
              final List<NoticeModel> notices = state.notices;
              if (notices.isEmpty) {
                return const Center(
                  child: Text(
                    'No notices yet. Stay tuned!',
                    style: TextStyle(color: Colors.white54, fontSize: 15),
                  ),
                );
              }

              return RefreshIndicator(
                color: Colors.blueAccent,
                backgroundColor: const Color(0xFF1E293B),
                onRefresh: () async {
                  // Assuming your bloc responds to a fetch event. Adjust if your event name is different.
                  // context.read<NoticeBloc>().add(const FetchNotices());
                },
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  itemCount: notices.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (BuildContext context, int index) {
                    return _NoticeCard(notice: notices[index]);
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
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
    // Format the date nicely to get rid of the ugly decimals
    final String dateStr = notice.createdAt != null
        ? "${notice.createdAt!.year}-${notice.createdAt!.month.toString().padLeft(2, '0')}-${notice.createdAt!.day.toString().padLeft(2, '0')}"
        : "Recently";

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E293B), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // TODO: Navigate to your NoticeDetailScreen here
            // Navigator.push(context, MaterialPageRoute(builder: (_) => NoticeDetailScreen(notice: notice)));
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Professional Mini Thumbnail
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: notice.imageUrl.isNotEmpty
                      ? Image.network(
                    notice.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported, color: Colors.white38),
                  )
                      : const Center(
                    child: Icon(Icons.campaign_rounded, color: Colors.blueAccent, size: 32),
                  ),
                ),
                const SizedBox(width: 16),

                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notice.eventName.isNotEmpty ? notice.eventName : 'Campus Event',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notice.otherDetails.isNotEmpty
                            ? notice.otherDetails
                            : 'Tap to view details about this event.',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.access_time_rounded, size: 14, color: Colors.blueAccent),
                          const SizedBox(width: 6),
                          Text(
                            'Posted on $dateStr',
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}