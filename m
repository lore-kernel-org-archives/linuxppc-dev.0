Return-Path: <vijay.t.nikam@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.225])
	by ozlabs.org (Postfix) with ESMTP id 609C6DDF9A
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 16:29:03 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so134203rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 06 Apr 2009 23:29:01 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 7 Apr 2009 11:59:01 +0530
Message-ID: <f234e2140904062329i48630711safdedf786ab7f0c6@mail.gmail.com>
Subject: Bug:scheduling while atomic
From: Vijay Nikam <vijay.t.nikam@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello All,

I have mpc8313erb with linux kernel 2.6.20.

When I ported the kernel with CONFIG_PREEMPT=y (Enabled) I am getting
the 'scheduling while atomic'. Please check the following call trace,
thanks.

Could anyone please let me to the way to fix it ? ? ?

Kindly please acknowledge ... thank you ...

Kind Regards,
Vijay Nikam

################################## LOG #################################
mpc8313_rdb_setup_arch()
arch: exit

[    0.000000] Using MPC8313 RDB machine description
[    0.000000] Linux version 2.6.20 (messung@localhost.localdomain)
(gcc version 4.0.2 20060628 (Wasabi)) #23 PREEMPT Tue Apr 7 10:36:18
IST 209
[    0.000000] Found MPC83xx PCI host bridge at 0x00000000e0008500.
Firmware bus number: 0->0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    32768
[    0.000000]   Normal      32768 ->    32768
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    32768
[    0.000000] Built 1 zonelists.  Total pages: 32512
[    0.000000] Kernel command line: root=/dev/mtdblock4
rootfstype=jffs2 rw console=ttyS0,115200 mtdparts=nand0:-(rootfs)
[    0.000000] IPIC (128 IRQ sources) at fdefa700
[    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
[   10.730683] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[   10.731455] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[   10.744855] Memory: 125836k/131072k available (3296k kernel code,
5088k reserved, 472k data, 110k bss, 144k init)
[   10.766153] Mount-cache hash table entries: 512
[   10.776457] NET: Registered protocol family 16
[   10.795354] PCI: Probing PCI hardware
[   10.835814] Generic PHY: Registered new driver
[   10.845802] SCSI subsystem initialized
[   10.848001] usbcore: registered new interface driver usbfs
[   10.849225] usbcore: registered new interface driver hub
[   10.850730] usbcore: registered new device driver usb
[   10.864131] NET: Registered protocol family 2
[   10.873891] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[   10.875624] TCP established hash table entries: 4096 (order: 4, 65536 bytes)
[   10.876118] TCP bind hash table entries: 2048 (order: 3, 40960 bytes)
[   10.876483] TCP: Hash tables configured (established 4096 bind 2048)
[   10.876508] TCP reno registered
[   10.926572] Initializing RT-Tester: OK
[   10.931275] JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
[   10.932114] io scheduler noop registered
[   10.932142] io scheduler anticipatory registered (default)
[   10.932164] io scheduler deadline registered
[   10.932336] io scheduler cfq registered
[   11.669977] Generic RTC Driver v1.07
[   11.673740] WDT driver for MPC83xx initialized. mode:reset
timeout=65535 (25 seconds)
[   11.673826] Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports,
IRQ sharing disabled
[   11.680975] serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 16) is a 16550A
[   11.902695] serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 17) is a 16550A
[   11.934522] RAMDISK driver initialized: 16 RAM disks of 32768K size
1024 blocksize
[   11.953408] loop: loaded (max 8 devices)
[   11.957368] Intel(R) PRO/1000 Network Driver - version 7.3.15-k2-NAPI
[   11.963862] Copyright (c) 1999-2006 Intel Corporation.
[   11.979780] Gianfar MII Bus: probed
[   11.986456] eth0: Gianfar Ethernet Controller Version 1.4, 00:04:9f:ef:23:33
[   11.993766] eth0: MTU = 1500 (frame size=1540,truesize=2296)
[   11.999442] eth0: Running with NAPI enabled
[   12.003644] eth0: 64/64 RX/TX BD ring size
[   12.007756] eth0: Socket buffer recycling mode enabled
[   12.014840] eth1: Gianfar Ethernet Controller Version 1.4, 00:e0:0c:00:7e:21
[   12.022155] eth1: MTU = 1500 (frame size=1540,truesize=2296)
[   12.027855] eth1: Running with NAPI enabled
[   12.032060] eth1: 64/64 RX/TX BD ring size
[   12.036169] eth1: Socket buffer recycling mode enabled
[   12.041374] SKB Handler initialized(max=64)
[   12.047711] Marvell 88E1101: Registered new driver
[   12.053683] Marvell 88E1111: Registered new driver
[   12.059610] Marvell 88E1145: Registered new driver
[   12.065650] MPC8313ERDB Ethernet Switch: Registered new driver
[   12.080151] MPC8313RDB flash device: 800000 at fe000000 Partition number 4
[   12.087755] MPC8313RDB Flash Map Info: Found 1 x16 devices at 0x0
in 16-bit bank
[   12.095290]  Amd/Fujitsu Extended Query Table at 0x0040
[   12.100558] MPC8313RDB Flash Map Info: Swapping erase regions for
broken CFI table.
[   12.108294] number of CFI chips: 1
[   12.111729] cfi_cmdset_0002: Disabling erase-suspend-program due to
code brokenness.
[   12.119556] Creating 4 MTD partitions on "MPC8313RDB Flash Map Info":
[   12.126040] 0x00000000-0x00100000 : "U-Boot"
[   12.134115] 0x00100000-0x00300000 : "Kernel"
[   12.142296] 0x00300000-0x00700000 : "JFFS2"
[   12.150546] 0x00700000-0x00800000 : "dtb"
[   12.158445] MPC8313RDB flash device (MPC8313RDB Flash Map Info) initialized
[   12.165481] Freescale eLBC NAND Driver (C) 2006 Freescale
[   12.173380] NAND device: Manufacturer ID: 0xec, Chip ID: 0x75
(Samsung NAND 32MiB 3,3V 8-bit)
[   12.182145] Scanning device for bad blocks
[   12.702672] 1 cmdlinepart partitions found on MTD device nand0
[   12.708534] Creating 1 MTD partitions on "nand0":
[   12.713277] 0x00000000-0x02000000 : "rootfs"
[   12.721823] usbmon: debugfs is not available
[   12.727329] fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
[   12.735447] fsl-ehci fsl-ehci.0: new USB bus registered, assigned
bus number 1
[   12.764287] fsl-ehci fsl-ehci.0: irq 38, io base 0xe0023000
[   12.769902] fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00, driver
10 Dec 2004
[   12.780758] usb usb1: configuration #1 chosen from 1 choice
[   12.787885] hub 1-0:1.0: USB hub found
[   12.791820] hub 1-0:1.0: 1 port detected
[   12.900109] Initializing USB Mass Storage driver...
[   12.906124] usbcore: registered new interface driver usb-storage
[   12.912183] USB Mass Storage support registered.
[   12.916884] Freescale High-Speed USB SOC Device Controller driver
(Feb 5, 2007)
[   12.925310] i2c /dev entries driver
[   12.958762] TCP cubic registered
[   12.962118] NET: Registered protocol family 1
[   12.966558] NET: Registered protocol family 17
[   12.972695] BUG: scheduling while atomic: swapper/0x00000001/1
[   12.978516] Call Trace:
[   12.980956] [C07F1D50] [C0009074] show_stack+0x50/0x190 (unreliable)
[   12.987334] [C07F1D80] [C028EB94] schedule+0x4c/0x6fc
[   12.992405] [C07F1DD0] [C028F8B8] schedule_timeout+0x64/0xe0
[   12.998073] [C07F1E10] [C01FF1BC] i2c_wait+0x138/0x1ec
[   13.003221] [C07F1E50] [C01FF4D4] mpc_xfer+0x264/0x3e4
[   13.008365] [C07F1E90] [C01FC510] i2c_transfer+0x58/0x7c
[   13.013681] [C07F1EB0] [C01FF6E4] ds1337_command+0x90/0x3e8
[   13.019258] [C07F1F30] [C0017974] ds1337_get_rtc_time+0x38/0x58
[   13.025189] [C07F1F50] [C0321494] mpc8313_rtc_hookup+0x64/0xb0
[   13.031037] [C07F1F90] [C0003964] init+0x94/0x2b4
[   13.035748] [C07F1FF0] [C00112BC] kernel_thread+0x44/0x60
[   13.041475] BUG: scheduling while atomic: swapper/0x00000001/1
[   13.047342] Call Trace:
[   13.049807] [C07F1D50] [C0009074] show_stack+0x50/0x190 (unreliable)
[   13.056242] [C07F1D80] [C028EB94] schedule+0x4c/0x6fc
[   13.061358] [C07F1DD0] [C028F8B8] schedule_timeout+0x64/0xe0
[   13.067077] [C07F1E10] [C01FF1BC] i2c_wait+0x138/0x1ec
[   13.072276] [C07F1E50] [C01FF558] mpc_xfer+0x2e8/0x3e4
[   13.077467] [C07F1E90] [C01FC510] i2c_transfer+0x58/0x7c
[   13.082827] [C07F1EB0] [C01FF6E4] ds1337_command+0x90/0x3e8
[   13.088452] [C07F1F30] [C0017974] ds1337_get_rtc_time+0x38/0x58
[   13.094430] [C07F1F50] [C0321494] mpc8313_rtc_hookup+0x64/0xb0
[   13.100326] [C07F1F90] [C0003964] init+0x94/0x2b4
[   13.105081] [C07F1FF0] [C00112BC] kernel_thread+0x44/0x60
[   13.110555] BUG: scheduling while atomic: swapper/0x00000001/1
[   13.116415] Call Trace:
[   13.118877] [C07F1D50] [C0009074] show_stack+0x50/0x190 (unreliable)
[   13.125310] [C07F1D80] [C028EB94] schedule+0x4c/0x6fc
[   13.130421] [C07F1DD0] [C028F8B8] schedule_timeout+0x64/0xe0
[   13.136132] [C07F1E10] [C01FF1BC] i2c_wait+0x138/0x1ec
[   13.141329] [C07F1E50] [C01FF360] mpc_xfer+0xf0/0x3e4
[   13.146437] [C07F1E90] [C01FC510] i2c_transfer+0x58/0x7c
[   13.151798] [C07F1EB0] [C01FF6E4] ds1337_command+0x90/0x3e8
[   13.157421] [C07F1F30] [C0017974] ds1337_get_rtc_time+0x38/0x58
[   13.163397] [C07F1F50] [C0321494] mpc8313_rtc_hookup+0x64/0xb0
[   13.169293] [C07F1F90] [C0003964] init+0x94/0x2b4
[   13.174048] [C07F1FF0] [C00112BC] kernel_thread+0x44/0x60
[   13.179520] BUG: scheduling while atomic: swapper/0x00000001/1
[   13.185379] Call Trace:
[   13.187843] [C07F1D50] [C0009074] show_stack+0x50/0x190 (unreliable)
[   13.194275] [C07F1D80] [C028EB94] schedule+0x4c/0x6fc
[   13.199387] [C07F1DD0] [C028F8B8] schedule_timeout+0x64/0xe0
[   13.205097] [C07F1E10] [C01FF1BC] i2c_wait+0x138/0x1ec
[   13.210299] [C07F1E50] [C01FF400] mpc_xfer+0x190/0x3e4
[   13.215491] [C07F1E90] [C01FC510] i2c_transfer+0x58/0x7c
[   13.220853] [C07F1EB0] [C01FF6E4] ds1337_command+0x90/0x3e8
[   13.226477] [C07F1F30] [C0017974] ds1337_get_rtc_time+0x38/0x58
[   13.232455] [C07F1F50] [C0321494] mpc8313_rtc_hookup+0x64/0xb0
[   13.238348] [C07F1F90] [C0003964] init+0x94/0x2b4
[   13.243105] [C07F1FF0] [C00112BC] kernel_thread+0x44/0x60
[   13.248576] BUG: scheduling while atomic: swapper/0x00000001/1
[   13.254435] Call Trace:
[   13.256899] [C07F1D50] [C0009074] show_stack+0x50/0x190 (unreliable)
[   13.263333] [C07F1D80] [C028EB94] schedule+0x4c/0x6fc
[   13.268448] [C07F1DD0] [C028F8B8] schedule_timeout+0x64/0xe0
[   13.274158] [C07F1E10] [C01FF1BC] i2c_wait+0x138/0x1ec
[   13.279355] [C07F1E50] [C01FF400] mpc_xfer+0x190/0x3e4
[   13.284546] [C07F1E90] [C01FC510] i2c_transfer+0x58/0x7c
[   13.289904] [C07F1EB0] [C01FF6E4] ds1337_command+0x90/0x3e8
[   13.295528] [C07F1F30] [C0017974] ds1337_get_rtc_time+0x38/0x58
[   13.301505] [C07F1F50] [C0321494] mpc8313_rtc_hookup+0x64/0xb0
[   13.307394] [C07F1F90] [C0003964] init+0x94/0x2b4
[   13.312146] [C07F1FF0] [C00112BC] kernel_thread+0x44/0x60
[   13.317616] BUG: scheduling while atomic: swapper/0x00000001/1
[   13.323475] Call Trace:
[   13.325938] [C07F1D50] [C0009074] show_stack+0x50/0x190 (unreliable)
[   13.332376] [C07F1D80] [C028EB94] schedule+0x4c/0x6fc
[   13.337489] [C07F1DD0] [C028F8B8] schedule_timeout+0x64/0xe0
[   13.343209] [C07F1E10] [C01FF1BC] i2c_wait+0x138/0x1ec
[   13.348406] [C07F1E50] [C01FF400] mpc_xfer+0x190/0x3e4
[   13.353595] [C07F1E90] [C01FC510] i2c_transfer+0x58/0x7c
[   13.358955] [C07F1EB0] [C01FF6E4] ds1337_command+0x90/0x3e8
[   13.364581] [C07F1F30] [C0017974] ds1337_get_rtc_time+0x38/0x58
[   13.370558] [C07F1F50] [C0321494] mpc8313_rtc_hookup+0x64/0xb0
[   13.376449] [C07F1F90] [C0003964] init+0x94/0x2b4
[   13.381208] [C07F1FF0] [C00112BC] kernel_thread+0x44/0x60
[   13.386678] BUG: scheduling while atomic: swapper/0x00000001/1
[   13.392537] Call Trace:
[   13.395000] [C07F1D50] [C0009074] show_stack+0x50/0x190 (unreliable)
[   13.401438] [C07F1D80] [C028EB94] schedule+0x4c/0x6fc
[   13.406547] [C07F1DD0] [C028F8B8] schedule_timeout+0x64/0xe0
[   13.412267] [C07F1E10] [C01FF1BC] i2c_wait+0x138/0x1ec
[   13.417459] [C07F1E50] [C01FF400] mpc_xfer+0x190/0x3e4
[   13.422646] [C07F1E90] [C01FC510] i2c_transfer+0x58/0x7c
[   13.428006] [C07F1EB0] [C01FF6E4] ds1337_command+0x90/0x3e8
[   13.433631] [C07F1F30] [C0017974] ds1337_get_rtc_time+0x38/0x58
[   13.439608] [C07F1F50] [C0321494] mpc8313_rtc_hookup+0x64/0xb0
[   13.445497] [C07F1F90] [C0003964] init+0x94/0x2b4
[   13.450257] [C07F1FF0] [C00112BC] kernel_thread+0x44/0x60
[   13.455728] BUG: scheduling while atomic: swapper/0x00000001/1
[   13.461587] Call Trace:
[   13.464050] [C07F1D50] [C0009074] show_stack+0x50/0x190 (unreliable)
[   13.470479] [C07F1D80] [C028EB94] schedule+0x4c/0x6fc
[   13.475589] [C07F1DD0] [C028F8B8] schedule_timeout+0x64/0xe0
[   13.481308] [C07F1E10] [C01FF1BC] i2c_wait+0x138/0x1ec
[   13.486504] [C07F1E50] [C01FF400] mpc_xfer+0x190/0x3e4
[   13.491692] [C07F1E90] [C01FC510] i2c_transfer+0x58/0x7c
[   13.497052] [C07F1EB0] [C01FF6E4] ds1337_command+0x90/0x3e8
[   13.502676] [C07F1F30] [C0017974] ds1337_get_rtc_time+0x38/0x58
[   13.508654] [C07F1F50] [C0321494] mpc8313_rtc_hookup+0x64/0xb0
[   13.514547] [C07F1F90] [C0003964] init+0x94/0x2b4
[   13.519307] [C07F1FF0] [C00112BC] kernel_thread+0x44/0x60
[   13.524779] BUG: scheduling while atomic: swapper/0x00000001/1
[   13.530637] Call Trace:
[   13.533102] [C07F1D50] [C0009074] show_stack+0x50/0x190 (unreliable)
[   13.539530] [C07F1D80] [C028EB94] schedule+0x4c/0x6fc
[   13.544641] [C07F1DD0] [C028F8B8] schedule_timeout+0x64/0xe0
[   13.550358] [C07F1E10] [C01FF1BC] i2c_wait+0x138/0x1ec
[   13.555550] [C07F1E50] [C01FF400] mpc_xfer+0x190/0x3e4
[   13.560736] [C07F1E90] [C01FC510] i2c_transfer+0x58/0x7c
[   13.566096] [C07F1EB0] [C01FF6E4] ds1337_command+0x90/0x3e8
[   13.571719] [C07F1F30] [C0017974] ds1337_get_rtc_time+0x38/0x58
[   13.577696] [C07F1F50] [C0321494] mpc8313_rtc_hookup+0x64/0xb0
[   13.583587] [C07F1F90] [C0003964] init+0x94/0x2b4
[   13.588347] [C07F1FF0] [C00112BC] kernel_thread+0x44/0x60
[   13.593815] BUG: scheduling while atomic: swapper/0x00000001/1
[   13.599674] Call Trace:
[   13.602138] [C07F1D50] [C0009074] show_stack+0x50/0x190 (unreliable)
[   13.608564] [C07F1D80] [C028EB94] schedule+0x4c/0x6fc
[   13.613673] [C07F1DD0] [C028F8B8] schedule_timeout+0x64/0xe0
[   13.619386] [C07F1E10] [C01FF1BC] i2c_wait+0x138/0x1ec
[   13.624580] [C07F1E50] [C01FF400] mpc_xfer+0x190/0x3e4
[   13.629769] [C07F1E90] [C01FC510] i2c_transfer+0x58/0x7c
[   13.635129] [C07F1EB0] [C01FF6E4] ds1337_command+0x90/0x3e8
[   13.640752] [C07F1F30] [C0017974] ds1337_get_rtc_time+0x38/0x58
[   13.646729] [C07F1F50] [C0321494] mpc8313_rtc_hookup+0x64/0xb0
[   13.652630] [C07F1F90] [C0003964] init+0x94/0x2b4
[   13.657387] [C07F1FF0] [C00112BC] kernel_thread+0x44/0x60
[   14.470018] Empty flash at 0x003a4d74 ends at 0x003a4e00
[   14.716173] Empty flash at 0x00a0d15c ends at 0x00a0d200
[   14.721669] Empty flash at 0x00a0e604 ends at 0x00a0e800
[   14.831533] Empty flash at 0x00c88408 ends at 0x00c88600
[   14.836997] Empty flash at 0x00c89420 ends at 0x00c89600
[   14.842420] Empty flash at 0x00c8a420 ends at 0x00c8a600
[   14.909287] Empty flash at 0x00e24f30 ends at 0x00e25000
[   14.968135] Empty flash at 0x00f99318 ends at 0x00f99400
[   15.058060] Empty flash at 0x011806f4 ends at 0x01180800
[   15.154096] Empty flash at 0x013a11b4 ends at 0x013a1200
[   15.562613] Empty flash at 0x01850258 ends at 0x01850400
[   15.594730] Empty flash at 0x018bcd40 ends at 0x018bce00
[   15.600200] Empty flash at 0x018be8b0 ends at 0x018bea00
[   15.605597] Empty flash at 0x018bf15c ends at 0x018bf200
[   15.848968] Empty flash at 0x01c89abc ends at 0x01c89c00
[   15.887667] Empty flash at 0x01d29218 ends at 0x01d29400
[   15.893204] Empty flash at 0x01d2a060 ends at 0x01d2a200
[   16.139702] VFS: Mounted root (jffs2 filesystem).
[   16.145042] Freeing unused kernel memory: 144k init
Setting the hostname to freescale
Mounting filesystems
[   17.514073] JFFS2 notice: (717) check_node_data: wrong data CRC in
data node at 0x01c89800: read 0x2d1ba49a, calculated 0xa8ef5d7e.
Starting syslogd and klogd
Running sysctl
Setting up networking on loopback device:
Setting up networking on eth0:
udhcpc (v0.9.9-pre) started
Sending discover...
[   18.727343] BUG: spinlock recursion on CPU#0, jffs2_gcd_mtd4/736
[   18.733391]  lock: c7fbb320, .magic: dead4ead, .owner:
jffs2_gcd_mtd4/736, .owner_cpu: 0
[   18.741492] Call Trace:
[   18.743950] [C7C79C50] [C0009074] show_stack+0x50/0x190 (unreliable)
[   18.750380] [C7C79C80] [C014E7B0] spin_bug+0x94/0xb0
[   18.755393] [C7C79CA0] [C014EBCC] _raw_spin_lock+0x180/0x184
[   18.761092] [C7C79CD0] [C0290EB8] _spin_lock+0x20/0x30
[   18.766278] [C7C79CE0] [C01997EC] gfar_transmit+0x50/0x290
[   18.771807] [C7C79D10] [C0043A10] handle_IRQ_event+0x5c/0xb0
[   18.777511] [C7C79D30] [C004594C] handle_level_irq+0xb0/0x178
[   18.783301] [C7C79D50] [C000645C] do_IRQ+0xa4/0xc8
[   18.788138] [C7C79D60] [C0010B08] ret_from_except+0x0/0x14
[   18.793670] --- Exception: 501 at check_poison_obj+0x9c/0x1f0
[   18.799457]     LR = check_poison_obj+0x28/0x1f0
[   18.804084] [C7C79E20] [C0067A54] kmem_cache_free+0x84/0x108 (unreliable)
[   18.810928] [C7C79E50] [C0066918] cache_alloc_debugcheck_after+0xfc/0x1f0
[   18.817760] [C7C79E70] [C0067968] kmem_cache_zalloc+0xac/0x114
[   18.823636] [C7C79E90] [C0120690] jffs2_do_crccheck_inode+0x2c/0xb4
[   18.829957] [C7C79F00] [C01245C0] jffs2_garbage_collect_pass+0x154/0x7b4
[   18.836708] [C7C79F50] [C0125FF8] jffs2_garbage_collect_thread+0xac/0x170
[   18.843540] [C7C79FF0] [C00112BC] kernel_thread+0x44/0x60
[   23.336327] BUG: spinlock lockup on CPU#0, jffs2_gcd_mtd4/736, c7fbb320
[   23.342946] Call Trace:
[   23.345405] [C7C79C70] [C0009074] show_stack+0x50/0x190 (unreliable)
[   23.351819] [C7C79CA0] [C014EB84] _raw_spin_lock+0x138/0x184
[   23.357521] [C7C79CD0] [C0290EB8] _spin_lock+0x20/0x30
[   23.362700] [C7C79CE0] [C01997EC] gfar_transmit+0x50/0x290
[   23.368231] [C7C79D10] [C0043A10] handle_IRQ_event+0x5c/0xb0
[   23.373931] [C7C79D30] [C004594C] handle_level_irq+0xb0/0x178
[   23.379719] [C7C79D50] [C000645C] do_IRQ+0xa4/0xc8
[   23.384553] [C7C79D60] [C0010B08] ret_from_except+0x0/0x14
[   23.390084] --- Exception: 501 at check_poison_obj+0x9c/0x1f0
[   23.395868]     LR = check_poison_obj+0x28/0x1f0
[   23.400498] [C7C79E20] [C0067A54] kmem_cache_free+0x84/0x108 (unreliable)
[   23.407341] [C7C79E50] [C0066918] cache_alloc_debugcheck_after+0xfc/0x1f0
[   23.414175] [C7C79E70] [C0067968] kmem_cache_zalloc+0xac/0x114
[   23.420055] [C7C79E90] [C0120690] jffs2_do_crccheck_inode+0x2c/0xb4
[   23.426376] [C7C79F00] [C01245C0] jffs2_garbage_collect_pass+0x154/0x7b4
[   23.433129] [C7C79F50] [C0125FF8] jffs2_garbage_collect_thread+0xac/0x170
[   23.439959] [C7C79FF0] [C00112BC] kernel_thread+0x44/0x60
[   33.446870] BUG: soft lockup detected on CPU#0!
[   33.451386] Call Trace:
[   33.453826] [C7C79AE0] [C0009074] show_stack+0x50/0x190 (unreliable)
[   33.460202] [C7C79B10] [C0043904] softlockup_tick+0xb8/0xe0
[   33.465779] [C7C79B30] [C0027518] run_local_timers+0x18/0x28
[   33.471454] [C7C79B40] [C0027558] update_process_times+0x30/0x7c
[   33.477468] [C7C79B50] [C000D344] timer_interrupt+0x124/0x5c8
[   33.483218] [C7C79BE0] [C0010B08] ret_from_except+0x0/0x14
[   33.488709] --- Exception: 901 at _raw_spin_lock+0x13c/0x184
[   33.494370]     LR = _raw_spin_lock+0xf8/0x184
[   33.498800] [C7C79CA0] [C014EB84] _raw_spin_lock+0x138/0x184 (unreliable)
[   33.505598] [C7C79CD0] [C0290EB8] _spin_lock+0x20/0x30
[   33.510744] [C7C79CE0] [C01997EC] gfar_transmit+0x50/0x290
[   33.516238] [C7C79D10] [C0043A10] handle_IRQ_event+0x5c/0xb0
[   33.521905] [C7C79D30] [C004594C] handle_level_irq+0xb0/0x178
[   33.527659] [C7C79D50] [C000645C] do_IRQ+0xa4/0xc8
[   33.532461] [C7C79D60] [C0010B08] ret_from_except+0x0/0x14
[   33.537951] --- Exception: 501 at check_poison_obj+0x9c/0x1f0
[   33.543701]     LR = check_poison_obj+0x28/0x1f0
[   33.548304] [C7C79E20] [C0067A54] kmem_cache_free+0x84/0x108 (unreliable)
[   33.555103] [C7C79E50] [C0066918] cache_alloc_debugcheck_after+0xfc/0x1f0
[   33.561895] [C7C79E70] [C0067968] kmem_cache_zalloc+0xac/0x114
[   33.567733] [C7C79E90] [C0120690] jffs2_do_crccheck_inode+0x2c/0xb4
[   33.574016] [C7C79F00] [C01245C0] jffs2_garbage_collect_pass+0x154/0x7b4
[   33.580724] [C7C79F50] [C0125FF8] jffs2_garbage_collect_thread+0xac/0x170
[   33.587515] [C7C79FF0] [C00112BC] kernel_thread+0x44/0x60
 ################################# END
##########################################################
