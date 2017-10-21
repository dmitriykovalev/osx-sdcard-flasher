#! /bin/sh

if [ $# -eq 0 ]; then
  echo "$0 <image-file>"
  exit 1
fi

# Image file.
IMAGE_FILE=$1
if [ ! -f $IMAGE_FILE ]; then
  echo "Image file not found."
  exit 1
fi

echo "Disk image file: $IMAGE_FILE,$(wc -c < $IMAGE_FILE) bytes"

# SD-card.
DISK_XPATH='/plist/array[1]/dict/key[.="_items"]/following-sibling::array[1]/dict/key[.="_items"]/following-sibling::array[1]/dict/key[.="bsd_name"]/following-sibling::string[1]/text()'
DISK=$(system_profiler -xml SPCardReaderDataType | xmllint --xpath $DISK_XPATH - 2>/dev/null)
if [ ! $? -eq 0 ]; then
  echo "SD-card is not inserted."
  exit 1
fi

DEV_DISK=/dev/$DISK
DEV_RDISK=/dev/r$DISK

diskutil list $DEV_DISK
if [ ! $? -eq 0 ]; then
  echo "SD-card is not inserted."
  exit 1
fi

# Process.
CMD="sudo dd if=$IMAGE_FILE of=$DEV_RDISK bs=10m"

read -p "Execute: $CMD (y/n)?" -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  diskutil unmountDisk $DEV_DISK
  echo "Writing image..."
  time sudo $CMD
  echo "Done."
  diskutil eject $DEV_DISK
fi
