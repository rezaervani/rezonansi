#!/bin/bash
# konverter_hq.sh — buat cover A4 full page + merge tanpa merusak vektor (qpdf)
set -euo pipefail

IMG="REZONANSI.jpg"
PDF="rezonansi.pdf"
COVER="cover.pdf"
OUTPUT="buku_rezonansi_akhir.pdf"

# Ambil ukuran A4 dari pdfinfo (agar presisi)
PAGE_W_PT=$(pdfinfo "$PDF" | awk '/Page size/{print $3}')
PAGE_H_PT=$(pdfinfo "$PDF" | awk '/Page size/{print $5}')

# Tentukan DPI cover (300 cukup tajam; 600 untuk cetak sangat halus)
DPI=300
PAGE_W_PX=$(printf "%.0f" "$(echo "$PAGE_W_PT/72*$DPI" | bc -l)")
PAGE_H_PX=$(printf "%.0f" "$(echo "$PAGE_H_PT/72*$DPI" | bc -l)")

echo "Membuat cover A4 FULL page @${DPI}dpi → ${PAGE_W_PX}x${PAGE_H_PX}px"

# MODE FILL (penuhi halaman, crop seperlunya agar TANPA bar putih)
magick "$IMG" \
  -units PixelsPerInch -density $DPI \
  -resize ${PAGE_W_PX}x${PAGE_H_PX}^ \
  -gravity center -extent ${PAGE_W_PX}x${PAGE_H_PX} \
  -compress Zip \
  "$COVER"

# Merge TANPA merusak vektor halaman PDF asli
qpdf --empty --pages "$COVER" "$PDF" -- "$OUTPUT"

echo "Selesai → $OUTPUT"
