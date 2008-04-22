Return-Path: <Sellsa@ZIN-TECH.COM>
Received: from zinexc.ZIN.NET (ramp034-158.rampant.com [64.28.34.158])
	by ozlabs.org (Postfix) with ESMTP id 53044DE156
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Apr 2008 06:59:54 +1000 (EST)
Message-ID: <480E4EBD.3010202@zin-tech.com>
Date: Tue, 22 Apr 2008 16:46:53 -0400
From: Aaron Sells <aaron.sells@zin-tech.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: SecretLab 2.6.24 with USB
References: <800687fe0804141927y1f6ea75cv7ad0ba68b4fa637a@mail.gmail.com>	
	<fa686aa40804211109g2f7f45d0gf836be46e2c1a40b@mail.gmail.com>	
	<16825460.post@talk.nabble.com>
	<fa686aa40804221309g7d0749e8qc329ad72389f0138@mail.gmail.com>
In-Reply-To: <fa686aa40804221309g7d0749e8qc329ad72389f0138@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> 1. Post your boot log

Linux/PPC load: console=ttyUL0,9600 root=/dev/nfs rw 
nfsroot=172.16.100.6:/opt/oe/console ip=dhcp
Uncompressing Linux...done.
Now booting the kernel
[    0.000000] Linux version 2.6.24-rc8-xlnx-dirty 
(sellsa@SS-SBIR-Ubuntu) (gcc version 4.2.2) #2 Tue Apr 22 12:04:46 EDT 2008
[    0.000000] Xilinx Generic PowerPC board support package (Xilinx 
ML403) (Virtex-4 FX)
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    16384
[    0.000000]   Normal      16384 ->    16384
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    16384
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. 
Total pages: 16256
[    0.000000] Kernel command line: console=ttyUL0,9600 root=/dev/nfs rw 
nfsroot=172.16.100.6:/opt/oe/console ip=dhcp
[    0.000000] Xilinx INTC #0 at 0x81800000 mapped to 0xFDFFF000
[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[    0.000258] Console: colour dummy device 80x25
[    0.000922] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.002038] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.021346] Memory: 61312k available (2616k kernel code, 868k data, 
132k init, 0k highmem)
[    0.108742] Mount-cache hash table entries: 512
[    0.116268] net_namespace: 152 bytes
[    0.119536] NET: Registered protocol family 16
[    0.123901] Registering device uartlite:0
[    0.125230] Fixup MAC address for xilinx_lltemac:0
[    0.125289] Registering device xilinx_lltemac:0
[    0.126444] Registering device xilinx_iic:0
[    0.171651] SCSI subsystem initialized
[    0.175959] usbcore: registered new interface driver usbfs
[    0.178205] usbcore: registered new interface driver hub
[    0.179810] usbcore: registered new device driver usb
[    0.218553] NET: Registered protocol family 2
[    0.256930] IP route cache hash table entries: 1024 (order: 0, 4096 
bytes)
[    0.260235] TCP established hash table entries: 2048 (order: 2, 16384 
bytes)
[    0.260666] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.260912] TCP: Hash tables configured (established 2048 bind 2048)
[    0.260955] TCP reno registered
[    0.283619] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    0.285708] JFFS2 version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
[    0.287381] io scheduler noop registered
[    0.287442] io scheduler anticipatory registered (default)
[    0.287481] io scheduler deadline registered
[    0.287740] io scheduler cfq registered
[    0.373233] Macintosh non-volatile memory driver v1.1
[    0.374364] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ 
sharing disabled
[    0.382613] uartlite.0: ttyUL0 at MMIO 0x84000003 (irq = 7) is a uartlite
[    0.382713] console [ttyUL0] enabled
[    3.227497] brd: module loaded
[    3.259241] loop: module loaded
[    3.285114] Xilinx SystemACE device driver, major=254
[    3.348555] nbd: registered device at major 43
[    3.426028] usbcore: registered new interface driver ub
[    3.472247] tun: Universal TUN/TAP device driver, 1.6
[    3.532134] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    3.609161] xilinx_lltemac xilinx_lltemac.0: MAC address is now  0: 
a:35: 1: 2: 3
[    3.696055] xilinx_lltemac xilinx_lltemac.0: XLlTemac: using FIFO 
direct interrupt driven mode.
[    3.800113] XLlTemac: Fifo base address: 0xc5052000
[    3.861023] XTemac: No PHY detected.  Assuming a PHY at address 0
[    3.936569] xilinx_lltemac xilinx_lltemac.0: eth0: Xilinx TEMAC at 
0x81C00000 mapped to 0xC5054000, irq=2
[    4.048559] Linux video capture interface: v2.00
[    4.106344] block2mtd: version $Revision: 1.30 $
[    4.156087] usbmon: debugfs is not available
[    4.209164] Initializing USB Mass Storage driver...
[    4.268301] usbcore: registered new interface driver usb-storage
[    4.336109] USB Mass Storage support registered.
[    4.392985] i8042.c: No controller found.
[    4.444206] mice: PS/2 mouse device common for all mice
[    4.507075] i2c /dev entries driver
[    4.561419] xilinx_iic.0 #0 at 0x81600000 mapped to 0xC5060000, irq=3
[    4.625626] usbcore: registered new interface driver usbhid
[    4.688119] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[    4.765302] Advanced Linux Sound Architecture Driver Version 
1.0.16rc2 (Thu Jan 31 16:40:16 2008 UTC).
[    4.880392] ALSA device list:
[    4.908042]   No soundcards found.
[    4.958069] TCP cubic registered
[    4.988228] NET: Registered protocol family 1
[    5.040274] NET: Registered protocol family 17
[    5.097536] RPC: Registered udp transport module.
[    5.152077] RPC: Registered tcp transport module.
[    5.717327] eth0: XLlTemac: Options: 0x3fa
[    5.748106] eth0: XLlTemac: allocating interrupt 0 for fifo mode.
[    7.832825] eth0: XLlTemac: speed set to 100Mb/s
[    8.876099] Sending DHCP requests ., OK
[    8.920092] IP-Config: Got DHCP answer from 0.0.0.0, my address is 
172.16.100.199
[    8.998117] IP-Config: Complete:
[    9.032048]      device=eth0, addr=172.16.100.199, 
mask=255.255.255.0, gw=172.16.100.1,
[    9.124032]      host=172.16.100.199, domain=zin.net, nis-domain=(none),
[    9.204160]      bootserver=0.0.0.0, rootserver=172.16.100.6, rootpath=
[    9.288645] Looking up port of RPC 100003/2 on 172.16.100.6
[    9.370826] Looking up port of RPC 100005/1 on 172.16.100.6
[    9.872124] eth0: XLlTemac: PHY Link carrier lost.
[   11.922151] eth0: XLlTemac: speed set to 100Mb/s
[   11.960020] eth0: XLlTemac: PHY Link carrier restored.
[   14.569232] VFS: Mounted root (nfs filesystem).
[   14.608501] Freeing unused kernel memory: 132k init
INIT: version 2.86 booting
Starting the hotplug events dispatcher udevd
Synthesizing the initial hotplug events
[   32.666441] nbd13: Attempted send on closed socket
[   32.708098] end_request: I/O error, dev nbd13, sector 0
[   32.781692] nbd11: Attempted send on closed socket
[   32.828123] end_request: I/O error, dev nbd11, sector 0
[   32.892778] nbd12: Attempted send on closed socket
[   32.948107] end_request: I/O error, dev nbd12, sector 0
[   33.021755] nbd1: Attempted send on closed socket
[   33.064057] end_request: I/O error, dev nbd1, sector 0
[   33.178423] nbd15: Attempted send on closed socket
[   33.220102] end_request: I/O error, dev nbd15, sector 0
[   33.296955] nbd10: Attempted send on closed socket
[   33.340105] end_request: I/O error, dev nbd10, sector 0
[   33.412948] nbd0: Attempted send on closed socket
[   33.456319] end_request: I/O error, dev nbd0, sector 0
[   33.749262] nbd2: Attempted send on closed socket
[   33.788077] end_request: I/O error, dev nbd2, sector 0
[   33.910500] nbd14: Attempted send on closed socket
[   33.952068] end_request: I/O error, dev nbd14, sector 0
[   35.643604] FAT: unable to read boot sector
[   35.726130] FAT: unable to read boot sector
[   35.767178] FAT: unable to read boot sector
[   35.808826] FAT: unable to read boot sector
[   35.883115] FAT: unable to read boot sector
[   35.985109] FAT: unable to read boot sector
[   36.046253] FAT: unable to read boot sector
[   36.130150] FAT: unable to read boot sector
[   36.176588] FAT: unable to read boot sector
[   37.434412] nbd3: Attempted send on closed socket
[   37.472068] end_request: I/O error, dev nbd3, sector 0
[   37.619660] nbd7: Attempted send on closed socket
[   37.660096] end_request: I/O error, dev nbd7, sector 0
[   37.879683] nbd4: Attempted send on closed socket
[   37.920090] end_request: I/O error, dev nbd4, sector 0
[   37.994513] nbd6: Attempted send on closed socket
[   38.036165] end_request: I/O error, dev nbd6, sector 0
[   38.189853] nbd5: Attempted send on closed socket
[   38.228057] end_request: I/O error, dev nbd5, sector 0
[   38.307332] nbd8: Attempted send on closed socket
[   38.348365] end_request: I/O error, dev nbd8, sector 0
[   38.422145] nbd9: Attempted send on closed socket
[   38.464063] end_request: I/O error, dev nbd9, sector 0
[   39.476587] FAT: unable to read boot sector
[   39.572328] FAT: unable to read boot sector
[   39.715495] FAT: unable to read boot sector
[   39.811415] FAT: unable to read boot sector
[   39.920564] FAT: unable to read boot sector
[   39.972659] FAT: unable to read boot sector
[   40.101692] FAT: unable to read boot sector
Remounting root file system...
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces... udhcpc (v1.9.1) started
Sending discover...
Sending select for 172.16.100.199...
Lease of 172.16.100.199 obtained, lease time 604800
done.
Starting portmap daemon: portmap.
hwclock: can't open '/dev/misc/rtc': No such file or directory
Nothing to be done
INIT: Entering runlevel: 5
Starting Dropbear SSH server: dropbear.
Starting system message bus: dbus.
Starting syslogd/klogd: start-stop-daemon: lseek: Invalid argument
  * Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon
[ ok ]

> 2. Make sure a platform device for the usb controller is getting
> registered with the kernel.

Correct me if I'm wrong, but it does not look like my Cypress CY7C6300 
USB host controller is getting registered with the kernel.  Any ideas?

Regards,
Aaron Sells
