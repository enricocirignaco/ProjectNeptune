# passkey_generator
A Program to generate a random password and program a USB Digispark to print it.

# Bootloader
How to flash new bootloader on the ATtiny85 or Digispark. (Needed to remove the 5 seconds delay).
## dependencies
* [avr-gcc compiler](https://www.obdev.at/products/crosspack/download.html)
* [ruby](https://www.ruby-lang.org/en/) 1.9 or newer
* [micronucleus](https://github.com/micronucleus/micronucleus)


## 1. install micronucleus program(bootloader flasher)
In order to install micronucleus navigate to micronucleus --> comandline and compile and install the tool.
```
cd micronucleus/comandline
sudo make install
```
## 2. Compile bootloader
go to the **firmware** directory and compile the hex file.
If you want to change the configuration(or remove the 5 seconds delay) you have to modify the **bootloaderconfig.h** file in the configuration folder before compiling.
```
cd micronucleus/firmware
make clean
make all
```
## 3. Upgrade hex file
The compiled hex file is to big to be loaded on the ATtiny85. It has to be compressed. Follow these steps:
```
cd micronucleus/upgrade
ruby generate-data.rb ../firmware/main.hex
make clean
make
```

**Info:** If your are getting an error on MacOS while building try to add **static** at the beginning of line 71 of the file utils.h like that:
```
static inline void delay(unsigned int ms) {
```
## 4. Flash hex
Flash generated hex file on the chip
```
micronucleus --run upgrade.hex
```
**Info** If flash fails, disconnect uC and retry a second time. This is a known problem.


# Setup avr-gcc (compiler)
## Installaton
If not already installed you need to install the **avr-gcc** compiler.
For MacOS you can download and install the [CrossPack package](https://www.obdev.at/products/crosspack/download.html).
Alternatively if you have the Arduino IDE already installed on your machine you can Dowload the Arduino AVR Board package from the package manager.

## Add avr-gcc to PATH
Put avr-gcc compiler that come preinstalled with arduino in Path variable

1. find out the **avr-gcc** path. The avr-gcc that comes with the Arduino IDE usually is stored here : **/Users/xxxx/Library/Arduino15/packages/arduino/tools/avr-gcc/x.x.x-arduino5/bin**

2. add path to $PATH global variable:
```
sudo nano /etc/paths
```
Add path to the end of the file.
3. Reopen Terminal.
