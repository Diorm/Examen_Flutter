import 'package:flutter/material.dart';

class AddSemesterDialog extends StatefulWidget {
  final Function(int, int, int) onAdd;

  const AddSemesterDialog({super.key, required this.onAdd});

  @override
  _AddSemesterDialogState createState() => _AddSemesterDialogState();
}

class _AddSemesterDialogState extends State<AddSemesterDialog> {
  final _formKey = GlobalKey<FormState>();
  int _numeroSemestre = 1;
  int _volumeHoraireTotale = 0;
  int _nombreTotalModules = 0;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onAdd(_numeroSemestre, _volumeHoraireTotale, _nombreTotalModules);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ajouter un Semestre'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Numéro de Semestre'),
              keyboardType: TextInputType.number,
              onSaved: (value) {
                _numeroSemestre = int.parse(value!);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un numéro de semestre';
                }
                return null;
              },
            ),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Volume Horaire Total'),
              keyboardType: TextInputType.number,
              onSaved: (value) {
                _volumeHoraireTotale = int.parse(value!);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer le volume horaire total';
                }
                return null;
              },
            ),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Nombre Total de Modules'),
              keyboardType: TextInputType.number,
              onSaved: (value) {
                _nombreTotalModules = int.parse(value!);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer le nombre total de modules';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Ajouter'),
        ),
      ],
    );
  }
}
