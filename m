Date: Fri, 14 Nov 2003 02:10:48 +0100
From: Wilmer van der Gaast <lintux@lintux.cx>
To: linuxppc-dev@lists.linuxppc.org
Subject: Oops in current linux-2.5-benh
Message-ID: <20031114011048.GG24030@gaast.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Mjqg7Yu+0hL22rav"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hello,

I assume this list is the best place to report PPC-specific kernel bugs?
If not, please tell me and I'll repost somewhere else. Please Cc me on a
reply, I'm not on the list.

On my iBook 600 (CD-ROM/750fx/Radeon), dmasound_pmac fails to load and
dumps an oops. Attaching the log.

After this oops, trying to get the laptop to sleep also fails with an
oops, I'm also attaching this dump. But this oops might be caused by a
previous one; not very useful.

Just testing, the pmud oops also happens without a failed dmasound load.

Hope this dump is of some use, took me some time to type the last one on
another console. :-)

Greetings,

Wilmer van der Gaast.

--
+-------- .''`.     - -- ---+  +        - -- --- ---- ----- ------+
| lintux : :'  :  lintux.cx |  | OSS Programmer   www.bitlbee.org |
|   at   `. `~'  debian.org |  | www.algoritme.nl   www.lintux.cx |
+--- -- -  ` ---------------+  +------ ----- ---- --- -- -        +

--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=dmasound_oops

Total memory = 384MB; using 1024kB for hash table (at c0300000)
Linux version 2.6.0-test9 (wilmer@jona) (gcc version 3.3.2 (Debian)) #1 Fri Nov 14 01:38:02 CET 2003
Found Uninorth memory controller & host bridge, revision: 192
Mapped at 0xfdf3c000
Found a Pangea mac-io controller, rev: 0, mapped at 0xfdebc000
Processor NAP mode on idle enabled.
PowerMac motherboard: iBook 2 rev. 2
Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->0
via-pmu: Server Mode is disabled
PMU driver 2 initialized for Core99, firmware: 0c
nvram: Checking bank 0...
nvram: gen0=305, gen1=306
nvram: Active bank is: 1
nvram: OF partition at 0x410
nvram: XP partition at 0xffffffff
nvram: NR partition at 0xffffffff
On node 0 totalpages: 98304
  DMA zone: 98304 pages, LIFO batch:16
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: root=/dev/hda4 ro
PowerMac using OpenPIC irq controller at 0x80040000
OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at fc66e000
OpenPIC timer frequency is 4.160000 MHz
PID hash table entries: 2048 (order 11: 16384 bytes)
GMT Delta read from XPRAM: 0 minutes, DST: on
time_init: decrementer frequency = 24.835245 MHz
Console: colour dummy device 80x25
Memory: 385024k available (1708k kernel code, 976k data, 124k init, 0k highmem)
AGP special page: 0xd7fff000
Calibrating delay loop... 1187.84 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
bus type 'platform' registered
NET: Registered protocol family 16
bus type 'of_platform' registered
bus type 'pci' registered
bus type 'macio' registered
PCI: Probing PCI hardware
Fixup res 1 (101) of dev 0000:00:10.0: 400 -> 802400
bus pci: add device 0000:00:0b.0
bus pci: add device 0000:00:10.0
bus pci: add device 0001:01:0b.0
bus pci: add device 0001:01:17.0
bus pci: add device 0001:01:18.0
bus pci: add device 0001:01:19.0
bus pci: add device 0002:02:0b.0
bus pci: add device 0002:02:0e.0
bus pci: add device 0002:02:0f.0
PCI->OF bus map:
0 -> 0
1 -> 0
2 -> 0
PCI: bridge rsrc 802000..1001fff (100), parent c01f8478
PCI: bridge rsrc f1000000..f1ffffff (200), parent c01f8494
PCI: bridge rsrc 90000000..9fffffff (200), parent c01f8494
PCI: bridge rsrc 0..7fffff (100), parent c01f8478
PCI: bridge rsrc f3000000..f3ffffff (200), parent c01f8494
PCI: bridge rsrc 80000000..8fffffff (200), parent c01f8494
PCI: bridge rsrc ff7fe000..ffffdfff (100), parent c01f8478
PCI: bridge rsrc f5000000..f5ffffff (200), parent c01f8494
PCI:0000:00:10.0: Resource 0: 98000000-9fffffff (f=1208)
PCI:0000:00:10.0: Resource 2: 90000000-9000ffff (f 0)
PCI:0001:01:17.0: Resource 0: 80000000-8007ffff (f 0)
PCI:0002:02:0f.0: Resource 0: f5200000-f53fffff (f 0)
PCI:0000:00:10.0: Resource 1: 00802400-008024ff (f=101)
PCI:0001:01:18.0: Resource 0: 80081000-80081fff (f 0)
PCI:0001:01:19.0: Resource 0: 80080000-80080fff (f 0)
PCI:0002:02:0e.0: Resource 0: f5000000-f5000fff (f 0)
Registering openpic with sysfs...
bus type 'i2c' registered
bus i2c: add driver i2c_adapter
bus pci: add driver radeonfb
radeonfb_pci_register BEGIN
PCI: Enabling device 0000:00:10.0 (0086 -> 0087)
aper_base: 98000000 MC_FB_LOC to: 9bff9800, MC_AGP_LOC to: ffffa000
radeonfb: probed DDR SGRAM 16384k videoram
radeonfb: Invalid ROM signature 8080 should be 0xaa55
radeonfb: Retreived PLL infos from Open Firmware
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=166.00 Mhz, System=166.00 MHz
Starting monitor auto detection...
radeon_probe_OF_head
head: ATY,Fall_A (letter: A, head_no: 0)
analyzing OF properties...
display-type: LCD
radeon_probe_OF_head
head: ATY,Fall_A (letter: A, head_no: 1)
radeonfb: I2C (port 3) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: Monitor 1 type LCD found
radeonfb: EDID probed
========================================
Display Information (EDID)
========================================
   EDID Version 1.3
   Manufacturer: APP Model: 9c12 Serial#: 16843009
   Year: 2002 Week 0
   Display Characteristics:
      Digital Display Input      Sync:
      Max H-size in cm: 25
      Max V-size in cm: 18
      Gamma: 2.20
      DPMS: Active no, Suspend no, Standby no
      RGB Color Display
      Chromaticity: RedX:   0.584 RedY:   0.340
                    GreenX: 0.289 GreenY: 0.540
                    BlueX:  0.148 BlueY:  0.133
                    WhiteX: 0.313 WhiteY: 0.329
      First DETAILED Timing is preferred
   Standard Timings
   Supported VESA Modes
      1024x768@60Hz
      Manufacturer's mask: 0
   Detailed Monitor Information
      65 MHz 1024 1048 1184 1344 768 771 777 806 -HSync -VSync

      LTN121X1-L02
      LTN121X1-L02
      Monitor Name  : Color LCD
========================================
radeonfb: Monitor 2 type no found
Parsing EDID data for panel info
Setting up default mode based on panel info
radeonfb: Power Management enabled for Mobility chipsets
Registered "ati" backlight controller, level: 15/15
radeonfb: ATI Radeon LY  DDR SGRAM 16 MB
radeonfb_pci_register END
bound device '0000:00:10.0' to driver 'radeonfb'
Thermal assist unit using timers, shrink_timer: 2000 jiffies
bus of_platform: add device uni-n-i2c
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
hStart = 1048, hEnd = 1184, hTotal = 1344
vStart = 771, vEnd = 777, vTotal = 806
h_total_disp = 0x7f00a7	   hsync_strt_wid = 0x910412
v_total_disp = 0x2ff0325	   vsync_strt_wid = 0x860302
pixclock = 15384
freq = 6500
lvds_gen_cntl: 000d24a1
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
bus pci: add driver gem
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:93:a7:ef:6c
PHY ID: 4061e4, addr: 0
eth0: Found BCM5221 PHY
bound device '0002:02:0f.0' to driver 'gem'
bus pci: add driver macio
MacIO PCI driver attached to Pangea chipset
preparing mdev @d7ea7c00, ofdev @d7ea7c08, dev @d7ea7c18, kobj @d7ea7c40
bus macio: add device 0.80000000:mac-io
preparing mdev @d7ea7800, ofdev @d7ea7808, dev @d7ea7818, kobj @d7ea7840
bus macio: add device 0.00040000:interrup
preparing mdev @d7ea7400, ofdev @d7ea7408, dev @d7ea7418, kobj @d7ea7440
bus macio: add device 0.00000050:gpio
preparing mdev @d7ea7000, ofdev @d7ea7008, dev @d7ea7018, kobj @d7ea7040
bus macio: add device 0.00013000:escc
preparing mdev @d7d93c00, ofdev @d7d93c08, dev @d7d93c18, kobj @d7d93c40
bus macio: add device 0.00010000:i2s
preparing mdev @d7d93800, ofdev @d7d93808, dev @d7d93818, kobj @d7d93840
bus macio: add device 0.00015000:timer
preparing mdev @d7d93400, ofdev @d7d93408, dev @d7d93418, kobj @d7d93440
bus macio: add device 0.00016000:via-pmu
preparing mdev @d7d93000, ofdev @d7d93008, dev @d7d93018, kobj @d7d93040
bus macio: add device 0.0000f300:backligh
preparing mdev @d7d8bc00, ofdev @d7d8bc08, dev @d7d8bc18, kobj @d7d8bc40
bus macio: add device 0.00018000:i2c
preparing mdev @d7d8b800, ofdev @d7d8b808, dev @d7d8b818, kobj @d7d8b840
bus macio: add device 0.0001f000:ata-4
preparing mdev @d7d8b400, ofdev @d7d8b408, dev @d7d8b418, kobj @d7d8b440
bus macio: add device 0.00013020:ch-a
preparing mdev @d7d8b000, ofdev @d7d8b008, dev @d7d8b018, kobj @d7d8b040
bus macio: add device 0.00013000:ch-b
bound device '0001:01:17.0' to driver 'macio'
bus macio: add driver media-bay
input: Macintosh mouse button emulation
apm_emu: APM Emulation 0.5 initialized.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
bus type 'ide' registered
bus pci: add driver PCI IDE
bus pci: add driver ide-pmac
bus macio: add driver ide-pmac
adb: starting probe task...
adb devices: [2]: 2 c3 [3]: 3 1 [7]: 7 1f
ADB keyboard at 2, handler 1
Detected ADB keyboard, type ANSI.
input: ADB keyboard on adb2:2.c3/input
input: ADB Powerbook buttons on adb7:7.1f/input
ADB mouse at 3, handler set to 4 (trackpad)
input: ADB mouse on adb3:3.01/input
adb: finished probe task...
ide0: Found Apple KeyLargo ATA-4 controller, bus ID 2
Probing IDE interface ide0...
hda: IBM-IC25N020ATCS04-0, ATA DISK drive
hdb: LG CD-ROM CRN-8245B, ATAPI CD/DVD-ROM drive
ide_pmac: Set UDMA timing for mode 2, reg: 0x1090038c
hda: Enabling Ultra DMA 2
ide_pmac: Set UDMA timing for mode 2, reg: 0x1090038c
hdb: Enabling Ultra DMA 2
Using anticipatory io scheduler
ide0 at 0xda2e9000-0xda2e9007,0xda2e9160 on irq 19
bus ide: add device 0.0
bus ide: add device 0.1
bound device '0.0001f000:ata-4' to driver 'ide-pmac'
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1768KiB Cache, CHS=38760/16/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: [mac] p1 p2 p3 p4 p5
bus ide: add driver ide-disk
Console: switching to colour frame buffer device 128x48
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
bus i2c: add driver dev_driver
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 124k init 4k chrp 8k prep
Adding 393112k swap on /dev/ide/host0/bus0/target0/lun0/part5.  Priority:-1 extents:1
EXT3 FS on hda4, internal journal
bus type 'usb' registered
bus usb: add driver usbfs
drivers/usb/core/usb.c: registered new driver usbfs
bus usb: add driver hub
drivers/usb/core/usb.c: registered new driver hub
bus usb: add driver usb
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
bus pci: add driver ohci_hcd
PCI: Enabling device 0001:01:18.0 (0000 -> 0002)
ohci_hcd 0001:01:18.0: OHCI Host Controller
ohci_hcd 0001:01:18.0: irq 27, pci mem da321000
ohci_hcd 0001:01:18.0: new USB bus registered, assigned bus number 1
bus usb: add device usb1
bound device 'usb1' to driver 'usb'
bus usb: add device 1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
bound device '1-0:1.0' to driver 'hub'
bound device '0001:01:18.0' to driver 'ohci_hcd'
PCI: Enabling device 0001:01:19.0 (0000 -> 0002)
ohci_hcd 0001:01:19.0: OHCI Host Controller
ohci_hcd 0001:01:19.0: irq 28, pci mem da323000
ohci_hcd 0001:01:19.0: new USB bus registered, assigned bus number 2
bus usb: add device usb2
bound device 'usb2' to driver 'usb'
bus usb: add device 2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
bound device '2-0:1.0' to driver 'hub'
bound device '0001:01:19.0' to driver 'ohci_hcd'
Linux agpgart interface v0.100 (c) Dave Jones
bus pci: add driver agpgart-uninorth
agpgart: Detected Apple UniNorth/Pangea chipset
agpgart: Maximum main memory to use for agp memory: 322M
agpgart: configuring for size idx: 4
agpgart: AGP aperture is 16M @ 0x0
bound device '0000:00:0b.0' to driver 'agpgart-uninorth'
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C0082AE8 LR: C0082C1C SP: D7519E60 REGS: d7519db0 TRAP: 0301    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000008, DSISR: 40000000
TASK = d7951a40[77] 'modprobe' Last syscall: 128
GPR00: C0082C1C D7519E60 D7951A40 DA36EC5C 00000000 DA36EC60 D7519E88 40000000
GPR08: 0000003A DA36EBD8 C01CDC13 00000000 003BAE80
Call trace:
 [c0082c1c] sysfs_create_dir+0x48/0x98
 [c00b565c] create_dir+0x28/0x6c
 [c00b5ba0] kobject_add+0xdc/0x194
 [c00dc128] bus_register+0x54/0xa4
 [da32e018] i2c_init+0x18/0xc8 [i2c_core]
 [c0030878] sys_init_module+0x198/0x31c
 [c000595c] ret_from_syscall+0x0/0x44
PHY ID: 4061e4, addr: 0
eth0: Link is up at 100 Mbps, full-duplex.
eth0: Pause is disabled
bus usb: add driver hid
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
hda: Set PIO timing for mode 0, reg: 0x1090032b
Oops: Exception in kernel mode, sig: 4 [#2]
NIP: C025F310 LR: DA330FA0 SP: D65B9ED0 REGS: d65b9e20 TRAP: 0700    Not tainted
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = d6950140[350] 'modprobe' Last syscall: 128
GPR00: C025F310 D65B9ED0 D6950140 00020009 C02BA42C 00000000 00000001 40000000
GPR08: D7D53658 C0290000 00009032 00000000 82022228 1001D4B0 00000000 10016070
GPR16: 00000000 00000000 00000000 00000000 00000000 100011A4 00000000 DA3D0000
GPR24: 00000000 DA3D0000 DA3D0000 DA3D0000 DA3D0000 C02BA42C C02BA6DC DA3D1880
Call trace:
 [c0030878] sys_init_module+0x198/0x31c
 [c000595c] ret_from_syscall+0x0/0x44

--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=sleep_oops

hdb: start_power_step(step: 0)
hdb: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
eth0: suspending, WakeOnLan disabled
Oops: Exception in kernel mode, sig: 4 [#3]
NIP: C025F310 LR: DA32AE88 SP: D6959D90 REGS: d6959ce0 TRAP: 0700    Not tainted
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = d7d100a0[300] 'pmud' Last syscall: 54
GPR00: C025F310 D6959D90 D7D100A0 0002000C C02BC860 00000000 00000000 00000002
GPR08: 00000000 C0290000 00000000 00000000 82004424 1001DF14 00000000 00000000
GPR16: 00000000 00000000 65786563 BFFFF9F8 10000000 BFFFFBC8 BFFFFBB8 BFFFFC48
GPR24: BFFFFAC8 0000036F 00000002 C0230000 00000002 D7FBA400 D78E9228 D78E9000
Call trace:
 [da34c86c] usb_hcd_pci_suspend+0x5c/0x94 [usbcore]
 [c00bd74c] pci_device_suspend+0x48/0x50
 [c00ddb48] suspend_device+0x8c/0xdc
 [c00ddbfc] device_suspend+0x64+0xd4
 [c0280764] 0xc0280764
 [c0280c48] 0xc0280c48
 [c028167c] 0xc028167c
 [c0062c1c] sys_ioctl+0xdc/0x300
 [c000595c] ret_from_syscall+0x0/0x44

--Mjqg7Yu+0hL22rav--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
