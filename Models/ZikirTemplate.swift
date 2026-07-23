import Foundation

struct ZikirStep: Identifiable, Hashable, Codable {
    var id: UUID = UUID()
    let title: String
    let turkishPronunciation: String?
    let arabicText: String?
    let targetCount: Int
}

enum ZikirCategory: String, CaseIterable, Identifiable {
    case sets = "📿 Namaz Tesbihatı & Setler"
    case daily = "🤲 Günlük Zikirler"
    case salavat = "📜 Özel Salavatlar"
    
    var id: String { self.rawValue }
}

struct ZikirTemplate: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let category: ZikirCategory
    let arabicText: String?
    let turkishPronunciation: String?
    let meaning: String?
    let defaultTarget: Int
    let steps: [ZikirStep]?
    
    init(
        title: String,
        category: ZikirCategory,
        arabicText: String? = nil,
        turkishPronunciation: String? = nil,
        meaning: String? = nil,
        defaultTarget: Int = 1000,
        steps: [ZikirStep]? = nil
    ) {
        self.title = title
        self.category = category
        self.arabicText = arabicText
        self.turkishPronunciation = turkishPronunciation
        self.meaning = meaning
        self.defaultTarget = defaultTarget
        self.steps = steps
    }
    
    // 1. ALLAH'IN 99 İSMİ (EKSİKSİZ TAM 99 ADIM)
    static let esma99Steps: [ZikirStep] = [
        ZikirStep(title: "1/99. Allah", turkishPronunciation: "Allah (c.c)", arabicText: "اللهُ", targetCount: 1),
        ZikirStep(title: "2/99. Er-Rahmân", turkishPronunciation: "Er-Rahmân", arabicText: "الرَّحْمَنُ", targetCount: 1),
        ZikirStep(title: "3/99. Er-Rahîm", turkishPronunciation: "Er-Rahîm", arabicText: "الرَّحِيمُ", targetCount: 1),
        ZikirStep(title: "4/99. El-Melik", turkishPronunciation: "El-Melik", arabicText: "الْمَلِكُ", targetCount: 1),
        ZikirStep(title: "5/99. El-Kuddûs", turkishPronunciation: "El-Kuddûs", arabicText: "الْقُدُّوسُ", targetCount: 1),
        ZikirStep(title: "6/99. Es-Selâm", turkishPronunciation: "Es-Selâm", arabicText: "السَّلاَمُ", targetCount: 1),
        ZikirStep(title: "7/99. El-Mü'min", turkishPronunciation: "El-Mü'min", arabicText: "الْمُؤْمِنُ", targetCount: 1),
        ZikirStep(title: "8/99. El-Müheymin", turkishPronunciation: "El-Müheymin", arabicText: "الْمُهَيْمِنُ", targetCount: 1),
        ZikirStep(title: "9/99. El-Azîz", turkishPronunciation: "El-Azîz", arabicText: "الْعَزِيزُ", targetCount: 1),
        ZikirStep(title: "10/99. El-Cebbâr", turkishPronunciation: "El-Cebbâr", arabicText: "الْجَبَّارُ", targetCount: 1),
        ZikirStep(title: "11/99. El-Mütekebbır", turkishPronunciation: "El-Mütekebbır", arabicText: "الْمُتَكَبِّرُ", targetCount: 1),
        ZikirStep(title: "12/99. El-Hâlık", turkishPronunciation: "El-Hâlık", arabicText: "الْخَالِقُ", targetCount: 1),
        ZikirStep(title: "13/99. El-Bâri'", turkishPronunciation: "El-Bâri'", arabicText: "الْبَارِئُ", targetCount: 1),
        ZikirStep(title: "14/99. El-Musavvir", turkishPronunciation: "El-Musavvir", arabicText: "الْمُصَوِّرُ", targetCount: 1),
        ZikirStep(title: "15/99. El-Gaffâr", turkishPronunciation: "El-Gaffâr", arabicText: "الْغَفَّارُ", targetCount: 1),
        ZikirStep(title: "16/99. El-Kahhâr", turkishPronunciation: "El-Kahhâr", arabicText: "الْقَهَّارُ", targetCount: 1),
        ZikirStep(title: "17/99. El-Vehhâb", turkishPronunciation: "El-Vehhâb", arabicText: "الْوَهَّابُ", targetCount: 1),
        ZikirStep(title: "18/99. Er-Razzâk", turkishPronunciation: "Er-Razzâk", arabicText: "الرَّزَّاقُ", targetCount: 1),
        ZikirStep(title: "19/99. El-Fettâh", turkishPronunciation: "El-Fettâh", arabicText: "الْفَتَّاحُ", targetCount: 1),
        ZikirStep(title: "20/99. El-Alîm", turkishPronunciation: "El-Alîm", arabicText: "الْعَلِيمُ", targetCount: 1),
        ZikirStep(title: "21/99. El-Kâbıd", turkishPronunciation: "El-Kâbıd", arabicText: "الْقَابِضُ", targetCount: 1),
        ZikirStep(title: "22/99. El-Bâsıt", turkishPronunciation: "El-Bâsıt", arabicText: "الْبَاسِطُ", targetCount: 1),
        ZikirStep(title: "23/99. El-Hâfıd", turkishPronunciation: "El-Hâfıd", arabicText: "الْخَا فِضُ", targetCount: 1),
        ZikirStep(title: "24/99. Er-Râfi'", turkishPronunciation: "Er-Râfi'", arabicText: "الرَّافِعُ", targetCount: 1),
        ZikirStep(title: "25/99. El-Mü'ızz", turkishPronunciation: "El-Mü'ızz", arabicText: "الْمُعِزُّ", targetCount: 1),
        ZikirStep(title: "26/99. El-Müzıll", turkishPronunciation: "El-Müzıll", arabicText: "الْمُذِلُّ", targetCount: 1),
        ZikirStep(title: "27/99. Es-Semî'", turkishPronunciation: "Es-Semî'", arabicText: "السَّمِيعُ", targetCount: 1),
        ZikirStep(title: "28/99. El-Basîr", turkishPronunciation: "El-Basîr", arabicText: "الْبَصِيرُ", targetCount: 1),
        ZikirStep(title: "29/99. El-Hakem", turkishPronunciation: "El-Hakem", arabicText: "الْحَكَمُ", targetCount: 1),
        ZikirStep(title: "30/99. El-Adl", turkishPronunciation: "El-Adl", arabicText: "الْعَدْلُ", targetCount: 1),
        ZikirStep(title: "31/99. El-Latîf", turkishPronunciation: "El-Latîf", arabicText: "اللَّطِيفُ", targetCount: 1),
        ZikirStep(title: "32/99. El-Habîr", turkishPronunciation: "El-Habîr", arabicText: "الْخَبِيرُ", targetCount: 1),
        ZikirStep(title: "33/99. El-Halîm", turkishPronunciation: "El-Halîm", arabicText: "الْحَلِيمُ", targetCount: 1),
        ZikirStep(title: "34/99. El-Azîm", turkishPronunciation: "El-Azîm", arabicText: "الْعَظِيمُ", targetCount: 1),
        ZikirStep(title: "35/99. El-Gafûr", turkishPronunciation: "El-Gafûr", arabicText: "الْغَفُورُ", targetCount: 1),
        ZikirStep(title: "36/99. Eş-Şekûr", turkishPronunciation: "Eş-Şekûr", arabicText: "الشَّكُورُ", targetCount: 1),
        ZikirStep(title: "37/99. El-Aliyy", turkishPronunciation: "El-Aliyy", arabicText: "الْعَلِيُّ", targetCount: 1),
        ZikirStep(title: "38/99. El-Kebîr", turkishPronunciation: "El-Kebîr", arabicText: "الْكَبِيرُ", targetCount: 1),
        ZikirStep(title: "39/99. El-Hafîz", turkishPronunciation: "El-Hafîz", arabicText: "الْحَفِيظُ", targetCount: 1),
        ZikirStep(title: "40/99. El-Mukît", turkishPronunciation: "El-Mukît", arabicText: "الْمُقِيتُ", targetCount: 1),
        ZikirStep(title: "41/99. El-Hasîb", turkishPronunciation: "El-Hasîb", arabicText: "الْحَسِيبُ", targetCount: 1),
        ZikirStep(title: "42/99. El-Celîl", turkishPronunciation: "El-Celîl", arabicText: "الْجَلِيلُ", targetCount: 1),
        ZikirStep(title: "43/99. El-Kerîm", turkishPronunciation: "El-Kerîm", arabicText: "الْكَرِيمُ", targetCount: 1),
        ZikirStep(title: "44/99. Er-Rakîb", turkishPronunciation: "Er-Rakîb", arabicText: "الرَّقِيبُ", targetCount: 1),
        ZikirStep(title: "45/99. El-Mucîb", turkishPronunciation: "El-Mucîb", arabicText: "الْمُجِيبُ", targetCount: 1),
        ZikirStep(title: "46/99. El-Vâsi'", turkishPronunciation: "El-Vâsi'", arabicText: "الْوَاسِعُ", targetCount: 1),
        ZikirStep(title: "47/99. El-Hakîm", turkishPronunciation: "El-Hakîm", arabicText: "الْحَكِيمُ", targetCount: 1),
        ZikirStep(title: "48/99. El-Vedûd", turkishPronunciation: "El-Vedûd", arabicText: "الْوَدُودُ", targetCount: 1),
        ZikirStep(title: "49/99. El-Mecîd", turkishPronunciation: "El-Mecîd", arabicText: "الْمَجِيدُ", targetCount: 1),
        ZikirStep(title: "50/99. El-Bâ'ıs", turkishPronunciation: "El-Bâ'ıs", arabicText: "الْبَاعِثُ", targetCount: 1),
        ZikirStep(title: "51/99. Eş-Şehîd", turkishPronunciation: "Eş-Şehîd", arabicText: "الشَّهِيدُ", targetCount: 1),
        ZikirStep(title: "52/99. El-Hakk", turkishPronunciation: "El-Hakk", arabicText: "الْحَقُّ", targetCount: 1),
        ZikirStep(title: "53/99. El-Vekîl", turkishPronunciation: "El-Vekîl", arabicText: "الْوَكِيلُ", targetCount: 1),
        ZikirStep(title: "54/99. El-Kaviyy", turkishPronunciation: "El-Kaviyy", arabicText: "الْقَوِيُّ", targetCount: 1),
        ZikirStep(title: "55/99. El-Metîn", turkishPronunciation: "El-Metîn", arabicText: "الْمَتِينُ", targetCount: 1),
        ZikirStep(title: "56/99. El-Veliyy", turkishPronunciation: "El-Veliyy", arabicText: "الْوَلِيُّ", targetCount: 1),
        ZikirStep(title: "57/99. El-Hamîd", turkishPronunciation: "El-Hamîd", arabicText: "الْحَمِيدُ", targetCount: 1),
        ZikirStep(title: "58/99. El-Muhsî", turkishPronunciation: "El-Muhsî", arabicText: "الْمُحْصِي", targetCount: 1),
        ZikirStep(title: "59/99. El-Mubdi'", turkishPronunciation: "El-Mubdi'", arabicText: "الْمُبْدِئُ", targetCount: 1),
        ZikirStep(title: "60/99. El-Mu'îd", turkishPronunciation: "El-Mu'îd", arabicText: "الْمُعِيدُ", targetCount: 1),
        ZikirStep(title: "61/99. El-Muhyî", turkishPronunciation: "El-Muhyî", arabicText: "الْمُحْيِي", targetCount: 1),
        ZikirStep(title: "62/99. El-Mümît", turkishPronunciation: "El-Mümît", arabicText: "الْمُمِيتُ", targetCount: 1),
        ZikirStep(title: "63/99. El-Hayy", turkishPronunciation: "El-Hayy", arabicText: "الْحَيُّ", targetCount: 1),
        ZikirStep(title: "64/99. El-Kayyûm", turkishPronunciation: "El-Kayyûm", arabicText: "الْقَيُّومُ", targetCount: 1),
        ZikirStep(title: "65/99. El-Vâcid", turkishPronunciation: "El-Vâcid", arabicText: "الْوَاجِدُ", targetCount: 1),
        ZikirStep(title: "66/99. El-Mâcid", turkishPronunciation: "El-Mâcid", arabicText: "الْمَاجِدُ", targetCount: 1),
        ZikirStep(title: "67/99. El-Vâhid", turkishPronunciation: "El-Vâhid", arabicText: "الْوَاحِدُ", targetCount: 1),
        ZikirStep(title: "68/99. Es-Samed", turkishPronunciation: "Es-Samed", arabicText: "الصَّمَدُ", targetCount: 1),
        ZikirStep(title: "69/99. El-Kâdir", turkishPronunciation: "El-Kâdir", arabicText: "الْقَادِرُ", targetCount: 1),
        ZikirStep(title: "70/99. El-Muktedir", turkishPronunciation: "El-Muktedir", arabicText: "الْمُقْتَدِرُ", targetCount: 1),
        ZikirStep(title: "71/99. El-Mukaddim", turkishPronunciation: "El-Mukaddim", arabicText: "الْمُقَدِّمُ", targetCount: 1),
        ZikirStep(title: "72/99. El-Muahhir", turkishPronunciation: "El-Muahhir", arabicText: "الْمُؤَخِّرُ", targetCount: 1),
        ZikirStep(title: "73/99. El-Evvel", turkishPronunciation: "El-Evvel", arabicText: "الأَوَّلُ", targetCount: 1),
        ZikirStep(title: "74/99. El-Âhir", turkishPronunciation: "El-Âhir", arabicText: "الآخِرُ", targetCount: 1),
        ZikirStep(title: "75/99. Ez-Zâhir", turkishPronunciation: "Ez-Zâhir", arabicText: "الظَّاهِرُ", targetCount: 1),
        ZikirStep(title: "76/99. El-Bâtın", turkishPronunciation: "El-Bâtın", arabicText: "الْبَاطِنُ", targetCount: 1),
        ZikirStep(title: "77/99. El-Vâlî", turkishPronunciation: "El-Vâlî", arabicText: "الْوَالِي", targetCount: 1),
        ZikirStep(title: "78/99. El-Müteâlî", turkishPronunciation: "El-Müteâlî", arabicText: "الْمُتَعَالِي", targetCount: 1),
        ZikirStep(title: "79/99. El-Berr", turkishPronunciation: "El-Berr", arabicText: "الْبَرُّ", targetCount: 1),
        ZikirStep(title: "80/99. Et-Tevvâb", turkishPronunciation: "Et-Tevvâb", arabicText: "التَّوَّابُ", targetCount: 1),
        ZikirStep(title: "81/99. El-Müntakım", turkishPronunciation: "El-Müntakım", arabicText: "الْمُنْتَقِمُ", targetCount: 1),
        ZikirStep(title: "82/99. El-Afüvv", turkishPronunciation: "El-Afüvv", arabicText: "الْعَفُوُّ", targetCount: 1),
        ZikirStep(title: "83/99. Er-Raûf", turkishPronunciation: "Er-Raûf", arabicText: "الرَّؤُوفُ", targetCount: 1),
        ZikirStep(title: "84/99. Mâlikü'l-Mülk", turkishPronunciation: "Mâlikü'l-Mülk", arabicText: "مَالِكُ الْمُلْكِ", targetCount: 1),
        ZikirStep(title: "85/99. Zü'l-Celâli ve'l-İkrâm", turkishPronunciation: "Zü'l-Celâli ve'l-İkrâm", arabicText: "ذُو الْجَلاَلِ وَالإِكْرَامِ", targetCount: 1),
        ZikirStep(title: "86/99. El-Muksıt", turkishPronunciation: "El-Muksıt", arabicText: "الْمُقْسِطُ", targetCount: 1),
        ZikirStep(title: "87/99. El-Câmi'", turkishPronunciation: "El-Câmi'", arabicText: "الْجَامِعُ", targetCount: 1),
        ZikirStep(title: "88/99. El-Ganiyy", turkishPronunciation: "El-Ganiyy", arabicText: "الْغَنِيُّ", targetCount: 1),
        ZikirStep(title: "89/99. El-Mugnî", turkishPronunciation: "El-Mugnî", arabicText: "الْمُغْنِي", targetCount: 1),
        ZikirStep(title: "90/99. El-Mâni'", turkishPronunciation: "El-Mâni'", arabicText: "الْمَانِعُ", targetCount: 1),
        ZikirStep(title: "91/99. Ed-Dârr", turkishPronunciation: "Ed-Dârr", arabicText: "الضَّارُّ", targetCount: 1),
        ZikirStep(title: "92/99. En-Nâfi'", turkishPronunciation: "En-Nâfi'", arabicText: "النَّافِعُ", targetCount: 1),
        ZikirStep(title: "93/99. En-Nûr", turkishPronunciation: "En-Nûr", arabicText: "النُّورُ", targetCount: 1),
        ZikirStep(title: "94/99. El-Hâdî", turkishPronunciation: "El-Hâdî", arabicText: "الْهَادِي", targetCount: 1),
        ZikirStep(title: "95/99. El-Bedî'", turkishPronunciation: "El-Bedî'", arabicText: "الْبَدِيعُ", targetCount: 1),
        ZikirStep(title: "96/99. El-Bâkî", turkishPronunciation: "El-Bâkî", arabicText: "الْبَاقِي", targetCount: 1),
        ZikirStep(title: "97/99. El-Vâris", turkishPronunciation: "El-Vâris", arabicText: "الْوَارِثُ", targetCount: 1),
        ZikirStep(title: "98/99. Er-Reşîd", turkishPronunciation: "Er-Reşîd", arabicText: "الرَّشِيدُ", targetCount: 1),
        ZikirStep(title: "99/99. Es-Sabûr", turkishPronunciation: "Es-Sabûr", arabicText: "الصَّبُورُ", targetCount: 1)
    ]
    
    // 2. UZUN TESBİHAT DUASI (EKSİKSİZ TAM 38 ADIM)
    static let uzunTesbihatSteps: [ZikirStep] = [
        ZikirStep(title: "1/38. yâ Allâh - yâ Rahmân", turkishPronunciation: "Subhaneke ya Allâh tealeyte yâ Rahman ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا اَللّٰهُ تَعَالَيْتَ يَا رَحْمٰنُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "2/38. yâ Rahîm - yâ Kerîm", turkishPronunciation: "Subhaneke ya Râhiym tealeyte yâ Kerim ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا رَحِيمُ تَعَالَيْتَ يَا كَرِيمُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "3/38. yâ Hâmid - yâ Hâkim", turkishPronunciation: "Subhaneke ya Hâmid tealeyte yâ Hâkim ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا حَمِيدُ تَعَالَيْتَ يَا حَكِيمُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "4/38. yâ Mecîd - yâ Melik", turkishPronunciation: "Subhaneke ya Mecid tealeyte yâ Melik ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا مَجِيدُ تَعَالَيْتَ يَا مَلِكُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "5/38. yâ Kuddûs - yâ Selâm", turkishPronunciation: "Subhaneke ya Kuddüs tealeyte yâ Selâm ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا قُدُّوسُ تَعَالَيْتَ يَا سَلاَمُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "6/38. yâ Mü’min - yâ Müheymin", turkishPronunciation: "Subhaneke ya Mü’min tealeyte yâ Müheymin ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا مُؤْمِنُ تَعَالَيْتَ يَا مُهَيْمِنُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "7/38. yâ Âziz - yâ Cebbâr", turkishPronunciation: "Subhaneke ya Âziz tealeyte yâ Cebbâr ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا عَزِيزُ تَعَالَيْتَ يَا جَبَّارُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "8/38. yâ Mütekebbir - yâ Hâlık", turkishPronunciation: "Subhaneke ya Mütekebbir tealeyte yâ Hâlık ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا مُتَكَبِّرُ تَعَالَيْتَ يَا خَالِقُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "9/38. yâ Evvel - yâ Âhir", turkishPronunciation: "Subhaneke ya Evvel tealeyte yâ Âhir ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا اَوَّلُ تَعَالَيْتَ يَا اخِرُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "10/38. yâ Zâhir - yâ Bâtın", turkishPronunciation: "Subhaneke ya zâhir tealeyte yâ Bâtın ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا ظَاهِرُ تَعَالَيْتَ يَا بَاطِنُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "11/38. yâ Bâri - yâ Musâvvir", turkishPronunciation: "Subhaneke ya Bâri tealeyte yâ Musâvvir ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا بَارِئُ تَعَالَيْتَ يَا مُصَوِّرُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "12/38. yâ Tevvâb - yâ Vehhâb", turkishPronunciation: "Subhaneke ya Tevvâb tealeyte yâ Vehhâb ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا تَوَّابُ تَعَالَيْتَ يَا وَهَّابُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "13/38. yâ Bâis - yâ Vâris", turkishPronunciation: "Subhaneke ya Bâis tealeyte yâ Vâris ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا بَاعِثُ تَعَالَيْتَ يَا وَارِثُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "14/38. yâ Kâdim - yâ Mukim", turkishPronunciation: "Subhaneke ya Kâdim tealeyte yâ Mukim ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا قَادِمُ تَعَالَيْتَ يَا مُقِيمُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "15/38. yâ Ferd - yâ Vitr", turkishPronunciation: "Subhaneke ya Ferd tealeyte yâ Vitr ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا فَرْدُ تَعَالَيْتَ يَا وِتْرُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "16/38. yâ Nur - yâ Settâr", turkishPronunciation: "Subhaneke ya Nur tealeyte yâ Settâr ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا نُورُ تَعَالَيْتَ يَا سَتَّارُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "17/38. yâ Celil - yâ Cemil", turkishPronunciation: "Subhaneke ya Celil tealeyte yâ Cemil ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا جَلِيلُ تَعَالَيْتَ يَا جَمِيلُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "18/38. yâ Kâhir - yâ Kâdir", turkishPronunciation: "Subhaneke ya Kâhir tealeyte yâ Kâdir ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا قَاهِرُ تَعَالَيْتَ يَا قَادِرُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "19/38. yâ Melik - yâ Muktedir", turkishPronunciation: "Subhaneke ya Melik tealeyte yâ Muktedir ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا مَلِكُ تَعَالَيْتَ يَا مُقْتَدِرُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "20/38. yâ Alim - yâ Âllâm", turkishPronunciation: "Subhaneke ya Alim tealeyte yâ Âllâm ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا عَلِيمُ تَعَالَيْتَ يَا عَلاَّمُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "21/38. yâ Aziym - yâ Gâfur", turkishPronunciation: "Subhaneke ya Aziym tealeyte yâ Gâfur ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا عَظِيمُ تَعَالَيْتَ يَا غَفُورُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "22/38. yâ Hâlim - yâ Vedud", turkishPronunciation: "Subhaneke ya Hâlim tealeyte yâ Vedud ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا حَلِيمُ تَعَالَيْتَ يَا وَدُودُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "23/38. yâ Şehid - yâ Şâhid", turkishPronunciation: "Subhaneke ya Şehid tealeyte yâ Şâhid ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا شَهِيدُ تَعَالَيْتَ يَا شَاهِدُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "24/38. yâ Kebir - yâ Müteâl", turkishPronunciation: "Subhaneke ya Kebir tealeyte yâ Müteâl ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا كَبِيرُ تَعَالَيْتَ يَا مُتَعَالُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "25/38. yâ Nur - yâ Lâtif", turkishPronunciation: "Subhaneke ya Nur tealeyte yâ Lâtif ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا نُورُ تَعَالَيْتَ يَا لَطِيفُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "26/38. yâ Semi' - yâ Kefil", turkishPronunciation: "Subhaneke ya Semi' tealeyte yâ Kefil ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا سَمِيعُ تَعَالَيْتَ يَا كَفِيلُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "27/38. yâ Kârib - yâ Bâsiyr", turkishPronunciation: "Subhaneke ya Kârib tealeyte yâ Bâsiyr ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا قَرِيبُ تَعَالَيْتَ يَا بَصِيرُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "28/38. yâ Hâkk - yâ Mübin", turkishPronunciation: "Subhaneke ya Hâkk tealeyte yâ Mübin ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا حَقُّ تَعَالَيْتَ يَا مُبِينُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "29/38. yâ Râuf - yâ Râhiym", turkishPronunciation: "Subhaneke ya Râuf tealeyte yâ Râhiym ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا رَؤُوفُ تَعَالَيْتَ يَا رَحِيمُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "30/38. yâ Tâhir - yâ Müteâhhir", turkishPronunciation: "Subhaneke ya Tâhir tealeyte yâ Müteâhhir ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا طَاهِرُ تَعَالَيْتَ يَا مُطَهِّرُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "31/38. yâ Mücemmil - yâ Mufâddil", turkishPronunciation: "Subhaneke ya Mücemmil tealeyte yâ Mufâddil ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا مُجَمِّلُ تَعَالَيْتَ يَا مُفَضِّلُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "32/38. yâ Müzhır - yâ Mün’im", turkishPronunciation: "Subhaneke ya Müzhır tealeyte yâ Mün’im ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا مُظْهِرُ تَعَالَيْتَ يَا مُنْعِمُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "33/38. yâ Deyyân - yâ Sultân", turkishPronunciation: "Subhaneke ya Deyyân tealeyte yâ Sultân ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا دَيَّانُ تَعَالَيْتَ يَا سُلْطَانُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "34/38. yâ Hânnân - yâ Mennân", turkishPronunciation: "Subhaneke ya Hânnân tealeyte yâ Mennân ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا حَنَّانُ تَعَالَيْتَ يَا مَنَّانُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "35/38. yâ Ehâd - yâ Sâmed", turkishPronunciation: "Subhaneke ya Ehâd tealeyte yâ Sâmed ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا اَحَدُ تَعَالَيْتَ يَا صَمَدُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "36/38. yâ Hâyy - yâ Kâyyum", turkishPronunciation: "Subhaneke ya Hâyy tealeyte yâ Kâyyum ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا حَيُّ تَعَالَيْتَ يَا قَيُّومُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "37/38. yâ Adl - yâ Hâkem", turkishPronunciation: "Subhaneke ya Adl tealeyte yâ Hâkem ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا عَدْلُ تَعَالَيْتَ يَا حَكَمُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1),
        ZikirStep(title: "38/38. yâ Ferd - yâ Kuddûs", turkishPronunciation: "Subhaneke ya Ferd tealeyte yâ Kuddûs ecirnâ mine'n-nâr bi afvike yâ Rahmân", arabicText: "سُبْحَانَكَ يَا فَرْدُ تَعَالَيْتَ يَا قُدُّوسُ اَجِرْنَا مِنَ النَّارِ بِعَفْوِكَ يَا رَحْمٰنُ", targetCount: 1)
    ]
    
    static let presetTemplates: [ZikirTemplate] = [
        // 1. SETLER (Namaz Tesbihatı, Esma-ül Hüsna 99 & Uzun Tesbihat Setleri)
        ZikirTemplate(
            title: "Namaz Sonrası Tesbihatı Seti",
            category: .sets,
            arabicText: "سُبْحَانَ اللّٰهِ • اَلْحَمْدُ لِلّٰهِ • اَللّٰهُ اَكْبَرُ",
            turkishPronunciation: "33 Sübhanallah • 33 Elhamdülillah • 33 Allahu Ekber • 1 Tevhid Duası",
            meaning: "Namaz sonrasında 33'er defa yapılan sünnet tesbihat seti.",
            defaultTarget: 100,
            steps: [
                ZikirStep(title: "Sübhanallah (1/4)", turkishPronunciation: "Sübhânallâh", arabicText: "سُبْحَانَ اللّٰهِ", targetCount: 33),
                ZikirStep(title: "Elhamdülillah (2/4)", turkishPronunciation: "Elhamdulillâh", arabicText: "اَلْحَمْدُ لِلّٰهِ", targetCount: 33),
                ZikirStep(title: "Allahu Ekber (3/4)", turkishPronunciation: "Allâhu Ekber", arabicText: "اَللّٰهُ اَكْبَرُ", targetCount: 33),
                ZikirStep(title: "Tevhid Duası (4/4)", turkishPronunciation: "Lâ ilâhe illallâhu vahdehû lâ şerîke leh, lehül-mülkü ve lehül-hamdü ve hüve 'alâ külli şey'in kadîr.", arabicText: "لاَ إِلَهَ إِلاَّ اللهُ وَحْدَهُ لاَ شَرِيكَ لَهُ لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ", targetCount: 1)
            ]
        ),
        
        ZikirTemplate(
            title: "Uzun Tesbihat Seti",
            category: .sets,
            arabicText: "سُبْحَانَكَ يَا اَللّٰهُ تَعَالَيْتَ يَا رَحْمٰنُ...",
            turkishPronunciation: "38 Adımlı Namaz Tesbihatı Yakarış Duası (Subhaneke ya Allâh tealeyte...)",
            meaning: "Namaz sonrasında okunan 38 adımlı mübarek İsm-i Âzam ve uzun tesbihat seti.",
            defaultTarget: 38,
            steps: uzunTesbihatSteps
        ),
        
        ZikirTemplate(
            title: "Esma-ül Hüsna (99 İsmi) Seti",
            category: .sets,
            arabicText: "اَلأَسْمَاءُ الْحُسْنَى (99)",
            turkishPronunciation: "Allah'ın 99 Güzel İsmi Sırasıyla (1'er Tekrar)",
            meaning: "Allah'ın 99 mübarek isminin tamamını sırasıyla zikretme seti.",
            defaultTarget: 99,
            steps: esma99Steps
        ),
        
        // 2. GÜNLÜK ZİKİRLER
        ZikirTemplate(
            title: "Kelime-i Tevhid",
            category: .daily,
            arabicText: "لاَ إِلَهَ إِلاَّ اللهُ",
            turkishPronunciation: "Lâ ilâhe illallâh",
            meaning: "Allah'tan başka ilah yoktur.",
            defaultTarget: 1000
        ),
        ZikirTemplate(
            title: "İstiğfar-ı Şerif",
            category: .daily,
            arabicText: "أَسْتَغْفِرُ اللّٰهَ الْعَظِيمَ وَأَتُوبُ إِلَيْهِ",
            turkishPronunciation: "Estağfirullâhal-'azîm ve etûbu ileyh",
            meaning: "Büyük Allah'tan bağışlanma diler, O'na tövbe ederim.",
            defaultTarget: 1000
        ),
        ZikirTemplate(
            title: "Sübhanallahi ve Bihamdihi",
            category: .daily,
            arabicText: "سُبْحَانَ اللّٰهِ وَبِحَمْدِهِ سُبْحَانَ اللّٰهِ الْعَظِيمِ",
            turkishPronunciation: "Sübhanallahi ve bihamdihi, Sübhanallahil azim",
            meaning: "Allah'ı hamd ile tesbih ederim, Yüce Allah noksanlıklardan münezzehtir.",
            defaultTarget: 1000
        ),
        ZikirTemplate(
            title: "Lâ Havle (Havkele)",
            category: .daily,
            arabicText: "لاَ حَوْلَ وَلاَ قُوَّةَ إِلاَّ بِاللّٰهِ الْعَلِيِّ الْعَظِيمِ",
            turkishPronunciation: "Lâ havle ve lâ kuvvete illâ billâhil-'aliyyil-'azîm",
            meaning: "Güç ve kuvvet ancak Yüce ve Azim olan Allah'ın yardımıyladır.",
            defaultTarget: 1000
        ),
        ZikirTemplate(
            title: "Hasbunallah",
            category: .daily,
            arabicText: "حَسْبُنَا اللّٰهُ وَنِعْمَ الْوَكِيلُ",
            turkishPronunciation: "Hasbunallâhu ve ni'mel vekîl",
            meaning: "Allah bize yeter, O ne güzel vekildir.",
            defaultTarget: 1000
        ),
        
        // 3. ÖZEL SALAVATLAR
        ZikirTemplate(
            title: "Salavat-ı Şerife",
            category: .salavat,
            arabicText: "اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ",
            turkishPronunciation: "Allâhumme salli 'alâ Muhammedin ve 'alâ âli Muhammed",
            meaning: "Allah'ım Hz. Muhammed'e ve ailesine salat eyle.",
            defaultTarget: 1000
        ),
        ZikirTemplate(
            title: "Salavat-ı Tefriciye",
            category: .salavat,
            arabicText: "اللَّهُمَّ صَلِّ صَلاَةً كَامِلَةً وَسَلِّمْ سَلاَمًا تَامًّا عَلَى سَيِّدِنَا مُحَمَّدٍ الَّذِي تَنْحَلُّ بِهِ الْعُقَدُ وَتَنْفَرِجُ بِهِ الْكُرَبُ وَتُقْضَى بِهِ الْحَوَائِجُ وَتُنَالُ بِهِ الرَّغَائِبُ وَحُسْنُ الْخَوَاتِمِ وَيُسْتَسْقَى الْغَمَامُ بِوَجْهِهِ الْكَرِيمِ وَعَلَى آلِهِ وَصَحْبِهِ فِي كُلِّ لَمْحَةٍ وَنَفَسٍ بِعَدَدِ كُلِّ مَعْلُومٍ لَكَ",
            turkishPronunciation: "Allâhumme salli salâten kâmileten ve sellim selâmen tâmmân 'alâ seyyidinâ Muhammedinillezî tenhallü bihil-'ukad ve tenfericu bihil-kürab ve tukdâ bihil-havâicu ve tunâlu bihir-reğâibu ve husnul-havâtimi ve yusteskāl-ğamâmu bi-vechihil-kerîm ve 'alâ âlihî ve sahbihî fî külli lemhatin ve nefesin bi-'adedi külli ma'lûmin lek.",
            meaning: "Dilek ve hacetlerin kabulü için okunan 4.444 duası.",
            defaultTarget: 4444
        ),
        ZikirTemplate(
            title: "Salaten Tuncina (Salat-ı Münciye)",
            category: .salavat,
            arabicText: "اَللَّهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ وَعَلَى آلِ سَيِّدِنَا مُحَمَّدٍ صَلَاةً تُنْجِينَا بِهَا مِنْ جَمِيعِ الْأَهْوَالِ وَالْآفَاتِ وَتَقْضِي لَنَا بِهَا جَمِيعَ الْحَاجَاتِ وَتُطَهِّرُنَا بِهَا مِنْ جَمِيعِ السَّيئَاتِ وَتَرْفَعُنَا بِهَا عِنْدَكَ أَعْلَى الدَّرَجَاتِ وَتُبَلِّغُنَا بِهَا أَقْصَى الْغَايَاتِ مِنْ جَمِيعِ الْخَيْرَاتِ فِي الْحَيَاةِ وَبَعْدَ الْمَمَاتِ",
            turkishPronunciation: "Allâhumme salli 'alâ seyyidinâ Muhammedin ve 'alâ âli seyyidinâ Muhammed. Salâten tuncînâ bihâ min cemî'ıl-ehvâli vel-âfât, ve takzî lenâ bihâ cemî'al-hâcât, ve tutahhirunâ bihâ min cemî'ıs-seyyiât, ve terfe'unâ bihâ 'ındeke a'led-derecât, ve tubelliğunâ bihâ aksal-ğâyât min cemî'ıl-hayrâti fil-hayâti ve ba'del-memât.",
            meaning: "Her türlü kaza ve beladan korunma salavatı.",
            defaultTarget: 1000
        ),
        ZikirTemplate(
            title: "Salavat-ı Fatih",
            category: .salavat,
            arabicText: "اللَّهُمَّ صَلِّ وَسَلِّمْ وَبَارِكْ عَلَى سَيِّدِنَا مُحَمَّدٍ الْفَاتِحِ لِمَا أُغْلِقَ وَالْخَاتِمِ لِمَا سَبَقَ نَاصِرِ الْحَقِّ بِالْحَقِّ وَالْهَادِي إِلَى صِرَاطِكَ الْمُسْتَقِيمِ وَعَلَى آلِهِ وَأَصْحَابِهِ حَقَّ قَدْرِهِ وَمِقْدَارِهِ الْعَظِيمِ",
            turkishPronunciation: "Allâhumme salli ve sellim ve bârik 'alâ seyyidinâ Muhammedinil-fâtihı limâ uğlika vel-hâtimi limâ sebeka nâsıril-hakkı bil-hakkı vel-hâdî ilâ sırâtıkel-mustekîm ve 'alâ âlihî ve ashâbihî hakka kadrihî ve mikdârihil-'azîm.",
            meaning: "Kilitli kapıları açan mübarek salavat.",
            defaultTarget: 1000
        )
    ]
}
