import 'dart:io';
import 'package:image/image.dart' as img;

class ObjectValidatorService {
  bool isLikelyChiliObject(File imageFile, {double minRatio = 0.12}) {
    final rawImage = img.decodeImage(imageFile.readAsBytesSync());
    if (rawImage == null) return false;

    final small = img.copyResize(rawImage, width: 100, height: 100);

    int matchedPixels = 0;
    final totalPixels = small.width * small.height;

    for (int y = 0; y < small.height; y++) {
      for (int x = 0; x < small.width; x++) {
        final pixel = small.getPixel(x, y);
        final r = pixel.r.toInt();
        final g = pixel.g.toInt();
        final b = pixel.b.toInt();

        if (_isChiliColor(r, g, b)) matchedPixels++;
      }
    }

    final ratio = matchedPixels / totalPixels;
    return ratio >= minRatio;
  }

  bool _isChiliColor(int r, int g, int b) {
    // Hijau (daun, atau cabai yang masih muda)
    final isGreen = g > r && g > b && g > 60;

    // Merah (cabai matang)
    final isRed = r > 100 && r > g * 1.3 && r > b * 1.3;

    // Oranye/kuning (cabai setengah matang)
    final isOrangeYellow = r > 120 && g > 80 && b < g * 0.7 && r >= g;

    return isGreen || isRed || isOrangeYellow;
  }
}
