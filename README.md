# PhotoFrame

Simple bash script to make a digital photo frame with QIV.

## How to use

Clone the repository on the Raspberry Pi (or any system Linux based) :

```bash
git clone git@github.com:semhoun/photoframe.git
cd photoframe
```

Execute the system setup script. 

:warning: This script will remove and clean Linux packages unused for this project.

```bash
./system_init.sh
```

When the script is done, you should have QIV installed, an autoloading slideshow at system boot, and a new folder `~/pics`. Add photos in this folder, and they will be added to slideshow.

## Slideshow script

The slideshow will automatically launch at system boot, but you can start it manually :

```bash
./qiv_slideshow.sh
```

## Bonus

### Mount a shared drive

In order to add more photos to the system, maybe you want to access a shared drive (computer, server, NAS, etc.).

Add this line in `/etc/fstab` to automatically mount a shared folder at system boot :

```
server_name:remote_folder /home/pi/shared_folder nfs defaults 0 0
```

### Copy distant photos

If you have mounted a shared drive, you could like to copy some photos from the remote to the local system.

For this, use a rsync command :

```bash
rsync -avz --exclude '*.NEF' --exclude '*.MOV' --exclude '*.m4v' --exclude '*.mp4' /home/pi/shared_folder/cats/ /home/pi/pics/cats/
```

This command copy all the photo from `/home/pi/shared_folder/cats/` to the local system, without the RAW and video files.

### Rename all .JPG files to .jpg

```bash
find . -name "*.JPG" -exec rename 's/.JPG$/.jpg/' {} \;
```

### Resize photos

If you want to resize all your photos to fit the size of your screen :

```bash
sudo chmod 777 *
find . -name "*.jpg" -exec mogrify -resize 1400x800 {} +
find . -type f -name '*~' -exec rm -f '{}' \;
```

The chmod is here because mogrify must have access to the photos. The third command is to remove photos in case mogrify has created copy of the resized images.

### Remove @eaDir

Il you copy your files from a Synology, there could be some folders named "@eaDir". You can remove them with this command :

```bash
find . -name "@eaDir" -type d -print |while read FILENAME; do rm -rf "${FILENAME}"; done
```
