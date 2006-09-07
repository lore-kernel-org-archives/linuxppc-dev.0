Return-Path: <olaf@ibook.aepfle.de>
Received: from natblert.rzone.de (natblert.rzone.de [81.169.145.181])
	by ozlabs.org (Postfix) with ESMTP id 0F2A767BB9
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 22:43:06 +1000 (EST)
Date: Thu, 7 Sep 2006 14:42:56 +0200
From: Olaf Hering <olaf@aepfle.de>
To: alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
Subject: oops in snd-powermac due to snd-aoa
Message-ID: <20060907124256.GA22928@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I was playing with snd-aoa, maybe the driver would work on a G4/466.
mv /lib/modules/*/kernel/sound/ppc/snd-powermac.ko .
reboot
$insmod /lib/modules/*/kernel/sound/aoa/*/*.ko
alsamixer finds nothing.
mv snd-powermac.ko /lib/modules/*/kernel/sound/ppc/
$insmod snd-powermac.ko -> oops

Using PowerMac machine description
Total memory = 256MB; using 512kB for hash table (at cff80000)
Linux version 2.6.18-rc5-git6-2-default (geeko@buildhost) (gcc version 4.1.2 20060731 (prerelease) (SUSE Linux)) #1 Fri Sep 1 22:19:04 UTC 2006
Found initrd at 0xc4100000:0xc433b000
Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0x11
Mapped at 0xfdfc0000
Found a Keylargo mac-io controller, rev: 3, mapped at 0xfdf40000
Processor NAP mode on idle enabled.
PowerMac motherboard: PowerMac G4 Silver
Found UniNorth PCI host bridge at 0x00000000f0000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0x00000000f2000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0x00000000f4000000. Firmware bus number: 0->0
via-pmu: Server Mode is disabled
PMU driver v2 initialized for Core99, firmware: 0c
nvram: Checking bank 0...
nvram: gen0=356, gen1=355
nvram: Active bank is: 0
nvram: OF partition at 0x210
nvram: XP partition at 0x1220
nvram: NR partition at 0x1320
Top of RAM: 0x10000000, Total RAM: 0x10000000
Memory hole size: 0MB
On node 0 totalpages: 65536
  DMA zone: 65536 pages, LIFO batch:15
Built 1 zonelists.  Total pages: 65536
Kernel command line: root=/dev/hda13  debug sysrq=1 video=aty128fb:1024x768@85 
mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 4 CPUs
mpic: ISU size: 64, shift: 6, mask: 3f
mpic: Initializing for 64 sources
PID hash table entries: 2048 (order: 11, 8192 bytes)
GMT Delta read from XPRAM: 120 minutes, DST: on
time_init: decrementer frequency = 33.290001 MHz
time_init: processor frequency   = 466.666665 MHz
Console: colour dummy device 80x25
pmac_zilog: i2c-modem detected, id: 1
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
High memory: 0k
Memory: 251904k/262144k available (3584k kernel code, 9896k reserved, 524k data, 452k bss, 192k init)
Calibrating delay loop... 66.30 BogoMIPS (lpj=132608)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
device-tree: Duplicate name in /cpus/PowerPC,G4@0, renamed to "l2-cache#1"
checking if image is initramfs... it is
Freeing initrd memory: 2284k freed
NET: Registered protocol family 16
KeyWest i2c @0xf8001003 irq 42 /uni-n@f8000000/i2c@f8001000
 channel 0 bus <multibus>
 channel 1 bus <multibus>
KeyWest i2c @0x80018000 irq 26 /pci@f2000000/mac-io@17/i2c@18000
 channel 0 bus <multibus>
PMU i2c /pci@f2000000/mac-io@17/via-pmu@16000
 channel 1 bus <multibus>
 channel 2 bus <multibus>
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 4 of device 0001:10:12.0
PCI: Cannot allocate resource region 4 of device 0001:10:12.1
PCI: Cannot allocate resource region 1 of device 0001:10:12.3
PCI: Cannot allocate resource region 0 of device 0001:10:14.0
usbcore: registered new driver usbfs
usbcore: registered new driver hub
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
Thermal assist unit using timers, shrink_timer: 500 jiffies
audit: initializing netlink socket (disabled)
audit(1157631807.756:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Enabling device 0000:00:10.0 (0086 -> 0087)
aty128fb: Invalid ROM signature 1111 should  be 0xaa55
aty128fb: BIOS not located, guessing timings.
aty128fb: Rage128 PF PRO AGP [chip rev 0x1] 16M 128-bit SDR SGRAM (1:1)
Console: switching to colour frame buffer device 128x48
fb0: ATY Rage128 frame buffer device on Rage128 PF PRO AGP
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
ttyS0 at MMIO 0x80013020 (irq = 22) is a Z85c30 ESCC - Internal modem
ttyS1 at MMIO 0x80013000 (irq = 50) is a Z85c30 ESCC - Serial port
RAMDISK driver initialized: 16 RAM disks of 123456K size 1024 blocksize
MacIO PCI driver attached to Keylargo chipset
input: Macintosh mouse button emulation as /class/input/input0
apm_emu: APM Emulation 0.5 initialized.
adb: starting probe task...
adb: finished probe task...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0: Found Apple KeyLargo ATA-4 controller, bus ID 2, irq 19
Probing IDE interface ide0...
hda: Maxtor 33073H3 B, ATA DISK drive
hda: Enabling Ultra DMA 4
ide0 at 0xd1022000-0xd1022007,0xd1022160 on irq 19
ide1: Found Apple KeyLargo ATA-3 controller, bus ID 0, irq 20
Probing IDE interface ide1...
hdc: SONY CD-RW CRX140E, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
hdc: Enabling MultiWord DMA 2
ide1 at 0xd102e000-0xd102e007,0xd102e160 on irq 20
ide2: Found Apple KeyLargo ATA-3 controller, bus ID 1, irq 21
Probing IDE interface ide2...
Probing IDE interface ide2...
hda: max request size: 128KiB
hda: 60032448 sectors (30736 MB) w/2048KiB Cache, CHS=59556/16/63, UDMA(66)
hda: cache flushes not supported
 hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 hda15
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: Enabling device 0001:10:18.0 (0000 -> 0002)
ohci_hcd 0001:10:18.0: OHCI Host Controller
ohci_hcd 0001:10:18.0: new USB bus registered, assigned bus number 1
ohci_hcd 0001:10:18.0: irq 27, io mem 0x80083000
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.18-rc5-git6-2-default ohci_hcd
usb usb1: SerialNumber: 0001:10:18.0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Enabling device 0001:10:19.0 (0000 -> 0002)
ohci_hcd 0001:10:19.0: OHCI Host Controller
ohci_hcd 0001:10:19.0: new USB bus registered, assigned bus number 2
ohci_hcd 0001:10:19.0: irq 28, io mem 0x80082000
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.18-rc5-git6-2-default ohci_hcd
usb usb2: SerialNumber: 0001:10:19.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-1: new full speed USB device using ohci_hcd and address 2
usb 1-1: new device found, idVendor=05ac, idProduct=1001
usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1: Product: Hub in Apple USB Keyboard
usb 1-1: Manufacturer: Alps Electric
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 3 ports detected
usb 1-1.1: new low speed USB device using ohci_hcd and address 3
usb 1-1.1: new device found, idVendor=05ac, idProduct=0202
usb 1-1.1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1.1: Product: Apple USB Keyboard
usb 1-1.1: Manufacturer: Alps Electric
usb 1-1.1: configuration #1 chosen from 1 choice
usb 1-1.2: new low speed USB device using ohci_hcd and address 4
usb 1-1.2: new device found, idVendor=05ac, idProduct=0307
usb 1-1.2: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1.2: Product: Apple Optical USB Mouse
usb 1-1.2: Manufacturer: Logitech
usb 1-1.2: configuration #1 chosen from 1 choice
usbcore: registered new driver hiddev
input: Alps Electric Apple USB Keyboard as /class/input/input1
input: USB HID v1.00 Keyboard [Alps Electric Apple USB Keyboard] on usb-0001:10:18.0-1.1
input: Logitech Apple Optical USB Mouse as /class/input/input2
input: USB HID v1.10 Mouse [Logitech Apple Optical USB Mouse] on usb-0001:10:18.0-1.2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver appletouch
mice: PS/2 mouse device common for all mice
PowerMac i2c bus pmu 2 registered
PowerMac i2c bus pmu 1 registered
PowerMac i2c bus mac-io 0 registered
PowerMac i2c bus uni-n 1 registered
PowerMac i2c bus uni-n 0 registered
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 1
NET: Registered protocol family 17
input: PMU as /class/input/input3
Freeing unused kernel memory: 192k init
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda13, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
JBD: barrier-based sync failed on hda13 - disabling barriers
ide-floppy driver 0.99.newide
hdd: No disk in drive
hdd: 0kB, 0/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
snd_aoa_soundbus: module not supported by Novell, setting U taint flag.
snd_aoa_i2sbus: module not supported by Novell, setting U taint flag.
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.20
JBD: barrier-based sync failed on hda13 - disabling barriers
ieee1394: Initialized config rom entry `ip1394'
PCI: Enabling device 0001:10:12.3 (0090 -> 0093)
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected Apple UniNorth 1.5 chipset
agpgart: configuring for size idx: 4
agpgart: AGP aperture is 16M @ 0x0
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[52]  MMIO=[80084000-800847ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
USB Universal Host Controller Interface driver v3.0
PCI: Enabling device 0001:10:12.0 (0014 -> 0015)
PCI: VIA IRQ fixup for 0001:10:12.0, from 52 to 4
PHY ID: 206053, addr: 0
uhci_hcd 0001:10:12.0: UHCI Host Controller
uhci_hcd 0001:10:12.0: new USB bus registered, assigned bus number 3
uhci_hcd 0001:10:12.0: irq 52, io base 0x00010000
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.18-rc5-git6-2-default uhci_hcd
usb usb3: SerialNumber: 0001:10:12.0
usb usb3: configuration #1 chosen from 1 choice
8139too Fast Ethernet driver 0.9.27
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:30:65:f3:4c:ae 
eth0: Found BCM5401 PHY
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ohci1394: fw-host1: OHCI-1394 1.0 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
PCI: Enabling device 0001:10:12.1 (0014 -> 0015)
PCI: VIA IRQ fixup for 0001:10:12.1, from 52 to 4
uhci_hcd 0001:10:12.1: UHCI Host Controller
uhci_hcd 0001:10:12.1: new USB bus registered, assigned bus number 4
uhci_hcd 0001:10:12.1: irq 52, io base 0x00010020
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.18-rc5-git6-2-default uhci_hcd
usb usb4: SerialNumber: 0001:10:12.1
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011060000006685]
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PCI: Enabling device 0001:10:12.2 (0014 -> 0016)
PCI: VIA IRQ fixup for 0001:10:12.2, from 52 to 4
ehci_hcd 0001:10:12.2: EHCI Host Controller
ehci_hcd 0001:10:12.2: new USB bus registered, assigned bus number 5
ehci_hcd 0001:10:12.2: irq 52, io mem 0x80081000
ehci_hcd 0001:10:12.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: new device found, idVendor=0000, idProduct=0000
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: EHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.18-rc5-git6-2-default ehci_hcd
usb usb5: SerialNumber: 0001:10:12.2
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 4 ports detected
PCI: Enabling device 0001:10:14.0 (0004 -> 0007)
eth1: RealTek RTL8139 at 0xd21f8000, 00:50:fc:76:65:12, IRQ 54
eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[003065fffef34cae]
eth0: Link is up at 100 Mbps, full-duplex.
eth0 renamed to ethxx0
eth1 renamed to eth0
ethxx0 renamed to eth1
Adding 131064k swap on /dev/hda12.  Priority:-1 extents:1 across:131064k
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
JBD: barrier-based sync failed on hda13 - disabling barriers
hdd: No disk in drive
loop: loaded (max 8 devices)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
AppArmor: AppArmor (version 2.0-19.43r6320) initialized
audit(1157631835.404:2): AppArmor (version 2.0-19.43r6320) initialized

eth0: link down
eth1: Link is up at 100 Mbps, full-duplex.
eth1: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ADDRCONF(NETDEV_UP): eth0: link is not ready
IPv6 over IPv4 tunneling driver
[drm] Initialized drm 1.0.1 20051102
[drm] Initialized r128 2.5.0 20030725 on minor 0
agpgart: Putting AGP V2 device at 0000:00:0b.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:00:10.0 into 1x mode
audit(1157631873.282:3): audit_backlog_limit=256 old=64 by auid=4294967295
audit(1157631873.542:4): audit_pid=3895 old=0 by auid=4294967295
snd_aoa: module not supported by Novell, setting U taint flag.
snd_aoa_codec_onyx: module not supported by Novell, setting U taint flag.
snd_aoa_codec_tas: module not supported by Novell, setting U taint flag.
snd-aoa-codec-tas: found 'deq' node
snd-aoa-codec-tas: tas found, addr 0x34 on /pci@f2000000/mac-io@17/i2c@18000/deq
snd_aoa_codec_toonie: module not supported by Novell, setting U taint flag.
snd_aoa_fabric_layout: module not supported by Novell, setting U taint flag.
ALSA sound/ppc/keywest.c:82: tumbler: cannot attach i2c client
read_audio_gpio addr 67 ret 2 av 4
headphone: 0, lineout: 0
check_audio_gpio addr 70 ret 4 av 4
check_audio_gpio addr 6f ret 7 av 4
Unable to handle kernel paging request for data at address 0x00000002
Faulting instruction address: 0xc0244af8
Oops: Kernel access of bad area, sig: 11 [#1]

Modules linked in: snd_powermac snd_aoa_fabric_layout snd_aoa_codec_toonie snd_aoa_codec_tas snd_aoa_codec_onyx snd_aoa snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device r128 drm ipv6 apparmor aamatch_pcre loop dm_mod 8139too mii ehci_hcd uhci_hcd uninorth_agp agpgart sungem sungem_phy ohci1394 ieee1394 ide_cd cdrom snd_aoa_i2sbus snd_aoa_soundbus ide_floppy snd_pcm snd_timer snd soundcore snd_page_alloc
NIP: C0244AF8 LR: D219CC8C CTR: C0244AD8
REGS: c6b69c40 TRAP: 0300   Tainted: G     U  (2.6.18-rc5-git6-2-default)
MSR: 00009032 <EE,ME,IR,DR>  CR: 22222244  XER: 20000000
DAR: 00000002, DSISR: 40000000
TASK = c291d930[4987] 'modprobe' THREAD: c6b68000
GPR00: D219CC8C C6B69CF0 C291D930 00000000 00000001 00000068 00000000 00000001 
GPR08: 00000002 00000000 00000070 C0244AD8 00000000 1002F308 0000000D D2191214 
GPR16: 0000001C D218FBE4 C1000300 D218FBBC 00000163 D218FB94 00000000 0000001E 
GPR24: D218F639 00000000 CD6D40AC CD6D4000 C66E30C0 0000000A D21A3F24 D219E714 
NIP [C0244AF8] i2c_smbus_write_byte_data+0x20/0x44
LR [D219CC8C] send_init_client+0x30/0x8c [snd_powermac]
Call Trace:
[C6B69CF0] [C005B2FC] setup_irq+0x1e4/0x22c (unreliable)
[C6B69D30] [D219CC8C] send_init_client+0x30/0x8c [snd_powermac]
[C6B69D50] [D213BDA8] snd_pmac_tumbler_post_init+0x28/0x6c [snd_powermac]
[C6B69D60] [D213A1F4] snd_pmac_probe+0x19c/0x2f0 [snd_powermac]
[C6B69D90] [C01F2788] platform_drv_probe+0x20/0x30
[C6B69DA0] [C01F0AD0] driver_probe_device+0x8c/0xf4
[C6B69DC0] [C01F0270] bus_for_each_drv+0x50/0x98
[C6B69DF0] [C01F0BAC] device_attach+0x70/0xac
[C6B69E10] [C01EFF24] bus_attach_device+0x24/0x44
[C6B69E20] [C01EEC14] device_add+0x1ec/0x314
[C6B69E50] [C01F2C00] platform_device_add+0x118/0x160
[C6B69E70] [C01F2E78] platform_device_register_simple+0x4c/0x78
[C6B69E90] [D213A038] alsa_card_pmac_init+0x38/0x58 [snd_powermac]
[C6B69EA0] [C004EB14] sys_init_module+0x1368/0x14f8
[C6B69F40] [C00125A4] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xff698a4
    LR = 0x100039d0
Instruction dump:
80010044 38210040 7c0803a6 4e800020 9421ffc0 7c0802a6 7c691b78 7c872378 
38c00000 39000002 90010044 98a10008 <a0a30002> a0890004 39210008 80630008 
 
Module                  Size  Used by
snd_powermac           66448  1 
snd_aoa_fabric_layout    13896  0 
snd_aoa_codec_toonie     3332  0 
snd_aoa_codec_tas      13728  0 
snd_aoa_codec_onyx     15456  0 
snd_aoa                20576  4 snd_aoa_fabric_layout,snd_aoa_codec_toonie,snd_aoa_codec_tas,snd_aoa_codec_onyx
snd_pcm_oss            61216  0 
snd_mixer_oss          21376  1 snd_pcm_oss
snd_seq                67808  0 
snd_seq_device         10028  1 snd_seq
r128                   44772  3 
drm                    80024  4 r128
ipv6                  288972  20 
apparmor               66520  0 
aamatch_pcre           17256  1 apparmor
loop                   20328  0 
dm_mod                 65296  0 
8139too                27936  0 
mii                     6592  1 8139too
ehci_hcd               35560  0 
uhci_hcd               32428  0 
uninorth_agp           10760  1 
agpgart                36924  2 drm,uninorth_agp
sungem                 34500  0 
sungem_phy             10432  1 sungem
ohci1394               39952  0 
ieee1394              114224  1 ohci1394
ide_cd                 47332  0 
cdrom                  43452  1 ide_cd
snd_aoa_i2sbus         23908  0 
snd_aoa_soundbus        7812  2 snd_aoa_fabric_layout,snd_aoa_i2sbus
ide_floppy             21728  0 
snd_pcm                99140  3 snd_powermac,snd_pcm_oss,snd_aoa_i2sbus
snd_timer              28260  2 snd_seq,snd_pcm
snd                    72948  13 snd_powermac,snd_aoa_fabric_layout,snd_aoa_codec_toonie,snd_aoa_codec_tas,snd_aoa_codec_onyx,snd_aoa,snd_pcm_oss,snd_mixer_oss,snd_seq,snd_seq_device,snd_aoa_i2sbus,snd_pcm,snd_timer
soundcore              11012  1 snd
snd_page_alloc         11560  1 snd_pcm
