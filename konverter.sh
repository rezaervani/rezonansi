#!/bin/bash
# konverter.sh — paksa REZONANSI.jpg jadi A4, lalu gabung ke rezonansi.pdf

IMG="REZONANSI.jpg"
PDF="rezonansi.pdf"
COVER="cover.pdf"
OUTPUT="buku_rezonansi_akhir.pdf"

# Konversi JPG → PDF dengan ukuran A4
magick "$IMG" \
  -units PixelsPerInch -density 72 \
  -resize 595x842\! \
  -extent 595x842 \
  "$COVER"

# Gabungkan cover + dokumen
magick "$COVER" "$PDF" "$OUTPUT"

echo "Selesai. Hasil ada di $OUTPUT"
