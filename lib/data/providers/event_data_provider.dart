import '../models/upcoming_event_model.dart';

class EventDataProvider {
  static final List<UpcomingEventModel> allEvents = [
    UpcomingEventModel(
      eventName: 'Raaga',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 16),
      registrationLink:
          'https://docs.google.com/forms/d/e/1FAIpQLSddng9-wlo8EjoDU_QOyL42W7ol9nkhnHoJMNwAz-VBaEAmQQ/viewform',
    ),
    UpcomingEventModel(
      eventName: 'Twig n Twine',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 30),
      registrationLink: 'https://forms.gle/snKZmaidRPJmJxjDA',
    ),
    UpcomingEventModel(
      eventName: 'Green Graffiti',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 31),
      registrationLink: 'https://forms.gle/seguB9maXBpJm7NR9',
    ),
    UpcomingEventModel(
      eventName: 'puzzle pulse',
      campus: 'Patna',
      eventDate: DateTime(2026, 04, 01),
      registrationLink: 'https://forms.gle/4YBrkfxqKb8z3yBo6',
    ),
    UpcomingEventModel(
      eventName: 'KALAKRITI (NO BRUSHES)',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 21),
      registrationLink: 'https://forms.gle/56kn9pffMRLAa4uh7',
    ),
    UpcomingEventModel(
      eventName: 'KALAKRITI (CLAY MODELLING)',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 21),
      registrationLink: 'https://forms.gle/nVQqWcmDpNifjoXY8',
    ),
    UpcomingEventModel(
      eventName: 'KALAKRITI (TSHIRT PAINTING)',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 22),
      registrationLink: 'https://forms.gle/dBKCRDv1xEcEBpbh9',
    ),
    UpcomingEventModel(
      eventName: 'KALAKRITI (FACE PAINTING)',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 22),
      registrationLink: 'https://forms.gle/cX1it1wFoXbHJyry7',
    ),
    UpcomingEventModel(
      eventName: 'Pratibimb',
      campus: 'Patna',
      eventDate: DateTime(2026, 04, 04),
      registrationLink: 'https://forms.gle/Rf5rnp2HQX6FYwtK8',
    ),
    UpcomingEventModel(
      eventName: 'Darpan',
      campus: 'Patna',
      eventDate: DateTime(2026, 04, 04),
      registrationLink: 'https://forms.gle/BFaiko5NjuQUUmJAA',
    ),
    UpcomingEventModel(
      eventName: 'Yogasana Competition',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 18),
      registrationLink: 'https://forms.gle/9nSsDJTfDG64D4ad6',
    ),
    UpcomingEventModel(
      eventName: 'Graphika',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 22),
      registrationLink: 'https://forms.gle/uAfoG8Rod9upShft5',
    ),
    UpcomingEventModel(
      eventName: 'Nrityangana',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 17),
      registrationLink: 'https://forms.gle/fpkUt1GDCatXmgHU8',
    ),
  ];

  /// Get top 5 upcoming events sorted by date
  static List<UpcomingEventModel> getUpcomingEvents({int limit = 5}) {
    final now = DateTime.now();
    final futureEvents = allEvents
        .where((event) => event.eventDate.isAfter(now))
        .toList();
    futureEvents.sort((a, b) => a.eventDate.compareTo(b.eventDate));
    return futureEvents.take(limit).toList();
  }

  /// Get top 2 upcoming events for a specific campus
  static List<UpcomingEventModel> getUpcomingEventsByCampus(
    String campus, {
    int limit = 2,
  }) {
    final now = DateTime.now();
    final campusEvents = allEvents
        .where(
          (event) =>
              event.campus.toLowerCase() == campus.toLowerCase() &&
              event.eventDate.isAfter(now),
        )
        .toList();
    campusEvents.sort((a, b) => a.eventDate.compareTo(b.eventDate));
    return campusEvents.take(limit).toList();
  }
}
