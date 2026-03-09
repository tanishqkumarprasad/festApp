import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/upcoming_event_model.dart';
import '../../../data/providers/event_data_provider.dart';
import '../../widgets/event_card.dart';

class UpcomingEventsPage extends StatefulWidget {
  const UpcomingEventsPage({super.key});

  @override
  State<UpcomingEventsPage> createState() => _UpcomingEventsPageState();
}

class _UpcomingEventsPageState extends State<UpcomingEventsPage> {
  static const _campuses = <String>['All', 'Patna', 'Bihta'];

  String _selectedCampus = 'All';

  List<UpcomingEventModel> _getFilteredEvents() {
    final events = EventDataProvider.allEvents;
    final now = DateTime.now();

    final filtered = events.where((event) {
      final isFutureDate = event.eventDate.isAfter(now);
      final matchesCampus =
          _selectedCampus == 'All' || event.campus == _selectedCampus;

      return isFutureDate && matchesCampus;
    }).toList();

    filtered.sort((a, b) => a.eventDate.compareTo(b.eventDate));

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upcoming Events')),
      body: Column(
        children: [
          const SizedBox(height: 8),
          _buildCampusFilterRow(),
          const Divider(height: 1),
          Expanded(
            child: _getFilteredEvents().isEmpty
                ? const Center(child: Text('No upcoming events found.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    itemCount: _getFilteredEvents().length,
                    itemBuilder: (context, index) {
                      final event = _getFilteredEvents()[index];
                      return EventCard(event: event);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCampusFilterRow() {
    return SizedBox(
      height: 56,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          ..._campuses.map(
            (campus) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ChoiceChip(
                label: Text(campus),
                selected: _selectedCampus == campus,
                onSelected: (_) {
                  setState(() {
                    _selectedCampus = campus;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
