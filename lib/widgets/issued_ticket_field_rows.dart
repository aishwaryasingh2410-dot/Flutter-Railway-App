import 'package:flutter/material.dart';

import '../models/issued_ticket.dart';

/// Shared CLASS / FROM / TO … rows for e-ticket and booking history.
class IssuedTicketFieldRows extends StatelessWidget {
  const IssuedTicketFieldRows({
    super.key,
    required this.ticket,
    required this.dateStr,
  });

  final IssuedTicket ticket;
  final String dateStr;

  static const Color routeBlue = Color(0xFF1565C0);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('CLASS', ticket.classLabel),
        _row('TICKET TYPE', ticket.ticketTypeLabel),
        _row('ADULT', '${ticket.passengers}'),
        _row('CHILD', '0'),
        _row('DATE', dateStr),
        _row('NUMBER', ticket.ticketNumber),
        _routeRow('FROM', ticket.fromStation),
        _row('VALID', '6 Hour'),
        _row('PRICE', '${ticket.fareRupees}.0'),
        _routeRow('TO', ticket.toStation),
        _row('ROUTE', 'Mumbai Line'),
      ],
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _routeRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: routeBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
