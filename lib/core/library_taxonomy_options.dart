import 'package:filmaniak/generated/l10n.dart';

class LibraryTaxonomyOption {
  LibraryTaxonomyOption({
    required this.slug,
    required this.labelKey,
    required this.resolveLabel,
  });

  final String slug;
  final String labelKey;
  final String Function(S s) resolveLabel;

  String label(S s) => resolveLabel(s);
}

final List<LibraryTaxonomyOption> libraryCategoryOptions = [
  LibraryTaxonomyOption(
    slug: 'pelicula',
    labelKey: 'libraryTaxonomyCatPelicula',
    resolveLabel: (s) => s.libraryTaxonomyCatPelicula,
  ),
  LibraryTaxonomyOption(
    slug: 'serie',
    labelKey: 'libraryTaxonomyCatSerie',
    resolveLabel: (s) => s.libraryTaxonomyCatSerie,
  ),
  LibraryTaxonomyOption(
    slug: 'cortometraje',
    labelKey: 'libraryTaxonomyCatCortometraje',
    resolveLabel: (s) => s.libraryTaxonomyCatCortometraje,
  ),
  LibraryTaxonomyOption(
    slug: 'documental',
    labelKey: 'libraryTaxonomyCatDocumental',
    resolveLabel: (s) => s.libraryTaxonomyCatDocumental,
  ),
  LibraryTaxonomyOption(
    slug: 'programatv',
    labelKey: 'libraryTaxonomyCatProgramatv',
    resolveLabel: (s) => s.libraryTaxonomyCatProgramatv,
  ),
];

final List<LibraryTaxonomyOption> libraryStyleOptions = [
  LibraryTaxonomyOption(
    slug: 'liveaction',
    labelKey: 'libraryTaxonomyStyleLiveaction',
    resolveLabel: (s) => s.libraryTaxonomyStyleLiveaction,
  ),
  LibraryTaxonomyOption(
    slug: 'animacion',
    labelKey: 'libraryTaxonomyStyleAnimacion',
    resolveLabel: (s) => s.libraryTaxonomyStyleAnimacion,
  ),
  LibraryTaxonomyOption(
    slug: 'anime',
    labelKey: 'libraryTaxonomyStyleAnime',
    resolveLabel: (s) => s.libraryTaxonomyStyleAnime,
  ),
];

final List<LibraryTaxonomyOption> libraryGenreOptions = [
  LibraryTaxonomyOption(
    slug: 'accion',
    labelKey: 'libraryTaxonomyGenreAccion',
    resolveLabel: (s) => s.libraryTaxonomyGenreAccion,
  ),
  LibraryTaxonomyOption(
    slug: 'aventuras',
    labelKey: 'libraryTaxonomyGenreAventuras',
    resolveLabel: (s) => s.libraryTaxonomyGenreAventuras,
  ),
  LibraryTaxonomyOption(
    slug: 'belico',
    labelKey: 'libraryTaxonomyGenreBelico',
    resolveLabel: (s) => s.libraryTaxonomyGenreBelico,
  ),
  LibraryTaxonomyOption(
    slug: 'ciencia-ficcion',
    labelKey: 'libraryTaxonomyGenreCienciaFiccion',
    resolveLabel: (s) => s.libraryTaxonomyGenreCienciaFiccion,
  ),
  LibraryTaxonomyOption(
    slug: 'cine-negro',
    labelKey: 'libraryTaxonomyGenreCineNegro',
    resolveLabel: (s) => s.libraryTaxonomyGenreCineNegro,
  ),
  LibraryTaxonomyOption(
    slug: 'cine-quinqui',
    labelKey: 'libraryTaxonomyGenreCineQuinqui',
    resolveLabel: (s) => s.libraryTaxonomyGenreCineQuinqui,
  ),
  LibraryTaxonomyOption(
    slug: 'comedia',
    labelKey: 'libraryTaxonomyGenreComedia',
    resolveLabel: (s) => s.libraryTaxonomyGenreComedia,
  ),
  LibraryTaxonomyOption(
    slug: 'documental',
    labelKey: 'libraryTaxonomyGenreDocumental',
    resolveLabel: (s) => s.libraryTaxonomyGenreDocumental,
  ),
  LibraryTaxonomyOption(
    slug: 'drama',
    labelKey: 'libraryTaxonomyGenreDrama',
    resolveLabel: (s) => s.libraryTaxonomyGenreDrama,
  ),
  LibraryTaxonomyOption(
    slug: 'fantasia',
    labelKey: 'libraryTaxonomyGenreFantasia',
    resolveLabel: (s) => s.libraryTaxonomyGenreFantasia,
  ),
  LibraryTaxonomyOption(
    slug: 'musical',
    labelKey: 'libraryTaxonomyGenreMusical',
    resolveLabel: (s) => s.libraryTaxonomyGenreMusical,
  ),
  LibraryTaxonomyOption(
    slug: 'romance',
    labelKey: 'libraryTaxonomyGenreRomance',
    resolveLabel: (s) => s.libraryTaxonomyGenreRomance,
  ),
  LibraryTaxonomyOption(
    slug: 'suspense',
    labelKey: 'libraryTaxonomyGenreSuspense',
    resolveLabel: (s) => s.libraryTaxonomyGenreSuspense,
  ),
  LibraryTaxonomyOption(
    slug: 'terror',
    labelKey: 'libraryTaxonomyGenreTerror',
    resolveLabel: (s) => s.libraryTaxonomyGenreTerror,
  ),
  LibraryTaxonomyOption(
    slug: 'thriller',
    labelKey: 'libraryTaxonomyGenreThriller',
    resolveLabel: (s) => s.libraryTaxonomyGenreThriller,
  ),
  LibraryTaxonomyOption(
    slug: 'western',
    labelKey: 'libraryTaxonomyGenreWestern',
    resolveLabel: (s) => s.libraryTaxonomyGenreWestern,
  ),
];

final List<LibraryTaxonomyOption> librarySubgenreOptions = [
  LibraryTaxonomyOption(
    slug: '1a-guerra-mundial',
    labelKey: 'libraryTaxonomySub1aGuerraMundial',
    resolveLabel: (s) => s.libraryTaxonomySub1aGuerraMundial,
  ),
  LibraryTaxonomyOption(
    slug: '2a-guerra-mundial',
    labelKey: 'libraryTaxonomySub2aGuerraMundial',
    resolveLabel: (s) => s.libraryTaxonomySub2aGuerraMundial,
  ),
  LibraryTaxonomyOption(
    slug: '3d',
    labelKey: 'libraryTaxonomySub3d',
    resolveLabel: (s) => s.libraryTaxonomySub3d,
  ),
  LibraryTaxonomyOption(
    slug: 'abusos-sexuales',
    labelKey: 'libraryTaxonomySubAbusosSexuales',
    resolveLabel: (s) => s.libraryTaxonomySubAbusosSexuales,
  ),
  LibraryTaxonomyOption(
    slug: 'adaptacion-comic',
    labelKey: 'libraryTaxonomySubAdaptacionComic',
    resolveLabel: (s) => s.libraryTaxonomySubAdaptacionComic,
  ),
  LibraryTaxonomyOption(
    slug: 'adaptacion-libro',
    labelKey: 'libraryTaxonomySubAdaptacionLibro',
    resolveLabel: (s) => s.libraryTaxonomySubAdaptacionLibro,
  ),
  LibraryTaxonomyOption(
    slug: 'adaptacion-relato',
    labelKey: 'libraryTaxonomySubAdaptacionRelato',
    resolveLabel: (s) => s.libraryTaxonomySubAdaptacionRelato,
  ),
  LibraryTaxonomyOption(
    slug: 'adaptacion-videojuego',
    labelKey: 'libraryTaxonomySubAdaptacionVideojuego',
    resolveLabel: (s) => s.libraryTaxonomySubAdaptacionVideojuego,
  ),
  LibraryTaxonomyOption(
    slug: 'adolescencia',
    labelKey: 'libraryTaxonomySubAdolescencia',
    resolveLabel: (s) => s.libraryTaxonomySubAdolescencia,
  ),
  LibraryTaxonomyOption(
    slug: 'american-gothic',
    labelKey: 'libraryTaxonomySubAmericanGothic',
    resolveLabel: (s) => s.libraryTaxonomySubAmericanGothic,
  ),
  LibraryTaxonomyOption(
    slug: 'animales',
    labelKey: 'libraryTaxonomySubAnimales',
    resolveLabel: (s) => s.libraryTaxonomySubAnimales,
  ),
  LibraryTaxonomyOption(
    slug: 'antigua-grecia',
    labelKey: 'libraryTaxonomySubAntiguaGrecia',
    resolveLabel: (s) => s.libraryTaxonomySubAntiguaGrecia,
  ),
  LibraryTaxonomyOption(
    slug: 'antigua-roma',
    labelKey: 'libraryTaxonomySubAntiguaRoma',
    resolveLabel: (s) => s.libraryTaxonomySubAntiguaRoma,
  ),
  LibraryTaxonomyOption(
    slug: 'antiguo-egipto',
    labelKey: 'libraryTaxonomySubAntiguoEgipto',
    resolveLabel: (s) => s.libraryTaxonomySubAntiguoEgipto,
  ),
  LibraryTaxonomyOption(
    slug: 'arqueologia',
    labelKey: 'libraryTaxonomySubArqueologia',
    resolveLabel: (s) => s.libraryTaxonomySubArqueologia,
  ),
  LibraryTaxonomyOption(
    slug: 'artes-marciales',
    labelKey: 'libraryTaxonomySubArtesMarciales',
    resolveLabel: (s) => s.libraryTaxonomySubArtesMarciales,
  ),
  LibraryTaxonomyOption(
    slug: 'asesinos-en-serie',
    labelKey: 'libraryTaxonomySubAsesinosEnSerie',
    resolveLabel: (s) => s.libraryTaxonomySubAsesinosEnSerie,
  ),
  LibraryTaxonomyOption(
    slug: 'aventuras-aereas',
    labelKey: 'libraryTaxonomySubAventurasAereas',
    resolveLabel: (s) => s.libraryTaxonomySubAventurasAereas,
  ),
  LibraryTaxonomyOption(
    slug: 'aventuras-marinas',
    labelKey: 'libraryTaxonomySubAventurasMarinas',
    resolveLabel: (s) => s.libraryTaxonomySubAventurasMarinas,
  ),
  LibraryTaxonomyOption(
    slug: 'bandas-pandillas-callejeras',
    labelKey: 'libraryTaxonomySubBandasPandillasCallejeras',
    resolveLabel: (s) => s.libraryTaxonomySubBandasPandillasCallejeras,
  ),
  LibraryTaxonomyOption(
    slug: 'biblia',
    labelKey: 'libraryTaxonomySubBiblia',
    resolveLabel: (s) => s.libraryTaxonomySubBiblia,
  ),
  LibraryTaxonomyOption(
    slug: 'biografico',
    labelKey: 'libraryTaxonomySubBiografico',
    resolveLabel: (s) => s.libraryTaxonomySubBiografico,
  ),
  LibraryTaxonomyOption(
    slug: 'bizarro',
    labelKey: 'libraryTaxonomySubBizarro',
    resolveLabel: (s) => s.libraryTaxonomySubBizarro,
  ),
  LibraryTaxonomyOption(
    slug: 'body-horror',
    labelKey: 'libraryTaxonomySubBodyHorror',
    resolveLabel: (s) => s.libraryTaxonomySubBodyHorror,
  ),
  LibraryTaxonomyOption(
    slug: 'brujeria',
    labelKey: 'libraryTaxonomySubBrujeria',
    resolveLabel: (s) => s.libraryTaxonomySubBrujeria,
  ),
  LibraryTaxonomyOption(
    slug: 'canibalismo',
    labelKey: 'libraryTaxonomySubCanibalismo',
    resolveLabel: (s) => s.libraryTaxonomySubCanibalismo,
  ),
  LibraryTaxonomyOption(
    slug: 'capa-y-espada',
    labelKey: 'libraryTaxonomySubCapaYEspada',
    resolveLabel: (s) => s.libraryTaxonomySubCapaYEspada,
  ),
  LibraryTaxonomyOption(
    slug: 'casas-encantadas',
    labelKey: 'libraryTaxonomySubCasasEncantadas',
    resolveLabel: (s) => s.libraryTaxonomySubCasasEncantadas,
  ),
  LibraryTaxonomyOption(
    slug: 'catastrofes',
    labelKey: 'libraryTaxonomySubCatastrofes',
    resolveLabel: (s) => s.libraryTaxonomySubCatastrofes,
  ),
  LibraryTaxonomyOption(
    slug: 'cine-dentro-de-cine',
    labelKey: 'libraryTaxonomySubCineDentroDeCine',
    resolveLabel: (s) => s.libraryTaxonomySubCineDentroDeCine,
  ),
  LibraryTaxonomyOption(
    slug: 'cine-epico',
    labelKey: 'libraryTaxonomySubCineEpico',
    resolveLabel: (s) => s.libraryTaxonomySubCineEpico,
  ),
  LibraryTaxonomyOption(
    slug: 'cine-experimental',
    labelKey: 'libraryTaxonomySubCineExperimental',
    resolveLabel: (s) => s.libraryTaxonomySubCineExperimental,
  ),
  LibraryTaxonomyOption(
    slug: 'cine-familiar',
    labelKey: 'libraryTaxonomySubCineFamiliar',
    resolveLabel: (s) => s.libraryTaxonomySubCineFamiliar,
  ),
  LibraryTaxonomyOption(
    slug: 'mudo',
    labelKey: 'libraryTaxonomySubMudo',
    resolveLabel: (s) => s.libraryTaxonomySubMudo,
  ),
  LibraryTaxonomyOption(
    slug: 'claustrofobia',
    labelKey: 'libraryTaxonomySubClaustrofobia',
    resolveLabel: (s) => s.libraryTaxonomySubClaustrofobia,
  ),
  LibraryTaxonomyOption(
    slug: 'coches-automoviles',
    labelKey: 'libraryTaxonomySubCochesAutomoviles',
    resolveLabel: (s) => s.libraryTaxonomySubCochesAutomoviles,
  ),
  LibraryTaxonomyOption(
    slug: 'colegios-universidades',
    labelKey: 'libraryTaxonomySubColegiosUniversidades',
    resolveLabel: (s) => s.libraryTaxonomySubColegiosUniversidades,
  ),
  LibraryTaxonomyOption(
    slug: 'comedia-de-terror',
    labelKey: 'libraryTaxonomySubComediaDeTerror',
    resolveLabel: (s) => s.libraryTaxonomySubComediaDeTerror,
  ),
  LibraryTaxonomyOption(
    slug: 'comedia-romantica',
    labelKey: 'libraryTaxonomySubComediaRomantica',
    resolveLabel: (s) => s.libraryTaxonomySubComediaRomantica,
  ),
  LibraryTaxonomyOption(
    slug: 'crimen',
    labelKey: 'libraryTaxonomySubCrimen',
    resolveLabel: (s) => s.libraryTaxonomySubCrimen,
  ),
  LibraryTaxonomyOption(
    slug: 'crossover',
    labelKey: 'libraryTaxonomySubCrossover',
    resolveLabel: (s) => s.libraryTaxonomySubCrossover,
  ),
  LibraryTaxonomyOption(
    slug: 'cuentos',
    labelKey: 'libraryTaxonomySubCuentos',
    resolveLabel: (s) => s.libraryTaxonomySubCuentos,
  ),
  LibraryTaxonomyOption(
    slug: 'culto',
    labelKey: 'libraryTaxonomySubCulto',
    resolveLabel: (s) => s.libraryTaxonomySubCulto,
  ),
  LibraryTaxonomyOption(
    slug: 'cyberpunk',
    labelKey: 'libraryTaxonomySubCyberpunk',
    resolveLabel: (s) => s.libraryTaxonomySubCyberpunk,
  ),
  LibraryTaxonomyOption(
    slug: 'demonios',
    labelKey: 'libraryTaxonomySubDemonios',
    resolveLabel: (s) => s.libraryTaxonomySubDemonios,
  ),
  LibraryTaxonomyOption(
    slug: 'deportes',
    labelKey: 'libraryTaxonomySubDeportes',
    resolveLabel: (s) => s.libraryTaxonomySubDeportes,
  ),
  LibraryTaxonomyOption(
    slug: 'dictadura-argentina',
    labelKey: 'libraryTaxonomySubDictaduraArgentina',
    resolveLabel: (s) => s.libraryTaxonomySubDictaduraArgentina,
  ),
  LibraryTaxonomyOption(
    slug: 'dictadura-chilena',
    labelKey: 'libraryTaxonomySubDictaduraChilena',
    resolveLabel: (s) => s.libraryTaxonomySubDictaduraChilena,
  ),
  LibraryTaxonomyOption(
    slug: 'dinosaurios',
    labelKey: 'libraryTaxonomySubDinosaurios',
    resolveLabel: (s) => s.libraryTaxonomySubDinosaurios,
  ),
  LibraryTaxonomyOption(
    slug: 'distopia',
    labelKey: 'libraryTaxonomySubDistopia',
    resolveLabel: (s) => s.libraryTaxonomySubDistopia,
  ),
  LibraryTaxonomyOption(
    slug: 'divulgativo-educativo',
    labelKey: 'libraryTaxonomySubDivulgativoEducativo',
    resolveLabel: (s) => s.libraryTaxonomySubDivulgativoEducativo,
  ),
  LibraryTaxonomyOption(
    slug: 'dragones',
    labelKey: 'libraryTaxonomySubDragones',
    resolveLabel: (s) => s.libraryTaxonomySubDragones,
  ),
  LibraryTaxonomyOption(
    slug: 'drama-social',
    labelKey: 'libraryTaxonomySubDramaSocial',
    resolveLabel: (s) => s.libraryTaxonomySubDramaSocial,
  ),
  LibraryTaxonomyOption(
    slug: 'drogas',
    labelKey: 'libraryTaxonomySubDrogas',
    resolveLabel: (s) => s.libraryTaxonomySubDrogas,
  ),
  LibraryTaxonomyOption(
    slug: 'duendes',
    labelKey: 'libraryTaxonomySubDuendes',
    resolveLabel: (s) => s.libraryTaxonomySubDuendes,
  ),
  LibraryTaxonomyOption(
    slug: 'edad-media',
    labelKey: 'libraryTaxonomySubEdadMedia',
    resolveLabel: (s) => s.libraryTaxonomySubEdadMedia,
  ),
  LibraryTaxonomyOption(
    slug: 'erotismo',
    labelKey: 'libraryTaxonomySubErotismo',
    resolveLabel: (s) => s.libraryTaxonomySubErotismo,
  ),
  LibraryTaxonomyOption(
    slug: 'esclavitud',
    labelKey: 'libraryTaxonomySubEsclavitud',
    resolveLabel: (s) => s.libraryTaxonomySubEsclavitud,
  ),
  LibraryTaxonomyOption(
    slug: 'espacial',
    labelKey: 'libraryTaxonomySubEspacial',
    resolveLabel: (s) => s.libraryTaxonomySubEspacial,
  ),
  LibraryTaxonomyOption(
    slug: 'espada-y-brujeria',
    labelKey: 'libraryTaxonomySubEspadaYBrujeria',
    resolveLabel: (s) => s.libraryTaxonomySubEspadaYBrujeria,
  ),
  LibraryTaxonomyOption(
    slug: 'espionaje',
    labelKey: 'libraryTaxonomySubEspionaje',
    resolveLabel: (s) => s.libraryTaxonomySubEspionaje,
  ),
  LibraryTaxonomyOption(
    slug: 'experimentos',
    labelKey: 'libraryTaxonomySubExperimentos',
    resolveLabel: (s) => s.libraryTaxonomySubExperimentos,
  ),
  LibraryTaxonomyOption(
    slug: 'explotation',
    labelKey: 'libraryTaxonomySubExplotation',
    resolveLabel: (s) => s.libraryTaxonomySubExplotation,
  ),
  LibraryTaxonomyOption(
    slug: 'expresionismo-aleman',
    labelKey: 'libraryTaxonomySubExpresionismoAleman',
    resolveLabel: (s) => s.libraryTaxonomySubExpresionismoAleman,
  ),
  LibraryTaxonomyOption(
    slug: 'extraterrestres',
    labelKey: 'libraryTaxonomySubExtraterrestres',
    resolveLabel: (s) => s.libraryTaxonomySubExtraterrestres,
  ),
  LibraryTaxonomyOption(
    slug: 'familia',
    labelKey: 'libraryTaxonomySubFamilia',
    resolveLabel: (s) => s.libraryTaxonomySubFamilia,
  ),
  LibraryTaxonomyOption(
    slug: 'fantasmas',
    labelKey: 'libraryTaxonomySubFantasmas',
    resolveLabel: (s) => s.libraryTaxonomySubFantasmas,
  ),
  LibraryTaxonomyOption(
    slug: 'folk',
    labelKey: 'libraryTaxonomySubFolk',
    resolveLabel: (s) => s.libraryTaxonomySubFolk,
  ),
  LibraryTaxonomyOption(
    slug: 'futurismo',
    labelKey: 'libraryTaxonomySubFuturismo',
    resolveLabel: (s) => s.libraryTaxonomySubFuturismo,
  ),
  LibraryTaxonomyOption(
    slug: 'giallo',
    labelKey: 'libraryTaxonomySubGiallo',
    resolveLabel: (s) => s.libraryTaxonomySubGiallo,
  ),
  LibraryTaxonomyOption(
    slug: 'gore',
    labelKey: 'libraryTaxonomySubGore',
    resolveLabel: (s) => s.libraryTaxonomySubGore,
  ),
  LibraryTaxonomyOption(
    slug: 'gotico',
    labelKey: 'libraryTaxonomySubGotico',
    resolveLabel: (s) => s.libraryTaxonomySubGotico,
  ),
  LibraryTaxonomyOption(
    slug: 'guerra-civil-espanola',
    labelKey: 'libraryTaxonomySubGuerraCivilEspanola',
    resolveLabel: (s) => s.libraryTaxonomySubGuerraCivilEspanola,
  ),
  LibraryTaxonomyOption(
    slug: 'guerra-de-corea',
    labelKey: 'libraryTaxonomySubGuerraDeCorea',
    resolveLabel: (s) => s.libraryTaxonomySubGuerraDeCorea,
  ),
  LibraryTaxonomyOption(
    slug: 'guerra-de-independencia-americana',
    labelKey: 'libraryTaxonomySubGuerraDeIndependenciaAmericana',
    resolveLabel: (s) => s.libraryTaxonomySubGuerraDeIndependenciaAmericana,
  ),
  LibraryTaxonomyOption(
    slug: 'guerra-de-irak',
    labelKey: 'libraryTaxonomySubGuerraDeIrak',
    resolveLabel: (s) => s.libraryTaxonomySubGuerraDeIrak,
  ),
  LibraryTaxonomyOption(
    slug: 'guerra-de-las-malvinas',
    labelKey: 'libraryTaxonomySubGuerraDeLasMalvinas',
    resolveLabel: (s) => s.libraryTaxonomySubGuerraDeLasMalvinas,
  ),
  LibraryTaxonomyOption(
    slug: 'guerra-de-secesion',
    labelKey: 'libraryTaxonomySubGuerraDeSecesion',
    resolveLabel: (s) => s.libraryTaxonomySubGuerraDeSecesion,
  ),
  LibraryTaxonomyOption(
    slug: 'guerra-de-vietnam',
    labelKey: 'libraryTaxonomySubGuerraDeVietnam',
    resolveLabel: (s) => s.libraryTaxonomySubGuerraDeVietnam,
  ),
  LibraryTaxonomyOption(
    slug: 'guerra-fria',
    labelKey: 'libraryTaxonomySubGuerraFria',
    resolveLabel: (s) => s.libraryTaxonomySubGuerraFria,
  ),
  LibraryTaxonomyOption(
    slug: 'guerras-napoleonicas',
    labelKey: 'libraryTaxonomySubGuerrasNapoleonicas',
    resolveLabel: (s) => s.libraryTaxonomySubGuerrasNapoleonicas,
  ),
  LibraryTaxonomyOption(
    slug: 'halloween',
    labelKey: 'libraryTaxonomySubHalloween',
    resolveLabel: (s) => s.libraryTaxonomySubHalloween,
  ),
  LibraryTaxonomyOption(
    slug: 'hechos-reales',
    labelKey: 'libraryTaxonomySubHechosReales',
    resolveLabel: (s) => s.libraryTaxonomySubHechosReales,
  ),
  LibraryTaxonomyOption(
    slug: 'antologia',
    labelKey: 'libraryTaxonomySubAntologia',
    resolveLabel: (s) => s.libraryTaxonomySubAntologia,
  ),
  LibraryTaxonomyOption(
    slug: 'historico',
    labelKey: 'libraryTaxonomySubHistorico',
    resolveLabel: (s) => s.libraryTaxonomySubHistorico,
  ),
  LibraryTaxonomyOption(
    slug: 'hombres-lobo',
    labelKey: 'libraryTaxonomySubHombresLobo',
    resolveLabel: (s) => s.libraryTaxonomySubHombresLobo,
  ),
  LibraryTaxonomyOption(
    slug: 'home-invasion',
    labelKey: 'libraryTaxonomySubHomeInvasion',
    resolveLabel: (s) => s.libraryTaxonomySubHomeInvasion,
  ),
  LibraryTaxonomyOption(
    slug: 'homosexual',
    labelKey: 'libraryTaxonomySubHomosexual',
    resolveLabel: (s) => s.libraryTaxonomySubHomosexual,
  ),
  LibraryTaxonomyOption(
    slug: 'humor-negro',
    labelKey: 'libraryTaxonomySubHumorNegro',
    resolveLabel: (s) => s.libraryTaxonomySubHumorNegro,
  ),
  LibraryTaxonomyOption(
    slug: 'independiente',
    labelKey: 'libraryTaxonomySubIndependiente',
    resolveLabel: (s) => s.libraryTaxonomySubIndependiente,
  ),
  LibraryTaxonomyOption(
    slug: 'infantil',
    labelKey: 'libraryTaxonomySubInfantil',
    resolveLabel: (s) => s.libraryTaxonomySubInfantil,
  ),
  LibraryTaxonomyOption(
    slug: 'japon-feudal',
    labelKey: 'libraryTaxonomySubJaponFeudal',
    resolveLabel: (s) => s.libraryTaxonomySubJaponFeudal,
  ),
  LibraryTaxonomyOption(
    slug: 'juego',
    labelKey: 'libraryTaxonomySubJuego',
    resolveLabel: (s) => s.libraryTaxonomySubJuego,
  ),
  LibraryTaxonomyOption(
    slug: 'juicios',
    labelKey: 'libraryTaxonomySubJuicios',
    resolveLabel: (s) => s.libraryTaxonomySubJuicios,
  ),
  LibraryTaxonomyOption(
    slug: 'kaiju-eiga',
    labelKey: 'libraryTaxonomySubKaijuEiga',
    resolveLabel: (s) => s.libraryTaxonomySubKaijuEiga,
  ),
  LibraryTaxonomyOption(
    slug: 'krimi',
    labelKey: 'libraryTaxonomySubKrimi',
    resolveLabel: (s) => s.libraryTaxonomySubKrimi,
  ),
  LibraryTaxonomyOption(
    slug: 'locura',
    labelKey: 'libraryTaxonomySubLocura',
    resolveLabel: (s) => s.libraryTaxonomySubLocura,
  ),
  LibraryTaxonomyOption(
    slug: 'mad-doctor',
    labelKey: 'libraryTaxonomySubMadDoctor',
    resolveLabel: (s) => s.libraryTaxonomySubMadDoctor,
  ),
  LibraryTaxonomyOption(
    slug: 'mafia',
    labelKey: 'libraryTaxonomySubMafia',
    resolveLabel: (s) => s.libraryTaxonomySubMafia,
  ),
  LibraryTaxonomyOption(
    slug: 'magia',
    labelKey: 'libraryTaxonomySubMagia',
    resolveLabel: (s) => s.libraryTaxonomySubMagia,
  ),
  LibraryTaxonomyOption(
    slug: 'miniserie',
    labelKey: 'libraryTaxonomySubMiniserie',
    resolveLabel: (s) => s.libraryTaxonomySubMiniserie,
  ),
  LibraryTaxonomyOption(
    slug: 'misterio',
    labelKey: 'libraryTaxonomySubMisterio',
    resolveLabel: (s) => s.libraryTaxonomySubMisterio,
  ),
  LibraryTaxonomyOption(
    slug: 'mitologia',
    labelKey: 'libraryTaxonomySubMitologia',
    resolveLabel: (s) => s.libraryTaxonomySubMitologia,
  ),
  LibraryTaxonomyOption(
    slug: 'mockbuster',
    labelKey: 'libraryTaxonomySubMockbuster',
    resolveLabel: (s) => s.libraryTaxonomySubMockbuster,
  ),
  LibraryTaxonomyOption(
    slug: 'mockumentary',
    labelKey: 'libraryTaxonomySubMockumentary',
    resolveLabel: (s) => s.libraryTaxonomySubMockumentary,
  ),
  LibraryTaxonomyOption(
    slug: 'momias',
    labelKey: 'libraryTaxonomySubMomias',
    resolveLabel: (s) => s.libraryTaxonomySubMomias,
  ),
  LibraryTaxonomyOption(
    slug: 'monstruos',
    labelKey: 'libraryTaxonomySubMonstruos',
    resolveLabel: (s) => s.libraryTaxonomySubMonstruos,
  ),
  LibraryTaxonomyOption(
    slug: 'munecos',
    labelKey: 'libraryTaxonomySubMunecos',
    resolveLabel: (s) => s.libraryTaxonomySubMunecos,
  ),
  LibraryTaxonomyOption(
    slug: 'musica',
    labelKey: 'libraryTaxonomySubMusica',
    resolveLabel: (s) => s.libraryTaxonomySubMusica,
  ),
  LibraryTaxonomyOption(
    slug: 'mutaciones',
    labelKey: 'libraryTaxonomySubMutaciones',
    resolveLabel: (s) => s.libraryTaxonomySubMutaciones,
  ),
  LibraryTaxonomyOption(
    slug: 'plantas-vegetacion',
    labelKey: 'libraryTaxonomySubPlantasVegetacion',
    resolveLabel: (s) => s.libraryTaxonomySubPlantasVegetacion,
  ),
  LibraryTaxonomyOption(
    slug: 'navidad',
    labelKey: 'libraryTaxonomySubNavidad',
    resolveLabel: (s) => s.libraryTaxonomySubNavidad,
  ),
  LibraryTaxonomyOption(
    slug: 'nazismo',
    labelKey: 'libraryTaxonomySubNazismo',
    resolveLabel: (s) => s.libraryTaxonomySubNazismo,
  ),
  LibraryTaxonomyOption(
    slug: 'ninjas',
    labelKey: 'libraryTaxonomySubNinjas',
    resolveLabel: (s) => s.libraryTaxonomySubNinjas,
  ),
  LibraryTaxonomyOption(
    slug: 'ninos',
    labelKey: 'libraryTaxonomySubNinos',
    resolveLabel: (s) => s.libraryTaxonomySubNinos,
  ),
  LibraryTaxonomyOption(
    slug: 'obsesion',
    labelKey: 'libraryTaxonomySubObsesion',
    resolveLabel: (s) => s.libraryTaxonomySubObsesion,
  ),
  LibraryTaxonomyOption(
    slug: 'parodia',
    labelKey: 'libraryTaxonomySubParodia',
    resolveLabel: (s) => s.libraryTaxonomySubParodia,
  ),
  LibraryTaxonomyOption(
    slug: 'payasos',
    labelKey: 'libraryTaxonomySubPayasos',
    resolveLabel: (s) => s.libraryTaxonomySubPayasos,
  ),
  LibraryTaxonomyOption(
    slug: 'peplum',
    labelKey: 'libraryTaxonomySubPeplum',
    resolveLabel: (s) => s.libraryTaxonomySubPeplum,
  ),
  LibraryTaxonomyOption(
    slug: 'pesadillas',
    labelKey: 'libraryTaxonomySubPesadillas',
    resolveLabel: (s) => s.libraryTaxonomySubPesadillas,
  ),
  LibraryTaxonomyOption(
    slug: 'piratas',
    labelKey: 'libraryTaxonomySubPiratas',
    resolveLabel: (s) => s.libraryTaxonomySubPiratas,
  ),
  LibraryTaxonomyOption(
    slug: 'policiaco',
    labelKey: 'libraryTaxonomySubPoliciaco',
    resolveLabel: (s) => s.libraryTaxonomySubPoliciaco,
  ),
  LibraryTaxonomyOption(
    slug: 'politica',
    labelKey: 'libraryTaxonomySubPolitica',
    resolveLabel: (s) => s.libraryTaxonomySubPolitica,
  ),
  LibraryTaxonomyOption(
    slug: 'posesiones-exorcismos',
    labelKey: 'libraryTaxonomySubPosesionesExorcismos',
    resolveLabel: (s) => s.libraryTaxonomySubPosesionesExorcismos,
  ),
  LibraryTaxonomyOption(
    slug: 'posguerra-espanola',
    labelKey: 'libraryTaxonomySubPosguerraEspanola',
    resolveLabel: (s) => s.libraryTaxonomySubPosguerraEspanola,
  ),
  LibraryTaxonomyOption(
    slug: 'post-apocalipsis',
    labelKey: 'libraryTaxonomySubPostApocalipsis',
    resolveLabel: (s) => s.libraryTaxonomySubPostApocalipsis,
  ),
  LibraryTaxonomyOption(
    slug: 'precuela',
    labelKey: 'libraryTaxonomySubPrecuela',
    resolveLabel: (s) => s.libraryTaxonomySubPrecuela,
  ),
  LibraryTaxonomyOption(
    slug: 'prehistoria',
    labelKey: 'libraryTaxonomySubPrehistoria',
    resolveLabel: (s) => s.libraryTaxonomySubPrehistoria,
  ),
  LibraryTaxonomyOption(
    slug: 'prision-carcel',
    labelKey: 'libraryTaxonomySubPrisionCarcel',
    resolveLabel: (s) => s.libraryTaxonomySubPrisionCarcel,
  ),
  LibraryTaxonomyOption(
    slug: 'thriller-psicologico',
    labelKey: 'libraryTaxonomySubThrillerPsicologico',
    resolveLabel: (s) => s.libraryTaxonomySubThrillerPsicologico,
  ),
  LibraryTaxonomyOption(
    slug: 'psicopatia',
    labelKey: 'libraryTaxonomySubPsicopatia',
    resolveLabel: (s) => s.libraryTaxonomySubPsicopatia,
  ),
  LibraryTaxonomyOption(
    slug: 'racismo',
    labelKey: 'libraryTaxonomySubRacismo',
    resolveLabel: (s) => s.libraryTaxonomySubRacismo,
  ),
  LibraryTaxonomyOption(
    slug: 'realidad-paralela-virtual',
    labelKey: 'libraryTaxonomySubRealidadParalelaVirtual',
    resolveLabel: (s) => s.libraryTaxonomySubRealidadParalelaVirtual,
  ),
  LibraryTaxonomyOption(
    slug: 'realismo-magico',
    labelKey: 'libraryTaxonomySubRealismoMagico',
    resolveLabel: (s) => s.libraryTaxonomySubRealismoMagico,
  ),
  LibraryTaxonomyOption(
    slug: 'religion',
    labelKey: 'libraryTaxonomySubReligion',
    resolveLabel: (s) => s.libraryTaxonomySubReligion,
  ),
  LibraryTaxonomyOption(
    slug: 'remake',
    labelKey: 'libraryTaxonomySubRemake',
    resolveLabel: (s) => s.libraryTaxonomySubRemake,
  ),
  LibraryTaxonomyOption(
    slug: 'revolucion-francesa',
    labelKey: 'libraryTaxonomySubRevolucionFrancesa',
    resolveLabel: (s) => s.libraryTaxonomySubRevolucionFrancesa,
  ),
  LibraryTaxonomyOption(
    slug: 'revolucion-mexicana',
    labelKey: 'libraryTaxonomySubRevolucionMexicana',
    resolveLabel: (s) => s.libraryTaxonomySubRevolucionMexicana,
  ),
  LibraryTaxonomyOption(
    slug: 'revolucion-rusa',
    labelKey: 'libraryTaxonomySubRevolucionRusa',
    resolveLabel: (s) => s.libraryTaxonomySubRevolucionRusa,
  ),
  LibraryTaxonomyOption(
    slug: 'road-movie',
    labelKey: 'libraryTaxonomySubRoadMovie',
    resolveLabel: (s) => s.libraryTaxonomySubRoadMovie,
  ),
  LibraryTaxonomyOption(
    slug: 'robos',
    labelKey: 'libraryTaxonomySubRobos',
    resolveLabel: (s) => s.libraryTaxonomySubRobos,
  ),
  LibraryTaxonomyOption(
    slug: 'robots-androides',
    labelKey: 'libraryTaxonomySubRobotsAndroides',
    resolveLabel: (s) => s.libraryTaxonomySubRobotsAndroides,
  ),
  LibraryTaxonomyOption(
    slug: 'samurais',
    labelKey: 'libraryTaxonomySubSamurais',
    resolveLabel: (s) => s.libraryTaxonomySubSamurais,
  ),
  LibraryTaxonomyOption(
    slug: 'satira',
    labelKey: 'libraryTaxonomySubSatira',
    resolveLabel: (s) => s.libraryTaxonomySubSatira,
  ),
  LibraryTaxonomyOption(
    slug: 'sectas',
    labelKey: 'libraryTaxonomySubSectas',
    resolveLabel: (s) => s.libraryTaxonomySubSectas,
  ),
  LibraryTaxonomyOption(
    slug: 'secuela',
    labelKey: 'libraryTaxonomySubSecuela',
    resolveLabel: (s) => s.libraryTaxonomySubSecuela,
  ),
  LibraryTaxonomyOption(
    slug: 'secuela-alternativa',
    labelKey: 'libraryTaxonomySubSecuelaAlternativa',
    resolveLabel: (s) => s.libraryTaxonomySubSecuelaAlternativa,
  ),
  LibraryTaxonomyOption(
    slug: 'secuestros-desapariciones',
    labelKey: 'libraryTaxonomySubSecuestrosDesapariciones',
    resolveLabel: (s) => s.libraryTaxonomySubSecuestrosDesapariciones,
  ),
  LibraryTaxonomyOption(
    slug: 'serie-b',
    labelKey: 'libraryTaxonomySubSerieB',
    resolveLabel: (s) => s.libraryTaxonomySubSerieB,
  ),
  LibraryTaxonomyOption(
    slug: 'serie-z',
    labelKey: 'libraryTaxonomySubSerieZ',
    resolveLabel: (s) => s.libraryTaxonomySubSerieZ,
  ),
  LibraryTaxonomyOption(
    slug: 'sexo',
    labelKey: 'libraryTaxonomySubSexo',
    resolveLabel: (s) => s.libraryTaxonomySubSexo,
  ),
  LibraryTaxonomyOption(
    slug: 'sitcom',
    labelKey: 'libraryTaxonomySubSitcom',
    resolveLabel: (s) => s.libraryTaxonomySubSitcom,
  ),
  LibraryTaxonomyOption(
    slug: 'sketches',
    labelKey: 'libraryTaxonomySubSketches',
    resolveLabel: (s) => s.libraryTaxonomySubSketches,
  ),
  LibraryTaxonomyOption(
    slug: 'slasher',
    labelKey: 'libraryTaxonomySubSlasher',
    resolveLabel: (s) => s.libraryTaxonomySubSlasher,
  ),
  LibraryTaxonomyOption(
    slug: 'snuff',
    labelKey: 'libraryTaxonomySubSnuff',
    resolveLabel: (s) => s.libraryTaxonomySubSnuff,
  ),
  LibraryTaxonomyOption(
    slug: 'sobrenatural',
    labelKey: 'libraryTaxonomySubSobrenatural',
    resolveLabel: (s) => s.libraryTaxonomySubSobrenatural,
  ),
  LibraryTaxonomyOption(
    slug: 'spin-off',
    labelKey: 'libraryTaxonomySubSpinOff',
    resolveLabel: (s) => s.libraryTaxonomySubSpinOff,
  ),
  LibraryTaxonomyOption(
    slug: 'steampunk',
    labelKey: 'libraryTaxonomySubSteampunk',
    resolveLabel: (s) => s.libraryTaxonomySubSteampunk,
  ),
  LibraryTaxonomyOption(
    slug: 'superheroes',
    labelKey: 'libraryTaxonomySubSuperheroes',
    resolveLabel: (s) => s.libraryTaxonomySubSuperheroes,
  ),
  LibraryTaxonomyOption(
    slug: 'surrealismo',
    labelKey: 'libraryTaxonomySubSurrealismo',
    resolveLabel: (s) => s.libraryTaxonomySubSurrealismo,
  ),
  LibraryTaxonomyOption(
    slug: 'survival-supervivencia',
    labelKey: 'libraryTaxonomySubSurvivalSupervivencia',
    resolveLabel: (s) => s.libraryTaxonomySubSurvivalSupervivencia,
  ),
  LibraryTaxonomyOption(
    slug: 'tecnologia-informatica',
    labelKey: 'libraryTaxonomySubTecnologiaInformatica',
    resolveLabel: (s) => s.libraryTaxonomySubTecnologiaInformatica,
  ),
  LibraryTaxonomyOption(
    slug: 'telefilm',
    labelKey: 'libraryTaxonomySubTelefilm',
    resolveLabel: (s) => s.libraryTaxonomySubTelefilm,
  ),
  LibraryTaxonomyOption(
    slug: 'terrorismo',
    labelKey: 'libraryTaxonomySubTerrorismo',
    resolveLabel: (s) => s.libraryTaxonomySubTerrorismo,
  ),
  LibraryTaxonomyOption(
    slug: 'tiburones-asesinos',
    labelKey: 'libraryTaxonomySubTiburonesAsesinos',
    resolveLabel: (s) => s.libraryTaxonomySubTiburonesAsesinos,
  ),
  LibraryTaxonomyOption(
    slug: 'tokusatsu',
    labelKey: 'libraryTaxonomySubTokusatsu',
    resolveLabel: (s) => s.libraryTaxonomySubTokusatsu,
  ),
  LibraryTaxonomyOption(
    slug: 'torturas',
    labelKey: 'libraryTaxonomySubTorturas',
    resolveLabel: (s) => s.libraryTaxonomySubTorturas,
  ),
  LibraryTaxonomyOption(
    slug: 'transexualidad-transgenero',
    labelKey: 'libraryTaxonomySubTransexualidadTransgenero',
    resolveLabel: (s) => s.libraryTaxonomySubTransexualidadTransgenero,
  ),
  LibraryTaxonomyOption(
    slug: 'vampiros',
    labelKey: 'libraryTaxonomySubVampiros',
    resolveLabel: (s) => s.libraryTaxonomySubVampiros,
  ),
  LibraryTaxonomyOption(
    slug: 'venganza',
    labelKey: 'libraryTaxonomySubVenganza',
    resolveLabel: (s) => s.libraryTaxonomySubVenganza,
  ),
  LibraryTaxonomyOption(
    slug: 'viaje-temporal',
    labelKey: 'libraryTaxonomySubViajeTemporal',
    resolveLabel: (s) => s.libraryTaxonomySubViajeTemporal,
  ),
  LibraryTaxonomyOption(
    slug: 'vikingos',
    labelKey: 'libraryTaxonomySubVikingos',
    resolveLabel: (s) => s.libraryTaxonomySubVikingos,
  ),
  LibraryTaxonomyOption(
    slug: 'visiones',
    labelKey: 'libraryTaxonomySubVisiones',
    resolveLabel: (s) => s.libraryTaxonomySubVisiones,
  ),
  LibraryTaxonomyOption(
    slug: 'vudu',
    labelKey: 'libraryTaxonomySubVudu',
    resolveLabel: (s) => s.libraryTaxonomySubVudu,
  ),
  LibraryTaxonomyOption(
    slug: 'wuxia',
    labelKey: 'libraryTaxonomySubWuxia',
    resolveLabel: (s) => s.libraryTaxonomySubWuxia,
  ),
  LibraryTaxonomyOption(
    slug: 'zombies-infectados',
    labelKey: 'libraryTaxonomySubZombiesInfectados',
    resolveLabel: (s) => s.libraryTaxonomySubZombiesInfectados,
  ),
];

String labelForTaxonomySlug(
  S s,
  List<LibraryTaxonomyOption> options,
  String? slug,
) {
  final value = (slug ?? '').trim();
  if (value.isEmpty) return '';
  for (final option in options) {
    if (option.slug == value) return option.label(s);
  }
  return value;
}
