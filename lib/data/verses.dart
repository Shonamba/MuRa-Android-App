class Verse {
  final int id;
  final String kannada;
  final String transliteration;
  final String english;
  final String category;

  const Verse({
    required this.id,
    required this.kannada,
    required this.transliteration,
    required this.english,
    required this.category,
  });
}

const List<Verse> allVerses = [
  Verse(
    id: 1,
    kannada: 'ಬದುಕೆಂಬ ಈ ಹರವು ಎಲ್ಲಿಗೆ ಎಂದು ತಿಳಿಯದು,\nನಡೆದಷ್ಟು ದಾರಿ ಹೊಸತು, ನಿಲ್ಲದೆ ಸಾಗೋ ಮನಸು.',
    transliteration: 'Badukemba ee haravu elli endu tiliyadu,\nNadedashtu daari hosatu, nilllade saago manasu.',
    english: 'Life\'s expanse knows no end or destination,\nEvery step reveals new paths — keep walking, restless soul.',
    category: 'ಜೀವನ (Life)',
  ),
  Verse(
    id: 2,
    kannada: 'ಮೌನದ ಮಡಿಲಲ್ಲಿ ಮಾತು ಮಲಗಿರುವುದು,\nಅರ್ಥವ ಕಾಣಲು ನಿಶಬ್ಧವ ಕೇಳು.',
    transliteration: 'Maunadda madilalli maatu malagiruvudu,\nArthava kaanalu nishabdhava keelu.',
    english: 'Words rest in the lap of silence,\nTo find meaning, listen to the quiet.',
    category: 'ತಾತ್ವಿಕ (Philosophy)',
  ),
  Verse(
    id: 3,
    kannada: 'ಹೂವು ಅರಳಲು ಕಾರಣ ಕೇಳದು,\nಮನಸು ಒಳ್ಳೆಯದಾಗಲು ಕಾರಣ ಬೇಡ.',
    transliteration: 'Hooovu aralalu kaarana keeladu,\nManasu olleyadadagalu kaarana beeda.',
    english: 'A flower blooms without asking why,\nA good heart needs no reason to be kind.',
    category: 'ಮನಸು (Mind)',
  ),
  Verse(
    id: 4,
    kannada: 'ನದಿಯು ತನ್ನ ದಾರಿ ತಾನೇ ಕಂಡುಕೊಳ್ಳುವುದು,\nಮನಸು ಗಟ್ಟಿಯಿದ್ದರೆ ಮಾರ್ಗ ತೆರೆದೇ ತೀರುವುದು.',
    transliteration: 'Nadiyu tanna daari taane kandukolluvudu,\nManasu gattiyiddare maarga terede tiruvudu.',
    english: 'The river finds its own way forward,\nA resolute mind always finds a path.',
    category: 'ಧೈರ್ಯ (Courage)',
  ),
  Verse(
    id: 5,
    kannada: 'ಕ್ಷಣ ಕ್ಷಣವು ಜೀವನದ ಗೀತೆ,\nಹಾಡಿದಷ್ಟು ಸಿಹಿ, ಕೇಳಿದಷ್ಟು ಪ್ರೀತಿ.',
    transliteration: 'Kshana kshanavu jeevanada geethe,\nHaadidashtu sihi, kelidashtu preeti.',
    english: 'Every moment is a verse of life\'s song,\nThe more you sing, the sweeter; the more you listen, the deeper the love.',
    category: 'ಜೀವನ (Life)',
  ),
  Verse(
    id: 6,
    kannada: 'ತಾರೆ ಬೆಳಗಲು ಕತ್ತಲೆ ಬೇಕು,\nಮನಸು ಅರಳಲು ಕಷ್ಟ ಬೇಕು.',
    transliteration: 'Taare begalalu kattale beeku,\nManasu aralalu kashta beeku.',
    english: 'Stars need darkness to shine,\nThe soul needs struggle to bloom.',
    category: 'ಧೈರ್ಯ (Courage)',
  ),
  Verse(
    id: 7,
    kannada: 'ಪ್ರೀತಿ ಇರುವಲ್ಲಿ ಭಯ ಇರದು,\nಭಯ ಇರುವಲ್ಲಿ ಪ್ರೀತಿ ತಲುಪದು.',
    transliteration: 'Preeti iruvalli bhaya iradu,\nBhaya iruvalli preeti talupadu.',
    english: 'Where love dwells, fear cannot stay,\nWhere fear rules, love cannot reach.',
    category: 'ಪ್ರೀತಿ (Love)',
  ),
  Verse(
    id: 8,
    kannada: 'ಮಣ್ಣಿನ ಮಗ ಮರಳಿ ಮಣ್ಣಾಗುವ,\nಆದರೆ ಮಾಡಿದ ಒಳ್ಳೆಯ ಕೆಲಸ ಉಳಿದೇ ಇರುವ.',
    transliteration: 'Mannina maga marali mannaaguva,\nAadare maadida olleya kelasa ulide iruva.',
    english: 'The son of soil shall return to soil,\nBut good deeds done shall forever remain.',
    category: 'ತಾತ್ವಿಕ (Philosophy)',
  ),
  Verse(
    id: 9,
    kannada: 'ಮಾತು ಬೆಳ್ಳಿ, ಮೌನ ಬಂಗಾರ,\nಆದರೆ ಒಳ್ಳೆಯ ಮಾತು ಅಮೃತಕ್ಕಿಂತ ಮಿಗಿಲು.',
    transliteration: 'Maatu belli, mauna bangara,\nAadare olleya maatu amrutakkintha migilu.',
    english: 'Speech is silver, silence is gold,\nBut kind words are worth more than nectar.',
    category: 'ಜ್ಞಾನ (Wisdom)',
  ),
  Verse(
    id: 10,
    kannada: 'ದೀಪ ಇರಲು ಎಣ್ಣೆ ಬೇಕು,\nಮನಸ್ಸಿರಲು ಕರುಣೆ ಬೇಕು.',
    transliteration: 'Deepa iralu enne beeku,\nManassiralu karune beeku.',
    english: 'A lamp needs oil to burn,\nA soul needs compassion to live.',
    category: 'ಮನಸು (Mind)',
  ),
  Verse(
    id: 11,
    kannada: 'ಗಿಡ ನೆಟ್ಟವ ನೆರಳ ತಂದ,\nಒಳ್ಳೆಯದ ಮಾಡಿದವ ಶಾಂತಿ ಕಂಡ.',
    transliteration: 'Gida nettava nerala tanda,\nOlleyada maadidava shaanti kanda.',
    english: 'One who plants a tree gives shade,\nOne who does good finds peace.',
    category: 'ಜ್ಞಾನ (Wisdom)',
  ),
  Verse(
    id: 12,
    kannada: 'ಹಸಿವಿನ ಮುಂದೆ ಹಮ್ಮು ಸಾಲದು,\nದಣಿದ ಮನಕೆ ಪ್ರೀತಿ ಮಾತ್ರ ನೆರವು.',
    transliteration: 'Hasivina munde hammu saaladu,\nDanida manake preeti maatra neravu.',
    english: 'Pride fades before hunger\'s truth,\nOnly love can heal a weary heart.',
    category: 'ಪ್ರೀತಿ (Love)',
  ),
  Verse(
    id: 13,
    kannada: 'ಕಾಲ ನದಿಯಂತೆ ಹರಿಯುತ್ತಲೇ ಇರುವುದು,\nನಿಂತು ನೋಡಿದರೆ ಬದುಕು ಕಳೆದೇ ಹೋಗುವುದು.',
    transliteration: 'Kaala nadiyante hariyuttale iruvudu,\nNintu noodidare baduku kalede hooguvudu.',
    english: 'Time flows like a river, always moving,\nStand still to watch it and life slips away.',
    category: 'ಜೀವನ (Life)',
  ),
  Verse(
    id: 14,
    kannada: 'ತಪ್ಪು ಮಾಡಿದವ ಕಲಿತನು,\nತಪ್ಪ ಒಪ್ಪಿದವ ಬೆಳೆದನು.',
    transliteration: 'Tappu maadidava kalitanu,\nTappa oppidava beledanu.',
    english: 'One who errs has learned,\nOne who admits the error has grown.',
    category: 'ಜ್ಞಾನ (Wisdom)',
  ),
  Verse(
    id: 15,
    kannada: 'ಆಕಾಶಕ್ಕೆ ಎಲ್ಲೆ ಇಲ್ಲ, ಕನಸಿಗೂ ಇಲ್ಲ,\nಮನಸ್ಸು ಮುಕ್ತವಾದರೆ ಮಿತಿ ಇಲ್ಲ.',
    transliteration: 'Aakaashakke elle illa, kanasigoo illa,\nManassu muktavaadarae miti illa.',
    english: 'The sky has no boundary, nor do dreams,\nWhen the mind is free, there are no limits.',
    category: 'ಮನಸು (Mind)',
  ),
  Verse(
    id: 16,
    kannada: 'ಬೇರು ಆಳವಾದಷ್ಟು ಮರ ಎತ್ತರ,\nಮೌಲ್ಯ ಗಟ್ಟಿಯಾದಷ್ಟು ಮನಸು ಉತ್ತರ.',
    transliteration: 'Beeru aalavaadashtu mara ettara,\nMaulya gattiyaadashtu manasu uttara.',
    english: 'The deeper the roots, the taller the tree,\nThe stronger the values, the nobler the soul.',
    category: 'ತಾತ್ವಿಕ (Philosophy)',
  ),
  Verse(
    id: 17,
    kannada: 'ಮಳೆ ಬಂದಾಗ ಮಣ್ಣು ಮೊಳಕೆ ಹೊಡೆಯಿತು,\nಪ್ರೀತಿ ಸಿಕ್ಕಾಗ ಮನಸು ಅರಳಿತು.',
    transliteration: 'Male bandaaga mannu molake hodeyitu,\nPreeti sikkaaga manasu aralitu.',
    english: 'When rain came, the earth sprouted,\nWhen love arrived, the heart bloomed.',
    category: 'ಪ್ರೀತಿ (Love)',
  ),
  Verse(
    id: 18,
    kannada: 'ಜ್ಞಾನ ಇರುವಲ್ಲಿ ಅಹಂಕಾರ ಇರದು,\nಅಹಂಕಾರ ಇರುವಲ್ಲಿ ಜ್ಞಾನ ಮೊಳೆಯದು.',
    transliteration: 'Jnaana iruvalli ahankara iradu,\nAhankara iruvalli jnaana moleyadu.',
    english: 'Where wisdom lives, ego cannot dwell,\nWhere ego reigns, wisdom cannot take root.',
    category: 'ಜ್ಞಾನ (Wisdom)',
  ),
  Verse(
    id: 19,
    kannada: 'ಕ್ಷಮೆ ಕೊಟ್ಟವ ಹಗುರಾದ,\nದ್ವೇಷ ಹಿಡಿದವ ಭಾರವಾದ.',
    transliteration: 'Kshame kottava haguraada,\nDvesha hididava bhaaraavaada.',
    english: 'One who forgave became lighter,\nOne who held hatred became heavier.',
    category: 'ಧೈರ್ಯ (Courage)',
  ),
  Verse(
    id: 20,
    kannada: 'ಸಂಜೆ ಮುಳುಗಿದ ಸೂರ್ಯ ನಾಳೆ ಬರುವ,\nಕಳೆದ ದಿನ ಮರಳದು, ಹೊಸ ಬೆಳಕು ತರುವ.',
    transliteration: 'Sanje muluguida soorya naale baruva,\nKaleda dina maraladu, hosa belaku taruva.',
    english: 'The sun that set this evening shall return tomorrow,\nYesterday cannot come back, but new light always arrives.',
    category: 'ಜೀವನ (Life)',
  ),
];

const List<String> verseCategories = [
  'ಎಲ್ಲಾ (All)',
  'ಜೀವನ (Life)',
  'ತಾತ್ವಿಕ (Philosophy)',
  'ಮನಸು (Mind)',
  'ಧೈರ್ಯ (Courage)',
  'ಪ್ರೀತಿ (Love)',
  'ಜ್ಞಾನ (Wisdom)',
];
