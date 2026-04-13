import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/mumbai_suburban_stations.dart';
import '../../providers/fyp_ticket_draft_provider.dart';
import '../../providers/ticket_checkout_provider.dart';
import '../../theme/fyp_colors.dart';
import '../booking/ticket_details_screen.dart';

class RailwayMapScreen extends ConsumerStatefulWidget {
  const RailwayMapScreen({super.key});

  @override
  ConsumerState<RailwayMapScreen> createState() => _RailwayMapScreenState();
}

class _RailwayMapScreenState extends ConsumerState<RailwayMapScreen> {
  String? _selectedSource;

  void _onStationClicked(String station) {
    setState(() {
      _selectedSource = station;
    });
    _showDestinationPicker(station);
  }

  void _showDestinationPicker(String source) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Select Destination',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Source: $source',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.separated(
                  itemCount: MumbaiSuburbanStations.all.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final dest = MumbaiSuburbanStations.all[index];
                    if (dest == source) return const SizedBox.shrink();
                    return ListTile(
                      title: Text(dest),
                      onTap: () {
                        ref.read(fypTicketDraftProvider.notifier).setFrom(source);
                        ref.read(fypTicketDraftProvider.notifier).setTo(dest);
                        ref.read(ticketCheckoutProvider.notifier).reset();
                        
                        Navigator.pop(context); // Close bottom sheet
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const TicketDetailsScreen()),
                        );
                      },
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: FypColors.appBarLavender,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('MUMBAI RAILWAY MAP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'MUMBAI RAILWAY STATIONS AND ROUTES MAP',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.black87),
                ),
                const SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMapLine('HARBOUR', Colors.lightGreen, [
                      'CSMT', 'Masjid', 'Sandhurst Road', 'Dockyard Road', 'Reay Road', 'Cotton Green', 'Sewri', 
                      'Wadala Road', 'GTB Nagar', 'Chunabhatti', 'Kurla', 'Tilak Nagar', 'Chembur', 'Govandi', 'Mankhurd',
                      'Vashi', 'Sanpada', 'Juinagar', 'Nerul', 'Seawoods', 'Belapur', 'Kharghar', 'Mansarovar', 'Khandeshwar', 'Panvel'
                    ]),
                    const SizedBox(width: 40),
                    _buildMapLine('CENTRAL', Colors.orange, [
                      'CSMT', 'Masjid', 'Sandhurst Road', 'Byculla', 'Chinchpokli', 'Currey Road', 'Parel', 'Dadar', 'Matunga',
                      'Sion', 'Kurla', 'Vidyavihar', 'Ghatkopar', 'Vikhroli', 'Kanjurmarg', 'Bhandup', 'Nahur', 'Mulund', 'Thane',
                      'Kalwa', 'Mumbra', 'Diva', 'Lower Kopar', 'Dombivli', 'Thakurli', 'Kalyan'
                    ]),
                    const SizedBox(width: 40),
                    _buildMapLine('WESTERN', Colors.cyan, [
                      'Churchgate', 'Marine Lines', 'Charni Road', 'Grant Road', 'Mumbai Central', 'Mahalaxmi', 'Lower Parel',
                      'Prabhadevi', 'Matunga Road', 'Mahim Junction', 'Bandra', 'Khar Road', 'Santacruz', 'Vile Parle', 'Andheri',
                      'Jogeshwari', 'Goregaon', 'Malad', 'Kandivali', 'Borivali', 'Dahisar', 'Mira Road', 'Bhayandar', 'Naigaon', 'Vasai Road'
                    ]),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMapLine(String title, Color color, List<String> stations) {
    return Column(
      children: [
        Row(
          children: [
            Container(width: 4, height: 40, color: color),
            const SizedBox(width: 8),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 10)),
          ],
        ),
        ...stations.map((s) => _buildStationNode(s, color)),
      ],
    );
  }

  Widget _buildStationNode(String name, Color lineColor) {
    return InkWell(
      onTap: () => _onStationClicked(name),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(width: 4, height: 24, color: lineColor),
            const SizedBox(width: 12),
            Text(
              name,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
