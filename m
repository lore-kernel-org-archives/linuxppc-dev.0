Return-Path: <rutger@wingding.demon.nl>
Received: from post-24.mail.nl.demon.net (post-24.mail.nl.demon.net
	[194.159.73.194]) by ozlabs.org (Postfix) with ESMTP id 3A60FDDE25
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 07:41:14 +1000 (EST)
Received: from wingding.demon.nl ([82.161.27.36]:44445)
	by post-24.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1ICMhL-00097p-IN
	for linuxppc-dev@ozlabs.org; Sat, 21 Jul 2007 21:41:12 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.63)
	(envelope-from <rutger@wingding.demon.nl>) id 1ICMhH-0003bc-Kr
	for linuxppc-dev@ozlabs.org; Sat, 21 Jul 2007 23:41:07 +0200
Date: Sat, 21 Jul 2007 23:41:07 +0200
From: Rutger Nijlunsing <rutger@nospam.com>
To: linuxppc-dev@ozlabs.org
Subject: 2.6.22-git OOPSes on PCMCIA card insertion on PowerBook G3 Lombard
Message-ID: <20070721214107.GA12278@nospam.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Reply-To: linuxppc-dev@tux.tmfweb.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[    0.000000] Using PowerMac machine description
[    0.000000] Total memory = 320MB; using 1024kB for hash table (at cff00000)
[    0.000000] Linux version 2.6.22-g2e3ee3d4 (rutger@wingding) (gcc version 4.0.2) #24 Sat Jul 21 23:10:03 CEST 2007
[    0.000000] Found a Paddington mac-io controller, rev: 0, mapped at 0xfdf80000
[    0.000000] PowerMac motherboard: PowerBook 101 (Lombard)
[    0.000000] PMU driver v2 initialized for 1999 PowerBook G3, firmware: 0b
[    0.000000] console [udbg0] enabled
[    0.000000] Entering add_active_range(0, 0, 81920) 0 entries of 256 used
[    0.000000] Found Grackle (MPC106) PCI host bridge at 0x0000000080000000. Firmware bus number: 0->0
[    0.000000] nvram: OF partition at 0x140
[    0.000000] nvram: XP partition at 0xffffffff
[    0.000000] nvram: NR partition at 0xffffffff
[    0.000000] Top of RAM: 0x14000000, Total RAM: 0x14000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    81920
[    0.000000]   Normal      81920 ->    81920
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    81920
[    0.000000] On node 0 totalpages: 81920
[    0.000000]   DMA zone: 640 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 81280 pages, LIFO batch:15
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] Built 1 zonelists in Zone order.  Total pages: 81280
[    0.000000] Kernel command line: root=/dev/hda3 ro 
[    0.000000] irq: Found primary Apple PIC /pci@80000000/mac-io@10 for 64 irqs
[    0.000000] irq: System has 64 possible interrupts
[    0.000000] PID hash table entries: 2048 (order: 11, 8192 bytes)
[    0.000000] GMT Delta read from XPRAM: 0 minutes, DST: on
[    0.000000] time_init: decrementer frequency = 16.704100 MHz
[    0.000000] time_init: processor frequency   = 399.999996 MHz
[    0.000359] Console: colour dummy device 80x25
[    0.001232] console handover: boot [udbg0] -> real [tty0]
[    0.004371] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.007763] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.052732] Memory: 319488k/327680k available (3152k kernel code, 7844k reserved, 144k data, 225k bss, 184k init)
[    0.053155] Calibrating delay loop... 33.38 BogoMIPS (lpj=166912)
[    0.250186] Mount-cache hash table entries: 512
[    0.253522] PM: Adding info for No Bus:platform
[    0.254912] NET: Registered protocol family 16
[    0.256926] PM: Adding info for No Bus:vtcon0
[    0.258697] PMU i2c /pci@80000000/mac-io@10/via-pmu@16000
[    0.258738]  channel 1 bus <multibus>
[    0.258750]  channel 2 bus <multibus>
[    0.258918] PCI: Probing PCI hardware
[    0.258980] PM: Adding info for No Bus:pci0000:00
[    0.259376] PCI: Scanning bus 0000:00
[    0.259427] PCI: Found 0000:00:00.0 [1057/0002] 000600 00
[    0.259474] PCI: Calling quirk c001238c for 0000:00:00.0
[    0.259522] PCI: Found 0000:00:0e.0 [11c1/5801] 000c03 00
[    0.259560] PCI: Calling quirk c001238c for 0000:00:0e.0
[    0.259594] PCI: Found 0000:00:0f.0 [123f/8888] 000480 00
[    0.259630] PCI: Calling quirk c001238c for 0000:00:0f.0
[    0.259673] PCI: Found 0000:00:10.0 [106b/0017] 00ff00 00
[    0.259708] PCI: Calling quirk c001238c for 0000:00:10.0
[    0.259736] PCI: Found 0000:00:11.0 [1002/4c49] 000300 00
[    0.259777] PCI: Calling quirk c001238c for 0000:00:11.0
[    0.259806] PCI: Found 0000:00:13.0 [104c/ac1e] 000607 02
[    0.259824] PCI: Calling quirk c001238c for 0000:00:13.0
[    0.259849] PCI: Fixups for bus 0000:00
[    0.260118] PCI: Scanning behind PCI bridge 0000:00:13.0, config 000000, pass 0
[    0.260146] PCI: Scanning behind PCI bridge 0000:00:13.0, config 000000, pass 1
[    0.260573] PCI: Bus scan for 0000:00 returning with max=04
[    0.260618] PM: Adding info for pci:0000:00:00.0
[    0.261064] PM: Adding info for pci:0000:00:0e.0
[    0.261489] PM: Adding info for pci:0000:00:0f.0
[    0.261886] PM: Adding info for pci:0000:00:10.0
[    0.262292] PM: Adding info for pci:0000:00:11.0
[    0.262741] PM: Adding info for pci:0000:00:13.0
[    0.263192] PCI: Cannot allocate resource region 1 of device 0000:00:11.0
[    0.263278]   got res [1000:10ff] bus [1000:10ff] flags 101 for BAR 1 of 0000:00:11.0
[    0.263297] PCI: moved device 0000:00:11.0 resource 1 (101) to 1000
[    0.263366] Registering pmac pic with sysfs...
[    0.263984] PM: Adding info for platform:i2c-powermac.0
[    0.264059] PM: Adding info for platform:i2c-powermac.1
[    0.273229] usbcore: registered new interface driver usbfs
[    0.273639] usbcore: registered new interface driver hub
[    0.274098] usbcore: registered new device driver usb
[    0.276572] PM: Adding info for No Bus:mem
[    0.276929] PM: Adding info for No Bus:kmem
[    0.277269] PM: Adding info for No Bus:null
[    0.277608] PM: Adding info for No Bus:port
[    0.277984] PM: Adding info for No Bus:zero
[    0.278361] PM: Adding info for No Bus:full
[    0.278691] PM: Adding info for No Bus:random
[    0.279016] PM: Adding info for No Bus:urandom
[    0.279343] PM: Adding info for No Bus:kmsg
[    0.279782] NET: Registered protocol family 2
[    0.360162] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.360528] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.361668] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[    0.362255] TCP: Hash tables configured (established 16384 bind 16384)
[    0.362279] TCP reno registered
[    0.390568] Thermal assist unit using timers, shrink_timer: 200 jiffies
[    0.393749] fuse init (API version 7.8)
[    0.393885] PM: Adding info for No Bus:fuse
[    0.394951] io scheduler noop registered
[    0.394988] io scheduler anticipatory registered
[    0.395032] io scheduler deadline registered
[    0.395080] io scheduler cfq registered (default)
[    0.395113] PCI: Calling quirk c001d878 for 0000:00:00.0
[    0.395126] PCI: Calling quirk c011240c for 0000:00:00.0
[    0.395137] PCI: Calling quirk c019720c for 0000:00:00.0
[    0.395150] PCI: Calling quirk c001d878 for 0000:00:0e.0
[    0.395160] PCI: Calling quirk c011240c for 0000:00:0e.0
[    0.395170] PCI: Calling quirk c019720c for 0000:00:0e.0
[    0.395226] PCI: Calling quirk c001d878 for 0000:00:0f.0
[    0.395236] PCI: Calling quirk c011240c for 0000:00:0f.0
[    0.395246] PCI: Calling quirk c019720c for 0000:00:0f.0
[    0.395257] PCI: Calling quirk c001d878 for 0000:00:10.0
[    0.395267] PCI: Calling quirk c011240c for 0000:00:10.0
[    0.395277] PCI: Calling quirk c019720c for 0000:00:10.0
[    0.395288] PCI: Calling quirk c001d878 for 0000:00:11.0
[    0.395298] PCI: Calling quirk c011240c for 0000:00:11.0
[    0.395308] PCI: Calling quirk c019720c for 0000:00:11.0
[    0.395319] PCI: Calling quirk c001d878 for 0000:00:13.0
[    0.395328] PCI: Calling quirk c001d9fc for 0000:00:13.0
[    0.395347] PCI: Calling quirk c011240c for 0000:00:13.0
[    0.395358] PCI: Calling quirk c019720c for 0000:00:13.0
[    0.395462] PM: Adding info for No Bus:fbcon
[    0.396239] PCI: Enabling device 0000:00:11.0 (0086 -> 0087)
[    0.396328] atyfb: using auxiliary register aperture
[    0.396897] atyfb: 3D RAGE LT PRO (Mach64 LI, PCI) [0x4c49 rev 0xdc]
[    0.396955] atyfb: 8M SDRAM (1:1), 29.498928 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK, 100 MHz XCLK
[    0.397531] atyfb: monitor sense=62b, mode 6
[    0.397664] PM: Adding info for No Bus:fb0
[    0.398349] PM: Adding info for No Bus:vtcon1
[    0.461667] Console: switching to colour frame buffer device 128x48
[    0.481139] atyfb: fb0: ATY Mach64 frame buffer device on PCI
[    0.482757] PM: Adding info for No Bus:tty
[    0.483169] PM: Adding info for No Bus:console
[    0.483514] PM: Adding info for No Bus:ptmx
[    0.483852] PM: Adding info for No Bus:tty0
[    0.484459] PM: Adding info for No Bus:vcs
[    0.484802] PM: Adding info for No Bus:vcsa
[    0.485166] PM: Adding info for No Bus:tty1
... (all 200 or so pty/tty lines deleted) ...
[    0.770598] PM: Adding info for No Bus:ttyef
[    0.771150] PM: Adding info for No Bus:apm_bios
[    0.771485] Macintosh non-volatile memory driver v1.1
[    0.771794] PM: Adding info for No Bus:nvram
[    0.772143] pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
[    0.772588] pmac_zilog: serial modem detected
[    0.772935] ttyS0 at MMIO 0x80813020 (irq = 16) is a Z85c30 ESCC - Internal modem
[    0.773588] PM: Adding info for No Bus:ttyS0
[    0.773983] ttyS1 at MMIO 0x80813000 (irq = 17) is a Z85c30 ESCC - Infrared port
[    0.774652] PM: Adding info for No Bus:ttyS1
[    0.775759] PM: Adding info for No Bus:lo
[    0.776186] netconsole: not configured, aborting
[    0.776813] MacIO PCI driver attached to Paddington chipset
[    0.777162] PM: Adding info for macio:0.80800000:mac-io
[    0.777719] PM: Adding info for macio:0.00000010:interrup
[    0.778252] PM: Adding info for macio:0.00013000:escc
[    0.778903] PM: Adding info for macio:0.00014000:davbus
[    0.779379] Can't request resource 0 for MacIO device 0.00000000:power-mg
[    0.779728] PM: Adding info for macio:0.00000000:power-mg
[    0.780339] PM: Adding info for macio:0.00016000:via-pmu
[    0.781001] PM: Adding info for macio:0.00020000:ata-3
[    0.781645] PM: Adding info for macio:0.00000034:media-ba
[    0.782246] PM: Adding info for macio:0.00010000:scsi
[    0.782894] PM: Adding info for macio:0.00011000:ethernet
[    1.331839] PM: Adding info for No Bus:eth0
[    1.332385] eth0: BMAC+ at 00:50:e4:d0:79:4e
[    1.332974] PM: Adding info for macio:0.00015000:fdc
[    1.333632] PM: Adding info for macio:0.00021000:ata-3
[    1.334299] PM: Adding info for macio:0.00013020:ch-a
[    1.335006] PM: Adding info for macio:0.00013000:ch-b
[    1.335954] mediabay0: Registered Heathrow media-bay
[    1.336216] mediabay0: powering down
[    1.580272] PM: Adding info for No Bus:input0
[    1.580718] input: Macintosh mouse button emulation as /class/input/input0
[    1.581163] PM: Adding info for No Bus:pmu
[    1.582042] pmubl: Backlight initialized (pmubl)
[    1.582322] apm_emu: PMU APM Emulation initialized.
[    1.583153] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    1.583455] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    1.584097] adb: starting probe task...
[    2.610023] ide0: Found Apple Heathrow ATA controller, bus ID 0, irq 25
[    2.610369] Probing IDE interface ide0...
[    2.910195] hda: IBM-DBCA-206480, ATA DISK drive
[    2.910489] PM: Adding info for No Bus:ide0
[    3.630028] hda: selected mode 0x22
[    3.630052] hda: Enabling MultiWord DMA 2
[    3.631462] ide0 at 0xd5012000-0xd5012007,0xd5012160 on irq 25
[    3.631810] PM: Adding info for ide:0.0
[    3.632665] ide1: Found Apple Heathrow ATA controller, bus ID 1 (mediabay), irq 36
[    3.643858] hda: max request size: 128KiB
[    3.729562] adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
[    3.754885] ADB keyboard at 2, handler 1
[    3.764529] Detected ADB keyboard, type ISO, swapping keys.
[    3.774425] PM: Adding info for No Bus:input1
[    3.774870] input: ADB keyboard as /class/input/input1
[    3.785009] PM: Adding info for No Bus:input2
[    3.785502] input: ADB Powerbook buttons as /class/input/input2
[    3.805439] ADB mouse at 3, handler set to 4 (trackpad)
[    3.871226] PM: Adding info for No Bus:input3
[    3.871665] input: ADB mouse as /class/input/input3
[    3.881528] adb: finished probe task...
[    4.017305] hda: 12685680 sectors (6495 MB) w/420KiB Cache, CHS=13424/15/63, (U)DMA
[    4.027135] hda: cache flushes not supported
[    4.036920]  hda: [mac] hda1 hda2 hda3 hda4
[    4.083810] PM: Adding info for No Bus:usbmon0
[    4.084128] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[    4.084852] ohci_hcd 0000:00:0e.0: OHCI Host Controller
[    4.095169] PM: Adding info for No Bus:usbmon1
[    4.095513] ohci_hcd 0000:00:0e.0: new USB bus registered, assigned bus number 1
[    4.105335] ohci_hcd 0000:00:0e.0: irq 28, io mem 0x80882000
[    4.189364] PM: Adding info for usb:usb1
[    4.190439] PM: Adding info for No Bus:usbdev1.1_ep00
[    4.190850] usb usb1: configuration #1 chosen from 1 choice
[    4.200771] PM: Adding info for usb:1-0:1.0
[    4.201244] hub 1-0:1.0: USB hub found
[    4.211222] hub 1-0:1.0: 2 ports detected
[    4.330163] PM: Adding info for No Bus:usbdev1.1_ep81
[    4.950165] usbcore: registered new interface driver libusual
[    4.960146] PM: Adding info for No Bus:mice
[    4.960582] PM: Adding info for No Bus:mouse0
[    4.960983] PM: Adding info for No Bus:mouse1
[    4.961349] PM: Adding info for No Bus:psaux
[    4.961643] mice: PS/2 mouse device common for all mice
[    4.971624] PM: Adding info for No Bus:event0
[    4.972044] PM: Adding info for No Bus:event1
[    4.972394] PM: Adding info for No Bus:event2
[    4.972766] PM: Adding info for No Bus:event3
[    4.973134] PM: Adding info for No Bus:ts0
[    4.973489] PM: Adding info for No Bus:ts1
[    4.973783] i2c /dev entries driver
[    4.984627] PM: Adding info for No Bus:i2c-0
[    4.984996] PM: Adding info for No Bus:i2c-0
[    4.985324] PowerMac i2c bus pmu 2 registered
[    4.995327] PM: Adding info for No Bus:i2c-1
[    4.995804] PM: Adding info for No Bus:i2c-1
[    4.996128] PowerMac i2c bus pmu 1 registered
[    5.006199] Advanced Linux Sound Architecture Driver Version 1.0.14 (Thu May 31 09:03:25 2007 UTC).
[    5.016263] PM: Adding info for No Bus:timer
[    5.016763] PM: Adding info for No Bus:sequencer
[    5.017129] PM: Adding info for No Bus:sequencer2
[    5.017901] PM: Adding info for No Bus:seq
[    5.018664] PM: Adding info for platform:snd_powermac
[    5.968107] PM: Adding info for No Bus:input4
[    5.968590] input: PowerMac Beep as /class/input/input4
[    5.978558] PM: Adding info for No Bus:event4
[    5.979020] PM: Adding info for No Bus:pcmC0D0p
[    5.979425] PM: Adding info for No Bus:pcmC0D0c
[    5.979841] PM: Adding info for No Bus:dsp
[    5.980286] PM: Adding info for No Bus:audio
[    5.980696] PM: Adding info for No Bus:controlC0
[    5.981167] PM: Adding info for No Bus:mixer
[    5.982459] ALSA device list:
[    5.992260]   #0: PowerMac Screamer [PBG3] Rev 0
[    6.002110] TCP cubic registered
[    6.011717] NET: Registered protocol family 1
[    6.089573] kjournald starting.  Commit interval 5 seconds
[    6.099240] EXT3-fs: mounted filesystem with ordered data mode.
[    6.108898] VFS: Mounted root (ext3 filesystem) readonly.
[    6.118550] Freeing unused kernel memory: 184k init
[    6.184978] PM: Adding info for No Bus:vcs1
[    6.231732] PM: Adding info for No Bus:vcsa1
[   21.952294] PCI: Enabling device 0000:00:13.0 (0000 -> 0002)
[   21.962203] Yenta: CardBus bridge found at 0000:00:13.0 [0000:0000]
[   21.972074] PCI: Bus 1, cardbus bridge: 0000:00:13.0
[   21.981771]   IO window: 00001400-000015ff
[   21.991428]   IO window: 00001800-000019ff
[   22.000910]   PREFETCH window: 80000000-803fffff
[   22.010270]   MEM window: 80400000-807fffff
[   22.019463] Yenta: Enabling burst memory read transactions
[   22.028649] Yenta: Using CSCINT to route CSC interrupts to PCI
[   22.037785] Yenta: Routing CardBus interrupts to PCI
[   22.046920] Yenta TI: socket 0000:00:13.0, mfunc 0x00000002, devctl 0x60
[   22.160069] Yenta: ISA IRQ mask 0x0000, PCI irq 22
[   22.169278] Socket status: 30000086
[   22.178373] pcmcia: parent PCI bridge I/O window: 0x0 - 0x7fffff
[   22.187572] pcmcia: parent PCI bridge Memory window: 0x80000000 - 0xfcffffff
[   22.196762] pcmcia: parent PCI bridge Memory window: 0xfd000000 - 0xfdffffff
[   22.206139] PM: Adding info for No Bus:pcmcia_socket0
[   24.711843] PM: Adding info for No Bus:vcs2
[   24.721627] PM: Adding info for No Bus:vcsa2
[   24.736384] PM: Removing info for No Bus:vcs2
[   24.739836] PM: Removing info for No Bus:vcsa2
[   24.747574] PM: Adding info for No Bus:vcs3
[   24.750694] PM: Adding info for No Bus:vcsa3
[   24.759518] PM: Removing info for No Bus:vcs3
[   24.761042] PM: Removing info for No Bus:vcsa3
[   24.766645] PM: Adding info for No Bus:vcs4
[   24.816559] PM: Adding info for No Bus:vcsa4
[   24.831416] PM: Removing info for No Bus:vcs4
[   24.840354] PM: Removing info for No Bus:vcsa4
[   24.847886] PM: Adding info for No Bus:vcs5
[   24.850870] PM: Adding info for No Bus:vcsa5
[   24.859671] PM: Removing info for No Bus:vcs5
[   24.870823] PM: Removing info for No Bus:vcsa5
[   24.876255] PM: Adding info for No Bus:vcs6
[   24.879862] PM: Adding info for No Bus:vcsa6
[   24.888828] PM: Removing info for No Bus:vcs6
[   24.890582] PM: Removing info for No Bus:vcsa6
[   25.618010] Adding 296900k swap on /dev/hda4.  Priority:-1 extents:1 across:296900k
[   26.316196] EXT3 FS on hda3, internal journal
[   28.106720] loop: module loaded
[   33.507736] phy registers:
[   33.507767]  0800 7849 2000 5c10 01e1 45e1 0007 2801
[   33.518133]  0000 0000 0000 0000 0000 0000 0000 0000
[   33.528494]  2002 0000 0000 0000 0001 0000 0020 0000
[   33.538855]  0000 0000 0180 0100 0006 0f00 0000 0000
[   35.169864] NET: Registered protocol family 17
[   35.950906] PM: Adding info for No Bus:vcs2
[   35.960705] PM: Adding info for No Bus:vcsa2
[   36.028044] PM: Removing info for No Bus:vcs2
[   36.030836] PM: Removing info for No Bus:vcsa2
[   36.057460] PM: Adding info for No Bus:vcs3
[   36.067216] PM: Adding info for No Bus:vcsa3
[   36.134593] PM: Removing info for No Bus:vcs3
[   36.138065] PM: Removing info for No Bus:vcsa3
[   36.163992] PM: Adding info for No Bus:vcs4
[   36.173717] PM: Adding info for No Bus:vcsa4
[   36.241096] PM: Removing info for No Bus:vcs4
[   36.249961] PM: Removing info for No Bus:vcsa4
[   36.270522] PM: Adding info for No Bus:vcs5
[   36.280277] PM: Adding info for No Bus:vcsa5
[   36.347476] PM: Removing info for No Bus:vcs5
[   36.350471] PM: Removing info for No Bus:vcsa5
[   36.416034] PM: Adding info for No Bus:vcs2
[   36.425751] PM: Adding info for No Bus:vcsa2
[   36.493100] PM: Removing info for No Bus:vcs2
[   36.496571] PM: Removing info for No Bus:vcsa2
[   36.522725] PM: Adding info for No Bus:vcs3
[   36.532635] PM: Adding info for No Bus:vcsa3
[   36.599901] PM: Removing info for No Bus:vcs3
[   36.603422] PM: Removing info for No Bus:vcsa3
[   36.630374] PM: Adding info for No Bus:vcs4
[   36.640063] PM: Adding info for No Bus:vcsa4
[   36.712159] PM: Removing info for No Bus:vcs4
[   36.715625] PM: Removing info for No Bus:vcsa4
[   36.738320] PM: Adding info for No Bus:vcs5
[   36.741868] PM: Adding info for No Bus:vcsa5
[   36.815380] PM: Removing info for No Bus:vcs5
[   36.818857] PM: Removing info for No Bus:vcsa5
[   36.845067] PM: Adding info for No Bus:vcs6
[   36.854792] PM: Adding info for No Bus:vcsa6
[   36.922330] PM: Removing info for No Bus:vcs6
[   36.925803] PM: Removing info for No Bus:vcsa6
[   46.843286] tsdev (compaq touchscreen emulation) is scheduled for removal.
[   46.843312] See Documentation/feature-removal-schedule.txt for details.
[   46.914937] tsdev (compaq touchscreen emulation) is scheduled for removal.
[   46.914963] See Documentation/feature-removal-schedule.txt for details.
[   58.165735] PM: Adding info for No Bus:vcs3
[   58.170123] PM: Adding info for No Bus:vcsa3
[   58.176554] PM: Adding info for No Bus:vcs4
[   58.180472] PM: Adding info for No Bus:vcsa4
[   58.207871] PM: Adding info for No Bus:vcs6
[   58.218027] PM: Adding info for No Bus:vcsa6
[   58.230146] PM: Adding info for No Bus:vcs5
[   58.241753] PM: Adding info for No Bus:vcs2
[   58.246045] PM: Adding info for No Bus:vcsa2
[   58.254265] PM: Adding info for No Bus:vcsa5
*inserting PCMCIA card here*
[ 1245.750028] pccard: PCMCIA card inserted into slot 0
[ 1245.751674] cs: memory probe 0x80000000-0xfcffffff: excluding 0x80000000-0x81ffffff
[ 1246.001143] cs: memory probe 0xfd000000-0xfdffffff:Machine check in kernel mode.
[ 1246.002530] Caused by (from SRR1=49030): Transfer error ack signal
[ 1246.004242] Oops: Machine check, sig: 7 [#1]
[ 1246.004578] PowerMac
[ 1246.004697] Modules linked in: af_packet loop pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core
[ 1246.005219] NIP: d50381e4 LR: d50381b8 CTR: c00124d8
[ 1246.005447] REGS: d3a1fc90 TRAP: 0200   Not tainted  (2.6.22-g2e3ee3d4)
[ 1246.005727] MSR: 00049030 <EE,ME,IR,DR>  CR: 82004024  XER: 00000000
[ 1246.006113] TASK = d3f2b1c0[1645] 'pccardd' THREAD: d3a1e000
[ 1246.006334] GPR00: 000000ff d3a1fd40 d3f2b1c0 00000000 d502a014 00000070 00000002 d3a1fd99 
[ 1246.006808] GPR08: d5029000 d5028000 d5028000 00001000 22000022 00000000 d5030000 00080000 
[ 1246.007284] GPR16: 00200000 00000002 d3fda9c0 01000000 fd000000 d3fda9c0 fd000000 000004fb 
[ 1246.007759] GPR24: 00000002 d3a1fd99 00000021 c07bdc28 00000000 00000000 00000002 d3a1fd99 
[ 1246.008263] NIP [d50381e4] pcmcia_read_cis_mem+0x1e4/0x2d8 [pcmcia_core]
[ 1246.008631] LR [d50381b8] pcmcia_read_cis_mem+0x1b8/0x2d8 [pcmcia_core]
[ 1246.008948] Call Trace:
[ 1246.009079] [d3a1fd40] [d50381b8] pcmcia_read_cis_mem+0x1b8/0x2d8 [pcmcia_core] (unreliable)
[ 1246.009492] [d3a1fd70] [d5038440] read_cis_cache+0x168/0x16c [pcmcia_core]
[ 1246.009826] [d3a1fd90] [d50385e8] pccard_get_next_tuple+0x100/0x48c [pcmcia_core]
[ 1246.010250] [d3a1fdd0] [d5038a0c] pccard_get_first_tuple+0x98/0x144 [pcmcia_core]
[ 1246.010615] [d3a1fe00] [d5038c10] pccard_validate_cis+0xa0/0x234 [pcmcia_core]
[ 1246.010963] [d3a1fe30] [d502d084] readable+0x4c/0xa0 [rsrc_nonstatic]
[ 1246.011283] [d3a1fe50] [d502e3f0] pcmcia_nonstatic_validate_mem+0x360/0x3d8 [rsrc_nonstatic]
[ 1246.011664] [d3a1fec0] [d5039174] pcmcia_validate_mem+0x28/0x40 [pcmcia_core]
[ 1246.012017] [d3a1fed0] [d5062ec4] pcmcia_card_add+0x24/0x16c [pcmcia]
[ 1246.012356] [d3a1ff40] [d50631d8] ds_event+0xd4/0x100 [pcmcia]
[ 1246.012649] [d3a1ff60] [d50357bc] send_event+0xbc/0xf0 [pcmcia_core]
[ 1246.012982] [d3a1ff80] [d5035a6c] socket_insert+0xe0/0x188 [pcmcia_core]
[ 1246.013307] [d3a1ff90] [d50365f0] pccardd+0x278/0x2c8 [pcmcia_core]
[ 1246.013620] [d3a1ffd0] [c0046900] kthread+0x84/0x8c
[ 1246.013882] [d3a1fff0] [c0011434] kernel_thread+0x44/0x60
[ 1246.014167] Instruction dump:
[ 1246.014329] 4bffe831 7c691b79 41820104 817b00ec 380bffff 7d095a14 7fa30038 7d491a14 
[ 1246.014772] 7f885000 41beffc4 7c0004ac 7c0918ae <0c000000> 4c00012c 34beffff 981f0000 

(.config attached)

Help?

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.22
# Sat Jul 21 23:02:35 2007
#
# CONFIG_PPC64 is not set

#
# Processor support
#
CONFIG_6xx=y
# CONFIG_PPC_85xx is not set
# CONFIG_PPC_8xx is not set
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_E200 is not set
CONFIG_PPC_FPU=y
# CONFIG_ALTIVEC is not set
CONFIG_PPC_STD_MMU=y
CONFIG_PPC_STD_MMU_32=y
# CONFIG_PPC_MM_SLICES is not set
# CONFIG_SMP is not set
CONFIG_PPC32=y
CONFIG_PPC_MERGE=y
CONFIG_MMU=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_IRQ_PER_CPU=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_ARCH_HAS_ILOG2_U32=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
CONFIG_PPC=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_NVRAM=y
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_PPC_OF=y
# CONFIG_PPC_UDBG_16550 is not set
# CONFIG_GENERIC_TBSYNC is not set
CONFIG_AUDIT_ARCH=y
CONFIG_GENERIC_BUG=y
CONFIG_SYS_SUPPORTS_APM_EMULATION=y
# CONFIG_DEFAULT_UIMAGE is not set
# CONFIG_PPC_DCR_NATIVE is not set
# CONFIG_PPC_DCR_MMIO is not set
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
# CONFIG_TASK_XACCT is not set
# CONFIG_USER_NS is not set
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_SYSFS_DEPRECATED=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
# CONFIG_EMBEDDED is not set
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_ANON_INODES=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_BLOCK=y
# CONFIG_LBD is not set
CONFIG_BLK_DEV_IO_TRACE=y
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"

#
# Platform support
#
CONFIG_PPC_MULTIPLATFORM=y
# CONFIG_EMBEDDED6xx is not set
# CONFIG_PPC_82xx is not set
# CONFIG_PPC_83xx is not set
# CONFIG_PPC_86xx is not set
CONFIG_CLASSIC32=y
# CONFIG_PPC_CHRP is not set
# CONFIG_PPC_MPC52xx is not set
# CONFIG_PPC_MPC5200 is not set
# CONFIG_PPC_EFIKA is not set
# CONFIG_PPC_LITE5200 is not set
CONFIG_PPC_PMAC=y
# CONFIG_PPC_CELL is not set
# CONFIG_PPC_CELL_NATIVE is not set
# CONFIG_PQ2ADS is not set
CONFIG_PPC_NATIVE=y
CONFIG_MPIC=y
# CONFIG_MPIC_WEIRD is not set
# CONFIG_PPC_I8259 is not set
# CONFIG_PPC_RTAS is not set
# CONFIG_MMIO_NVRAM is not set
CONFIG_PPC_MPC106=y
# CONFIG_PPC_970_NAP is not set
# CONFIG_PPC_INDIRECT_IO is not set
# CONFIG_GENERIC_IOMAP is not set
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
CONFIG_CPU_FREQ_DEBUG=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

#
# CPU Frequency drivers
#
CONFIG_CPU_FREQ_PMAC=y
# CONFIG_PPC601_SYNC_FIX is not set
CONFIG_TAU=y
# CONFIG_TAU_INT is not set
# CONFIG_TAU_AVERAGE is not set
# CONFIG_CPM2 is not set

#
# Kernel options
#
# CONFIG_HIGHMEM is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
# CONFIG_KEXEC is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_RESOURCES_64BIT=y
CONFIG_ZONE_DMA_FLAG=1
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_PROC_DEVICETREE=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_PM=y
CONFIG_PM_LEGACY=y
CONFIG_PM_DEBUG=y
# CONFIG_DISABLE_CONSOLE_SUSPEND is not set
# CONFIG_SOFTWARE_SUSPEND is not set
CONFIG_APM_EMULATION=y
# CONFIG_SECCOMP is not set
# CONFIG_WANT_DEVICE_TREE is not set
CONFIG_ISA_DMA_API=y

#
# Bus options
#
CONFIG_ZONE_DMA=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_PPC_INDIRECT_PCI=y
# CONFIG_PPC_INDIRECT_PCI_BE is not set
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_SYSCALL=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_ARCH_SUPPORTS_MSI=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_DEBUG=y

#
# PCCARD (PCMCIA/CardBus) support
#
CONFIG_PCCARD=m
CONFIG_PCMCIA_DEBUG=y
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_PCMCIA_IOCTL=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
CONFIG_PD6729=m
# CONFIG_I82092 is not set
CONFIG_PCCARD_NONSTATIC=m
# CONFIG_HOTPLUG_PCI is not set

#
# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set

#
# Default settings for advanced configuration options are used
#
CONFIG_HIGHMEM_START=0xfe000000
CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_KERNEL_START=0xc0000000
CONFIG_TASK_SIZE=0x80000000
CONFIG_BOOT_LOAD=0x00800000

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NF_CONNTRACK_ENABLED=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_CT_ACCT=y
# CONFIG_NF_CONNTRACK_MARK is not set
# CONFIG_NF_CONNTRACK_EVENTS is not set
# CONFIG_NF_CT_PROTO_SCTP is not set
# CONFIG_NF_CT_PROTO_UDPLITE is not set
# CONFIG_NF_CONNTRACK_AMANDA is not set
# CONFIG_NF_CONNTRACK_FTP is not set
# CONFIG_NF_CONNTRACK_H323 is not set
# CONFIG_NF_CONNTRACK_IRC is not set
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
# CONFIG_NF_CONNTRACK_PPTP is not set
# CONFIG_NF_CONNTRACK_SANE is not set
# CONFIG_NF_CONNTRACK_SIP is not set
# CONFIG_NF_CONNTRACK_TFTP is not set
# CONFIG_NF_CT_NETLINK is not set
CONFIG_NETFILTER_XTABLES=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
# CONFIG_NETFILTER_XT_TARGET_CONNMARK is not set
# CONFIG_NETFILTER_XT_TARGET_DSCP is not set
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
# CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
# CONFIG_NETFILTER_XT_TARGET_TRACE is not set
# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNBYTES is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNMARK is not set
# CONFIG_NETFILTER_XT_MATCH_CONNTRACK is not set
# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
# CONFIG_NETFILTER_XT_MATCH_ESP is not set
# CONFIG_NETFILTER_XT_MATCH_HELPER is not set
# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
CONFIG_NETFILTER_XT_MATCH_MAC=m
# CONFIG_NETFILTER_XT_MATCH_MARK is not set
# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
# CONFIG_NETFILTER_XT_MATCH_REALM is not set
# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
# CONFIG_NETFILTER_XT_MATCH_STATE is not set
# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set

#
# IP: Netfilter Configuration
#
# CONFIG_NF_CONNTRACK_IPV4 is not set
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_TOS is not set
# CONFIG_IP_NF_TARGET_ECN is not set
# CONFIG_IP_NF_TARGET_TTL is not set
CONFIG_IP_NF_RAW=m
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set

#
# Wireless
#
CONFIG_CFG80211=m
CONFIG_WIRELESS_EXT=y
# CONFIG_MAC80211 is not set
CONFIG_IEEE80211=m
# CONFIG_IEEE80211_DEBUG is not set
CONFIG_IEEE80211_CRYPT_WEP=m
CONFIG_IEEE80211_CRYPT_CCMP=m
CONFIG_IEEE80211_CRYPT_TKIP=m
CONFIG_IEEE80211_SOFTMAC=m
# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
CONFIG_CONNECTOR=m
# CONFIG_MTD is not set
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_FD is not set
# CONFIG_MAC_FLOPPY is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=65536
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_MISC_DEVICES=y
# CONFIG_PHANTOM is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_DELKIN=m
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_IDEPCI_PCIBUS_ORDER=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SL82C105 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_TC86C001 is not set
CONFIG_BLK_DEV_IDE_PMAC=y
# CONFIG_BLK_DEV_IDE_PMAC_ATA100FIRST is not set
CONFIG_BLK_DEV_IDEDMA_PMAC=y
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=m
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_TGT is not set
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set
CONFIG_SCSI_WAIT_SCAN=m

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
# CONFIG_SCSI_SAS_LIBSAS_DEBUG is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_MESH is not set
# CONFIG_SCSI_MAC53C94 is not set
# CONFIG_SCSI_SRP is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set
# CONFIG_ATA is not set
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_IEEE1394 is not set
# CONFIG_I2O is not set
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_ADB=y
CONFIG_ADB_CUDA=y
CONFIG_ADB_PMU=y
CONFIG_ADB_PMU_LED=y
CONFIG_ADB_PMU_LED_IDE=y
CONFIG_PMAC_APM_EMU=y
CONFIG_PMAC_MEDIABAY=y
CONFIG_PMAC_BACKLIGHT=y
CONFIG_PMAC_BACKLIGHT_LEGACY=y
CONFIG_INPUT_ADBHID=y
CONFIG_MAC_EMUMOUSEBTN=y
# CONFIG_THERM_WINDTUNNEL is not set
CONFIG_THERM_ADT746X=m
CONFIG_WINDFARM=m
CONFIG_ANSLCD=y
# CONFIG_PMAC_RACKMETER is not set
CONFIG_NETDEVICES=y
# CONFIG_NETDEVICES_MULTIQUEUE is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_ARCNET is not set
CONFIG_PHYLIB=m

#
# MII PHY device drivers
#
CONFIG_MARVELL_PHY=m
CONFIG_DAVICOM_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_LXT_PHY=m
CONFIG_CICADA_PHY=m
CONFIG_VITESSE_PHY=m
CONFIG_SMSC_PHY=m
CONFIG_BROADCOM_PHY=m
# CONFIG_ICPLUS_PHY is not set
CONFIG_FIXED_PHY=m
# CONFIG_FIXED_MII_10_FDX is not set
CONFIG_FIXED_MII_100_FDX=y
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_MACE=m
# CONFIG_MACE_AAUI_PORT is not set
CONFIG_BMAC=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_TYPHOON=m
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_NET_PCI is not set
# CONFIG_NETDEV_1000 is not set
# CONFIG_NETDEV_10000 is not set
# CONFIG_TR is not set

#
# Wireless LAN
#
# CONFIG_WLAN_PRE80211 is not set
CONFIG_WLAN_80211=y
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_LIBERTAS is not set
# CONFIG_AIRO is not set
CONFIG_HERMES=m
# CONFIG_APPLE_AIRPORT is not set
# CONFIG_PLX_HERMES is not set
# CONFIG_TMD_HERMES is not set
# CONFIG_NORTEL_HERMES is not set
CONFIG_PCI_HERMES=m
# CONFIG_ATMEL is not set
# CONFIG_PCMCIA_HERMES is not set
# CONFIG_PCMCIA_SPECTRUM is not set
# CONFIG_AIRO_CS is not set
# CONFIG_PCMCIA_WL3501 is not set
# CONFIG_PRISM54 is not set
# CONFIG_USB_ZD1201 is not set
CONFIG_HOSTAP=m
CONFIG_HOSTAP_FIRMWARE=y
# CONFIG_HOSTAP_FIRMWARE_NVRAM is not set
# CONFIG_HOSTAP_PLX is not set
# CONFIG_HOSTAP_PCI is not set
CONFIG_HOSTAP_CS=m
# CONFIG_BCM43XX is not set
# CONFIG_ZD1211RW is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET_MII is not set
# CONFIG_USB_USBNET is not set
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_PCMCIA_AXNET=m
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
CONFIG_NETCONSOLE=y
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_ISDN is not set
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_TSDEV=y
CONFIG_INPUT_TSDEV_SCREEN_X=1024
CONFIG_INPUT_TSDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ATKBD is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_ATI_REMOTE is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_POWERMATE is not set
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_UINPUT=m

#
# Hardware I/O ports
#
CONFIG_SERIO=y
# CONFIG_SERIO_I8042 is not set
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=m
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_COMPUTONE=m
CONFIG_ROCKETPORT=m
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_DIGIEPCA=m
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
# CONFIG_MOXA_SMARTIO_NEW is not set
# CONFIG_ISI is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
# CONFIG_SYNCLINK_GT is not set
CONFIG_N_HDLC=m
CONFIG_RISCOM8=m
CONFIG_SPECIALIX=m
# CONFIG_SPECIALIX_RTSCTS is not set
CONFIG_SX=m
CONFIG_RIO=m
CONFIG_RIO_OLDPCI=y
CONFIG_STALDRV=y
CONFIG_STALLION=m
CONFIG_ISTALLION=m

#
# Serial drivers
#
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_PCI=m
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_NR_UARTS=48
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_PMACZILOG=y
# CONFIG_SERIAL_PMACZILOG_CONSOLE is not set
CONFIG_SERIAL_JSM=m
CONFIG_SERIAL_OF_PLATFORM=m
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_IPMI_HANDLER is not set
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
CONFIG_WDTPCI=m
CONFIG_WDT_501_PCI=y

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_HW_RANDOM=y
CONFIG_NVRAM=y
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_AGP is not set
CONFIG_DRM=m
# CONFIG_DRM_TDFX is not set
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
CONFIG_RAW_DRIVER=m
CONFIG_MAX_RAW_DEVS=256
# CONFIG_TCG_TPM is not set
CONFIG_DEVPORT=y
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_POWERMAC=y
# CONFIG_I2C_MPC is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_TINY_USB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_DS1682 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_M41T00 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set

#
# Multifunction device drivers
#
CONFIG_MFD_SM501=m

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DVB_CORE is not set
# CONFIG_DAB is not set

#
# Graphics support
#
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_LCD_CLASS_DEVICE=y

#
# Display device support
#
CONFIG_DISPLAY_SUPPORT=m

#
# Display hardware drivers
#
# CONFIG_VGASTATE is not set
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
# CONFIG_FB_DDC is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_SYS_FILLRECT is not set
# CONFIG_FB_SYS_COPYAREA is not set
# CONFIG_FB_SYS_IMAGEBLIT is not set
# CONFIG_FB_SYS_FOPS is not set
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_SVGALIB is not set
CONFIG_FB_MACMODES=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_OF=y
CONFIG_FB_CONTROL=y
CONFIG_FB_PLATINUM=y
CONFIG_FB_VALKYRIE=y
# CONFIG_FB_CT65550 is not set
CONFIG_FB_ASILIANT=y
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GENERIC_LCD=y
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_BACKLIGHT=y
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
# CONFIG_VGA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_LOGO is not set

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# ALSA PowerMac devices
#
CONFIG_SND_POWERMAC=y
CONFIG_SND_POWERMAC_AUTO_DRC=y

#
# Apple Onboard Audio driver
#
# CONFIG_SND_AOA is not set
# CONFIG_SND_AOA_SOUNDBUS is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SND_USB_CAIAQ is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_PDAUDIOCF is not set

#
# System on Chip audio support
#
# CONFIG_SND_SOC is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
# CONFIG_HID_DEBUG is not set

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT_POWERBOOK=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_DEVICE_CLASS is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=y
# CONFIG_USB_PERSIST is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PPC_OF=y
CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
# CONFIG_USB_OHCI_HCD_PPC_OF_LE is not set
CONFIG_USB_OHCI_HCD_PCI=y
CONFIG_USB_OHCI_BIG_ENDIAN_DESC=y
CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_KARMA is not set
CONFIG_USB_LIBUSUAL=y

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
CONFIG_USB_MON=y

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=m
# CONFIG_USB_BERRY_CHARGE is not set
CONFIG_USB_LED=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGET is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set
# CONFIG_MMC is not set

#
# LED devices
#
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y

#
# LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_IDE_DISK=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_INFINIBAND is not set

#
# Real Time Clock
#
# CONFIG_RTC_CLASS is not set

#
# DMA Engine support
#
# CONFIG_DMA_ENGINE is not set

#
# DMA Clients
#

#
# DMA Devices
#

#
# Userspace I/O
#
# CONFIG_UIO is not set

#
# File systems
#
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
# CONFIG_EXT4DEV_FS is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
CONFIG_CONFIGFS_FS=m

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set
# CONFIG_UCC_SLOW is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_PLIST=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
CONFIG_PRINTK_TIME=y
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SHIRQ=y
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHED_DEBUG is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_TIMER_STATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
CONFIG_FORCED_INLINING=y
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_DEBUGGER=y
CONFIG_XMON=y
# CONFIG_XMON_DEFAULT is not set
CONFIG_XMON_DISASSEMBLY=y
# CONFIG_BDI_SWITCH is not set
CONFIG_BOOTX_TEXT=y
# CONFIG_PPC_EARLY_DEBUG is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set
CONFIG_CRYPTO=y
CONFIG_CRYPTO_ALGAPI=m
CONFIG_CRYPTO_BLKCIPHER=m
CONFIG_CRYPTO_MANAGER=m
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_NULL=m
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_GF128MUL is not set
CONFIG_CRYPTO_ECB=m
CONFIG_CRYPTO_CBC=m
CONFIG_CRYPTO_PCBC=m
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_AES=m
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_HW=y

--mP3DRpeJDSE+ciuQ--
