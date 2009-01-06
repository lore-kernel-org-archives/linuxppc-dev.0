Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 010ACDE480
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 17:34:09 +1100 (EST)
Subject: Re: [QUESTION] 440EPx with PCI to PCIe bridge error
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Steven A. Falco" <sfalco@harris.com>
In-Reply-To: <49627D33.8030605@harris.com>
References: <496268E7.5090907@harris.com>
	<1231190318.14860.17.camel@pasglop>  <49627D33.8030605@harris.com>
Content-Type: text/plain
Date: Tue, 06 Jan 2009 17:33:54 +1100
Message-Id: <1231223634.14860.18.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Here is a complete startup log, with debug turned on as you requested.
> This is still against 2.6.27.9, as it will take me a little time to
> build 2.6.28.  Hopefully, this log will be useful in the meantime.

Can you add "debug" to your kernel command line option or send the
output of the "dmesg" command please ?

Cheers,
Ben.

> 	Steve
> 
> 
> U-Boot 2008.10-00079-gebb3412 (Dec  9 2008 - 16:06:05)
> 
> CPU:   AMCC PowerPC 440EPx Rev. A at 666.666 MHz (PLB=166, OPB=83, EBC=55 MHz)
>        Security/Kasumi support
>        Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
>        Internal PCI arbiter enabled, PCI async ext clock used
>        32 kB I-Cache 32 kB D-Cache
> Board: Sequoia - AMCC PPC440EPx Evaluation Board, Rev. F, PCI=66 MHz, serial# 7654
> I2C:   ready
> SPI:   ready
> DTT:   1 is 27 C
> DRAM:  256 MB
> FLASH: 64 MB
> NAND:  32 MiB
> PCI:   Bus Dev VenId DevId Class Int
>         01  00  1172  0004  ff00  43
>         00  0c  10b5  8112  0604  43
> In:    serial
> Out:   serial
> Err:   serial
> RTC:   ready
> USB:   Host(int phy) Device(ext phy)
> Net:   ppc_4xx_eth0, ppc_4xx_eth1
> IDE:   Bus 0: OK
>   Device 0: PIO mode 4
> Model: SMC01GBFK6E Firm: CF080204 Ser#: NU0B4000000000102893
>             Type: Hard Disk
>             Capacity: 977.4 MB = 0.9 GB (2001888 x 512)
> 
> 
> 
> ==========================================================
> |                                                        |
> |                    Welcome to Hydra                    |
> |                                                        |
> ==========================================================
> 
> 
> 
> Please type "sm" to enter safe-mode.
> 
> 
> Starting current kernel - please wait.
> Starting previous kernel - please wait.
> Starting safe-mode kernel - please wait.
> ## Booting kernel from Legacy Image at fd400000 ...
>    Image Name:   Linux-2.6.27.9-00045-gcccf182-di
>    Created:      2009-01-05  21:29:41 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1684167 Bytes =  1.6 MB
>    Load Address: 00400000
>    Entry Point:  00400454
>    Verifying Checksum ... OK
> ## Loading init Ramdisk from Legacy Image at fd900000 ...
>    Image Name:   initramfs
>    Created:      2008-11-26  15:13:12 UTC
>    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>    Data Size:    2443397 Bytes =  2.3 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>    Loading Ramdisk to 0fcb7000, end 0ff0b885 ... OK
> CPU clock-frequency <- 0x27bc86a4 (667MHz)
> CPU timebase-frequency <- 0x27bc86a4 (667MHz)
> /plb: clock-frequency <- 9ef21a9 (167MHz)
> /plb/opb: clock-frequency <- 4f790d4 (83MHz)
> /plb/opb/ebc: clock-frequency <- 34fb5e3 (56MHz)
> /plb/opb/serial@ef600300: clock-frequency <- a8c000 (11MHz)
> /plb/opb/serial@ef600400: clock-frequency <- a8c000 (11MHz)
> /plb/opb/serial@ef600500: clock-frequency <- a8c000 (11MHz)
> /plb/opb/serial@ef600600: clock-frequency <- a8c000 (11MHz)
> Memory <- <0x0 0x0 0xffff000> (255MB)
> ENET0: local-mac-address <- 00:10:ec:01:04:d0
> ENET1: local-mac-address <- 00:10:ec:01:04:d1
> 
> zImage starting: loaded at 0x00400000 (sp: 0x0ff0c300)
> Allocating 0x371974 bytes for kernel ...
> gunzipping (0x00000000 <- 0x0040f000:0x007ac72c)...done 0x35a1e4 bytes
> Using loader supplied ramdisk at 0xfcb7000-0xff0b885
> initrd head: 0x1f8b0808
> 
> Linux/PowerPC load: root=/dev/sda3 rw ip=137.237.178.105:137.237.179.31:137.237.178.1:255.255.255.0:hydra_temp:eth0:off panic=1 console=ttyS0,115200
> Finalizing device tree... flat tree at 0x40bf08
> Using Hydra_temp machine description
> Linux version 2.6.27.9-00045-gcccf182-dirty (sfalco@saf.cs.myharris.net) (gcc version 4.2.2) #135 Mon Jan 5 16:29:11 EST 2009
> Found initrd at 0xcfcb7000:0xcff0b885
> console [udbg0] enabled
> setup_arch: bootmem
> arch: exit
> Zone PFN ranges:
>   DMA      0x00000000 -> 0x0000ffff
>   Normal   0x0000ffff -> 0x0000ffff
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     0: 0x00000000 -> 0x0000ffff
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65023
> Kernel command line: root=/dev/sda3 rw ip=137.237.178.105:137.237.179.31:137.237.178.1:255.255.255.0:hydra_temp:eth0:off panic=1 console=ttyS0,115200
> UIC0 (32 IRQ sources) at DCR 0xc0
> UIC1 (32 IRQ sources) at DCR 0xd0
> UIC2 (32 IRQ sources) at DCR 0xe0
> PID hash table entries: 1024 (order: 10, 4096 bytes)
> clocksource: timebase mult[600000] shift[22] registered
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 253620k/262140k available (3284k kernel code, 8220k reserved, 124k data, 90k bss, 156k init)
> SLUB: Genslabs=10, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> Calibrating delay loop... 1331.20 BogoMIPS (lpj=2662400)
> Mount-cache hash table entries: 512
> net_namespace: 288 bytes
> NET: Registered protocol family 16
> 
> PCI host bridge /plb/pci@1ec000000 (primary) ranges:
>  MEM 0x0000000180000000..0x000000018fffffff -> 0x0000000080000000
>   IO 0x00000001e8000000..0x00000001e80fffff -> 0x0000000000000000
> 4xx PCI DMA offset set to 0x00000000
> PCI: Probing PCI hardware
> PCI: Hiding 4xx host bridge resources 0000:00:00.0
> pci 0000:00:0c.0: PME# supported from D0 D1 D3hot
> pci 0000:00:0c.0: PME# disabled
> Try to map irq for 0000:00:00.0...
> pci_busdev_to_OF_node(0,0x0)
>  parent is /plb/pci@1ec000000
>  result is <NULL>
>  -> got one, spec 2 cells (0x00000003 0x00000008...) on /interrupt-controller2
>  -> mapped to linux irq 16
> Try to map irq for 0000:00:0c.0...
> pci_busdev_to_OF_node(0,0x60)
>  parent is /plb/pci@1ec000000
>  result is <NULL>
>  -> got one, spec 2 cells (0x00000003 0x00000008...) on /interrupt-controller2
>  -> mapped to linux irq 16
> Try to map irq for 0000:01:00.0...
> pci_busdev_to_OF_node(1,0x0)
> pci_busdev_to_OF_node(0,0x60)
>  parent is /plb/pci@1ec000000
>  result is <NULL>
>  -> got one, spec 2 cells (0x00000003 0x00000008...) on /interrupt-controller2
>  -> mapped to linux irq 16
> PCI: PHB (bus 0) bridge rsrc 0: 0000000000000000-00000000000fffff [0x100], parent c0339b40 (PCI IO)
> PCI: PHB (bus 0) bridge rsrc 1: 0000000180000000-000000018fffffff [0x200], parent c0339b18 (PCI mem)
> PCI: Assigning unassigned resouces...
> pci 0000:00:0c.0: BAR 8: can't allocate mem resource [0x180000000-0x18fffffff]
> pci 0000:01:00.0: BAR 1: can't allocate mem resource [0x1f0000000-0x1ffffffff]
> pci 0000:01:00.0: BAR 0: can't allocate mem resource [0x180000000-0x18007ffff]
> pci 0000:00:0c.0: PCI bridge, secondary bus 0000:01
> pci 0000:00:0c.0:   IO window: disabled
> pci 0000:00:0c.0:   MEM window: disabled
> pci 0000:00:0c.0:   PREFETCH window: disabled
> bus: 00 index 0 io port: [0, fffff]
> bus: 00 index 1 mmio: [180000000, 18fffffff]
> bus: 01 index 0 mmio: [0, 0]
> bus: 01 index 1 mmio: [0, 0]
> bus: 01 index 2 mmio: [0, 0]
> bus: 01 index 3 mmio: [0, 0]
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> NET: Registered protocol family 2
> IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
> TCP established hash table entries: 8192 (order: 4, 65536 bytes)
> TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
> TCP: Hash tables configured (established 8192 bind 8192)
> TCP reno registered
> NET: Registered protocol family 1
> checking if image is initramfs... it is
> Freeing initrd memory: 2386k freed
> msgmni has been set to 500
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> Serial: 8250/16550 driver4 ports, IRQ sharing enabled
> serial8250.0: ttyS0 at MMIO 0x1ef600300 (irq = 17) is a 16550A
>                                                               console handover: boot [udbg0] -> real [ttyS0]
> serial8250.0: ttyS1 at MMIO 0x1ef600400 (irq = 18) is a 16550A
> serial8250.0: ttyS2 at MMIO 0x1ef600500 (irq = 19) is a 16550A
> serial8250.0: ttyS3 at MMIO 0x1ef600600 (irq = 20) is a 16550A
> 1ef600300.serial: ttyS0 at MMIO 0x1ef600300 (irq = 17) is a 16550A
> 1ef600400.serial: ttyS1 at MMIO 0x1ef600400 (irq = 18) is a 16550A
> 1ef600500.serial: ttyS2 at MMIO 0x1ef600500 (irq = 19) is a 16550A
> 1ef600600.serial: ttyS3 at MMIO 0x1ef600600 (irq = 20) is a 16550A
> brd: module loaded
> PPC 4xx OCP EMAC driver, version 3.54
> MAL v2 /plb/mcmal, 2 TX channels, 2 RX channels
> ZMII /plb/opb/emac-zmii@ef600d00 initialized
> RGMII /plb/opb/emac-rgmii@ef601000 initialized with MDIO support
> /plb/opb/emac-rgmii@ef601000: input 0 in RGMII mode
> eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:10:ec:01:04:d0
> eth0: found Marvell 88E1111 Ethernet PHY (0x00)
> /plb/opb/emac-rgmii@ef601000: input 1 in RGMII mode
> eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:10:ec:01:04:d1
> eth1: found Marvell 88E1111 Ethernet PHY (0x01)
> Uniform Multi-Platform E-IDE driver
> Driver 'sd' needs updating - please use bus_type methods
> scsi0 : pata_platform
> ata1: PATA max PIO6 mmio cmd 0x1c1000000 ctl 0x1c1000098 irq 32
> ata1.00: ATA-0: SMC01GBFK6E, CF080204, max MWDMA2
> ata1.00: 2001888 sectors, multi 0: LBA
> ata1.00: configured for PIO
> ata1.00: configured for PIO
> ata1: EH complete
> scsi 0:0:0:0: Direct-Access     ATA      SMC01GBFK6E      CF08 PQ: 0 ANSI: 5
> sd 0:0:0:0: [sda] 2001888 512-byte hardware sectors (1025 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> sd 0:0:0:0: [sda] 2001888 512-byte hardware sectors (1025 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
>  sda: sda1 sda2 sda3 sda4
> sd 0:0:0:0: [sda] Attached SCSI disk
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> 1fc000000.nor_flash: Found 1 x16 devices at 0x0 in 16-bit bank
>  Amd/Fujitsu Extended Query Table at 0x0040
> 1fc000000.nor_flash: CFI does not contain boot bank location. Assuming top.
> number of CFI chips: 1
> cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
> RedBoot partition parsing not available
> Creating 9 MTD partitions on "1fc000000.nor_flash":
> 0x00000000-0x00500000 : "kernel0"
> 0x00500000-0x00a00000 : "ramdisk0"
> 0x00a00000-0x00f00000 : "kernel1"
> 0x00f00000-0x01400000 : "ramdisk1"
> 0x01400000-0x01900000 : "kernel2"
> 0x01900000-0x01e00000 : "ramdisk2"
> 0x03f60000-0x03f80000 : "env0"
> 0x03f80000-0x03fa0000 : "env1"
> 0x03fa0000-0x04000000 : "u-boot"
> spi_ppc4xx_of 1ef600900.spi: driver initialized
> ppc-of-ehci e0000300.ehci: OF EHCI
> ppc-of-ehci e0000300.ehci: new USB bus registered, assigned bus number 1
> ppc-of-ehci e0000300.ehci: irq 34, io mem 0xe0000300
> ppc-of-ehci e0000300.ehci: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: OF EHCI
> usb usb1: Manufacturer: Linux 2.6.27.9-00045-gcccf182-dirty ehci_hcd
> usb usb1: SerialNumber: PPC-OF USB
> ppc-of-ohci e0000400.usb: OF OHCI
> ppc-of-ohci e0000400.usb: new USB bus registered, assigned bus number 2
> ppc-of-ohci e0000400.usb: irq 35, io mem 0xe0000400
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 1 port detected
> usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
> usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb2: Product: OF OHCI
> usb usb2: Manufacturer: Linux 2.6.27.9-00045-gcccf182-dirty ohci_hcd
> usb usb2: SerialNumber: PPC-OF USB
> Initializing USB Mass Storage driver...
> usbcore: registered new interface driver usb-storage
> USB Mass Storage support registered.
> i2c /dev entries driver
> rtc-m41t80 0-0068: chip found, driver version 0.05
> rtc-m41t80 0-0068: rtc core: registered m41t65 as rtc0
> ibm-iic 1ef600700.i2c: using standard (100 kHz) mode
> ibm-iic 1ef600800.i2c: using standard (100 kHz) mode
> at24 0-0052: 512 byte 24c04 EEPROM (writable)
> ad7414 0-0048: chip found
> TCP cubic registered
> NET: Registered protocol family 17
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> rtc-m41t80 0-0068: setting system clock to 2009-01-05 11:33:38 UTC (1231155218)
> eth0: link is down
> eth0: link is up, 100 FDX, pause enabled
> IP-Config: Complete:
>      device=eth0, addr=137.237.178.105, mask=255.255.255.0, gw=137.237.178.1,
>      host=hydra_temp, domain=, nis-domain=(none),
>      bootserver=137.237.179.31, rootserver=137.237.179.31, rootpath=
> Freeing unused kernel memory: 156k init
> Checking /dev/sda1
> Checking /dev/sda2
> Checking /dev/sda3
> Checking /dev/sda4
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on sda3, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on sda1, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on sda2, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on sda4, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> init started: BusyBox v1.10.4 (2008-10-27 12:52:02 EDT)
> starting pid 889, tty '/dev/ttyS0': '/etc/init.d/rcS'
> launcher[944]: launching /bin/craft on /dev/ttyS0
> Hydra>
