/// Mumbai Suburban Railway station names (Central, Harbour, Western).
/// Duplicates from the source list are merged into one canonical set.
abstract final class MumbaiSuburbanStations {
  MumbaiSuburbanStations._();

  /// Stable display order (roughly south → north / branch flow), used for filtering.
  static const List<String> all = [
    // Central — Main (CSMT area)
    'Chhatrapati Shivaji Maharaj Terminus',
    'Masjid',
    'Sandhurst Road',
    'Byculla',
    'Chinchpokli',
    'Currey Road',
    'Parel',
    'Dadar',
    'Matunga',
    'Sion',
    'Kurla',
    'Vidyavihar',
    'Ghatkopar',
    'Vikhroli',
    'Kanjurmarg',
    'Bhandup',
    'Nahur',
    'Mulund',
    'Thane',
    'Kalwa',
    'Mumbra',
    'Diva Junction',
    'Kopar',
    'Dombivli',
    'Thakurli',
    'Kalyan Junction',
    'Shahad',
    'Ambivli',
    'Titwala',
    'Khadavli',
    'Vasind',
    'Asangaon',
    'Atgaon',
    'Khardi',
    'Kasara',
    'Vitthalwadi',
    'Ulhasnagar',
    'Vangani',
    'Badlapur',
    'Ambernath',
    'Karjat',
    'Palasdari',
    'Kelavli',
    'Dolavli',
    'Lowjee',
    'Khopoli',
    // Harbour
    'Dockyard Road',
    'Reay Road',
    'Cotton Green',
    'Sewri',
    'Wadala Road',
    'Guru Tegh Bahadur Nagar',
    'Chunabhatti',
    'Tilak Nagar',
    'Chembur',
    'Govandi',
    'Mankhurd',
    'Vashi',
    'Sanpada',
    'Juinagar',
    'Nerul',
    'Seawoods-Darave',
    'CBD Belapur',
    'Kharghar',
    'Mansarovar',
    'Khandeshwar',
    'Panvel',
    // Western
    'Churchgate railway station',
    'Marine Lines',
    'Charni Road',
    'Grant Road',
    'Mumbai Central',
    'Mahalaxmi',
    'Lower Parel',
    'Prabhadevi',
    'Matunga Road',
    'Mahim Junction',
    'Bandra',
    'Khar Road',
    'Santacruz',
    'Vile Parle',
    'Andheri',
    'Jogeshwari',
    'Ram Mandir',
    'Goregaon',
    'Malad',
    'Kandivali',
    'Borivali',
    'Dahisar',
    'Mira Road',
    'Bhayandar',
    'Naigaon',
    'Vasai Road',
    'Nalasopara',
    'Virar',
    'Vaitarna',
    'Saphale',
    'Kelve Road',
    'Palghar',
    'Umroli',
    'Boisar',
    'Vangaon',
    'Dahanu Road',
  ];

  /// Substring match, case-insensitive, preserving [all] order, capped.
  static Iterable<String> matching(String query, {int limit = 15}) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return const Iterable<String>.empty();

    final out = <String>[];
    for (final s in all) {
      if (s.toLowerCase().contains(q)) {
        out.add(s);
        if (out.length >= limit) break;
      }
    }
    return out;
  }
}
