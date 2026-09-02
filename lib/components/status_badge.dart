import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String texto;
  final Color cor;

  const StatusBadge({super.key, required this.texto, required this.cor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: cor.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: cor.withValues(alpha: 0.4)),
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: cor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
