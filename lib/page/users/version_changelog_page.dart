import 'package:filmoly/generated/l10n.dart';
import 'package:flutter/material.dart';

/// Página de registro de versiones (como en Fitcron: mapa arriba, una línea por versión).
class VersionChangeLogPage extends StatelessWidget {
  const VersionChangeLogPage({super.key});

  /// Cada versión nueva ponerla en primer lugar. Usa S.current para el idioma actual.
  static Map<String, String> get versions => {
        S.current.appVersion10Code: S.current.appVersion10Description,
      };

  @override
  Widget build(BuildContext context) {
    final versionsMap = versions;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.appVersionChangeLogTitle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: versionsMap.length,
          itemBuilder: (context, index) {
            final key = versionsMap.keys.elementAt(index);
            final value = versionsMap[key]!;
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Card(
                  child: ExpansionTile(
                    title: Text(
                      key,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    initiallyExpanded: index == 0,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            value,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.visible,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
