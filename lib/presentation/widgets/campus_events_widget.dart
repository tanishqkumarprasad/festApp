import 'package:flutter/material.dart';

import '../../../data/providers/event_data_provider.dart';
import 'compact_event_card.dart';

class CampusEventsWidget extends StatelessWidget {
  final String campus;
  final String campusDisplayName;

  const CampusEventsWidget({
    super.key,
    required this.campus,
    required this.campusDisplayName,
  });

  @override
  Widget build(BuildContext context) {
    final events = EventDataProvider.getUpcomingEventsByCampus(
      campus,
      limit: 2,
    );

    if (events.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade700, Colors.blue.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              campusDisplayName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'No upcoming events',
              style: TextStyle(fontSize: 13, color: Colors.white70),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            campusDisplayName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          ...events.asMap().entries.map((entry) {
            final event = entry.value;
            final isLast = entry.key == events.length - 1;
            return Column(
              children: [
                CompactEventCard(event: event),
                if (!isLast) const SizedBox(height: 8),
              ],
            );
          }),
        ],
      ),
    );
  }
}
