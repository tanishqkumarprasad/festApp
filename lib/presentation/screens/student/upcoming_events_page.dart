import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/event_model.dart';
import '../../../logic/bloc/event/event_bloc.dart';
import '../../../logic/bloc/event/event_state.dart';

class UpcomingEventsPage extends StatefulWidget {
  const UpcomingEventsPage({super.key});

  @override
  State<UpcomingEventsPage> createState() => _UpcomingEventsPageState();
}

class _UpcomingEventsPageState extends State<UpcomingEventsPage> {
  static const _clubs = <String>[
    'hackslash',
    'vista',
    'expresso',
    'tesla',
    'natvansh',
    'total chaos',
    'ieee',
    'saptak',
    'incubation center',
    'photography and media',
  ];

  String? _selectedClub; // null = All clubs
  String? _selectedCategory; // null = All categories (sports / cultural)

  List<EventModel> _getFilteredEvents(List<EventModel> events) {
    final now = DateTime.now();

    final filtered = events.where((event) {
      final status = event.status.trim().toLowerCase();
      final isUpcomingStatus = status == 'upcoming';
      final isFutureDate = event.startAt == null || event.startAt!.isAfter(now);
      final isUpcoming = isUpcomingStatus || isFutureDate;

      final eventClub = event.club.trim().toLowerCase();
      final matchesClub =
          _selectedClub == null || eventClub == _selectedClub!.toLowerCase();

      final category = event.category.trim().toLowerCase();
      final matchesCategory =
          _selectedCategory == null ||
          category == _selectedCategory!.toLowerCase();

      return isUpcoming && matchesClub && matchesCategory;
    }).toList();

    filtered.sort((a, b) {
      final aStart = a.startAt ?? DateTime.now();
      final bStart = b.startAt ?? DateTime.now();
      return aStart.compareTo(bStart);
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        final events = state is EventLoaded ? state.events : <EventModel>[];

        return Scaffold(

          appBar: AppBar(title: const Text('Upcoming Events')),
          body: Column(
            children: [
              const SizedBox(height: 8),
              _buildClubFilterRow(theme),
              const SizedBox(height: 8),
              _buildCategoryFilterRow(theme),
              const Divider(height: 1),
              Expanded(
                child: _getFilteredEvents(events).isEmpty
                    ? const Center(child: Text('No upcoming events found.'))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        itemCount: _getFilteredEvents(events).length,
                        itemBuilder: (context, index) {
                          final event = _getFilteredEvents(events)[index];
                          return _EventCard(event: event);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildClubFilterRow(ThemeData theme) {
    return SizedBox(
      height: 56,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: const Text('All Clubs'),
              selected: _selectedClub == null,
              onSelected: (_) {
                setState(() {
                  _selectedClub = null;
                });
              },
            ),
          ),
          ..._clubs.map(
            (club) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ChoiceChip(
                label: Text(_capitalizeWords(club)),
                selected:
                    _selectedClub != null &&
                    _selectedClub == club.toLowerCase(),
                onSelected: (_) {
                  setState(() {
                    _selectedClub = club.toLowerCase();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilterRow(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: [
          Text('Category:', style: theme.textTheme.bodyMedium),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text('All'),
            selected: _selectedCategory == null,
            onSelected: (_) {
              setState(() {
                _selectedCategory = null;
              });
            },
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text('Sports'),
            selected: _selectedCategory == 'sports',
            onSelected: (_) {
              setState(() {
                _selectedCategory = 'sports';
              });
            },
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text('Cultural'),
            selected: _selectedCategory == 'cultural',
            onSelected: (_) {
              setState(() {
                _selectedCategory = 'cultural';
              });
            },
          ),
        ],
      ),
    );
  }

  String _capitalizeWords(String value) {
    return value
        .split(' ')
        .where((part) => part.isNotEmpty)
        .map(
          (part) =>
              part[0].toUpperCase() +
              (part.length > 1 ? part.substring(1) : ''),
        )
        .join(' ');
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event});

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final dateText = _formatDateRange(event.startAt, event.endAt);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    event.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(
                    event.category[0].toUpperCase() +
                        event.category.substring(1).toLowerCase(),
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              _capitalize(event.club),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (dateText != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16),
                  const SizedBox(width: 4),
                  Text(dateText, style: theme.textTheme.bodySmall),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  static String? _formatDateRange(DateTime? start, DateTime? end) {
    if (start == null && end == null) return null;
    if (start == null) return _formatSingle(end!);
    if (end == null) return _formatSingle(start);
    final startText = _formatSingle(start);
    final endText = _formatSingle(end);
    if (start.year == end.year &&
        start.month == end.month &&
        start.day == end.day) {
      return '$startText - ${_formatTime(end)}';
    }
    return '$startText → $endText';
  }

  static String _formatSingle(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    final time = _formatTime(date);
    return '$day/$month/$year, $time';
  }

  static String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }
}
