/// Validates that an email is an NIT Patna institutional email.
/// Used to restrict student (user) registration to @nitp.ac.in only.
bool isNitpEmail(String? email) {
  if (email == null || email.isEmpty) return false;
  final normalized = email.trim().toLowerCase();
  return normalized.endsWith('@nitp.ac.in');
}
