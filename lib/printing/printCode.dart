import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> printCertificate(
    {required String name,
    required String address,
    required String mobile,
    required int number,
    required String total,
    required String message,
    required double vers,
    totalVers,
    required String email}) async {
  final doc = pw.Document();

  // Load the image from assets
  final image = await imageFromAssetBundle('assets/invoice.png');

  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Stack(
          children: [
            pw.Image(image),
            // number
            pw.Positioned(
              left: 355, // Adjust according to your template
              top: 150, // Adjust according to your template
              child: pw.Text(
                "facture N = $number",
                style: pw.TextStyle(
                    fontSize: 12, // Adjust font size
                    color: PdfColors.grey800),
              ),
            ),
            // name
            pw.Positioned(
              left: 50, // Adjust according to your template
              top: 202, // Adjust according to your template
              child: pw.Text(
                name,
                style: pw.TextStyle(
                    fontSize: 12, // Adjust font size
                    color: PdfColors.grey800),
              ),
            ),
            // address
            pw.Positioned(
              left: 50, // Adjust according to your template
              top: 216, // Adjust according to your template
              child: pw.Text(
                address,
                style: pw.TextStyle(
                    fontSize: 12, // Adjust font size
                    color: PdfColors.grey800),
              ),
            ),
            // mail
            pw.Positioned(
              left: 50, // Adjust according to your template
              top: 229, // Adjust according to your template
              child: pw.Text(
                email,
                style: pw.TextStyle(
                    fontSize: 12, // Adjust font size
                    color: PdfColors.grey800),
              ),
            ),
            // mobile
            pw.Positioned(
              left: 50, // Adjust according to your template
              top: 244, // Adjust according to your template
              child: pw.Text(
                mobile,
                style: pw.TextStyle(
                    fontSize: 12, // Adjust font size
                    color: PdfColors.grey800),
              ),
            ),
            // pay today
            pw.Positioned(
              left: 250, // Adjust according to your template
              top: 305, // Adjust according to your template
              child: pw.Text(
                "${vers.toString()} DZD",
                style: const pw.TextStyle(
                  fontSize: 14, // Adjust font size
                  color: PdfColors.grey800,
                ),
              ),
            ),
            // total pay
            pw.Positioned(
              left: 250, // Adjust according to your template
              top: 330, // Adjust according to your template
              child: pw.Text(
                "${totalVers} DZD",
                style: pw.TextStyle(
                  fontSize: 14, // Adjust font size
                  color: PdfColors.grey800,
                ),
              ),
            ),
            // total
            pw.Positioned(
              left: 355, // Adjust according to your template
              top: 365, // Adjust according to your template
              child: pw.Text(
                "$total DZD",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12, // Adjust font size
                  color: PdfColors.grey800,
                ),
              ),
            ),
            // message
                    // First Positioned widget - first 100 characters
                    pw.Positioned(
                      left: 50,
                      top: 395,
                      child: pw.Text(
                        message.length > 100
                            ? message.substring(0, 100)
                            : message, // First 100 characters
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 12,
                          color: PdfColors.grey800,
                        ),
                      ),
                    ),

// Second Positioned widget - characters 101 to 200
message.length > 100 ?
                    pw.Positioned(
                      left: 50,
                      top:
                          420, // Adjust the top to avoid overlap with the first text
                      child: pw.Text(
                        message.length > 200
                            ? message.substring(
                                100, 200) // Characters 101 to 200
                            : (message.length > 100
                                ? message.substring(100)
                                : ''), // Handle cases where message is less than 200 characters
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 12,
                          color: PdfColors.grey800,
                        ),
                      ),
                    ): pw.Container()
          ],
        );
      },
    ),
  );

  // Print the PDF document
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => doc.save(),
  );
}

