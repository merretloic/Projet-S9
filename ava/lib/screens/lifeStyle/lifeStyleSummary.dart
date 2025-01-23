import 'package:flutter/material.dart';
import 'package:ava/services/configurationManager.dart';
import 'dart:convert';
import 'lifeStyleEditing.dart';

class LifeStyleSummaryMenu extends StatefulWidget {
  final ConfigurationManager configManager;
  const LifeStyleSummaryMenu({super.key, required this.configManager});

  @override
  _LifeStyleState createState() => _LifeStyleState();
}

class _LifeStyleState extends State<LifeStyleSummaryMenu> {
  late ConfigurationManager configManager;
  late List<dynamic> conseils;

  @override
  void initState() {
    super.initState();
    configManager = widget.configManager;
    if (configManager.conseilsNotifier.value.isNotEmpty) {
      conseils = jsonDecode(configManager.conseilsNotifier.value);
    } else {
      conseils = [];
    }
  }

  void _lifeStyleEditingMenu() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            LifeStyleEditingMenu(configManager: configManager),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: const Text(
                    'Bilan de style de vie :',
                    style: TextStyle(fontSize: 32),
                    overflow: TextOverflow.clip,
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: _lifeStyleEditingMenu,
                    child: const Text('Editer style de vie'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                border: Border.all(color: Colors.black),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Votre style de vie est sain à 78% !',
                style: TextStyle(fontSize: 32),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Conseils d\'améliorations :',
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: conseils.map((conseil) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              conseil['state']
                                  .replaceAll('Ã©', 'é')
                                  .replaceFirst(conseil['state'][0],
                                      conseil['state'][0].toUpperCase()),
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              conseil['recommendations'].replaceAll('Ã©', 'é'),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            if (conseils.isEmpty)
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  border: Border.all(color: Colors.black),
                ),
                child: const Text(
                  "Aucune données, remplissez le formulaire d'utilisateur auparavant",
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}