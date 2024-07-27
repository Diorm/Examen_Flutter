import 'package:flutter/material.dart';

class MySemesterCard extends StatelessWidget {
  final int numeroSemestre;
  final int volumeHoraireTotale;
  final int nombreTotalModules;
  final void Function()? onTap;
  final Color color;

  const MySemesterCard({
    super.key,
    required this.numeroSemestre,
    required this.volumeHoraireTotale,
    required this.nombreTotalModules,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(15),
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Semestre",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  numeroSemestre.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Modules: ",
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        Text(
                          nombreTotalModules.toString(),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Volume Horaires: ",
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        Text(
                          volumeHoraireTotale.toString(),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
