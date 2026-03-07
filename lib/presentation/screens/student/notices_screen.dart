import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fest_app/logic/bloc/notice/notice_bloc.dart';
import 'package:fest_app/logic/bloc/notice/notice_state.dart';
import 'package:fest_app/logic/bloc/notice/notice_event.dart';
import 'notice_detail_screen.dart';

class NoticesScreen extends StatelessWidget {
  const NoticesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        backgroundColor: const Color(0xFF020617),
        elevation: 0,
        title: const Text('Campus Notices', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: () async => context.read<NoticeBloc>().add(const FetchNotices()),
        child: BlocBuilder<NoticeBloc, NoticeState>(
          builder: (context, state) {
            if (state is NoticeLoading) {
              return const Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6)));
            }
            if (state is NoticeError) {
              return Center(child: Text(state.message, style: const TextStyle(color: Colors.redAccent)));
            }
            if (state is NoticeEmpty) {
              return const Center(child: Text("No notices available.", style: TextStyle(color: Colors.white54)));
            }

            if (state is NoticeLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.notices.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final notice = state.notices[index];

                  final dateStr = notice.createdAt != null
                      ? "${notice.createdAt!.year}-${notice.createdAt!.month.toString().padLeft(2, '0')}-${notice.createdAt!.day.toString().padLeft(2, '0')}"
                      : "Recent";

                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => NoticeDetailScreen(notice: notice))
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF1E293B)),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          // Mini Thumbnail
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E293B),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: notice.imageUrl.isNotEmpty
                                ? Image.network(notice.imageUrl, fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, color: Colors.white38))
                                : const Icon(Icons.campaign, color: Colors.blueAccent, size: 30),
                          ),
                          const SizedBox(width: 16),

                          // Text Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notice.eventName.isEmpty ? "Notice" : notice.eventName,
                                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  notice.otherDetails.isEmpty ? "Tap to view details." : notice.otherDetails,
                                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time, size: 12, color: Colors.blueAccent),
                                    const SizedBox(width: 4),
                                    Text("Posted: $dateStr", style: const TextStyle(color: Colors.blueAccent, fontSize: 11)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}