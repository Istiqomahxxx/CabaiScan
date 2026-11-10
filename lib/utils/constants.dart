class AppConstants {
  static const int inputImageSize = 224;

  static const String daunModelPath = 'assets/models/cnn_daun_v1.tflite';
  static const String daunLabelsPath = 'assets/models/labels_daun.json';
  static const String buahModelPath = 'assets/models/cnn_buah_v1.tflite';
  static const String buahLabelsPath = 'assets/models/labels_buah.json';

  static const Map<String, String> descriptions = {
    'sehat':
        'Tanaman dalam kondisi baik. Daun tampak hijau segar dan buah berkembang normal tanpa tanda infeksi jamur, bakteri, maupun virus.',
    'antraknosa':
        'Terdeteksi antraknosa (patek), ditandai bercak cekung berwarna coklat kehitaman pada permukaan buah. Penyakit ini disebabkan jamur Colletotrichum sp. dan berkembang cepat saat kelembapan tinggi.',
    'busuk_buah':
        'Buah menunjukkan gejala pembusukan akibat infeksi jamur atau bakteri yang umumnya dipicu kelembapan berlebih dan sirkulasi udara yang buruk di sekitar tanaman.',
    'bercak_daun':
        'Daun menunjukkan bercak-bercak khas akibat infeksi jamur. Jika dibiarkan, bercak dapat meluas dan mempercepat kerontokan daun sehingga mengganggu proses fotosintesis.',
    'virus_kuning':
        'Daun mengalami klorosis (menguning) akibat infeksi virus Gemini yang ditularkan oleh vektor kutu kebul (Bemisia tabaci). Penyebarannya bisa cepat antar tanaman.',
  };

  static const Map<String, String> suggestions = {
    'sehat':
        'Pertahankan pola perawatan saat ini penyiraman teratur, pemupukan berimbang, dan pemantauan berkala untuk mencegah serangan dini.',
    'antraknosa':
        'Segera petik dan musnahkan buah yang terinfeksi, hindari penyiraman langsung ke bagian atas tanaman, serta aplikasikan fungisida berbahan aktif sesuai dosis anjuran.',
    'busuk_buah':
        'Panen segera buah yang terinfeksi agar tidak menular, pangkas daun/cabang yang menghalangi sirkulasi udara, dan kurangi kelembapan berlebih di sekitar area tanam.',
    'bercak_daun':
        'Buang dan musnahkan daun yang terinfeksi, atur jarak tanam agar sirkulasi udara lebih baik, serta semprotkan fungisida secara berkala sesuai anjuran.',
    'virus_kuning':
        'Kendalikan populasi kutu kebul dengan insektisida atau perangkap kuning, cabut dan musnahkan tanaman yang sudah parah agar tidak menjadi sumber penularan.',
  };

  static const Map<String, String> penyebab = {
    'sehat': 'Tidak ada patogen terdeteksi.',
    'antraknosa': 'Jamur Colletotrichum sp.',
    'busuk_buah': 'Jamur Phytophthora sp. atau bakteri Erwinia sp.',
    'bercak_daun': 'Jamur Cercospora capsici.',
    'virus_kuning':
        'Virus Gemini, ditularkan oleh kutu kebul (Bemisia tabaci).',
  };

  static const Map<String, String> tingkatKeparahan = {
    'sehat': 'Normal',
    'antraknosa': 'Sedang - Tinggi',
    'busuk_buah': 'Tinggi',
    'bercak_daun': 'Ringan - Sedang',
    'virus_kuning': 'Tinggi',
  };

  static String getDescription(String label) =>
      descriptions[label] ?? 'Deskripsi untuk "$label" belum ditambahkan.';

  static String getSuggestion(String label) =>
      suggestions[label] ?? 'Saran untuk "$label" belum ditambahkan.';

  static String getPenyebab(String label) =>
      penyebab[label] ?? 'Penyebab untuk "$label" belum ditambahkan.';

  static String getTingkatKeparahan(String label) =>
      tingkatKeparahan[label] ?? '-';

  static const Map<String, String?> diseaseImages = {
    'sehat': 'assets/images/disease/daun_dan_buah_sehat.jpg',
    'antraknosa': 'assets/images/disease/antraknosa.jpg',
    'busuk_buah': 'assets/images/disease/busuk_buah.jpg',
    'bercak_daun': 'assets/images/disease/bercak_daun.jpg',
    'virus_kuning': 'assets/images/disease/virus_kuning.jpg',
  };

  static const List<Map<String, String>> diseaseInfoList = [
    {
      'title': 'Sehat',
      'category': 'Daun & Buah',
      'description':
          'Daun cabai sehat memiliki warna hijau segar dan merata, tekstur halus tanpa bercak atau perubahan warna. Buah cabai sehat memiliki warna cerah merata sesuai tingkat kematangannya, dengan permukaan kulit mulus tanpa lesi atau area busuk.',
      'image': 'assets/images/disease/daun_dan_buah_sehat.jpg',
    },
    {
      'title': 'Bercak Daun (Cercospora Leaf Spot)',
      'category': 'Daun',
      'description':
          'Disebabkan oleh jamur Cercospora capsici. Gejala berupa bercak kecil berwarna cokelat hingga kehitaman yang meluas seiring waktu. Jika dibiarkan, jaringan daun rusak sehingga luas permukaan fotosintesis berkurang dan produktivitas tanaman menurun.',
      'image': 'assets/images/disease/bercak_daun.jpg',
    },
    {
      'title': 'Virus Kuning (Yellow Leaf Curl)',
      'category': 'Daun',
      'description':
          'Disebabkan oleh virus Gemini (Begomovirus) yang ditularkan oleh kutu kebul (whitefly). Daun menguning tidak merata, menggulung/mengeriting, ukurannya mengecil, dan pertumbuhan tanaman terhambat. Infeksi pada fase awal pertumbuhan berisiko menyebabkan gagal panen.',
      'image': 'assets/images/disease/virus_kuning.jpg',
    },
    {
      'title': 'Antraknosa (Patek)',
      'category': 'Buah',
      'description':
          'Disebabkan oleh jamur Colletotrichum sp. Ditandai lesi/bercak cekung berwarna gelap kehitaman berbentuk melingkar yang meluas dan sering disertai pembusukan dari titik infeksi. Menyebabkan buah tidak layak jual dan menurunkan kualitas serta kuantitas hasil panen.',
      'image': 'assets/images/disease/antraknosa.jpg',
    },
    {
      'title': 'Busuk Buah (Phytophthora Fruit Rot)',
      'category': 'Buah',
      'description':
          'Disebabkan oleh patogen Phytophthora capsici atau bakteri sejenis. Buah tampak basah (water-soaked), berubah cokelat kehitaman, teksturnya melunak, dan pada kelembapan tinggi muncul lapisan miselium putih yang menyebar cepat, bahkan berpotensi menular ke batang dan akar.',
      'image': 'assets/images/disease/busuk_buah.jpg',
    },
  ];
}
