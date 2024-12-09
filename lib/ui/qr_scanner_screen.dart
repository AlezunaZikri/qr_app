import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final MobileScannerController _controller = MobileScannerController();
  String? barcodeValue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const CustomSnackbar(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Code"),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
      ),
      body: Stack(
        children: [
          // Pemindaian QR Code
          MobileScanner(
            controller: _controller,
            onDetect: (capture) {
              _handleQrDetection(capture);
            },
          ),
          // Overlay Scanner
          ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Colors.black54,
              BlendMode.srcOut,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black54, // Warna luar
                  ),
                ),
                Center(
                  child: CustomPaint(
                    size: const Size(250, 250),
                    painter: SmoothRoundedPainter(isDarkMode: isDarkMode),
                  ),
                ),
              ],
            ),
          ),
          // Teks petunjuk
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Place the QR Code inside the frame",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.8),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleQrDetection(BarcodeCapture capture) {
    final Uint8List? image = capture.image;
    final List<Barcode> value = capture.barcodes;

    for (final barcode in value) {
      barcodeValue = barcode.rawValue!;
    }
    if (image != null) {
      _controller.stop(); // Hentikan pemindaian sementara
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("QR Code Detected"),
              const SizedBox(height: 10),
              Image.memory(image),
              Text(barcodeValue!, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: barcodeValue!));
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.copy),
                        Text("Copy"),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _controller.start(); // Mulai pemindaian kembali
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.close),
                        Text("Close"),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }
}

class SmoothRoundedPainter extends CustomPainter {
  final bool isDarkMode;

  SmoothRoundedPainter({required this.isDarkMode});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDarkMode ? Colors.white70 : Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final path = Path();
    const double cornerSize = 20;

    // Sudut kiri atas
    path.moveTo(0, cornerSize);
    path.lineTo(0, 0);
    path.lineTo(cornerSize, 0);

    // Sudut kanan atas
    path.moveTo(size.width - cornerSize, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, cornerSize);

    // Sudut kiri bawah
    path.moveTo(0, size.height - cornerSize);
    path.lineTo(0, size.height);
    path.lineTo(cornerSize, size.height);

    // Sudut kanan bawah
    path.moveTo(size.width - cornerSize, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - cornerSize);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CustomSnackbar extends StatelessWidget {
  const CustomSnackbar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.white10 : Colors.black26,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Scan QR Code",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Place QR code inside the frame to scan. Please avoid shake to get results quickly.",
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.white70 : Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Center(
            child: Image.asset(
              'assets/images/scan-icon.png',
              width: 220,
              height: 220,
            ),
          ),
        ],
      ),
    );
  }
}
