import 'package:flutter/material.dart';

import '../../../core/utils/button.dart';
import '../../../data/models/event_model.dart';

/// Reusable section for displaying top/upcoming events with a header and optional "See All" link.
class TopEventsSection extends StatelessWidget {
  final String title;
  final List<EventModel> events;
  final int limit;
  final VoidCallback? onSeeAllTap;
  final bool isLoading;

  const TopEventsSection({
    super.key,
    required this.title,
    required this.events,
    this.limit = 5,
    this.onSeeAllTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final sorted = List<EventModel>.from(events)
      ..sort((a, b) {
        final da = a.startAt;
        final db = b.startAt;
        if (da == null && db == null) return 0;
        if (da == null) return 1;
        if (db == null) return -1;
        return da.compareTo(db);
      });
    final displayEvents = sorted.take(limit).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (onSeeAllTap != null)
              AppButton(
                text: 'See All',
                variant: AppButtonVariant.text,
                size: AppButtonSize.small,
                onPressed: onSeeAllTap,
              ),
          ],
        ),
        const SizedBox(height: 16),
        if (isLoading)
          const Center(child: CircularProgressIndicator())
        else if (displayEvents.isEmpty)
          const Text(
            'No more upcoming events.',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          )
        else
          Column(
            children: [
              for (final EventModel e in displayEvents) ...[
                _TopEventCard.fromEvent(e),
                const SizedBox(height: 16),
              ],
            ],
          ),
      ],
    );
  }
}

class _TopEventCard extends StatelessWidget {
  final String day;
  final String month;
  final String title;
  final String location;
  final String time;

  const _TopEventCard({
    required this.day,
    required this.month,
    required this.title,
    required this.location,
    required this.time,
  });

  factory _TopEventCard.fromEvent(EventModel event) {
    final DateTime? date = event.startAt;
    final String day =
        date != null ? date.day.toString().padLeft(2, '0') : '--';
    final String month =
        date != null ? _monthAbbreviation(date.month) : '--';

    String time;
    if (date != null) {
      final String h = date.hour.toString().padLeft(2, '0');
      final String m = date.minute.toString().padLeft(2, '0');
      time = '$h:$m';
    } else {
      time = 'Time TBD';
    }

    final String location =
        event.category.isNotEmpty ? event.category : 'Campus';

    return _TopEventCard(
      day: day,
      month: month,
      title: event.title,
      location: location,
      time: time,
    );
  }

  static String _monthAbbreviation(int month) {
    const List<String> months = <String>[
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC',
    ];
    if (month < 1 || month > 12) return '--';
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  month,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
