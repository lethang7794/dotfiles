#!/bin/bash

# Check if the EPUB file is provided as an argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <epub-file>"
  exit 1
fi

EPUB_FILE="$1"
EPUB_FILENAME="${EPUB_FILE%.*}"

COVERS_DIR=/tmp/epub-covers

# Create the target directory if it doesn't exist
mkdir -p $COVERS_DIR

# Check if the EPUB file exists
if [ ! -f "$EPUB_FILE" ]; then
  echo "File not found: $EPUB_FILE"
  exit 1
fi

# Create a temporary directory for extraction
TEMP_DIR=$(mktemp -d)

# Extract the EPUB file
unzip -q "$EPUB_FILE" -d "$TEMP_DIR"

# Locate the content.opf file
OPF_FILE=$(find "$TEMP_DIR" -name "*.opf" | head -n 1)

if [ -z "$OPF_FILE" ]; then
  echo "No content.opf file found."
  rm -rf "$TEMP_DIR"
  exit 1
fi

# Find the line with the cover image metadata
COVER_LINE=$(grep '<meta name="cover" content="' "$OPF_FILE")

if [ -z "$COVER_LINE" ]; then
  echo "No cover meta tag found in $OPF_FILE."
else
  # Extract the cover image path using regex
  COVER_IMAGE=$(echo "$COVER_LINE" | sed -n 's/.*content="\([^"]*\)".*/\1/p')

  # Find the cover image file in the extracted folder
  COVER_PATH=$(find "$TEMP_DIR" -name "$(basename "$COVER_IMAGE")" -print -quit)

  if [ -n "$COVER_PATH" ]; then
    # Extract cover extension
    COVER_BASENAME=$(basename "$COVER_PATH")
    COVER_EXT="${COVER_BASENAME##*.}"

    # Move the cover image to $COVERS_DIR
    TARGET_PATH="$COVERS_DIR/$EPUB_FILENAME.$COVER_EXT"
    mv "$COVER_PATH" "$TARGET_PATH"

    # Echo the epub cover's path
    echo "$TARGET_PATH"
  else
    echo "Cover image file not found: $COVER_IMAGE"
    exit 1
  fi
fi

# Clean up the temporary directory
rm -rf "$TEMP_DIR"
