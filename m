Message-ID: <38BF7C0A.332BF7F9@ncal.verio.com>
Date: Fri, 03 Mar 2000 00:47:06 -0800
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Some small progress on PowerBook 2000 (Pismo - 102)
References: <38BF5C2A.9A6FCADD@ncal.verio.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Attached is the kmsg dump. The system is a PowerBook 2000, 500Mhz, 256MB,
with DVD-ROM loaded with LinuxPPC 2000 Lite (3/1 version), and a QTronix
Scorpius USB keyboard attached to USB port 1 (USB 1 -- USB 0 is labeled
port 2). Kernel is 2.2.15pre3 loaded with BootX 1.2b3 with the installer
ramdisk image. Below are extracts of a system profiler report. Note the
kernel probes the DVD-ROM as a floppy, the empty USB probe strings, the
ADB keyboard and mouse are probed but don't function (even when no USB
keyboard attached), and the hda lost interrupts.

Also, the ^z break out to the shell also works in 24 bit color, it's
just not 100% reliable in either mode, usually works, but not always.


Henry

                            ------------------


Memory overview
        Disk cache:     7.96 MB
        Virtual memory: 257 MB
                Used on volume: MacOS HFS+
        Built-in memory:        256 MB
                                                                                                                                                                PC100-322S
                Location            Size           Memory type
                SODIMM0/J2  128 MB   SDRAM
                SODIMM1/J1  128 MB   SDRAM
        Video memory:   8 MB    Built-in display in use
        Backside L2 cache:      1 MB
Hardware overview
        Machine ID:     406
        Model name:     PowerBook
        Keyboard type:  PowerBook Keyboard with Inverted-T
        Processor info: PowerPC G3
        Machine speed:  500 MHz
        Nanokernel version: 2.13
        Nanokernel pool extends: 10
        Nanokernel scheduled CPUs:1
Network overview
Ethernet built-in       Link:   down    Speed:  n/a     Duplex: n/a
Modem
                Name:   PowerBook Internal 56K
                Protocol:       V.90
                Version:        V2.200-V90
                Status: Information gathered.

...


        Devices and Volumes
        USB 0   1.4     No devices found on this bus
        USB 1   1.4
                Hub (QTRONIX KBD HUB   )
                        Product ID:     -28141 ($9213)
                        Vendor: Alcor Micro, Inc. (ALCOR)
                        Driver version: 1.4
                        Driver name:    USBHub0Apple
                        Power (mA):     500 ($1f4)
                        Release number: 1.0.1
                        Serial number:
                                Keyboard (QTRONIX KBD HUB   )
                                        Product ID:     8212 ($2014)
                                        Vendor: Qtronix Corp (ALCOR)
                                        Driver version: 1.4
                                        Driver name:    USBHIDKeyboardModule1.4
                                        Power (mA):     200 ($c8)
                                        Release number: 1.0.1
                                        Serial number:  1234
        Firewire        2.3
        Expansion Bay 0
                ID = 0
                                DVD-ROM drive
                                        Driver version: 1.3.4
                                        Mac OS partitions:      1
                                        Removable media:        Yes
                                        Vendor: MATSHITA
                                        Revision number:        C113
                                        Product ID:     DVD-ROM SR-8174
                                        Serial number:  Not available

                                        LinuxPPC 2000 Install
                                                Volume format:  Mac OS Standard (HFS)
                                                Capacity:       172.70 MB
                                                Available:      0 bytes
                                                Percent full:   100
                                                Write protected:        Yes
                                                Is being file shared:   No
        Internal ATA 2
                ID = 0
                                Hard drive
                                        Driver version: Not available
                                        Mac OS partitions:      0
                                        Removable media:        No
                                        Vendor:
                                        Revision number:
                                        Product ID:     Not available
                                        Serial number:  Not available
                                        Size:   0 bytes (1K = 1000)
                                        Capacity:       0 bytes (1K = 1024)

                                        No volumes mounted
        PCI
                Slot $BD
                                Display card (Display)
                                        Card type:      RageM3p-parent
                                        Card name:      ATY,RageM3pParent
                                        Card model:     ATY,RageM3
                                        Card ROM #:     113-XXXXX-111
                                        Card revision:  2
                                        Card vendor ID: 1002

                                                Display
                                                        Screen Size (pixels):   1024 x 768
                                                        Grays/Colors:   256
                                                        Resolution (dpi):       72 x 72
                                                        Additional Information: Main screen
                Slot PC Card
                                PCI Slot
                                        Card type:      cardbus
                                        Card name:      cardbus
                                        Card model:     TXN,PCI1211-00
                                        Card ROM #:     Not available
                                        Card revision:  0
                                        Card vendor ID: 104C


                                 ------------------------------------

<6>device tree used 3050664 bytes
<4>Total memory = 256MB; using 1024kB for hash table (at c0600000)
<4>Linux version 2.2.15pre3 (benh@sawtooth.wanadoo.fr) (gcc version 2.95.2 19991024 (release/franzo)) #3 Sat Jan 29 18:02:45 CET 2000
<6>PCI bus 0 controlled by pci at f0000000
<6>PCI buses 0..1 controlled by pci at f2000000
<6>PCI bus 0 controlled by pci at f4000000
<6>Registered 1 feature controller(s)
<6>PMU driver initialized for Core99 (iBook/iMac/G4)
<4>PowerMac using OpenPIC irq controller
<4>OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at 80040000
<6>via_calibrate_decr: decrementer_count = 249666 (1497996 ticks)
<4>ide_setup: hda=noautotune
<4>Console: colour dummy device 80x25
<4>Calibrating delay loop... 996.15 BogoMIPS
<4>Memory: 252836k available (1460k kernel code, 4792k data, 152k init) [c0000000,d0000000]
<4>Dentry hash table entries: 32768 (order 6, 256k)
<4>Buffer cache hash table entries: 262144 (order 8, 1024k)
<4>Page cache hash table entries: 65536 (order 6, 256k)
<4>POSIX conformance testing by UNIFIX
<4>PCI: Probing PCI hardware
<7>adb devices: [2]: 2 c3 [3]: 3 1 [7]: 7 1f
<6>media bay 0 contains a floppy disk drive
<6>Registered 1 media-bay(s)
<6>Linux NET4.0 for Linux 2.2
<6>Based upon Swansea University Computer Society NET3.039
<6>NET4: Unix domain sockets 1.0 for Linux NET4.0.
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<4>TCP: Hash tables configured (ehash 262144 bhash 65536)
<6>NET4: AppleTalk 0.18 for Linux NET4.0
<4>Starting kswapd v 1.5
<6>OHCI USB Driver loading
<7>usb-ohci: 2 root hub ports found
<7>usb-ohci: 2 root hub ports found
<4>usbcore: Registered new driver mouse
<6>USB HID boot protocol mouse driver registered.
<4>usbcore: Registered new driver keyboard
<4>usbcore: Registered new driver hub
<6>Using unsupported 1024x768 MacOS display at a6008000, depth=8, pitch=1024
<4>Console: switching to colour frame buffer device 128x48
<4>fb0: Open Firmware frame buffer device on MacOS display
<4>ADB keyboard at 2, handler 1
<4>ADB mouse at 3, handler set to 4 (trackpad)
<4>PowerMac Z8530 serial driver version 2.0
<4>tty00 at 0x80013020 (irq = 22) is a Z8530 ESCC (cobalt modem)
<4>tty01 at 0x80013000 (irq = 23) is a Z8530 ESCC (powerbook IR)
<4>pty: 256 Unix98 ptys configured
<6>Macintosh ADB mouse driver installed.
<6>Macintosh non-volatile memory driver v1.0
<4>RAM disk driver initialized:  16 RAM disks of 8192K size
<6>loop: registered device at major 7
<4>pmac_ide: enabling IDE bus ID 2
<4>pmac_ide: enabling IDE bus ID 1
<4>hda: TOSHIBA MK1214GAP, ATA DISK drive
<4>ide0 at 0x8e01f000-0x8e01f007,0x8e01f160 on irq 19
<6>hda: TOSHIBA MK1214GAP, 11513MB w/0kB Cache, CHS=23392/16/63
<4>scsi : 0 hosts.
<4>scsi : detected total.
<6>PPP: version 2.3.7 (demand dialling)
<6>TCP compression code copyright 1989 Regents of the University of California
<6>PPP line discipline registered.
<6>eth0: GMAC at 00:30:65:4c:a8:58
<4>Partition check:
<4> hda:<7>ohci-control thread code for 0xc05b80e0 code at 0xc0167d18
<4>New USB bus registered, assigned bus number 1
<7>ohci-control thread code for 0xc05b8020 code at 0xc0167d18
<4>New USB bus registered, assigned bus number 2
<7>usb-ohci: HC c05b80e0 reset.
<7>usb-ohci: HC c05b8020 reset.
<6>usb-ohci: host controller operational
<6>usb-ohci: host controller operational
<7>ohci-control thread sleeping
<6>USB new device connect, assigned device number 1
<6>Manufacturer:
<6>Product:
<6>SerialNumber:
<6>USB hub found
<6>hub: 3 ports detected
<6>hub: ganged power switching
<6>hub: standalone hub
<6>hub: global over-current protection
<6>hub: power on to power good time: 44ms
<6>hub: hub controller current requirement: 100mA
<6>hub:  port 1 is not removable
<6>hub:  port 2 is removable
<6>hub:  port 3 is removable
<6>hub: local power source is good
<6>hub: no over-current condition exists
<6>hub: enabling power on all ports
<7>usb: usb-bandwidth-alloc: was: 0, new: 11, bustime = 11 us, Pipe allowed: yes
<7>usb: bw_alloc bumped to 11 for 1 requesters
<7>usbcore: hub driver claimed interface c09a9c60
<7>ohci-control thread sleeping
<6>hub: port 1 connection change
<6>USB new device connect, assigned device number 2
<6>usb: skipped 1 class/vendor specific interface descriptors
<6>Manufacturer:
<6>Product:
<6>SerialNumber:
<6>USB HID boot protocol keyboard detected.
<7>usb: usb-bandwidth-alloc: was: 11, new: 28, bustime = 17 us, Pipe allowed: yes
<7>usb: bw_alloc bumped to 28 for 2 requesters
<7>usbcore: keyboard driver claimed interface c09a9d60
<6>hub: port 1 reset change
<4>hda: lost interrupt
<4>hda: lost interrupt
<4>hda: lost interrupt
<4>hda: lost interrupt
<4>hda: lost interrupt
<4>hda: lost interrupt
<4>hda: lost interrupt
<4> hda1hda: lost interrupt
<4>hda: lost interrupt
<4> hda2 hda3hda: lost interrupt
<4>hda: lost interrupt
<4> hda4 hda5hda: lost interrupt
<4>hda: lost interrupt
<4> hda6 hda7hda: lost interrupt
<4>hda: lost interrupt
<4> hda8 hda9hda: lost interrupt
<4>hda: lost interrupt
<4> hda10 hda11hda: lost interrupt
<4>hda: lost interrupt
<4> hda12 hda13hda: lost interrupt
<4>hda: lost interrupt
<4> hda14 hda15hda: lost interrupt
<4>hda: lost interrupt
<4> hda16 hda17
<5>RAMDISK: Compressed image found at block 0
<4>EXT2-fs warning: maximal mount count reached, running e2fsck is recommended
<4>VFS: Mounted root (ext2 filesystem).
<4>Freeing unused kernel memory: 152k init 32k prep

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
