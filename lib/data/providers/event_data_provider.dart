import '../models/upcoming_event_model.dart';

class EventDataProvider {
  static final Map<String, List<Coordinator>> _coordinatorsMap = {
    'Raaga': [
      Coordinator(name: 'Vinayak Thakur', role: 'Coordinator'),
      Coordinator(name: 'Yogaja Aasti', role: 'Co-coordinator'),
      Coordinator(name: 'Yash Kashyap', role: 'Co-coordinator'),
    ],
    'Nrityangana': [
      Coordinator(name: 'Aditi Verma', role: 'Coordinator'),
      Coordinator(name: 'Anusha', role: 'Co-coordinator'),
      Coordinator(name: 'Mitali', role: 'Co-coordinator'),
    ],
    'Kalakriti': [
      Coordinator(name: 'Rohit Kumar', role: 'Coordinator'),
      Coordinator(name: 'Shrami Mathur', role: 'Co-coordinator'),
      Coordinator(name: 'Bhavyanshi', role: 'Co-coordinator'),
    ],
    'Avlokan': [
      Coordinator(name: 'Aparna', role: 'Coordinator'),
      Coordinator(name: 'Deepali', role: 'Co-coordinator'),
      Coordinator(name: 'Satyam', role: 'Co-coordinator'),
    ],
    'Sanhita': [
      Coordinator(name: 'Rishav', role: 'Coordinator'),
      Coordinator(name: 'Nitin', role: 'Co-coordinator'),
    ],
    'Abhinay': [
      Coordinator(name: 'Aditya Raj', role: 'Coordinator'),
      Coordinator(name: 'Manvi', role: 'Co-coordinator'),
    ],
    'Vistakari': [
      Coordinator(name: 'Niranjan', role: 'Coordinator'),
      Coordinator(name: 'Abhay', role: 'Co-coordinator'),
    ],
    'Graphika': [
      Coordinator(name: 'Bhanu Priya', role: 'Coordinator'),
      Coordinator(name: 'Tabassum Bannerjee', role: 'Co-coordinator'),
    ],
    'Pratibimb': [
      Coordinator(name: 'Aditi Rao', role: 'Coordinator'),
      Coordinator(name: 'Jyoti Kumari', role: 'Co-coordinator'),
    ],
    'Outdoor sports': [
      Coordinator(name: 'Dishant', role: 'Coordinator'),
      Coordinator(name: 'Prajwal', role: 'Co-coordinator'),
    ],
    'Yogasana Competition': [
      Coordinator(name: 'Sania Kumari', role: 'Coordinator'),
      Coordinator(name: 'Rahul Kumar', role: 'Co-coordinator'),
    ],
    'Darpan': [
      Coordinator(name: 'Aditi Rao', role: 'Coordinator'),
      Coordinator(name: 'Jyoti Kumari', role: 'Co-coordinator'),
    ],
    'Twig n Twine': [
      Coordinator(name: 'Aparna', role: 'Coordinator'),
      Coordinator(name: 'Deepali', role: 'Co-coordinator'),
      Coordinator(name: 'Satyam', role: 'Co-coordinator'),
    ],
    'Green Graffiti': [
      Coordinator(name: 'Aparna', role: 'Coordinator'),
      Coordinator(name: 'Deepali', role: 'Co-coordinator'),
      Coordinator(name: 'Satyam', role: 'Co-coordinator'),
    ],
    'puzzle pulse': [
      Coordinator(name: 'Aparna', role: 'Coordinator'),
      Coordinator(name: 'Deepali', role: 'Co-coordinator'),
      Coordinator(name: 'Satyam', role: 'Co-coordinator'),
    ],
  };

  static List<Coordinator> _getCoordinatorsForEvent(String eventName) {
    if (_coordinatorsMap.containsKey(eventName)) {
      return _coordinatorsMap[eventName]!;
    }
    // Try case insensitive match
    final lowerEventName = eventName.toLowerCase();
    for (final entry in _coordinatorsMap.entries) {
      if (entry.key.toLowerCase() == lowerEventName) {
        return entry.value;
      }
    }
    // Try partial match for events like KALAKRITI
    for (final entry in _coordinatorsMap.entries) {
      if (lowerEventName.contains(entry.key.toLowerCase()) ||
          entry.key.toLowerCase().contains(lowerEventName)) {
        return entry.value;
      }
    }
    return [];
  }

  static final List<UpcomingEventModel> allEvents = [
    UpcomingEventModel(
      eventName: 'Raaga',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 16),
      registrationLink:
          'https://docs.google.com/forms/d/e/1FAIpQLSddng9-wlo8EjoDU_QOyL42W7ol9nkhnHoJMNwAz-VBaEAmQQ/viewform',
      coordinators: _getCoordinatorsForEvent('Raaga'),
    ),
    UpcomingEventModel(
      eventName: 'Twig n Twine',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 30),
      registrationLink: 'https://forms.gle/snKZmaidRPJmJxjDA',
      coordinators: _getCoordinatorsForEvent('Twig n Twine'),
    ),
    UpcomingEventModel(
      eventName: 'Green Graffiti',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 31),
      registrationLink: 'https://forms.gle/seguB9maXBpJm7NR9',
      coordinators: _getCoordinatorsForEvent('Green Graffiti'),
    ),
    UpcomingEventModel(
      eventName: 'puzzle pulse',
      campus: 'Patna',
      eventDate: DateTime(2026, 04, 01),
      registrationLink: 'https://forms.gle/4YBrkfxqKb8z3yBo6',
      coordinators: _getCoordinatorsForEvent('puzzle pulse'),
    ),
    UpcomingEventModel(
      eventName: 'KALAKRITI (NO BRUSHES)',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 21),
      registrationLink: 'https://forms.gle/56kn9pffMRLAa4uh7',
      coordinators: _getCoordinatorsForEvent('KALAKRITI (NO BRUSHES)'),
    ),
    UpcomingEventModel(
      eventName: 'KALAKRITI (CLAY MODELLING)',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 21),
      registrationLink: 'https://forms.gle/nVQqWcmDpNifjoXY8',
      coordinators: _getCoordinatorsForEvent('KALAKRITI (CLAY MODELLING)'),
    ),
    UpcomingEventModel(
      eventName: 'KALAKRITI (TSHIRT PAINTING)',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 22),
      registrationLink: 'https://forms.gle/dBKCRDv1xEcEBpbh9',
      coordinators: _getCoordinatorsForEvent('KALAKRITI (TSHIRT PAINTING)'),
    ),
    UpcomingEventModel(
      eventName: 'KALAKRITI (FACE PAINTING)',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 22),
      registrationLink: 'https://forms.gle/cX1it1wFoXbHJyry7',
      coordinators: _getCoordinatorsForEvent('KALAKRITI (FACE PAINTING)'),
    ),
    UpcomingEventModel(
      eventName: 'Pratibimb',
      campus: 'Patna',
      eventDate: DateTime(2026, 04, 04),
      registrationLink: 'https://forms.gle/Rf5rnp2HQX6FYwtK8',
      coordinators: _getCoordinatorsForEvent('Pratibimb'),
    ),
    UpcomingEventModel(
      eventName: 'Darpan',
      campus: 'Patna',
      eventDate: DateTime(2026, 04, 04),
      registrationLink: 'https://forms.gle/BFaiko5NjuQUUmJAA',
      coordinators: _getCoordinatorsForEvent('Darpan'),
    ),
    UpcomingEventModel(
      eventName: 'Yogasana Competition',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 18),
      registrationLink: 'https://forms.gle/9nSsDJTfDG64D4ad6',
      coordinators: _getCoordinatorsForEvent('Yogasana Competition'),
    ),
    UpcomingEventModel(
      eventName: 'Graphika',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 22),
      registrationLink: 'https://forms.gle/uAfoG8Rod9upShft5',
      coordinators: _getCoordinatorsForEvent('Graphika'),
    ),
    UpcomingEventModel(
      eventName: 'Nrityangana',
      campus: 'Patna',
      eventDate: DateTime(2026, 03, 17),
      registrationLink: 'https://forms.gle/fpkUt1GDCatXmgHU8',
      coordinators: _getCoordinatorsForEvent('Nrityangana'),
    ),
    // Bihta Campus Events
    UpcomingEventModel(
      eventName: 'Tshirt Painting (Dye Verse)',
      campus: 'Bihta',
      eventDate: DateTime(2026, 03, 28),
      registrationLink: '',
      coordinators: [
        Coordinator(name: 'Anurag Mishra', role: 'Coordinator'),
        Coordinator(name: 'Khushbu Kumari', role: 'Co-coordinator'),
      ],
    ),
    UpcomingEventModel(
      eventName: 'Clay Modelling (Clay Clash)',
      campus: 'Bihta',
      eventDate: DateTime(2026, 03, 28),
      registrationLink: '',
      coordinators: [],
    ),
    UpcomingEventModel(
      eventName: 'Back Drawing',
      campus: 'Bihta',
      eventDate: DateTime(2026, 03, 30),
      registrationLink: '',
      coordinators: [],
    ),
    UpcomingEventModel(
      eventName: 'Pre – Sher o Shayari & Poetry',
      campus: 'Bihta',
      eventDate: DateTime(2026, 03, 31),
      registrationLink: '',
      coordinators: [],
    ),
    UpcomingEventModel(
      eventName: 'Hindi Debate',
      campus: 'Bihta',
      eventDate: DateTime(2026, 04, 01),
      registrationLink: '',
      coordinators: [],
    ),
    UpcomingEventModel(
      eventName: 'Final – Sher o Shayari & Poetry',
      campus: 'Bihta',
      eventDate: DateTime(2026, 04, 02),
      registrationLink: '',
      coordinators: [],
    ),
    UpcomingEventModel(
      eventName: 'Pre – Mimicry / MonoAct',
      campus: 'Bihta',
      eventDate: DateTime(2026, 03, 28),
      registrationLink: '',
      coordinators: [
        Coordinator(name: 'Anurag Kumar', role: 'Coordinator'),
        Coordinator(name: 'Tanya Bharti', role: 'Co-coordinator'),
      ],
    ),
    UpcomingEventModel(
      eventName: 'Pre – Standup / StoryTelling',
      campus: 'Bihta',
      eventDate: DateTime(2026, 03, 28),
      registrationLink: '',
      coordinators: [],
    ),
    UpcomingEventModel(
      eventName: 'Pre – Group Act',
      campus: 'Bihta',
      eventDate: DateTime(2026, 03, 28),
      registrationLink: '',
      coordinators: [],
    ),
    UpcomingEventModel(
      eventName: 'Final – Mimicry / MonoAct',
      campus: 'Bihta',
      eventDate: DateTime(2026, 04, 03),
      registrationLink: '',
      coordinators: [],
    ),
    UpcomingEventModel(
      eventName: 'Final – Standup / StoryTelling',
      campus: 'Bihta',
      eventDate: DateTime(2026, 04, 03),
      registrationLink: '',
      coordinators: [],
    ),
    UpcomingEventModel(
      eventName: 'Final – Group Act',
      campus: 'Bihta',
      eventDate: DateTime(2026, 04, 03),
      registrationLink: '',
      coordinators: [],
    ),
    UpcomingEventModel(
      eventName: 'Snaprush',
      campus: 'Bihta',
      eventDate: DateTime(2026, 03, 28),
      registrationLink: '',
      coordinators: [
        Coordinator(name: 'Nishant Kumar', role: 'Coordinator'),
        Coordinator(name: 'Shourya Kumar', role: 'Co-coordinator'),
      ],
    ),
    UpcomingEventModel(
      eventName: 'Graphika',
      campus: 'Bihta',
      eventDate: DateTime(2026, 03, 29),
      registrationLink: '',
      coordinators: [
        Coordinator(name: 'Shubham Sinha', role: 'Co-coordinator'),
      ],
    ),
    UpcomingEventModel(
      eventName: 'Antakshri',
      campus: 'Bihta',
      eventDate: DateTime(2026, 03, 29),
      registrationLink: '',
      coordinators: [
        Coordinator(name: 'Sarthak Rajan', role: 'Coordinator'),
        Coordinator(name: 'Yaksh Bariya', role: 'Co-coordinator'),
      ],
    ),
    UpcomingEventModel(
      eventName: 'Pre – Solo Singing',
      campus: 'Bihta',
      eventDate: DateTime(2026, 03, 30),
      registrationLink: '',
      coordinators: [],
    ),
    UpcomingEventModel(
      eventName: 'Final – Solo Singing',
      campus: 'Bihta',
      eventDate: DateTime(2026, 04, 02),
      registrationLink: '',
      coordinators: [],
    ),
    UpcomingEventModel(
      eventName: 'Pre – Solo Dance',
      campus: 'Bihta',
      eventDate: DateTime(2026, 03, 27),
      registrationLink: '',
      coordinators: [
        Coordinator(name: 'Talachintala Yashwanth', role: 'Coordinator'),
        Coordinator(name: 'Sai Koushik', role: 'Co-coordinator'),
      ],
    ),
    UpcomingEventModel(
      eventName: 'Pre – Duet Dance',
      campus: 'Bihta',
      eventDate: DateTime(2026, 03, 27),
      registrationLink: '',
      coordinators: [],
    ),
    UpcomingEventModel(
      eventName: 'Impromptu',
      campus: 'Bihta',
      eventDate: DateTime(2026, 03, 29),
      registrationLink: '',
      coordinators: [],
    ),
    UpcomingEventModel(
      eventName: 'Final – Solo Dance',
      campus: 'Bihta',
      eventDate: DateTime(2026, 04, 02),
      registrationLink: '',
      coordinators: [],
    ),
    UpcomingEventModel(
      eventName: 'Final – Duet Dance',
      campus: 'Bihta',
      eventDate: DateTime(2026, 04, 02),
      registrationLink: '',
      coordinators: [],
    ),
    UpcomingEventModel(
      eventName: 'Envo Quiz',
      campus: 'Bihta',
      eventDate: DateTime(2026, 03, 28),
      registrationLink: '',
      coordinators: [
        Coordinator(name: 'Ayush Kumar', role: 'Coordinator'),
        Coordinator(name: 'Vasu Choudhari', role: 'Co-coordinator'),
      ],
    ),
    UpcomingEventModel(
      eventName: 'Best From Waste',
      campus: 'Bihta',
      eventDate: DateTime(2026, 03, 31),
      registrationLink: '',
      coordinators: [],
    ),
    UpcomingEventModel(
      eventName: 'Reel Making',
      campus: 'Bihta',
      eventDate: DateTime(2026, 03, 31),
      registrationLink: '',
      coordinators: [],
    ),
    UpcomingEventModel(
      eventName: 'Treasure Hunt',
      campus: 'Bihta',
      eventDate: DateTime(2026, 04, 03),
      registrationLink: '',
      coordinators: [
        Coordinator(name: 'Anurag kumar', role: 'Coordinator'),
        Coordinator(name: 'Shivam Kumar', role: 'Co-coordinator'),
      ],
    ),
    UpcomingEventModel(
      eventName: 'Pre-Pratibimb & Pre-Darpan',
      campus: 'Bihta',
      eventDate: DateTime(2026, 03, 26),
      registrationLink: '',
      coordinators: [
        Coordinator(name: 'Palak Jaiswal', role: 'Coordinator'),
        Coordinator(name: 'Nandani Awase', role: 'Co-coordinator'),
      ],
    ),
    UpcomingEventModel(
      eventName: 'Final – Darpan',
      campus: 'Bihta',
      eventDate: DateTime(2026, 04, 02),
      registrationLink: '',
      coordinators: [],
    ),
    UpcomingEventModel(
      eventName: 'Final – Pratibimb',
      campus: 'Bihta',
      eventDate: DateTime(2026, 04, 03),
      registrationLink: '',
      coordinators: [],
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
