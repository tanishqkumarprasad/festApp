import '../models/team_member_model.dart';

class TeamDataProvider {
  static final Map<String, Map<String, String>> _peopleData = {
    'Dishant Kumar Patel': {
      'email': 'dishantp.ug24.ce@nitp.ac.in',
      'phone': '7073421006',
    },
    'Niranjan S': {
      'email': 'niranjans.ug23.ar@nitp.ac.in',
      'phone': '9188394053',
    },
    'Daksh Agrawal': {
      'email': 'daksha.ug23.ce@nitp.ac.in',
      'phone': '7737376294',
    },
    'KRISH KUMAR SINHA': {
      'email': 'krishs.ug23.ar@nitp.ac.in',
      'phone': '7061896463',
    },
    'Prajwal akki': {
      'email': 'prajwala.ug25.ce@nitp.ac.in',
      'phone': '8147950295',
    },
    'Shanvi Dixit': {
      'email': 'shanvid.ug23.ch@nitp.ac.in',
      'phone': '8810904010',
    },
    'Sidram': {'email': 'Sidramd.ug23.ar@nitp.ac.in', 'phone': '9353029255'},
    'Satyam Kumar': {
      'email': 'satyamk.ug24.ce@nitp.ac.in',
      'phone': '7765976599',
    },
    'Anusha Mitra': {
      'email': 'anusham.ug23.ar@nitp.ac.in',
      'phone': '6290552969',
    },
    'Suhani': {'email': 'Suhani.ug23.ar@nitp.ac.in', 'phone': '7292015147'},
    'Aparna singh': {
      'email': 'aparnas.ug23.ar@nitp.ac.in',
      'phone': '9234758623',
    },
    'Vinayak kumar': {
      'email': 'vinayakk.ug23.ee@nitp.ac.in',
      'phone': '6299099156',
    },
    'Rohit Kumar': {
      'email': 'rohitk.ug24.ce@nitp.ac.in',
      'phone': '7281903256',
    },
    'Subhadeep Dey': {
      'email': 'subhadeepd.ug23.ar@nitp.ac.in',
      'phone': '7047963335',
    },
    'Shivang Shukla': {
      'email': 'shivangs.ug23.ce@nitp.ac.in',
      'phone': '7007154261',
    },
    'Aditi Jayesh Rao': {
      'email': 'aditir.ug22.ar@nitp.ac.in',
      'phone': '6264767138',
    },
    'Nitin Tiwari': {
      'email': 'nitint.ug24.me@nitp.ac.in',
      'phone': '9555631830',
    },
    'Saksham kumar': {
      'email': 'sakshamk.ug24.ar@nitp.ac.in',
      'phone': '6299446166',
    },
    'Jyoti Kumari': {'email': 'jyotik.ug23.ar@nitp.ac', 'phone': '9905657081'},
    'Rahul Kumar': {
      'email': 'rahulk.ug24.ce@nitp.ac.in',
      'phone': '9608304214',
    },
    'Sania Kumari': {
      'email': 'saniak.ug23.ch@nitp.ac.in',
      'phone': '7488906485',
    },
    'Bhanu Priya': {
      'email': 'bhanup.ug23.ce@nitp.ac.in',
      'phone': '8235976798',
    },
    'Deepali Mishra': {
      'email': 'deepalim.ug24.me@nitp.ac.in',
      'phone': '7428485611',
    },
    'Aditi Verma': {
      'email': 'aditiv.ug23.me@nitp.ac.in',
      'phone': '7318552617',
    },
    'Anurag Mishra': {
      'email': 'anuragm.ug24.cs@nitp.ac.in',
      'phone': '7061633407',
    },
    'Mitali Raj': {
      'email': 'mitalir.ug24.ce@nitp.ac.in',
      'phone': '6204580397',
    },
    'Satyam Tiwari': {
      'email': 'satyamt.dd24.me@nitp.ac.in',
      'phone': '7545924508',
    },
    'TABASSUM BANERJEE': {
      'email': 'tabassumb.ug24.ar@nitp.ac.in',
      'phone': '8170919828',
    },
    'Abhisth Vitan Ambasth': {
      'email': 'Abhistha.ug24.ar@nitp.ac.in',
      'phone': '9973555357',
    },
    // New Bihta coordinators
    'Khushbu Kumari': {
      'email': 'khushbuk.ug24.cs@nitp.ac.in',
      'phone': '8100918754',
    },
    'Anurag Kumar': {
      'email': 'anuragk.ug23.cs@nitp.ac.in',
      'phone': '6203562428',
    },
    'Tanya Bharti': {
      'email': 'tanyab.ug24.ec@nitp.ac.in',
      'phone': '9835097452',
    },
    'Nishant Kumar': {
      'email': 'nishantk.ug23.ec@nitp.ac.in',
      'phone': '7903385887',
    },
    'Shourya Kumar': {
      'email': 'kumarssh.ug24.cs@nitp.ac.in',
      'phone': '7903385887',
    },
    'Shubham Sinha': {
      'email': 'shubhams.dd24.cs@nitp.ac.in',
      'phone': '8789806191',
    },
    'Sarthak Rajan': {
      'email': 'sarthakr.ug24.ec@nitp.ac.in',
      'phone': '8354819414',
    },
    'Yaksh Bariya': {
      'email': 'yakshb.ug24.cs@nitp.ac.in',
      'phone': '9662435662',
    },
    'Talachintala Yashwanth': {
      'email': 'talachintalay.ug23.ec@nitp.ac.in',
      'phone': '9347803531',
    },
    'Sai Koushik': {
      'email': 'puppalak.ug23.ec@nitp.ac.in',
      'phone': '7780154569',
    },
    'Ayush Kumar': {
      'email': 'ayushkr1.ug23.cs@nitp.ac.in',
      'phone': '8271154570',
    },
    'Vasu Choudhari': {
      'email': 'vasuc.ug23.cs@nitp.ac.in',
      'phone': '8600550839',
    },
    'Shivam Kumar': {'email': 'shivamk.dd24.cs@nitp.ac.in', 'phone': ''},
    'Palak Jaiswal': {
      'email': 'palakj.ug23.cs@nitp.ac.in',
      'phone': '9450081431',
    },
    'Nandani Awase': {
      'email': 'nandania.ug23.cs@nitp.ac.in',
      'phone': '6260248296',
    },
  };

  static final List<TeamMember> allTeamMembers = [
    // GMT
    TeamMember(
      team: 'GMT',
      role: 'Coordinator',
      name: 'Manaswini Patil',
      email: _getEmail('Manaswini Patil'),
      phone: _getPhone('Manaswini Patil'),
    ),
    TeamMember(
      team: 'GMT',
      role: 'Co-coordinator',
      name: 'Harshvardhan Dansena',
      email: _getEmail('Harshvardhan Dansena'),
      phone: _getPhone('Harshvardhan Dansena'),
    ),
    // Sponsorship
    TeamMember(
      team: 'Sponsorship',
      role: 'Coordinator',
      name: 'Krish Sinha',
      email: _getEmail('KRISH KUMAR SINHA'),
      phone: _getPhone('KRISH KUMAR SINHA'),
    ),
    TeamMember(
      team: 'Sponsorship',
      role: 'Co-coordinator',
      name: 'Priyanshu',
      email: _getEmail('Priyanshu'),
      phone: _getPhone('Priyanshu'),
    ),
    TeamMember(
      team: 'Sponsorship',
      role: 'Coordinator',
      name: 'Boda Karthik',
      email: _getEmail('Boda Karthik'),
      phone: _getPhone('Boda Karthik'),
    ),
    TeamMember(
      team: 'Sponsorship',
      role: 'Co-coordinator',
      name: 'Shivang',
      email: _getEmail('Shivang Shukla'),
      phone: _getPhone('Shivang Shukla'),
    ),
    // Decoration
    TeamMember(
      team: 'Decoration',
      role: 'Coordinator',
      name: 'Sai Karthik',
      email: _getEmail('Sai Karthik'),
      phone: _getPhone('Sai Karthik'),
    ),
    TeamMember(
      team: 'Decoration',
      role: 'Co-coordinator',
      name: 'Samriddhi',
      email: _getEmail('Samriddhi'),
      phone: _getPhone('Samriddhi'),
    ),
    // Design
    TeamMember(
      team: 'Design',
      role: 'Coordinator',
      name: 'Shubhadeep',
      email: _getEmail('Subhadeep Dey'),
      phone: _getPhone('Subhadeep Dey'),
    ),
    TeamMember(
      team: 'Design',
      role: 'Co-coordinator',
      name: 'Abhisth Vitan Ambasth',
      email: _getEmail('Abhisth Vitan Ambasth'),
      phone: _getPhone('Abhisth Vitan Ambasth'),
    ),
    // Media
    TeamMember(
      team: 'Media',
      role: 'Coordinator',
      name: 'Sidram',
      email: _getEmail('Sidram'),
      phone: _getPhone('Sidram'),
    ),
    TeamMember(
      team: 'Media',
      role: 'Co-coordinator',
      name: 'Suhani',
      email: _getEmail('Suhani'),
      phone: _getPhone('Suhani'),
    ),
    // Stage Management
    TeamMember(
      team: 'Stage Management',
      role: 'Coordinator',
      name: 'Shanvi Dixit',
      email: _getEmail('Shanvi Dixit'),
      phone: _getPhone('Shanvi Dixit'),
    ),
    TeamMember(
      team: 'Stage Management',
      role: 'Co-coordinator',
      name: 'Sanchita Jha',
      email: _getEmail('Sanchita Jha'),
      phone: _getPhone('Sanchita Jha'),
    ),
    // Raaga
    TeamMember(
      team: 'Raaga',
      role: 'Coordinator',
      name: 'Vinayak Thakur',
      email: _getEmail('Vinayak kumar'),
      phone: _getPhone('Vinayak kumar'),
    ),
    TeamMember(
      team: 'Raaga',
      role: 'Co-coordinator',
      name: 'Yogaja Aasti',
      email: _getEmail('Yogaja Aasti'),
      phone: _getPhone('Yogaja Aasti'),
    ),
    TeamMember(
      team: 'Raaga',
      role: 'Co-coordinator',
      name: 'Yash Kashyap',
      email: _getEmail('Yash Kashyap'),
      phone: _getPhone('Yash Kashyap'),
    ),
    TeamMember(
      team: 'Raaga',
      role: 'Coordinator',
      name: 'Sarthak Rajan',
      email: _getEmail('Sarthak Rajan'),
      phone: _getPhone('Sarthak Rajan'),
    ),
    TeamMember(
      team: 'Raaga',
      role: 'Co-coordinator',
      name: 'Yaksh Bariya',
      email: _getEmail('Yaksh Bariya'),
      phone: _getPhone('Yaksh Bariya'),
    ),
    // Nrityangana
    TeamMember(
      team: 'Nrityangana',
      role: 'Coordinator',
      name: 'Aditi Verma',
      email: _getEmail('Aditi Verma'),
      phone: _getPhone('Aditi Verma'),
    ),
    TeamMember(
      team: 'Nrityangana',
      role: 'Co-coordinator',
      name: 'Anusha',
      email: _getEmail('Anusha Mitra'),
      phone: _getPhone('Anusha Mitra'),
    ),
    TeamMember(
      team: 'Nrityangana',
      role: 'Co-coordinator',
      name: 'Mitali',
      email: _getEmail('Mitali Raj'),
      phone: _getPhone('Mitali Raj'),
    ),
    TeamMember(
      team: 'Nrityangana',
      role: 'Coordinator',
      name: 'Talachintala Yashwanth',
      email: _getEmail('Talachintala Yashwanth'),
      phone: _getPhone('Talachintala Yashwanth'),
    ),
    TeamMember(
      team: 'Nrityangana',
      role: 'Co-coordinator',
      name: 'Sai Koushik',
      email: _getEmail('Sai Koushik'),
      phone: _getPhone('Sai Koushik'),
    ),
    // Kalakriti
    TeamMember(
      team: 'Kalakriti',
      role: 'Coordinator',
      name: 'Rohit Kumar',
      email: _getEmail('Rohit Kumar'),
      phone: _getPhone('Rohit Kumar'),
    ),
    TeamMember(
      team: 'Kalakriti',
      role: 'Co-coordinator',
      name: 'Shrami Mathur',
      email: _getEmail('Shrami Mathur'),
      phone: _getPhone('Shrami Mathur'),
    ),
    TeamMember(
      team: 'Kalakriti',
      role: 'Co-coordinator',
      name: 'Bhavyanshi',
      email: _getEmail('Bhavyanshi'),
      phone: _getPhone('Bhavyanshi'),
    ),
    TeamMember(
      team: 'Kalakriti',
      role: 'Coordinator',
      name: 'Anurag Mishra',
      email: _getEmail('Anurag Mishra'),
      phone: _getPhone('Anurag Mishra'),
    ),
    TeamMember(
      team: 'Kalakriti',
      role: 'Co-coordinator',
      name: 'Khushbu Kumari',
      email: _getEmail('Khushbu Kumari'),
      phone: _getPhone('Khushbu Kumari'),
    ),
    // Avlokan
    TeamMember(
      team: 'Avlokan',
      role: 'Coordinator',
      name: 'Aparna',
      email: _getEmail('Aparna singh'),
      phone: _getPhone('Aparna singh'),
    ),
    TeamMember(
      team: 'Avlokan',
      role: 'Co-coordinator',
      name: 'Deepali',
      email: _getEmail('Deepali Mishra'),
      phone: _getPhone('Deepali Mishra'),
    ),
    TeamMember(
      team: 'Avlokan',
      role: 'Co-coordinator',
      name: 'Satyam',
      email: _getEmail('Satyam Kumar'),
      phone: _getPhone('Satyam Kumar'),
    ),
    // Sanhita
    TeamMember(
      team: 'Sanhita',
      role: 'Coordinator',
      name: 'Rishav',
      email: _getEmail('Rishav'),
      phone: _getPhone('Rishav'),
    ),
    TeamMember(
      team: 'Sanhita',
      role: 'Co-coordinator',
      name: 'Nitin',
      email: _getEmail('Nitin Tiwari'),
      phone: _getPhone('Nitin Tiwari'),
    ),
    // Abhinay
    TeamMember(
      team: 'Abhinay',
      role: 'Coordinator',
      name: 'Aditya Raj',
      email: _getEmail('Aditya Raj'),
      phone: _getPhone('Aditya Raj'),
    ),
    TeamMember(
      team: 'Abhinay',
      role: 'Co-coordinator',
      name: 'Manvi',
      email: _getEmail('Manvi'),
      phone: _getPhone('Manvi'),
    ),
    // Vistakari
    TeamMember(
      team: 'Vistakari',
      role: 'Coordinator',
      name: 'Niranjan',
      email: _getEmail('Niranjan S'),
      phone: _getPhone('Niranjan S'),
    ),
    TeamMember(
      team: 'Vistakari',
      role: 'Co-coordinator',
      name: 'Abhay',
      email: _getEmail('Abhay'),
      phone: _getPhone('Abhay'),
    ),
    // Graphika
    TeamMember(
      team: 'Graphika',
      role: 'Coordinator',
      name: 'Bhanu Priya',
      email: _getEmail('Bhanu Priya'),
      phone: _getPhone('Bhanu Priya'),
    ),
    TeamMember(
      team: 'Graphika',
      role: 'Co-coordinator',
      name: 'Tabassum Bannerjee',
      email: _getEmail('TABASSUM BANERJEE'),
      phone: _getPhone('TABASSUM BANERJEE'),
    ),
    TeamMember(
      team: 'Graphika',
      role: 'Co-coordinator',
      name: 'Shubham Sinha',
      email: _getEmail('Shubham Sinha'),
      phone: _getPhone('Shubham Sinha'),
    ),
    // Pratibimb
    TeamMember(
      team: 'Pratibimb',
      role: 'Coordinator',
      name: 'Aditi Rao',
      email: _getEmail('Aditi Jayesh Rao'),
      phone: _getPhone('Aditi Jayesh Rao'),
    ),
    TeamMember(
      team: 'Pratibimb',
      role: 'Co-coordinator',
      name: 'Jyoti Kumari',
      email: _getEmail('Jyoti Kumari'),
      phone: _getPhone('Jyoti Kumari'),
    ),
    TeamMember(
      team: 'Pratibimb',
      role: 'Coordinator',
      name: 'Palak Jaiswal',
      email: _getEmail('Palak Jaiswal'),
      phone: _getPhone('Palak Jaiswal'),
    ),
    TeamMember(
      team: 'Pratibimb',
      role: 'Co-coordinator',
      name: 'Nandani Awase',
      email: _getEmail('Nandani Awase'),
      phone: _getPhone('Nandani Awase'),
    ),
    // Outdoor sports
    TeamMember(
      team: 'Outdoor sports',
      role: 'Coordinator',
      name: 'Dishant',
      email: _getEmail('Dishant Kumar Patel'),
      phone: _getPhone('Dishant Kumar Patel'),
    ),
    TeamMember(
      team: 'Outdoor sports',
      role: 'Co-coordinator',
      name: 'Prajwal',
      email: _getEmail('Prajwal akki'),
      phone: _getPhone('Prajwal akki'),
    ),
    // Indoor sports
    TeamMember(
      team: 'Indoor sports',
      role: 'Coordinator',
      name: 'Daksh',
      email: _getEmail('Daksh Agrawal'),
      phone: _getPhone('Daksh Agrawal'),
    ),
    TeamMember(
      team: 'Indoor sports',
      role: 'Co-coordinator',
      name: 'Archi',
      email: _getEmail('Archi'),
      phone: _getPhone('Archi'),
    ),
    // Abhinay
    TeamMember(
      team: 'Abhinay',
      role: 'Coordinator',
      name: 'Anurag Kumar',
      email: _getEmail('Anurag Kumar'),
      phone: _getPhone('Anurag Kumar'),
    ),
    TeamMember(
      team: 'Abhinay',
      role: 'Co-coordinator',
      name: 'Tanya Bharti',
      email: _getEmail('Tanya Bharti'),
      phone: _getPhone('Tanya Bharti'),
    ),
    // PMC
    TeamMember(
      team: 'PMC',
      role: 'Coordinator',
      name: 'Nishant Kumar',
      email: _getEmail('Nishant Kumar'),
      phone: _getPhone('Nishant Kumar'),
    ),
    TeamMember(
      team: 'PMC',
      role: 'Co-coordinator',
      name: 'Shourya Kumar',
      email: _getEmail('Shourya Kumar'),
      phone: _getPhone('Shourya Kumar'),
    ),
    TeamMember(
      team: 'PMC',
      role: 'Co-coordinator',
      name: 'Shubham Sinha',
      email: _getEmail('Shubham Sinha'),
      phone: _getPhone('Shubham Sinha'),
    ),
    // Environment Club
    TeamMember(
      team: 'Environment Club',
      role: 'Coordinator',
      name: 'Ayush Kumar',
      email: _getEmail('Ayush Kumar'),
      phone: _getPhone('Ayush Kumar'),
    ),
    TeamMember(
      team: 'Environment Club',
      role: 'Co-coordinator',
      name: 'Vasu Choudhari',
      email: _getEmail('Vasu Choudhari'),
      phone: _getPhone('Vasu Choudhari'),
    ),
    // Treasure Hunt
    TeamMember(
      team: 'Treasure Hunt',
      role: 'Coordinator',
      name: 'Anurag kumar',
      email: _getEmail('Anurag Kumar'),
      phone: _getPhone('Anurag Kumar'),
    ),
    TeamMember(
      team: 'Treasure Hunt',
      role: 'Co-coordinator',
      name: 'Shivam Kumar',
      email: _getEmail('Shivam Kumar'),
      phone: _getPhone('Shivam Kumar'),
    ),
  ];

  static String? _getEmail(String name) {
    return _peopleData[name]?['email'];
  }

  static String? _getPhone(String name) {
    return _peopleData[name]?['phone'];
  }

  static Map<String, List<TeamMember>> getTeamMembersGroupedByTeam() {
    final Map<String, List<TeamMember>> grouped = {};
    for (final member in allTeamMembers) {
      if (member.email != null && member.phone != null) {
        grouped.putIfAbsent(member.team, () => []).add(member);
      }
    }
    return grouped;
  }
}
