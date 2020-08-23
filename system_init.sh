#!/bin/sh

set -x

# remove unused software
sudo apt-get update && \
sudo apt-get purge -q -y wolfram-engine \
	libreoffice* \
	minecraft-pi \
	sonic-pi \
	oracle-java* openjdk* \
	python-picraft python3-picraft \
	scratch* nuscratch \
	python3-pygame python-pygame \
	greenfoot && \
sudo apt-get clean -y && \
sudo apt-get autoremove -y && \

# update system
sudo apt-get upgrade -y && \
sudo apt-get dist-upgrade -y && \

sudo apt-get install -y qiv && \

# create the directory which will contains the pictures
mkdir -p /home/pi/pics && \

# config used to autostart the slideshow at Raspbian boot
mkdir -p /home/pi/.config/autostart
cp ./config_files/slideshow.desktop /home/pi/.config/autostart/slideshow.desktop
