# Flash SD-card on Mac OS X

## Raspberry Pi

1. Download image file archive:

```
wget --content-disposition https://downloads.raspberrypi.org/raspbian_lite_latest
```

2. Extract image file:

```
unzip *-raspbian-stretch-lite.zip
```

3. Flash image to the SD-card:

```
osx-sdcard-flasher.sh *-raspbian-stretch-lite.img
```
## BeagleBone Black

1. Download image file archive:

```
wget http://debian.beagleboard.org/images/bone-debian-9.1-lxqt-armhf-2017-08-31-4gb.img.xz
```

2. Extract image file:

```
xz -d bone-debian-9.1-lxqt-armhf-2017-08-31-4gb.img.xz
```

3. Flash image to the SD-card:

```
osx-sdcard-flasher.sh bone-debian-9.1-lxqt-armhf-2017-08-31-4gb.img
```
