import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle/data/game_catalog.dart';

void main() {
  group('GameCatalog', () {
    test('contains the canonical PuzzleBox catalog', () {
      expect(GameCatalog.all, hasLength(161));

      final ids = GameCatalog.all.map((game) => game.id).toSet();
      expect(ids, hasLength(GameCatalog.all.length));

      expect(GameCatalog.countInCategory('LOGIC'), 33);
      expect(GameCatalog.countInCategory('MATH'), 35);
      expect(GameCatalog.countInCategory('MEMORY'), 25);
      expect(GameCatalog.countInCategory('SPATIAL'), 20);
      expect(GameCatalog.countInCategory('ATTENTION'), 31);
      expect(GameCatalog.countInCategory('WORD'), 17);
    });

    test('curated quick-play games resolve to catalog entries', () {
      expect(GameCatalog.quickPlay, isNotEmpty);
      expect(
        GameCatalog.quickPlay.map((game) => game.id).toSet(),
        hasLength(GameCatalog.quickPlay.length),
      );
    });
  });
}
