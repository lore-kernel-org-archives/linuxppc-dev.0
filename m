Return-Path: <minhtuanmt1@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.232])
	by ozlabs.org (Postfix) with ESMTP id 44C6ADDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Nov 2008 14:16:31 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2190827rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 02 Nov 2008 19:16:30 -0800 (PST)
Message-ID: <9a53cf970811021916w57a91188ma126591932b78feb@mail.gmail.com>
Date: Mon, 3 Nov 2008 10:16:30 +0700
From: "Minh Tuan Duong" <minhtuanmt1@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: LSISAS3041E-R PCIe card bring up failed on AMCC Canyonlands
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_46891_22464621.1225682190150"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_46891_22464621.1225682190150
Content-Type: multipart/alternative;
	boundary="----=_Part_46892_5504613.1225682190150"

------=_Part_46892_5504613.1225682190150
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I am having some problems with AMCC Canyonlands' PCIe. I've tried to bring
up LSISAS3041E-R PCIe card with Canyonlands but failed. It seems PCIe card
can be detected in U-boot but Linux (kernel linux-2.6-denx). I also followed
advice at http://marc.info/?l=linux-netdev&m=121602350226912&w=2 applying
kernel 2.6.26 from kernel.org but nothing is progress. Log file is attached.
Please let me know if you have any idea.

-- 
Thanks and best regards,
Tuan

=====================================================================================================
CPU:   AMCC PowerPC 460EX Rev. A at 800 MHz (PLB=200, OPB=100, EBC=100 MHz)
       Security/Kasumi support
       Bootstrap Option B - Boot ROM Location EBC (16 bits)
       Internal PCI arbiter disabled
       32 kB I-Cache 32 kB D-Cache
Board: Canyonlands - AMCC PPC460EX Evaluation Board, 2*PCIe, Rev. 14
I2C:   ready
DTT:   1 is 48 C
DRAM:  512 MB (ECC not enabled, 400 MHz, CL3)
FLASH: 64 MB
NAND:  128 MiB
PCI:   Bus Dev VenId DevId Class Int
PCIE0: link is not up.
PCIE0: initialization as root-complex failed
PCIE1: successfully set as root-complex
        02  00  1000  0056  0100  00
        01  00  aaa1  bed1  0604  00
Net:   ppc_4xx_eth0, ppc_4xx_eth1

Type run flash_nfs to mount root filesystem over NFS

Hit any key to stop autoboot:  0
=> pci 1
Scanning PCI devices on bus 1
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
01.00.00   0xaaa1     0xbed1     Bridge device           0x04
=> pci 2
Scanning PCI devices on bus 2
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
02.00.00   0x1000     0x0056     Mass storage controller 0x00
=> run net_nfs
Waiting for PHY auto negotiation to complete.. done
ENET Speed is 100 Mbps - FULL duplex connection (EMAC0)
Using ppc_4xx_eth0 device
TFTP from server 10.38.12.201; our IP address is 10.38.12.229
Filename 'canyonlands/uImage'.
Load address: 0x400000
Loading: #################################################################
         ############################
done
Bytes transferred = 1352171 (14a1eb hex)
ENET Speed is 100 Mbps - FULL duplex connection (EMAC0)
Using ppc_4xx_eth0 device
TFTP from server 10.38.12.201; our IP address is 10.38.12.229
Filename 'canyonlands/canyonlands.dtb'.
Load address: 0xfc1e0000
Loading: #
done
Bytes transferred = 12288 (3000 hex)
## Booting kernel from Legacy Image at 00400000 ...
   Image Name:   Linux-2.6.26
   Created:      2008-10-31  10:38:58 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1352107 Bytes =  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Flattened Device Tree blob at fc1e0000
   Booting using the fdt blob at 0xfc1e0000
   Loading Device Tree to 007fc000, end 007ff188 ... OK
Using Canyonlands machine description
Linux version 2.6.26 (tuan@Saigon) (gcc version 4.0.0 (DENX ELDK 4.1 4.0.0))
#2 Fri Oct 31 17:38:56 ICT 2008
Zone PFN ranges:
  DMA             0 ->   131072
  Normal     131072 ->   131072
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   131072
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: root=/dev/nfs rw nfsroot=10.38.12.201:/opt/eldk/ppc_4xxFP
ip=10.38.12.229:10.38.12.201:10.38.12.1:255.255.252.0:canyonlands:eth0:off
panic=1 console=ttyS0,115200
UIC0 (32 IRQ sources) at DCR 0xc0
UIC1 (32 IRQ sources) at DCR 0xd0
UIC2 (32 IRQ sources) at DCR 0xe0
UIC3 (32 IRQ sources) at DCR 0xf0
PID hash table entries: 2048 (order: 11, 8192 bytes)
clocksource: timebase mult[500000] shift[22] registered
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 516608k/524288k available (2648k kernel code, 7440k reserved, 112k
data, 128k bss, 148k init)
SLUB: Genslabs=10, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Mount-cache hash table entries: 512
net_namespace: 192 bytes
NET: Registered protocol family 16
256k L2-cache enabled
PCIE0: Checking link...
PCIE0: No device detected.
PCI host bridge /plb/pciex@d00000000 (primary) ranges:
 MEM 0x0000000e00000000..0x0000000e7fffffff -> 0x0000000080000000
  IO 0x0000000f80000000..0x0000000f8000ffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCIE0: successfully set as root-complex
PCIE1: Checking link...
PCIE1: Device detected, waiting for link...
PCIE1: link is up !
PCI host bridge /plb/pciex@d20000000 (primary) ranges:
 MEM 0x0000000e80000000..0x0000000effffffff -> 0x0000000080000000
  IO 0x0000000f80010000..0x0000000f8001ffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCIE1: successfully set as root-complex
PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
 MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000
  IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCI: Probing PCI hardware
PCI: Hiding 4xx host bridge resources 0000:40:00.0
PCI: Hiding 4xx host bridge resources 0001:80:00.0
PCI: Bridge: 0000:40:00.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0001:80:00.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 16384 (order: 4, 65536 bytes)
TCP established hash table entries: 65536 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
TCP reno registered
NET: Registered protocol family 1
msgmni has been set to 1009
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
aer: probe of 0000:40:00.0:pcie01 failed with error -38
aer: probe of 0001:80:00.0:pcie01 failed with error -38
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq = 18) is a 16550A
console [ttyS0] enabled
serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq = 19) is a 16550A
serial8250.0: ttyS2 at MMIO 0x4ef600500 (irq = 29) is a 16550A
serial8250.0: ttyS3 at MMIO 0x4ef600600 (irq = 20) is a 16550A
4ef600300.serial: ttyS0 at MMIO 0x4ef600300 (irq = 18) is a 16550A
4ef600400.serial: ttyS1 at MMIO 0x4ef600400 (irq = 19) is a 16550A
4ef600500.serial: ttyS2 at MMIO 0x4ef600500 (irq = 29) is a 16550A
4ef600600.serial: ttyS3 at MMIO 0x4ef600600 (irq = 20) is a 16550A
brd: module loaded
PPC 4xx OCP EMAC driver, version 3.54
MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels
ZMII /plb/opb/emac-zmii@ef600d00 initialized
RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support
TAH /plb/opb/emac-tah@ef601350 initialized
TAH /plb/opb/emac-tah@ef601450 initialized
/plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:10:ec:00:f9:f6
eth0: found Generic MII PHY (0x00)
/plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode
eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:10:ec:80:f9:f6
eth1: found Generic MII PHY (0x01)
Fusion MPT base driver 3.04.06
Copyright (c) 1999-2007 LSI Corporation
Fusion MPT SPI Host driver 3.04.06
Fusion MPT FC Host driver 3.04.06
Fusion MPT SAS Host driver 3.04.06
Fusion MPT misc device (ioctl) driver 3.04.06
mptctl: Registered with Fusion MPT base driver
mptctl: /dev/mptctl @ (major,minor=10,220)
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
eth0: link is down
IP-Config: Complete:
     device=eth0, addr=10.38.12.229, mask=255.255.252.0, gw=10.38.12.1,
     host=canyonlands, domain=, nis-domain=(none),
     bootserver=10.38.12.201, rootserver=10.38.12.201, rootpath=
Looking up port of RPC 100003/2 on 10.38.12.201
eth0: link is up, 100 FDX, pause enabled
Looking up port of RPC 100005/1 on 10.38.12.201
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 148k init
modprobe: FATAL: Could not load /lib/modules/2.6.26/modules.dep: No such
file or directory

modprobe: FATAL: Could not load /lib/modules/2.6.26/modules.dep: No such
file or directory

INIT: version 2.85 booting
                Welcome to DENX Embedded Linux Environment
                Press 'I' to enter interactive startup.
Building the cache [  OK  ]
 storage network audio done[  OK  ]
modprobe: FATAL: Could not load /lib/modules/2.6.26/modules.dep: No such
file or directory

Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access
method.
Setting clock : Thu Jan  1 00:00:05 UTC 1970 [  OK  ]
Setting hostname canyonlands:  [  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling swap space:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Bringing up loopback interface:  [  OK  ]
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting portmap: [  OK  ]
Mounting NFS filesystems:  [  OK  ]
Mounting other filesystems:  [  OK  ]
Starting xinetd: [  OK  ]

DENX ELDK version 4.1 build 2007-01-19
Linux 2.6.26 on a ppc

canyonlands login: root
Last login: Sat Jul 12 02:53:28 on console
bash-3.00# uname -r
2.6.26
bash-3.00# lspci
40:00.0 PCI bridge: Unknown device aaa0:bed0 (rev 01)
80:00.0 PCI bridge: Unknown device aaa1:bed1 (rev 01)
bash-3.00# cat /proc/interrupts
           CPU0
 18:        252   UIC   Level     serial
 21:       6032   UIC   Level     MAL TX EOB
 22:      11737   UIC   Level     MAL RX EOB
 23:          0   UIC   Edge      L2C
 24:          0   UIC   Level     MAL SERR
 25:          0   UIC   Level     MAL TX DE
 26:          0   UIC   Level     MAL RX DE
 27:          0   UIC   Level     EMAC
BAD:          0
bash-3.00# cat /proc/devices
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
 10 misc
 21 sg
128 ptm
136 pts

Block devices:
  1 ramdisk
bash-3.00#

=====================================================================================================

------=_Part_46892_5504613.1225682190150
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,<br><br>I am having some problems with AMCC Canyonlands&#39; PCIe. I&#39;ve tried to bring up LSISAS3041E-R PCIe card with Canyonlands but failed. It seems PCIe card can be detected in U-boot but Linux (kernel linux-2.6-denx). I also followed advice at <a href="http://marc.info/?l=linux-netdev&amp;m=121602350226912&amp;w=2">http://marc.info/?l=linux-netdev&amp;m=121602350226912&amp;w=2</a> applying kernel 2.6.26 from <a href="http://kernel.org">kernel.org</a> but nothing is progress. Log file is attached.<br>
Please let me know if you have any idea.<br><br>-- <br>Thanks and best regards,<br>Tuan<br><br>=====================================================================================================<br>CPU:&nbsp;&nbsp; AMCC PowerPC 460EX Rev. A at 800 MHz (PLB=200, OPB=100, EBC=100 MHz)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Security/Kasumi support<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bootstrap Option B - Boot ROM Location EBC (16 bits)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal PCI arbiter disabled<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32 kB I-Cache 32 kB D-Cache<br>Board: Canyonlands - AMCC PPC460EX Evaluation Board, 2*PCIe, Rev. 14<br>
I2C:&nbsp;&nbsp; ready<br>DTT:&nbsp;&nbsp; 1 is 48 C<br>DRAM:&nbsp; 512 MB (ECC not enabled, 400 MHz, CL3)<br>FLASH: 64 MB<br>NAND:&nbsp; 128 MiB<br>PCI:&nbsp;&nbsp; Bus Dev VenId DevId Class Int<br>PCIE0: link is not up.<br>PCIE0: initialization as root-complex failed<br>
PCIE1: successfully set as root-complex<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 02&nbsp; 00&nbsp; 1000&nbsp; 0056&nbsp; 0100&nbsp; 00<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01&nbsp; 00&nbsp; aaa1&nbsp; bed1&nbsp; 0604&nbsp; 00<br>Net:&nbsp;&nbsp; ppc_4xx_eth0, ppc_4xx_eth1<br><br>Type run flash_nfs to mount root filesystem over NFS<br><br>
Hit any key to stop autoboot:&nbsp; 0<br>=&gt; pci 1<br>Scanning PCI devices on bus 1<br>BusDevFun&nbsp; VendorId&nbsp;&nbsp; DeviceId&nbsp;&nbsp; Device Class&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sub-Class<br>_____________________________________________________________<br>01.00.00&nbsp;&nbsp; 0xaaa1&nbsp;&nbsp;&nbsp;&nbsp; 0xbed1&nbsp;&nbsp;&nbsp;&nbsp; Bridge device&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x04<br>
=&gt; pci 2<br>Scanning PCI devices on bus 2<br>BusDevFun&nbsp; VendorId&nbsp;&nbsp; DeviceId&nbsp;&nbsp; Device Class&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sub-Class<br>_____________________________________________________________<br>02.00.00&nbsp;&nbsp; 0x1000&nbsp;&nbsp;&nbsp;&nbsp; 0x0056&nbsp;&nbsp;&nbsp;&nbsp; Mass storage controller 0x00<br>
=&gt; run net_nfs<br>Waiting for PHY auto negotiation to complete.. done<br>ENET Speed is 100 Mbps - FULL duplex connection (EMAC0)<br>Using ppc_4xx_eth0 device<br>TFTP from server <a href="http://10.38.12.201">10.38.12.201</a>; our IP address is <a href="http://10.38.12.229">10.38.12.229</a><br>
Filename &#39;canyonlands/uImage&#39;.<br>Load address: 0x400000<br>Loading: #################################################################<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ############################<br>done<br>Bytes transferred = 1352171 (14a1eb hex)<br>
ENET Speed is 100 Mbps - FULL duplex connection (EMAC0)<br>Using ppc_4xx_eth0 device<br>TFTP from server <a href="http://10.38.12.201">10.38.12.201</a>; our IP address is <a href="http://10.38.12.229">10.38.12.229</a><br>
Filename &#39;canyonlands/canyonlands.dtb&#39;.<br>Load address: 0xfc1e0000<br>Loading: #<br>done<br>Bytes transferred = 12288 (3000 hex)<br>## Booting kernel from Legacy Image at 00400000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.26<br>
&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2008-10-31&nbsp; 10:38:58 UTC<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1352107 Bytes =&nbsp; 1.3 MB<br>&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<br>## Flattened Device Tree blob at fc1e0000<br>&nbsp;&nbsp; Booting using the fdt blob at 0xfc1e0000<br>&nbsp;&nbsp; Loading Device Tree to 007fc000, end 007ff188 ... OK<br>Using Canyonlands machine description<br>
Linux version 2.6.26 (tuan@Saigon) (gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) #2 Fri Oct 31 17:38:56 ICT 2008<br>Zone PFN ranges:<br>&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp; 131072<br>&nbsp; Normal&nbsp;&nbsp;&nbsp;&nbsp; 131072 -&gt;&nbsp;&nbsp; 131072<br>Movable zone start PFN for each node<br>
early_node_map[1] active PFN ranges<br>&nbsp;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp; 131072<br>Built 1 zonelists in Zone order, mobility grouping on.&nbsp; Total pages: 130048<br>Kernel command line: root=/dev/nfs rw nfsroot=10.38.12.201:/opt/eldk/ppc_4xxFP ip=10.38.12.229:10.38.12.201:10.38.12.1:255.255.252.0:canyonlands:eth0:off panic=1 console=ttyS0,115200<br>
UIC0 (32 IRQ sources) at DCR 0xc0<br>UIC1 (32 IRQ sources) at DCR 0xd0<br>UIC2 (32 IRQ sources) at DCR 0xe0<br>UIC3 (32 IRQ sources) at DCR 0xf0<br>PID hash table entries: 2048 (order: 11, 8192 bytes)<br>clocksource: timebase mult[500000] shift[22] registered<br>
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)<br>Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)<br>Memory: 516608k/524288k available (2648k kernel code, 7440k reserved, 112k data, 128k bss, 148k init)<br>
SLUB: Genslabs=10, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1<br>Mount-cache hash table entries: 512<br>net_namespace: 192 bytes<br>NET: Registered protocol family 16<br>256k L2-cache enabled<br>PCIE0: Checking link...<br>
PCIE0: No device detected.<br>PCI host bridge /plb/pciex@d00000000 (primary) ranges:<br>&nbsp;MEM 0x0000000e00000000..0x0000000e7fffffff -&gt; 0x0000000080000000<br>&nbsp; IO 0x0000000f80000000..0x0000000f8000ffff -&gt; 0x0000000000000000<br>
4xx PCI DMA offset set to 0x00000000<br>PCIE0: successfully set as root-complex<br>PCIE1: Checking link...<br>PCIE1: Device detected, waiting for link...<br>PCIE1: link is up !<br>PCI host bridge /plb/pciex@d20000000 (primary) ranges:<br>
&nbsp;MEM 0x0000000e80000000..0x0000000effffffff -&gt; 0x0000000080000000<br>&nbsp; IO 0x0000000f80010000..0x0000000f8001ffff -&gt; 0x0000000000000000<br>4xx PCI DMA offset set to 0x00000000<br>PCIE1: successfully set as root-complex<br>
PCI host bridge /plb/pci@c0ec00000 (primary) ranges:<br>&nbsp;MEM 0x0000000d80000000..0x0000000dffffffff -&gt; 0x0000000080000000<br>&nbsp; IO 0x0000000c08000000..0x0000000c0800ffff -&gt; 0x0000000000000000<br>4xx PCI DMA offset set to 0x00000000<br>
PCI: Probing PCI hardware<br>PCI: Hiding 4xx host bridge resources 0000:40:00.0<br>PCI: Hiding 4xx host bridge resources 0001:80:00.0<br>PCI: Bridge: 0000:40:00.0<br>&nbsp; IO window: disabled.<br>&nbsp; MEM window: disabled.<br>&nbsp; PREFETCH window: disabled.<br>
PCI: Bridge: 0001:80:00.0<br>&nbsp; IO window: disabled.<br>&nbsp; MEM window: disabled.<br>&nbsp; PREFETCH window: disabled.<br>SCSI subsystem initialized<br>NET: Registered protocol family 2<br>IP route cache hash table entries: 16384 (order: 4, 65536 bytes)<br>
TCP established hash table entries: 65536 (order: 7, 524288 bytes)<br>TCP bind hash table entries: 65536 (order: 6, 262144 bytes)<br>TCP: Hash tables configured (established 65536 bind 65536)<br>TCP reno registered<br>NET: Registered protocol family 1<br>
msgmni has been set to 1009<br>io scheduler noop registered<br>io scheduler anticipatory registered (default)<br>io scheduler deadline registered<br>io scheduler cfq registered<br>assign_interrupt_mode Found MSI capability<br>
assign_interrupt_mode Found MSI capability<br>aer: probe of 0000:40:00.0:pcie01 failed with error -38<br>aer: probe of 0001:80:00.0:pcie01 failed with error -38<br>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled<br>
serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq = 18) is a 16550A<br>console [ttyS0] enabled<br>serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq = 19) is a 16550A<br>serial8250.0: ttyS2 at MMIO 0x4ef600500 (irq = 29) is a 16550A<br>
serial8250.0: ttyS3 at MMIO 0x4ef600600 (irq = 20) is a 16550A<br>4ef600300.serial: ttyS0 at MMIO 0x4ef600300 (irq = 18) is a 16550A<br>4ef600400.serial: ttyS1 at MMIO 0x4ef600400 (irq = 19) is a 16550A<br>4ef600500.serial: ttyS2 at MMIO 0x4ef600500 (irq = 29) is a 16550A<br>
4ef600600.serial: ttyS3 at MMIO 0x4ef600600 (irq = 20) is a 16550A<br>brd: module loaded<br>PPC 4xx OCP EMAC driver, version 3.54<br>MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels<br>ZMII /plb/opb/emac-zmii@ef600d00 initialized<br>
RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support<br>TAH /plb/opb/emac-tah@ef601350 initialized<br>TAH /plb/opb/emac-tah@ef601450 initialized<br>/plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode<br>eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:10:ec:00:f9:f6<br>
eth0: found Generic MII PHY (0x00)<br>/plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode<br>eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:10:ec:80:f9:f6<br>eth1: found Generic MII PHY (0x01)<br>Fusion MPT base driver 3.04.06<br>
Copyright (c) 1999-2007 LSI Corporation<br>Fusion MPT SPI Host driver 3.04.06<br>Fusion MPT FC Host driver 3.04.06<br>Fusion MPT SAS Host driver 3.04.06<br>Fusion MPT misc device (ioctl) driver 3.04.06<br>mptctl: Registered with Fusion MPT base driver<br>
mptctl: /dev/mptctl @ (major,minor=10,220)<br>TCP cubic registered<br>NET: Registered protocol family 17<br>RPC: Registered udp transport module.<br>RPC: Registered tcp transport module.<br>eth0: link is down<br>IP-Config: Complete:<br>
&nbsp;&nbsp;&nbsp;&nbsp; device=eth0, addr=<a href="http://10.38.12.229">10.38.12.229</a>, mask=<a href="http://255.255.252.0">255.255.252.0</a>, gw=<a href="http://10.38.12.1">10.38.12.1</a>,<br>&nbsp;&nbsp;&nbsp;&nbsp; host=canyonlands, domain=, nis-domain=(none),<br>
&nbsp;&nbsp;&nbsp;&nbsp; bootserver=<a href="http://10.38.12.201">10.38.12.201</a>, rootserver=<a href="http://10.38.12.201">10.38.12.201</a>, rootpath=<br>Looking up port of RPC 100003/2 on <a href="http://10.38.12.201">10.38.12.201</a><br>
eth0: link is up, 100 FDX, pause enabled<br>Looking up port of RPC 100005/1 on <a href="http://10.38.12.201">10.38.12.201</a><br>VFS: Mounted root (nfs filesystem).<br>Freeing unused kernel memory: 148k init<br>modprobe: FATAL: Could not load /lib/modules/2.6.26/modules.dep: No such file or directory<br>
<br>modprobe: FATAL: Could not load /lib/modules/2.6.26/modules.dep: No such file or directory<br><br>INIT: version 2.85 booting<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Welcome to DENX Embedded Linux Environment<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Press &#39;I&#39; to enter interactive startup.<br>
Building the cache [&nbsp; OK&nbsp; ]<br>&nbsp;storage network audio done[&nbsp; OK&nbsp; ]<br>modprobe: FATAL: Could not load /lib/modules/2.6.26/modules.dep: No such file or directory<br><br>Cannot access the Hardware Clock via any known method.<br>
Use the --debug option to see the details of our search for an access method.<br>Setting clock : Thu Jan&nbsp; 1 00:00:05 UTC 1970 [&nbsp; OK&nbsp; ]<br>Setting hostname canyonlands:&nbsp; [&nbsp; OK&nbsp; ]<br>Mounting local filesystems:&nbsp; [&nbsp; OK&nbsp; ]<br>
Enabling swap space:&nbsp; [&nbsp; OK&nbsp; ]<br>INIT: Entering runlevel: 3<br>Entering non-interactive startup<br>Bringing up loopback interface:&nbsp; [&nbsp; OK&nbsp; ]<br>Starting system logger: [&nbsp; OK&nbsp; ]<br>Starting kernel logger: [&nbsp; OK&nbsp; ]<br>Starting portmap: [&nbsp; OK&nbsp; ]<br>
Mounting NFS filesystems:&nbsp; [&nbsp; OK&nbsp; ]<br>Mounting other filesystems:&nbsp; [&nbsp; OK&nbsp; ]<br>Starting xinetd: [&nbsp; OK&nbsp; ]<br><br>DENX ELDK version 4.1 build 2007-01-19<br>Linux 2.6.26 on a ppc<br><br>canyonlands login: root<br>Last login: Sat Jul 12 02:53:28 on console<br>
bash-3.00# uname -r<br>2.6.26<br>bash-3.00# lspci<br>40:00.0 PCI bridge: Unknown device aaa0:bed0 (rev 01)<br>80:00.0 PCI bridge: Unknown device aaa1:bed1 (rev 01)<br>bash-3.00# cat /proc/interrupts<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<br>
&nbsp;18:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 252&nbsp;&nbsp; UIC&nbsp;&nbsp; Level&nbsp;&nbsp;&nbsp;&nbsp; serial<br>&nbsp;21:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6032&nbsp;&nbsp; UIC&nbsp;&nbsp; Level&nbsp;&nbsp;&nbsp;&nbsp; MAL TX EOB<br>&nbsp;22:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11737&nbsp;&nbsp; UIC&nbsp;&nbsp; Level&nbsp;&nbsp;&nbsp;&nbsp; MAL RX EOB<br>&nbsp;23:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; UIC&nbsp;&nbsp; Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; L2C<br>&nbsp;24:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; UIC&nbsp;&nbsp; Level&nbsp;&nbsp;&nbsp;&nbsp; MAL SERR<br>
&nbsp;25:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; UIC&nbsp;&nbsp; Level&nbsp;&nbsp;&nbsp;&nbsp; MAL TX DE<br>&nbsp;26:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; UIC&nbsp;&nbsp; Level&nbsp;&nbsp;&nbsp;&nbsp; MAL RX DE<br>&nbsp;27:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; UIC&nbsp;&nbsp; Level&nbsp;&nbsp;&nbsp;&nbsp; EMAC<br>BAD:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>bash-3.00# cat /proc/devices<br>Character devices:<br>&nbsp; 1 mem<br>&nbsp; 2 pty<br>
&nbsp; 3 ttyp<br>&nbsp; 4 ttyS<br>&nbsp; 5 /dev/tty<br>&nbsp; 5 /dev/console<br>&nbsp; 5 /dev/ptmx<br>&nbsp;10 misc<br>&nbsp;21 sg<br>128 ptm<br>136 pts<br><br>Block devices:<br>&nbsp; 1 ramdisk<br>bash-3.00#<br><br>=====================================================================================================<br>
<br>

------=_Part_46892_5504613.1225682190150--

------=_Part_46891_22464621.1225682190150
Content-Type: text/plain; name=log.txt
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fn2jedcs0
Content-Disposition: attachment; filename=log.txt

Q1BVOiAgIEFNQ0MgUG93ZXJQQyA0NjBFWCBSZXYuIEEgYXQgODAwIE1IeiAoUExCPTIwMCwgT1BC
PTEwMCwgRUJDPTEwMCBNSHopDQogICAgICAgU2VjdXJpdHkvS2FzdW1pIHN1cHBvcnQNCiAgICAg
ICBCb290c3RyYXAgT3B0aW9uIEIgLSBCb290IFJPTSBMb2NhdGlvbiBFQkMgKDE2IGJpdHMpDQog
ICAgICAgSW50ZXJuYWwgUENJIGFyYml0ZXIgZGlzYWJsZWQNCiAgICAgICAzMiBrQiBJLUNhY2hl
IDMyIGtCIEQtQ2FjaGUNCkJvYXJkOiBDYW55b25sYW5kcyAtIEFNQ0MgUFBDNDYwRVggRXZhbHVh
dGlvbiBCb2FyZCwgMipQQ0llLCBSZXYuIDE0DQpJMkM6ICAgcmVhZHkNCkRUVDogICAxIGlzIDQ4
IEMNCkRSQU06ICA1MTIgTUIgKEVDQyBub3QgZW5hYmxlZCwgNDAwIE1IeiwgQ0wzKQ0KRkxBU0g6
IDY0IE1CDQpOQU5EOiAgMTI4IE1pQg0KUENJOiAgIEJ1cyBEZXYgVmVuSWQgRGV2SWQgQ2xhc3Mg
SW50DQpQQ0lFMDogbGluayBpcyBub3QgdXAuDQpQQ0lFMDogaW5pdGlhbGl6YXRpb24gYXMgcm9v
dC1jb21wbGV4IGZhaWxlZA0KUENJRTE6IHN1Y2Nlc3NmdWxseSBzZXQgYXMgcm9vdC1jb21wbGV4
DQogICAgICAgIDAyICAwMCAgMTAwMCAgMDA1NiAgMDEwMCAgMDANCiAgICAgICAgMDEgIDAwICBh
YWExICBiZWQxICAwNjA0ICAwMA0KTmV0OiAgIHBwY180eHhfZXRoMCwgcHBjXzR4eF9ldGgxDQoN
ClR5cGUgcnVuIGZsYXNoX25mcyB0byBtb3VudCByb290IGZpbGVzeXN0ZW0gb3ZlciBORlMNCg0K
SGl0IGFueSBrZXkgdG8gc3RvcCBhdXRvYm9vdDogIDANCj0+IHBjaSAxDQpTY2FubmluZyBQQ0kg
ZGV2aWNlcyBvbiBidXMgMQ0KQnVzRGV2RnVuICBWZW5kb3JJZCAgIERldmljZUlkICAgRGV2aWNl
IENsYXNzICAgICAgIFN1Yi1DbGFzcw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KMDEuMDAuMDAgICAweGFhYTEgICAgIDB4YmVk
MSAgICAgQnJpZGdlIGRldmljZSAgICAgICAgICAgMHgwNA0KPT4gcGNpIDINClNjYW5uaW5nIFBD
SSBkZXZpY2VzIG9uIGJ1cyAyDQpCdXNEZXZGdW4gIFZlbmRvcklkICAgRGV2aWNlSWQgICBEZXZp
Y2UgQ2xhc3MgICAgICAgU3ViLUNsYXNzDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQowMi4wMC4wMCAgIDB4MTAwMCAgICAgMHgw
MDU2ICAgICBNYXNzIHN0b3JhZ2UgY29udHJvbGxlciAweDAwDQo9PiBydW4gbmV0X25mcw0KV2Fp
dGluZyBmb3IgUEhZIGF1dG8gbmVnb3RpYXRpb24gdG8gY29tcGxldGUuLiBkb25lDQpFTkVUIFNw
ZWVkIGlzIDEwMCBNYnBzIC0gRlVMTCBkdXBsZXggY29ubmVjdGlvbiAoRU1BQzApDQpVc2luZyBw
cGNfNHh4X2V0aDAgZGV2aWNlDQpURlRQIGZyb20gc2VydmVyIDEwLjM4LjEyLjIwMTsgb3VyIElQ
IGFkZHJlc3MgaXMgMTAuMzguMTIuMjI5DQpGaWxlbmFtZSAnY2FueW9ubGFuZHMvdUltYWdlJy4N
CkxvYWQgYWRkcmVzczogMHg0MDAwMDANCkxvYWRpbmc6ICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQogICAgICAgICAjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQpkb25lDQpCeXRlcyB0cmFuc2ZlcnJlZCA9IDEzNTIx
NzEgKDE0YTFlYiBoZXgpDQpFTkVUIFNwZWVkIGlzIDEwMCBNYnBzIC0gRlVMTCBkdXBsZXggY29u
bmVjdGlvbiAoRU1BQzApDQpVc2luZyBwcGNfNHh4X2V0aDAgZGV2aWNlDQpURlRQIGZyb20gc2Vy
dmVyIDEwLjM4LjEyLjIwMTsgb3VyIElQIGFkZHJlc3MgaXMgMTAuMzguMTIuMjI5DQpGaWxlbmFt
ZSAnY2FueW9ubGFuZHMvY2FueW9ubGFuZHMuZHRiJy4NCkxvYWQgYWRkcmVzczogMHhmYzFlMDAw
MA0KTG9hZGluZzogIw0KZG9uZQ0KQnl0ZXMgdHJhbnNmZXJyZWQgPSAxMjI4OCAoMzAwMCBoZXgp
DQojIyBCb290aW5nIGtlcm5lbCBmcm9tIExlZ2FjeSBJbWFnZSBhdCAwMDQwMDAwMCAuLi4NCiAg
IEltYWdlIE5hbWU6ICAgTGludXgtMi42LjI2DQogICBDcmVhdGVkOiAgICAgIDIwMDgtMTAtMzEg
IDEwOjM4OjU4IFVUQw0KICAgSW1hZ2UgVHlwZTogICBQb3dlclBDIExpbnV4IEtlcm5lbCBJbWFn
ZSAoZ3ppcCBjb21wcmVzc2VkKQ0KICAgRGF0YSBTaXplOiAgICAxMzUyMTA3IEJ5dGVzID0gIDEu
MyBNQg0KICAgTG9hZCBBZGRyZXNzOiAwMDAwMDAwMA0KICAgRW50cnkgUG9pbnQ6ICAwMDAwMDAw
MA0KICAgVmVyaWZ5aW5nIENoZWNrc3VtIC4uLiBPSw0KICAgVW5jb21wcmVzc2luZyBLZXJuZWwg
SW1hZ2UgLi4uIE9LDQojIyBGbGF0dGVuZWQgRGV2aWNlIFRyZWUgYmxvYiBhdCBmYzFlMDAwMA0K
ICAgQm9vdGluZyB1c2luZyB0aGUgZmR0IGJsb2IgYXQgMHhmYzFlMDAwMA0KICAgTG9hZGluZyBE
ZXZpY2UgVHJlZSB0byAwMDdmYzAwMCwgZW5kIDAwN2ZmMTg4IC4uLiBPSw0KVXNpbmcgQ2FueW9u
bGFuZHMgbWFjaGluZSBkZXNjcmlwdGlvbg0KTGludXggdmVyc2lvbiAyLjYuMjYgKHR1YW5AU2Fp
Z29uKSAoZ2NjIHZlcnNpb24gNC4wLjAgKERFTlggRUxESyA0LjEgNC4wLjApKSAjMiBGcmkgT2N0
IDMxIDE3OjM4OjU2IElDVCAyMDA4DQpab25lIFBGTiByYW5nZXM6DQogIERNQSAgICAgICAgICAg
ICAwIC0+ICAgMTMxMDcyDQogIE5vcm1hbCAgICAgMTMxMDcyIC0+ICAgMTMxMDcyDQpNb3ZhYmxl
IHpvbmUgc3RhcnQgUEZOIGZvciBlYWNoIG5vZGUNCmVhcmx5X25vZGVfbWFwWzFdIGFjdGl2ZSBQ
Rk4gcmFuZ2VzDQogICAgMDogICAgICAgIDAgLT4gICAxMzEwNzINCkJ1aWx0IDEgem9uZWxpc3Rz
IGluIFpvbmUgb3JkZXIsIG1vYmlsaXR5IGdyb3VwaW5nIG9uLiAgVG90YWwgcGFnZXM6IDEzMDA0
OA0KS2VybmVsIGNvbW1hbmQgbGluZTogcm9vdD0vZGV2L25mcyBydyBuZnNyb290PTEwLjM4LjEy
LjIwMTovb3B0L2VsZGsvcHBjXzR4eEZQIGlwPTEwLjM4LjEyLjIyOToxMC4zOC4xMi4yMDE6MTAu
MzguMTIuMToyNTUuMjU1LjI1Mi4wOmNhbnlvbmxhbmRzOmV0aDA6b2ZmIHBhbmljPTEgY29uc29s
ZT10dHlTMCwxMTUyMDANClVJQzAgKDMyIElSUSBzb3VyY2VzKSBhdCBEQ1IgMHhjMA0KVUlDMSAo
MzIgSVJRIHNvdXJjZXMpIGF0IERDUiAweGQwDQpVSUMyICgzMiBJUlEgc291cmNlcykgYXQgRENS
IDB4ZTANClVJQzMgKDMyIElSUSBzb3VyY2VzKSBhdCBEQ1IgMHhmMA0KUElEIGhhc2ggdGFibGUg
ZW50cmllczogMjA0OCAob3JkZXI6IDExLCA4MTkyIGJ5dGVzKQ0KY2xvY2tzb3VyY2U6IHRpbWVi
YXNlIG11bHRbNTAwMDAwXSBzaGlmdFsyMl0gcmVnaXN0ZXJlZA0KRGVudHJ5IGNhY2hlIGhhc2gg
dGFibGUgZW50cmllczogNjU1MzYgKG9yZGVyOiA2LCAyNjIxNDQgYnl0ZXMpDQpJbm9kZS1jYWNo
ZSBoYXNoIHRhYmxlIGVudHJpZXM6IDMyNzY4IChvcmRlcjogNSwgMTMxMDcyIGJ5dGVzKQ0KTWVt
b3J5OiA1MTY2MDhrLzUyNDI4OGsgYXZhaWxhYmxlICgyNjQ4ayBrZXJuZWwgY29kZSwgNzQ0MGsg
cmVzZXJ2ZWQsIDExMmsgZGF0YSwgMTI4ayBic3MsIDE0OGsgaW5pdCkNClNMVUI6IEdlbnNsYWJz
PTEwLCBIV2FsaWduPTMyLCBPcmRlcj0wLTMsIE1pbk9iamVjdHM9MCwgQ1BVcz0xLCBOb2Rlcz0x
DQpNb3VudC1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDUxMg0KbmV0X25hbWVzcGFjZTogMTky
IGJ5dGVzDQpORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDE2DQoyNTZrIEwyLWNhY2hl
IGVuYWJsZWQNClBDSUUwOiBDaGVja2luZyBsaW5rLi4uDQpQQ0lFMDogTm8gZGV2aWNlIGRldGVj
dGVkLg0KUENJIGhvc3QgYnJpZGdlIC9wbGIvcGNpZXhAZDAwMDAwMDAwIChwcmltYXJ5KSByYW5n
ZXM6DQogTUVNIDB4MDAwMDAwMGUwMDAwMDAwMC4uMHgwMDAwMDAwZTdmZmZmZmZmIC0+IDB4MDAw
MDAwMDA4MDAwMDAwMA0KICBJTyAweDAwMDAwMDBmODAwMDAwMDAuLjB4MDAwMDAwMGY4MDAwZmZm
ZiAtPiAweDAwMDAwMDAwMDAwMDAwMDANCjR4eCBQQ0kgRE1BIG9mZnNldCBzZXQgdG8gMHgwMDAw
MDAwMA0KUENJRTA6IHN1Y2Nlc3NmdWxseSBzZXQgYXMgcm9vdC1jb21wbGV4DQpQQ0lFMTogQ2hl
Y2tpbmcgbGluay4uLg0KUENJRTE6IERldmljZSBkZXRlY3RlZCwgd2FpdGluZyBmb3IgbGluay4u
Lg0KUENJRTE6IGxpbmsgaXMgdXAgIQ0KUENJIGhvc3QgYnJpZGdlIC9wbGIvcGNpZXhAZDIwMDAw
MDAwIChwcmltYXJ5KSByYW5nZXM6DQogTUVNIDB4MDAwMDAwMGU4MDAwMDAwMC4uMHgwMDAwMDAw
ZWZmZmZmZmZmIC0+IDB4MDAwMDAwMDA4MDAwMDAwMA0KICBJTyAweDAwMDAwMDBmODAwMTAwMDAu
LjB4MDAwMDAwMGY4MDAxZmZmZiAtPiAweDAwMDAwMDAwMDAwMDAwMDANCjR4eCBQQ0kgRE1BIG9m
ZnNldCBzZXQgdG8gMHgwMDAwMDAwMA0KUENJRTE6IHN1Y2Nlc3NmdWxseSBzZXQgYXMgcm9vdC1j
b21wbGV4DQpQQ0kgaG9zdCBicmlkZ2UgL3BsYi9wY2lAYzBlYzAwMDAwIChwcmltYXJ5KSByYW5n
ZXM6DQogTUVNIDB4MDAwMDAwMGQ4MDAwMDAwMC4uMHgwMDAwMDAwZGZmZmZmZmZmIC0+IDB4MDAw
MDAwMDA4MDAwMDAwMA0KICBJTyAweDAwMDAwMDBjMDgwMDAwMDAuLjB4MDAwMDAwMGMwODAwZmZm
ZiAtPiAweDAwMDAwMDAwMDAwMDAwMDANCjR4eCBQQ0kgRE1BIG9mZnNldCBzZXQgdG8gMHgwMDAw
MDAwMA0KUENJOiBQcm9iaW5nIFBDSSBoYXJkd2FyZQ0KUENJOiBIaWRpbmcgNHh4IGhvc3QgYnJp
ZGdlIHJlc291cmNlcyAwMDAwOjQwOjAwLjANClBDSTogSGlkaW5nIDR4eCBob3N0IGJyaWRnZSBy
ZXNvdXJjZXMgMDAwMTo4MDowMC4wDQpQQ0k6IEJyaWRnZTogMDAwMDo0MDowMC4wDQogIElPIHdp
bmRvdzogZGlzYWJsZWQuDQogIE1FTSB3aW5kb3c6IGRpc2FibGVkLg0KICBQUkVGRVRDSCB3aW5k
b3c6IGRpc2FibGVkLg0KUENJOiBCcmlkZ2U6IDAwMDE6ODA6MDAuMA0KICBJTyB3aW5kb3c6IGRp
c2FibGVkLg0KICBNRU0gd2luZG93OiBkaXNhYmxlZC4NCiAgUFJFRkVUQ0ggd2luZG93OiBkaXNh
YmxlZC4NClNDU0kgc3Vic3lzdGVtIGluaXRpYWxpemVkDQpORVQ6IFJlZ2lzdGVyZWQgcHJvdG9j
b2wgZmFtaWx5IDINCklQIHJvdXRlIGNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMTYzODQgKG9y
ZGVyOiA0LCA2NTUzNiBieXRlcykNClRDUCBlc3RhYmxpc2hlZCBoYXNoIHRhYmxlIGVudHJpZXM6
IDY1NTM2IChvcmRlcjogNywgNTI0Mjg4IGJ5dGVzKQ0KVENQIGJpbmQgaGFzaCB0YWJsZSBlbnRy
aWVzOiA2NTUzNiAob3JkZXI6IDYsIDI2MjE0NCBieXRlcykNClRDUDogSGFzaCB0YWJsZXMgY29u
ZmlndXJlZCAoZXN0YWJsaXNoZWQgNjU1MzYgYmluZCA2NTUzNikNClRDUCByZW5vIHJlZ2lzdGVy
ZWQNCk5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMQ0KbXNnbW5pIGhhcyBiZWVuIHNl
dCB0byAxMDA5DQppbyBzY2hlZHVsZXIgbm9vcCByZWdpc3RlcmVkDQppbyBzY2hlZHVsZXIgYW50
aWNpcGF0b3J5IHJlZ2lzdGVyZWQgKGRlZmF1bHQpDQppbyBzY2hlZHVsZXIgZGVhZGxpbmUgcmVn
aXN0ZXJlZA0KaW8gc2NoZWR1bGVyIGNmcSByZWdpc3RlcmVkDQphc3NpZ25faW50ZXJydXB0X21v
ZGUgRm91bmQgTVNJIGNhcGFiaWxpdHkNCmFzc2lnbl9pbnRlcnJ1cHRfbW9kZSBGb3VuZCBNU0kg
Y2FwYWJpbGl0eQ0KYWVyOiBwcm9iZSBvZiAwMDAwOjQwOjAwLjA6cGNpZTAxIGZhaWxlZCB3aXRo
IGVycm9yIC0zOA0KYWVyOiBwcm9iZSBvZiAwMDAxOjgwOjAwLjA6cGNpZTAxIGZhaWxlZCB3aXRo
IGVycm9yIC0zOA0KU2VyaWFsOiA4MjUwLzE2NTUwIGRyaXZlciAkUmV2aXNpb246IDEuOTAgJCA0
IHBvcnRzLCBJUlEgc2hhcmluZyBlbmFibGVkDQpzZXJpYWw4MjUwLjA6IHR0eVMwIGF0IE1NSU8g
MHg0ZWY2MDAzMDAgKGlycSA9IDE4KSBpcyBhIDE2NTUwQQ0KY29uc29sZSBbdHR5UzBdIGVuYWJs
ZWQNCnNlcmlhbDgyNTAuMDogdHR5UzEgYXQgTU1JTyAweDRlZjYwMDQwMCAoaXJxID0gMTkpIGlz
IGEgMTY1NTBBDQpzZXJpYWw4MjUwLjA6IHR0eVMyIGF0IE1NSU8gMHg0ZWY2MDA1MDAgKGlycSA9
IDI5KSBpcyBhIDE2NTUwQQ0Kc2VyaWFsODI1MC4wOiB0dHlTMyBhdCBNTUlPIDB4NGVmNjAwNjAw
IChpcnEgPSAyMCkgaXMgYSAxNjU1MEENCjRlZjYwMDMwMC5zZXJpYWw6IHR0eVMwIGF0IE1NSU8g
MHg0ZWY2MDAzMDAgKGlycSA9IDE4KSBpcyBhIDE2NTUwQQ0KNGVmNjAwNDAwLnNlcmlhbDogdHR5
UzEgYXQgTU1JTyAweDRlZjYwMDQwMCAoaXJxID0gMTkpIGlzIGEgMTY1NTBBDQo0ZWY2MDA1MDAu
c2VyaWFsOiB0dHlTMiBhdCBNTUlPIDB4NGVmNjAwNTAwIChpcnEgPSAyOSkgaXMgYSAxNjU1MEEN
CjRlZjYwMDYwMC5zZXJpYWw6IHR0eVMzIGF0IE1NSU8gMHg0ZWY2MDA2MDAgKGlycSA9IDIwKSBp
cyBhIDE2NTUwQQ0KYnJkOiBtb2R1bGUgbG9hZGVkDQpQUEMgNHh4IE9DUCBFTUFDIGRyaXZlciwg
dmVyc2lvbiAzLjU0DQpNQUwgdjIgL3BsYi9tY21hbCwgMiBUWCBjaGFubmVscywgMTYgUlggY2hh
bm5lbHMNClpNSUkgL3BsYi9vcGIvZW1hYy16bWlpQGVmNjAwZDAwIGluaXRpYWxpemVkDQpSR01J
SSAvcGxiL29wYi9lbWFjLXJnbWlpQGVmNjAxNTAwIGluaXRpYWxpemVkIHdpdGggTURJTyBzdXBw
b3J0DQpUQUggL3BsYi9vcGIvZW1hYy10YWhAZWY2MDEzNTAgaW5pdGlhbGl6ZWQNClRBSCAvcGxi
L29wYi9lbWFjLXRhaEBlZjYwMTQ1MCBpbml0aWFsaXplZA0KL3BsYi9vcGIvZW1hYy1yZ21paUBl
ZjYwMTUwMDogaW5wdXQgMCBpbiBSR01JSSBtb2RlDQpldGgwOiBFTUFDLTAgL3BsYi9vcGIvZXRo
ZXJuZXRAZWY2MDBlMDAsIE1BQyAwMDoxMDplYzowMDpmOTpmNg0KZXRoMDogZm91bmQgR2VuZXJp
YyBNSUkgUEhZICgweDAwKQ0KL3BsYi9vcGIvZW1hYy1yZ21paUBlZjYwMTUwMDogaW5wdXQgMSBp
biBSR01JSSBtb2RlDQpldGgxOiBFTUFDLTEgL3BsYi9vcGIvZXRoZXJuZXRAZWY2MDBmMDAsIE1B
QyAwMDoxMDplYzo4MDpmOTpmNg0KZXRoMTogZm91bmQgR2VuZXJpYyBNSUkgUEhZICgweDAxKQ0K
RnVzaW9uIE1QVCBiYXNlIGRyaXZlciAzLjA0LjA2DQpDb3B5cmlnaHQgKGMpIDE5OTktMjAwNyBM
U0kgQ29ycG9yYXRpb24NCkZ1c2lvbiBNUFQgU1BJIEhvc3QgZHJpdmVyIDMuMDQuMDYNCkZ1c2lv
biBNUFQgRkMgSG9zdCBkcml2ZXIgMy4wNC4wNg0KRnVzaW9uIE1QVCBTQVMgSG9zdCBkcml2ZXIg
My4wNC4wNg0KRnVzaW9uIE1QVCBtaXNjIGRldmljZSAoaW9jdGwpIGRyaXZlciAzLjA0LjA2DQpt
cHRjdGw6IFJlZ2lzdGVyZWQgd2l0aCBGdXNpb24gTVBUIGJhc2UgZHJpdmVyDQptcHRjdGw6IC9k
ZXYvbXB0Y3RsIEAgKG1ham9yLG1pbm9yPTEwLDIyMCkNClRDUCBjdWJpYyByZWdpc3RlcmVkDQpO
RVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDE3DQpSUEM6IFJlZ2lzdGVyZWQgdWRwIHRy
YW5zcG9ydCBtb2R1bGUuDQpSUEM6IFJlZ2lzdGVyZWQgdGNwIHRyYW5zcG9ydCBtb2R1bGUuDQpl
dGgwOiBsaW5rIGlzIGRvd24NCklQLUNvbmZpZzogQ29tcGxldGU6DQogICAgIGRldmljZT1ldGgw
LCBhZGRyPTEwLjM4LjEyLjIyOSwgbWFzaz0yNTUuMjU1LjI1Mi4wLCBndz0xMC4zOC4xMi4xLA0K
ICAgICBob3N0PWNhbnlvbmxhbmRzLCBkb21haW49LCBuaXMtZG9tYWluPShub25lKSwNCiAgICAg
Ym9vdHNlcnZlcj0xMC4zOC4xMi4yMDEsIHJvb3RzZXJ2ZXI9MTAuMzguMTIuMjAxLCByb290cGF0
aD0NCkxvb2tpbmcgdXAgcG9ydCBvZiBSUEMgMTAwMDAzLzIgb24gMTAuMzguMTIuMjAxDQpldGgw
OiBsaW5rIGlzIHVwLCAxMDAgRkRYLCBwYXVzZSBlbmFibGVkDQpMb29raW5nIHVwIHBvcnQgb2Yg
UlBDIDEwMDAwNS8xIG9uIDEwLjM4LjEyLjIwMQ0KVkZTOiBNb3VudGVkIHJvb3QgKG5mcyBmaWxl
c3lzdGVtKS4NCkZyZWVpbmcgdW51c2VkIGtlcm5lbCBtZW1vcnk6IDE0OGsgaW5pdA0KbW9kcHJv
YmU6IEZBVEFMOiBDb3VsZCBub3QgbG9hZCAvbGliL21vZHVsZXMvMi42LjI2L21vZHVsZXMuZGVw
OiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQoNCm1vZHByb2JlOiBGQVRBTDogQ291bGQgbm90
IGxvYWQgL2xpYi9tb2R1bGVzLzIuNi4yNi9tb2R1bGVzLmRlcDogTm8gc3VjaCBmaWxlIG9yIGRp
cmVjdG9yeQ0KDQpJTklUOiB2ZXJzaW9uIDIuODUgYm9vdGluZw0KICAgICAgICAgICAgICAgIFdl
bGNvbWUgdG8gREVOWCBFbWJlZGRlZCBMaW51eCBFbnZpcm9ubWVudA0KICAgICAgICAgICAgICAg
IFByZXNzICdJJyB0byBlbnRlciBpbnRlcmFjdGl2ZSBzdGFydHVwLg0KQnVpbGRpbmcgdGhlIGNh
Y2hlIFsgIE9LICBdDQogc3RvcmFnZSBuZXR3b3JrIGF1ZGlvIGRvbmVbICBPSyAgXQ0KbW9kcHJv
YmU6IEZBVEFMOiBDb3VsZCBub3QgbG9hZCAvbGliL21vZHVsZXMvMi42LjI2L21vZHVsZXMuZGVw
OiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQoNCkNhbm5vdCBhY2Nlc3MgdGhlIEhhcmR3YXJl
IENsb2NrIHZpYSBhbnkga25vd24gbWV0aG9kLg0KVXNlIHRoZSAtLWRlYnVnIG9wdGlvbiB0byBz
ZWUgdGhlIGRldGFpbHMgb2Ygb3VyIHNlYXJjaCBmb3IgYW4gYWNjZXNzIG1ldGhvZC4NClNldHRp
bmcgY2xvY2sgOiBUaHUgSmFuICAxIDAwOjAwOjA1IFVUQyAxOTcwIFsgIE9LICBdDQpTZXR0aW5n
IGhvc3RuYW1lIGNhbnlvbmxhbmRzOiAgWyAgT0sgIF0NCk1vdW50aW5nIGxvY2FsIGZpbGVzeXN0
ZW1zOiAgWyAgT0sgIF0NCkVuYWJsaW5nIHN3YXAgc3BhY2U6ICBbICBPSyAgXQ0KSU5JVDogRW50
ZXJpbmcgcnVubGV2ZWw6IDMNCkVudGVyaW5nIG5vbi1pbnRlcmFjdGl2ZSBzdGFydHVwDQpCcmlu
Z2luZyB1cCBsb29wYmFjayBpbnRlcmZhY2U6ICBbICBPSyAgXQ0KU3RhcnRpbmcgc3lzdGVtIGxv
Z2dlcjogWyAgT0sgIF0NClN0YXJ0aW5nIGtlcm5lbCBsb2dnZXI6IFsgIE9LICBdDQpTdGFydGlu
ZyBwb3J0bWFwOiBbICBPSyAgXQ0KTW91bnRpbmcgTkZTIGZpbGVzeXN0ZW1zOiAgWyAgT0sgIF0N
Ck1vdW50aW5nIG90aGVyIGZpbGVzeXN0ZW1zOiAgWyAgT0sgIF0NClN0YXJ0aW5nIHhpbmV0ZDog
WyAgT0sgIF0NCg0KREVOWCBFTERLIHZlcnNpb24gNC4xIGJ1aWxkIDIwMDctMDEtMTkNCkxpbnV4
IDIuNi4yNiBvbiBhIHBwYw0KDQpjYW55b25sYW5kcyBsb2dpbjogcm9vdA0KTGFzdCBsb2dpbjog
U2F0IEp1bCAxMiAwMjo1MzoyOCBvbiBjb25zb2xlDQpiYXNoLTMuMDAjIHVuYW1lIC1yDQoyLjYu
MjYNCmJhc2gtMy4wMCMgbHNwY2kNCjQwOjAwLjAgUENJIGJyaWRnZTogVW5rbm93biBkZXZpY2Ug
YWFhMDpiZWQwIChyZXYgMDEpDQo4MDowMC4wIFBDSSBicmlkZ2U6IFVua25vd24gZGV2aWNlIGFh
YTE6YmVkMSAocmV2IDAxKQ0KYmFzaC0zLjAwIyBjYXQgL3Byb2MvaW50ZXJydXB0cw0KICAgICAg
ICAgICBDUFUwDQogMTg6ICAgICAgICAyNTIgICBVSUMgICBMZXZlbCAgICAgc2VyaWFsDQogMjE6
ICAgICAgIDYwMzIgICBVSUMgICBMZXZlbCAgICAgTUFMIFRYIEVPQg0KIDIyOiAgICAgIDExNzM3
ICAgVUlDICAgTGV2ZWwgICAgIE1BTCBSWCBFT0INCiAyMzogICAgICAgICAgMCAgIFVJQyAgIEVk
Z2UgICAgICBMMkMNCiAyNDogICAgICAgICAgMCAgIFVJQyAgIExldmVsICAgICBNQUwgU0VSUg0K
IDI1OiAgICAgICAgICAwICAgVUlDICAgTGV2ZWwgICAgIE1BTCBUWCBERQ0KIDI2OiAgICAgICAg
ICAwICAgVUlDICAgTGV2ZWwgICAgIE1BTCBSWCBERQ0KIDI3OiAgICAgICAgICAwICAgVUlDICAg
TGV2ZWwgICAgIEVNQUMNCkJBRDogICAgICAgICAgMA0KYmFzaC0zLjAwIyBjYXQgL3Byb2MvZGV2
aWNlcw0KQ2hhcmFjdGVyIGRldmljZXM6DQogIDEgbWVtDQogIDIgcHR5DQogIDMgdHR5cA0KICA0
IHR0eVMNCiAgNSAvZGV2L3R0eQ0KICA1IC9kZXYvY29uc29sZQ0KICA1IC9kZXYvcHRteA0KIDEw
IG1pc2MNCiAyMSBzZw0KMTI4IHB0bQ0KMTM2IHB0cw0KDQpCbG9jayBkZXZpY2VzOg0KICAxIHJh
bWRpc2sNCmJhc2gtMy4wMCMNCg==
------=_Part_46891_22464621.1225682190150
Content-Type: application/octet-stream; name=config
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fn2jfiq81
Content-Disposition: attachment; filename=config

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMgTGlu
dXgga2VybmVsIHZlcnNpb246IDIuNi4yNgojIFN1biBOb3YgIDIgMDE6MjY6MTIgMjAwOAojCiMg
Q09ORklHX1BQQzY0IGlzIG5vdCBzZXQKCiMKIyBQcm9jZXNzb3Igc3VwcG9ydAojCiMgQ09ORklH
XzZ4eCBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ184NXh4IGlzIG5vdCBzZXQKIyBDT05GSUdfUFBD
Xzh4eCBpcyBub3Qgc2V0CiMgQ09ORklHXzQweCBpcyBub3Qgc2V0CkNPTkZJR180NHg9eQojIENP
TkZJR19FMjAwIGlzIG5vdCBzZXQKQ09ORklHX1BQQ19GUFU9eQpDT05GSUdfNHh4PXkKQ09ORklH
X0JPT0tFPXkKQ09ORklHX1BURV82NEJJVD15CkNPTkZJR19QSFlTXzY0QklUPXkKIyBDT05GSUdf
UFBDX01NX1NMSUNFUyBpcyBub3Qgc2V0CkNPTkZJR19OT1RfQ09IRVJFTlRfQ0FDSEU9eQpDT05G
SUdfUFBDMzI9eQpDT05GSUdfV09SRF9TSVpFPTMyCkNPTkZJR19QUENfTUVSR0U9eQpDT05GSUdf
TU1VPXkKQ09ORklHX0dFTkVSSUNfQ01PU19VUERBVEU9eQpDT05GSUdfR0VORVJJQ19USU1FPXkK
Q09ORklHX0dFTkVSSUNfVElNRV9WU1lTQ0FMTD15CkNPTkZJR19HRU5FUklDX0NMT0NLRVZFTlRT
PXkKQ09ORklHX0dFTkVSSUNfSEFSRElSUVM9eQojIENPTkZJR19IQVZFX1NFVFVQX1BFUl9DUFVf
QVJFQSBpcyBub3Qgc2V0CkNPTkZJR19JUlFfUEVSX0NQVT15CkNPTkZJR19TVEFDS1RSQUNFX1NV
UFBPUlQ9eQpDT05GSUdfTE9DS0RFUF9TVVBQT1JUPXkKQ09ORklHX1JXU0VNX1hDSEdBRERfQUxH
T1JJVEhNPXkKQ09ORklHX0FSQ0hfSEFTX0lMT0cyX1UzMj15CkNPTkZJR19HRU5FUklDX0hXRUlH
SFQ9eQpDT05GSUdfR0VORVJJQ19DQUxJQlJBVEVfREVMQVk9eQpDT05GSUdfR0VORVJJQ19GSU5E
X05FWFRfQklUPXkKIyBDT05GSUdfQVJDSF9OT19WSVJUX1RPX0JVUyBpcyBub3Qgc2V0CkNPTkZJ
R19QUEM9eQpDT05GSUdfRUFSTFlfUFJJTlRLPXkKQ09ORklHX0dFTkVSSUNfTlZSQU09eQpDT05G
SUdfU0NIRURfTk9fTk9fT01JVF9GUkFNRV9QT0lOVEVSPXkKQ09ORklHX0FSQ0hfTUFZX0hBVkVf
UENfRkRDPXkKQ09ORklHX1BQQ19PRj15CkNPTkZJR19PRj15CkNPTkZJR19QUENfVURCR18xNjU1
MD15CiMgQ09ORklHX0dFTkVSSUNfVEJTWU5DIGlzIG5vdCBzZXQKQ09ORklHX0FVRElUX0FSQ0g9
eQpDT05GSUdfR0VORVJJQ19CVUc9eQojIENPTkZJR19ERUZBVUxUX1VJTUFHRSBpcyBub3Qgc2V0
CkNPTkZJR19QUENfRENSX05BVElWRT15CiMgQ09ORklHX1BQQ19EQ1JfTU1JTyBpcyBub3Qgc2V0
CkNPTkZJR19QUENfRENSPXkKQ09ORklHX0RFRkNPTkZJR19MSVNUPSIvbGliL21vZHVsZXMvJFVO
QU1FX1JFTEVBU0UvLmNvbmZpZyIKCiMKIyBHZW5lcmFsIHNldHVwCiMKQ09ORklHX0VYUEVSSU1F
TlRBTD15CkNPTkZJR19CUk9LRU5fT05fU01QPXkKQ09ORklHX0lOSVRfRU5WX0FSR19MSU1JVD0z
MgpDT05GSUdfTE9DQUxWRVJTSU9OPSIiCkNPTkZJR19MT0NBTFZFUlNJT05fQVVUTz15CkNPTkZJ
R19TV0FQPXkKQ09ORklHX1NZU1ZJUEM9eQpDT05GSUdfU1lTVklQQ19TWVNDVEw9eQpDT05GSUdf
UE9TSVhfTVFVRVVFPXkKIyBDT05GSUdfQlNEX1BST0NFU1NfQUNDVCBpcyBub3Qgc2V0CiMgQ09O
RklHX1RBU0tTVEFUUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FVRElUIGlzIG5vdCBzZXQKIyBDT05G
SUdfSUtDT05GSUcgaXMgbm90IHNldApDT05GSUdfTE9HX0JVRl9TSElGVD0xNAojIENPTkZJR19D
R1JPVVBTIGlzIG5vdCBzZXQKIyBDT05GSUdfR1JPVVBfU0NIRUQgaXMgbm90IHNldApDT05GSUdf
U1lTRlNfREVQUkVDQVRFRD15CkNPTkZJR19TWVNGU19ERVBSRUNBVEVEX1YyPXkKIyBDT05GSUdf
UkVMQVkgaXMgbm90IHNldAojIENPTkZJR19OQU1FU1BBQ0VTIGlzIG5vdCBzZXQKQ09ORklHX0JM
S19ERVZfSU5JVFJEPXkKQ09ORklHX0lOSVRSQU1GU19TT1VSQ0U9IiIKIyBDT05GSUdfQ0NfT1BU
SU1JWkVfRk9SX1NJWkUgaXMgbm90IHNldApDT05GSUdfU1lTQ1RMPXkKQ09ORklHX0VNQkVEREVE
PXkKQ09ORklHX1NZU0NUTF9TWVNDQUxMPXkKQ09ORklHX1NZU0NUTF9TWVNDQUxMX0NIRUNLPXkK
Q09ORklHX0tBTExTWU1TPXkKIyBDT05GSUdfS0FMTFNZTVNfQUxMIGlzIG5vdCBzZXQKIyBDT05G
SUdfS0FMTFNZTVNfRVhUUkFfUEFTUyBpcyBub3Qgc2V0CkNPTkZJR19IT1RQTFVHPXkKQ09ORklH
X1BSSU5USz15CkNPTkZJR19CVUc9eQpDT05GSUdfRUxGX0NPUkU9eQpDT05GSUdfQ09NUEFUX0JS
Sz15CkNPTkZJR19CQVNFX0ZVTEw9eQpDT05GSUdfRlVURVg9eQpDT05GSUdfQU5PTl9JTk9ERVM9
eQpDT05GSUdfRVBPTEw9eQpDT05GSUdfU0lHTkFMRkQ9eQpDT05GSUdfVElNRVJGRD15CkNPTkZJ
R19FVkVOVEZEPXkKQ09ORklHX1NITUVNPXkKQ09ORklHX1ZNX0VWRU5UX0NPVU5URVJTPXkKQ09O
RklHX1NMVUJfREVCVUc9eQojIENPTkZJR19TTEFCIGlzIG5vdCBzZXQKQ09ORklHX1NMVUI9eQoj
IENPTkZJR19TTE9CIGlzIG5vdCBzZXQKIyBDT05GSUdfUFJPRklMSU5HIGlzIG5vdCBzZXQKIyBD
T05GSUdfTUFSS0VSUyBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX09QUk9GSUxFPXkKIyBDT05GSUdf
S1BST0JFUyBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0tQUk9CRVM9eQpDT05GSUdfSEFWRV9LUkVU
UFJPQkVTPXkKIyBDT05GSUdfSEFWRV9ETUFfQVRUUlMgaXMgbm90IHNldApDT05GSUdfUFJPQ19Q
QUdFX01PTklUT1I9eQpDT05GSUdfU0xBQklORk89eQpDT05GSUdfUlRfTVVURVhFUz15CiMgQ09O
RklHX1RJTllfU0hNRU0gaXMgbm90IHNldApDT05GSUdfQkFTRV9TTUFMTD0wCkNPTkZJR19NT0RV
TEVTPXkKIyBDT05GSUdfTU9EVUxFX0ZPUkNFX0xPQUQgaXMgbm90IHNldApDT05GSUdfTU9EVUxF
X1VOTE9BRD15CiMgQ09ORklHX01PRFVMRV9GT1JDRV9VTkxPQUQgaXMgbm90IHNldAojIENPTkZJ
R19NT0RWRVJTSU9OUyBpcyBub3Qgc2V0CiMgQ09ORklHX01PRFVMRV9TUkNWRVJTSU9OX0FMTCBp
cyBub3Qgc2V0CkNPTkZJR19LTU9EPXkKQ09ORklHX0JMT0NLPXkKQ09ORklHX0xCRD15CiMgQ09O
RklHX0JMS19ERVZfSU9fVFJBQ0UgaXMgbm90IHNldAojIENPTkZJR19MU0YgaXMgbm90IHNldAoj
IENPTkZJR19CTEtfREVWX0JTRyBpcyBub3Qgc2V0CgojCiMgSU8gU2NoZWR1bGVycwojCkNPTkZJ
R19JT1NDSEVEX05PT1A9eQpDT05GSUdfSU9TQ0hFRF9BUz15CkNPTkZJR19JT1NDSEVEX0RFQURM
SU5FPXkKQ09ORklHX0lPU0NIRURfQ0ZRPXkKQ09ORklHX0RFRkFVTFRfQVM9eQojIENPTkZJR19E
RUZBVUxUX0RFQURMSU5FIGlzIG5vdCBzZXQKIyBDT05GSUdfREVGQVVMVF9DRlEgaXMgbm90IHNl
dAojIENPTkZJR19ERUZBVUxUX05PT1AgaXMgbm90IHNldApDT05GSUdfREVGQVVMVF9JT1NDSEVE
PSJhbnRpY2lwYXRvcnkiCkNPTkZJR19DTEFTU0lDX1JDVT15CkNPTkZJR19QUEM0eHhfUENJX0VY
UFJFU1M9eQoKIwojIFBsYXRmb3JtIHN1cHBvcnQKIwojIENPTkZJR19QUENfTVBDNTEyeCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BQQ19NUEM1MTIxIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX0NFTEwg
aXMgbm90IHNldAojIENPTkZJR19QUENfQ0VMTF9OQVRJVkUgaXMgbm90IHNldAojIENPTkZJR19Q
UTJBRFMgaXMgbm90IHNldAojIENPTkZJR19CQU1CT08gaXMgbm90IHNldAojIENPTkZJR19FQk9O
WSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUVVPSUEgaXMgbm90IHNldAojIENPTkZJR19UQUlTSEFO
IGlzIG5vdCBzZXQKIyBDT05GSUdfS0FUTUFJIGlzIG5vdCBzZXQKIyBDT05GSUdfUkFJTklFUiBp
cyBub3Qgc2V0CiMgQ09ORklHX1dBUlAgaXMgbm90IHNldApDT05GSUdfQ0FOWU9OTEFORFM9eQoj
IENPTkZJR19ZT1NFTUlURSBpcyBub3Qgc2V0CkNPTkZJR180NjBFWD15CiMgQ09ORklHX0lQSUMg
aXMgbm90IHNldAojIENPTkZJR19NUElDIGlzIG5vdCBzZXQKIyBDT05GSUdfTVBJQ19XRUlSRCBp
cyBub3Qgc2V0CiMgQ09ORklHX1BQQ19JODI1OSBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ19SVEFT
IGlzIG5vdCBzZXQKIyBDT05GSUdfTU1JT19OVlJBTSBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ19N
UEMxMDYgaXMgbm90IHNldAojIENPTkZJR19QUENfOTcwX05BUCBpcyBub3Qgc2V0CiMgQ09ORklH
X1BQQ19JTkRJUkVDVF9JTyBpcyBub3Qgc2V0CiMgQ09ORklHX0dFTkVSSUNfSU9NQVAgaXMgbm90
IHNldAojIENPTkZJR19DUFVfRlJFUSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZTTF9VTEkxNTc1IGlz
IG5vdCBzZXQKCiMKIyBLZXJuZWwgb3B0aW9ucwojCiMgQ09ORklHX0hJR0hNRU0gaXMgbm90IHNl
dApDT05GSUdfVElDS19PTkVTSE9UPXkKQ09ORklHX05PX0haPXkKQ09ORklHX0hJR0hfUkVTX1RJ
TUVSUz15CkNPTkZJR19HRU5FUklDX0NMT0NLRVZFTlRTX0JVSUxEPXkKIyBDT05GSUdfSFpfMTAw
IGlzIG5vdCBzZXQKQ09ORklHX0haXzI1MD15CiMgQ09ORklHX0haXzMwMCBpcyBub3Qgc2V0CiMg
Q09ORklHX0haXzEwMDAgaXMgbm90IHNldApDT05GSUdfSFo9MjUwCiMgQ09ORklHX1NDSEVEX0hS
VElDSyBpcyBub3Qgc2V0CkNPTkZJR19QUkVFTVBUX05PTkU9eQojIENPTkZJR19QUkVFTVBUX1ZP
TFVOVEFSWSBpcyBub3Qgc2V0CiMgQ09ORklHX1BSRUVNUFQgaXMgbm90IHNldApDT05GSUdfQklO
Rk1UX0VMRj15CiMgQ09ORklHX0JJTkZNVF9NSVNDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFUSF9F
TVVMQVRJT04gaXMgbm90IHNldAojIENPTkZJR19JT01NVV9IRUxQRVIgaXMgbm90IHNldApDT05G
SUdfQVJDSF9FTkFCTEVfTUVNT1JZX0hPVFBMVUc9eQpDT05GSUdfQVJDSF9IQVNfV0FMS19NRU1P
Ulk9eQpDT05GSUdfQVJDSF9FTkFCTEVfTUVNT1JZX0hPVFJFTU9WRT15CkNPTkZJR19BUkNIX0ZM
QVRNRU1fRU5BQkxFPXkKQ09ORklHX0FSQ0hfUE9QVUxBVEVTX05PREVfTUFQPXkKQ09ORklHX1NF
TEVDVF9NRU1PUllfTU9ERUw9eQpDT05GSUdfRkxBVE1FTV9NQU5VQUw9eQojIENPTkZJR19ESVND
T05USUdNRU1fTUFOVUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BBUlNFTUVNX01BTlVBTCBpcyBu
b3Qgc2V0CkNPTkZJR19GTEFUTUVNPXkKQ09ORklHX0ZMQVRfTk9ERV9NRU1fTUFQPXkKIyBDT05G
SUdfU1BBUlNFTUVNX1NUQVRJQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NQQVJTRU1FTV9WTUVNTUFQ
X0VOQUJMRSBpcyBub3Qgc2V0CkNPTkZJR19QQUdFRkxBR1NfRVhURU5ERUQ9eQpDT05GSUdfU1BM
SVRfUFRMT0NLX0NQVVM9NApDT05GSUdfUkVTT1VSQ0VTXzY0QklUPXkKQ09ORklHX1pPTkVfRE1B
X0ZMQUc9MQpDT05GSUdfQk9VTkNFPXkKQ09ORklHX1ZJUlRfVE9fQlVTPXkKQ09ORklHX0ZPUkNF
X01BWF9aT05FT1JERVI9MTEKQ09ORklHX1BST0NfREVWSUNFVFJFRT15CkNPTkZJR19DTURMSU5F
X0JPT0w9eQpDT05GSUdfQ01ETElORT0iIgpDT05GSUdfU0VDQ09NUD15CkNPTkZJR19JU0FfRE1B
X0FQST15CgojCiMgQnVzIG9wdGlvbnMKIwpDT05GSUdfWk9ORV9ETUE9eQpDT05GSUdfUFBDX0lO
RElSRUNUX1BDST15CkNPTkZJR180eHhfU09DPXkKQ09ORklHX1BDST15CkNPTkZJR19QQ0lfRE9N
QUlOUz15CkNPTkZJR19QQ0lfU1lTQ0FMTD15CkNPTkZJR19QQ0lFUE9SVEJVUz15CkNPTkZJR19Q
Q0lFQUVSPXkKQ09ORklHX1BDSUVBU1BNPXkKIyBDT05GSUdfUENJRUFTUE1fREVCVUcgaXMgbm90
IHNldApDT05GSUdfQVJDSF9TVVBQT1JUU19NU0k9eQpDT05GSUdfUENJX01TST15CkNPTkZJR19Q
Q0lfTEVHQUNZPXkKIyBDT05GSUdfUENJX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfUENDQVJE
IGlzIG5vdCBzZXQKIyBDT05GSUdfSE9UUExVR19QQ0kgaXMgbm90IHNldAojIENPTkZJR19IQVNf
UkFQSURJTyBpcyBub3Qgc2V0CgojCiMgQWR2YW5jZWQgc2V0dXAKIwojIENPTkZJR19BRFZBTkNF
RF9PUFRJT05TIGlzIG5vdCBzZXQKCiMKIyBEZWZhdWx0IHNldHRpbmdzIGZvciBhZHZhbmNlZCBj
b25maWd1cmF0aW9uIG9wdGlvbnMgYXJlIHVzZWQKIwpDT05GSUdfTE9XTUVNX1NJWkU9MHgzMDAw
MDAwMApDT05GSUdfUEFHRV9PRkZTRVQ9MHhjMDAwMDAwMApDT05GSUdfS0VSTkVMX1NUQVJUPTB4
YzAwMDAwMDAKQ09ORklHX1BIWVNJQ0FMX1NUQVJUPTB4MDAwMDAwMDAKQ09ORklHX1RBU0tfU0la
RT0weGMwMDAwMDAwCkNPTkZJR19DT05TSVNURU5UX1NUQVJUPTB4ZmYxMDAwMDAKQ09ORklHX0NP
TlNJU1RFTlRfU0laRT0weDAwMjAwMDAwCgojCiMgTmV0d29ya2luZwojCkNPTkZJR19ORVQ9eQoK
IwojIE5ldHdvcmtpbmcgb3B0aW9ucwojCkNPTkZJR19QQUNLRVQ9eQojIENPTkZJR19QQUNLRVRf
TU1BUCBpcyBub3Qgc2V0CkNPTkZJR19VTklYPXkKIyBDT05GSUdfTkVUX0tFWSBpcyBub3Qgc2V0
CkNPTkZJR19JTkVUPXkKIyBDT05GSUdfSVBfTVVMVElDQVNUIGlzIG5vdCBzZXQKIyBDT05GSUdf
SVBfQURWQU5DRURfUk9VVEVSIGlzIG5vdCBzZXQKQ09ORklHX0lQX0ZJQl9IQVNIPXkKQ09ORklH
X0lQX1BOUD15CkNPTkZJR19JUF9QTlBfREhDUD15CkNPTkZJR19JUF9QTlBfQk9PVFA9eQojIENP
TkZJR19JUF9QTlBfUkFSUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9JUElQIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUX0lQR1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJQRCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NZTl9DT09LSUVTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9BSCBpcyBub3Qgc2V0
CiMgQ09ORklHX0lORVRfRVNQIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9JUENPTVAgaXMgbm90
IHNldAojIENPTkZJR19JTkVUX1hGUk1fVFVOTkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9U
VU5ORUwgaXMgbm90IHNldAojIENPTkZJR19JTkVUX1hGUk1fTU9ERV9UUkFOU1BPUlQgaXMgbm90
IHNldAojIENPTkZJR19JTkVUX1hGUk1fTU9ERV9UVU5ORUwgaXMgbm90IHNldAojIENPTkZJR19J
TkVUX1hGUk1fTU9ERV9CRUVUIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9MUk8gaXMgbm90IHNl
dApDT05GSUdfSU5FVF9ESUFHPXkKQ09ORklHX0lORVRfVENQX0RJQUc9eQojIENPTkZJR19UQ1Bf
Q09OR19BRFZBTkNFRCBpcyBub3Qgc2V0CkNPTkZJR19UQ1BfQ09OR19DVUJJQz15CkNPTkZJR19E
RUZBVUxUX1RDUF9DT05HPSJjdWJpYyIKIyBDT05GSUdfVENQX01ENVNJRyBpcyBub3Qgc2V0CiMg
Q09ORklHX0lQVjYgaXMgbm90IHNldAojIENPTkZJR19ORVRXT1JLX1NFQ01BUksgaXMgbm90IHNl
dAojIENPTkZJR19ORVRGSUxURVIgaXMgbm90IHNldAojIENPTkZJR19JUF9EQ0NQIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSVBfU0NUUCBpcyBub3Qgc2V0CiMgQ09ORklHX1RJUEMgaXMgbm90IHNldAoj
IENPTkZJR19BVE0gaXMgbm90IHNldAojIENPTkZJR19CUklER0UgaXMgbm90IHNldAojIENPTkZJ
R19WTEFOXzgwMjFRIGlzIG5vdCBzZXQKIyBDT05GSUdfREVDTkVUIGlzIG5vdCBzZXQKIyBDT05G
SUdfTExDMiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQWCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUQUxL
IGlzIG5vdCBzZXQKIyBDT05GSUdfWDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfTEFQQiBpcyBub3Qg
c2V0CiMgQ09ORklHX0VDT05FVCBpcyBub3Qgc2V0CiMgQ09ORklHX1dBTl9ST1VURVIgaXMgbm90
IHNldAojIENPTkZJR19ORVRfU0NIRUQgaXMgbm90IHNldAoKIwojIE5ldHdvcmsgdGVzdGluZwoj
CiMgQ09ORklHX05FVF9QS1RHRU4gaXMgbm90IHNldAojIENPTkZJR19IQU1SQURJTyBpcyBub3Qg
c2V0CiMgQ09ORklHX0NBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lSREEgaXMgbm90IHNldAojIENP
TkZJR19CVCBpcyBub3Qgc2V0CiMgQ09ORklHX0FGX1JYUlBDIGlzIG5vdCBzZXQKCiMKIyBXaXJl
bGVzcwojCiMgQ09ORklHX0NGRzgwMjExIGlzIG5vdCBzZXQKIyBDT05GSUdfV0lSRUxFU1NfRVhU
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUFDODAyMTEgaXMgbm90IHNldAojIENPTkZJR19JRUVFODAy
MTEgaXMgbm90IHNldAojIENPTkZJR19SRktJTEwgaXMgbm90IHNldAojIENPTkZJR19ORVRfOVAg
aXMgbm90IHNldAoKIwojIERldmljZSBEcml2ZXJzCiMKCiMKIyBHZW5lcmljIERyaXZlciBPcHRp
b25zCiMKQ09ORklHX1VFVkVOVF9IRUxQRVJfUEFUSD0iL3NiaW4vaG90cGx1ZyIKQ09ORklHX1NU
QU5EQUxPTkU9eQpDT05GSUdfUFJFVkVOVF9GSVJNV0FSRV9CVUlMRD15CkNPTkZJR19GV19MT0FE
RVI9eQojIENPTkZJR19ERUJVR19EUklWRVIgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19ERVZS
RVMgaXMgbm90IHNldAojIENPTkZJR19TWVNfSFlQRVJWSVNPUiBpcyBub3Qgc2V0CkNPTkZJR19D
T05ORUNUT1I9eQpDT05GSUdfUFJPQ19FVkVOVFM9eQojIENPTkZJR19NVEQgaXMgbm90IHNldApD
T05GSUdfT0ZfREVWSUNFPXkKIyBDT05GSUdfUEFSUE9SVCBpcyBub3Qgc2V0CkNPTkZJR19CTEtf
REVWPXkKIyBDT05GSUdfQkxLX0RFVl9GRCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19DUFFfREEg
aXMgbm90IHNldAojIENPTkZJR19CTEtfQ1BRX0NJU1NfREEgaXMgbm90IHNldAojIENPTkZJR19C
TEtfREVWX0RBQzk2MCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfVU1FTSBpcyBub3Qgc2V0
CiMgQ09ORklHX0JMS19ERVZfQ09XX0NPTU1PTiBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZf
TE9PUCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfTkJEIGlzIG5vdCBzZXQKIyBDT05GSUdf
QkxLX0RFVl9TWDggaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9SQU09eQpDT05GSUdfQkxLX0RF
Vl9SQU1fQ09VTlQ9MTYKQ09ORklHX0JMS19ERVZfUkFNX1NJWkU9MzUwMDAKIyBDT05GSUdfQkxL
X0RFVl9YSVAgaXMgbm90IHNldAojIENPTkZJR19DRFJPTV9QS1RDRFZEIGlzIG5vdCBzZXQKIyBD
T05GSUdfQVRBX09WRVJfRVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfWElMSU5YX1NZU0FDRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX01JU0NfREVWSUNFUyBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0lERT15
CiMgQ09ORklHX0lERSBpcyBub3Qgc2V0CgojCiMgU0NTSSBkZXZpY2Ugc3VwcG9ydAojCkNPTkZJ
R19SQUlEX0FUVFJTPW0KQ09ORklHX1NDU0k9eQpDT05GSUdfU0NTSV9ETUE9eQpDT05GSUdfU0NT
SV9UR1Q9eQpDT05GSUdfU0NTSV9ORVRMSU5LPXkKQ09ORklHX1NDU0lfUFJPQ19GUz15CgojCiMg
U0NTSSBzdXBwb3J0IHR5cGUgKGRpc2ssIHRhcGUsIENELVJPTSkKIwojIENPTkZJR19CTEtfREVW
X1NEIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hSX0RFVl9TVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NI
Ul9ERVZfT1NTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfU1IgaXMgbm90IHNldApDT05G
SUdfQ0hSX0RFVl9TRz15CiMgQ09ORklHX0NIUl9ERVZfU0NIIGlzIG5vdCBzZXQKCiMKIyBTb21l
IFNDU0kgZGV2aWNlcyAoZS5nLiBDRCBqdWtlYm94KSBzdXBwb3J0IG11bHRpcGxlIExVTnMKIwoj
IENPTkZJR19TQ1NJX01VTFRJX0xVTiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQ09OU1RBTlRT
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9MT0dHSU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9TQ0FOX0FTWU5DIGlzIG5vdCBzZXQKQ09ORklHX1NDU0lfV0FJVF9TQ0FOPW0KCiMKIyBTQ1NJ
IFRyYW5zcG9ydHMKIwpDT05GSUdfU0NTSV9TUElfQVRUUlM9eQpDT05GSUdfU0NTSV9GQ19BVFRS
Uz15CiMgQ09ORklHX1NDU0lfRkNfVEdUX0FUVFJTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9J
U0NTSV9BVFRSUyBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJX1NBU19BVFRSUz15CiMgQ09ORklHX1ND
U0lfU0FTX0xJQlNBUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU1JQX0FUVFJTIGlzIG5vdCBz
ZXQKQ09ORklHX1NDU0lfTE9XTEVWRUw9eQojIENPTkZJR19JU0NTSV9UQ1AgaXMgbm90IHNldAoj
IENPTkZJR19CTEtfREVWXzNXX1hYWFhfUkFJRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfM1df
OVhYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQUNBUkQgaXMgbm90IHNldAojIENPTkZJR19T
Q1NJX0FBQ1JBSUQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FJQzdYWFggaXMgbm90IHNldAoj
IENPTkZJR19TQ1NJX0FJQzdYWFhfT0xEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BSUM3OVhY
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BSUM5NFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9EUFRfSTJPIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BRFZBTlNZUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDU0lfQVJDTVNSIGlzIG5vdCBzZXQKIyBDT05GSUdfTUVHQVJBSURfTkVXR0VOIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUVHQVJBSURfTEVHQUNZIGlzIG5vdCBzZXQKIyBDT05GSUdfTUVH
QVJBSURfU0FTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9IUFRJT1AgaXMgbm90IHNldAojIENP
TkZJR19TQ1NJX0JVU0xPR0lDIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9ETVgzMTkxRCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NDU0lfRUFUQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRlVUVVJF
X0RPTUFJTiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfR0RUSCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NDU0lfSVBTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9JTklUSU8gaXMgbm90IHNldAojIENP
TkZJR19TQ1NJX0lOSUExMDAgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX01WU0FTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9TVEVYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9TWU01M0M4WFhf
MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUUxPR0lDXzEyODAgaXMgbm90IHNldAojIENPTkZJ
R19TQ1NJX1FMQV9GQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUUxBX0lTQ1NJIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9MUEZDIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9EQzM5NXggaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX0RDMzkwVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTlNQ
MzIgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9TUlAgaXMgbm90IHNldAojIENPTkZJR19BVEEgaXMgbm90IHNldAojIENPTkZJR19NRCBpcyBu
b3Qgc2V0CkNPTkZJR19GVVNJT049eQpDT05GSUdfRlVTSU9OX1NQST15CkNPTkZJR19GVVNJT05f
RkM9eQpDT05GSUdfRlVTSU9OX1NBUz15CkNPTkZJR19GVVNJT05fTUFYX1NHRT0xMjgKQ09ORklH
X0ZVU0lPTl9DVEw9eQpDT05GSUdfRlVTSU9OX0xPR0dJTkc9eQoKIwojIElFRUUgMTM5NCAoRmly
ZVdpcmUpIHN1cHBvcnQKIwoKIwojIEVuYWJsZSBvbmx5IG9uZSBvZiB0aGUgdHdvIHN0YWNrcywg
dW5sZXNzIHlvdSBrbm93IHdoYXQgeW91IGFyZSBkb2luZwojCiMgQ09ORklHX0ZJUkVXSVJFIGlz
IG5vdCBzZXQKIyBDT05GSUdfSUVFRTEzOTQgaXMgbm90IHNldAojIENPTkZJR19JMk8gaXMgbm90
IHNldAojIENPTkZJR19NQUNJTlRPU0hfRFJJVkVSUyBpcyBub3Qgc2V0CkNPTkZJR19ORVRERVZJ
Q0VTPXkKIyBDT05GSUdfTkVUREVWSUNFU19NVUxUSVFVRVVFIGlzIG5vdCBzZXQKIyBDT05GSUdf
RFVNTVkgaXMgbm90IHNldAojIENPTkZJR19CT05ESU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFD
VkxBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0VRVUFMSVpFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1RV
TiBpcyBub3Qgc2V0CiMgQ09ORklHX1ZFVEggaXMgbm90IHNldAojIENPTkZJR19BUkNORVQgaXMg
bm90IHNldAojIENPTkZJR19QSFlMSUIgaXMgbm90IHNldApDT05GSUdfTkVUX0VUSEVSTkVUPXkK
IyBDT05GSUdfTUlJIGlzIG5vdCBzZXQKIyBDT05GSUdfSEFQUFlNRUFMIGlzIG5vdCBzZXQKIyBD
T05GSUdfU1VOR0VNIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0FTU0lOSSBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVF9WRU5ET1JfM0NPTSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9UVUxJUCBpcyBub3Qg
c2V0CiMgQ09ORklHX0hQMTAwIGlzIG5vdCBzZXQKQ09ORklHX0lCTV9ORVdfRU1BQz15CkNPTkZJ
R19JQk1fTkVXX0VNQUNfUlhCPTI1NgpDT05GSUdfSUJNX05FV19FTUFDX1RYQj0yNTYKQ09ORklH
X0lCTV9ORVdfRU1BQ19QT0xMX1dFSUdIVD0zMgpDT05GSUdfSUJNX05FV19FTUFDX1JYX0NPUFlf
VEhSRVNIT0xEPTI1NgpDT05GSUdfSUJNX05FV19FTUFDX1JYX1NLQl9IRUFEUk9PTT0wCiMgQ09O
RklHX0lCTV9ORVdfRU1BQ19ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19JQk1fTkVXX0VNQUNfWk1J
ST15CkNPTkZJR19JQk1fTkVXX0VNQUNfUkdNSUk9eQpDT05GSUdfSUJNX05FV19FTUFDX1RBSD15
CkNPTkZJR19JQk1fTkVXX0VNQUNfRU1BQzQ9eQojIENPTkZJR19ORVRfUENJIGlzIG5vdCBzZXQK
IyBDT05GSUdfQjQ0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUREVWXzEwMDAgaXMgbm90IHNldAoj
IENPTkZJR19ORVRERVZfMTAwMDAgaXMgbm90IHNldAojIENPTkZJR19UUiBpcyBub3Qgc2V0Cgoj
CiMgV2lyZWxlc3MgTEFOCiMKIyBDT05GSUdfV0xBTl9QUkU4MDIxMSBpcyBub3Qgc2V0CiMgQ09O
RklHX1dMQU5fODAyMTEgaXMgbm90IHNldAojIENPTkZJR19JV0xXSUZJX0xFRFMgaXMgbm90IHNl
dAojIENPTkZJR19XQU4gaXMgbm90IHNldAojIENPTkZJR19GRERJIGlzIG5vdCBzZXQKIyBDT05G
SUdfSElQUEkgaXMgbm90IHNldAojIENPTkZJR19QUFAgaXMgbm90IHNldAojIENPTkZJR19TTElQ
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0ZDIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUQ09OU09M
RSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVFBPTEwgaXMgbm90IHNldAojIENPTkZJR19ORVRfUE9M
TF9DT05UUk9MTEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfSVNETiBpcyBub3Qgc2V0CiMgQ09ORklH
X1BIT05FIGlzIG5vdCBzZXQKCiMKIyBJbnB1dCBkZXZpY2Ugc3VwcG9ydAojCiMgQ09ORklHX0lO
UFVUIGlzIG5vdCBzZXQKCiMKIyBIYXJkd2FyZSBJL08gcG9ydHMKIwojIENPTkZJR19TRVJJTyBp
cyBub3Qgc2V0CiMgQ09ORklHX0dBTUVQT1JUIGlzIG5vdCBzZXQKCiMKIyBDaGFyYWN0ZXIgZGV2
aWNlcwojCiMgQ09ORklHX1ZUIGlzIG5vdCBzZXQKQ09ORklHX0RFVktNRU09eQojIENPTkZJR19T
RVJJQUxfTk9OU1RBTkRBUkQgaXMgbm90IHNldAojIENPTkZJR19OT1pPTUkgaXMgbm90IHNldAoK
IwojIFNlcmlhbCBkcml2ZXJzCiMKQ09ORklHX1NFUklBTF84MjUwPXkKQ09ORklHX1NFUklBTF84
MjUwX0NPTlNPTEU9eQojIENPTkZJR19TRVJJQUxfODI1MF9QQ0kgaXMgbm90IHNldApDT05GSUdf
U0VSSUFMXzgyNTBfTlJfVUFSVFM9NApDT05GSUdfU0VSSUFMXzgyNTBfUlVOVElNRV9VQVJUUz00
CkNPTkZJR19TRVJJQUxfODI1MF9FWFRFTkRFRD15CiMgQ09ORklHX1NFUklBTF84MjUwX01BTllf
UE9SVFMgaXMgbm90IHNldApDT05GSUdfU0VSSUFMXzgyNTBfU0hBUkVfSVJRPXkKIyBDT05GSUdf
U0VSSUFMXzgyNTBfREVURUNUX0lSUSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF84MjUwX1JT
QSBpcyBub3Qgc2V0CgojCiMgTm9uLTgyNTAgc2VyaWFsIHBvcnQgc3VwcG9ydAojCiMgQ09ORklH
X1NFUklBTF9VQVJUTElURSBpcyBub3Qgc2V0CkNPTkZJR19TRVJJQUxfQ09SRT15CkNPTkZJR19T
RVJJQUxfQ09SRV9DT05TT0xFPXkKIyBDT05GSUdfU0VSSUFMX0pTTSBpcyBub3Qgc2V0CkNPTkZJ
R19TRVJJQUxfT0ZfUExBVEZPUk09eQpDT05GSUdfVU5JWDk4X1BUWVM9eQpDT05GSUdfTEVHQUNZ
X1BUWVM9eQpDT05GSUdfTEVHQUNZX1BUWV9DT1VOVD0yNTYKIyBDT05GSUdfSVBNSV9IQU5ETEVS
IGlzIG5vdCBzZXQKIyBDT05GSUdfSFdfUkFORE9NIGlzIG5vdCBzZXQKIyBDT05GSUdfTlZSQU0g
aXMgbm90IHNldAojIENPTkZJR19HRU5fUlRDIGlzIG5vdCBzZXQKIyBDT05GSUdfUjM5NjQgaXMg
bm90IHNldAojIENPTkZJR19BUFBMSUNPTSBpcyBub3Qgc2V0CiMgQ09ORklHX1JBV19EUklWRVIg
aXMgbm90IHNldAojIENPTkZJR19UQ0dfVFBNIGlzIG5vdCBzZXQKQ09ORklHX0RFVlBPUlQ9eQoj
IENPTkZJR19JMkMgaXMgbm90IHNldAojIENPTkZJR19TUEkgaXMgbm90IHNldAojIENPTkZJR19X
MSBpcyBub3Qgc2V0CiMgQ09ORklHX1BPV0VSX1NVUFBMWSBpcyBub3Qgc2V0CiMgQ09ORklHX0hX
TU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfVEhFUk1BTCBpcyBub3Qgc2V0CiMgQ09ORklHX1RIRVJN
QUxfSFdNT04gaXMgbm90IHNldAojIENPTkZJR19XQVRDSERPRyBpcyBub3Qgc2V0CgojCiMgU29u
aWNzIFNpbGljb24gQmFja3BsYW5lCiMKQ09ORklHX1NTQl9QT1NTSUJMRT15CiMgQ09ORklHX1NT
QiBpcyBub3Qgc2V0CgojCiMgTXVsdGlmdW5jdGlvbiBkZXZpY2UgZHJpdmVycwojCiMgQ09ORklH
X01GRF9TTTUwMSBpcyBub3Qgc2V0CiMgQ09ORklHX0hUQ19QQVNJQzMgaXMgbm90IHNldAoKIwoj
IE11bHRpbWVkaWEgZGV2aWNlcwojCgojCiMgTXVsdGltZWRpYSBjb3JlIHN1cHBvcnQKIwojIENP
TkZJR19WSURFT19ERVYgaXMgbm90IHNldAojIENPTkZJR19EVkJfQ09SRSBpcyBub3Qgc2V0CiMg
Q09ORklHX1ZJREVPX01FRElBIGlzIG5vdCBzZXQKCiMKIyBNdWx0aW1lZGlhIGRyaXZlcnMKIwpD
T05GSUdfREFCPXkKCiMKIyBHcmFwaGljcyBzdXBwb3J0CiMKIyBDT05GSUdfQUdQIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRFJNIGlzIG5vdCBzZXQKIyBDT05GSUdfVkdBU1RBVEUgaXMgbm90IHNldApD
T05GSUdfVklERU9fT1VUUFVUX0NPTlRST0w9bQojIENPTkZJR19GQiBpcyBub3Qgc2V0CiMgQ09O
RklHX0JBQ0tMSUdIVF9MQ0RfU1VQUE9SVCBpcyBub3Qgc2V0CgojCiMgRGlzcGxheSBkZXZpY2Ug
c3VwcG9ydAojCiMgQ09ORklHX0RJU1BMQVlfU1VQUE9SVCBpcyBub3Qgc2V0CgojCiMgU291bmQK
IwojIENPTkZJR19TT1VORCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVVBQT1JUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTU1DIGlzIG5vdCBzZXQKIyBDT05GSUdfTUVNU1RJQ0sgaXMgbm90IHNldAoj
IENPTkZJR19ORVdfTEVEUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FDQ0VTU0lCSUxJVFkgaXMgbm90
IHNldAojIENPTkZJR19JTkZJTklCQU5EIGlzIG5vdCBzZXQKIyBDT05GSUdfRURBQyBpcyBub3Qg
c2V0CiMgQ09ORklHX1JUQ19DTEFTUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RNQURFVklDRVMgaXMg
bm90IHNldAojIENPTkZJR19VSU8gaXMgbm90IHNldAoKIwojIEZpbGUgc3lzdGVtcwojCkNPTkZJ
R19FWFQyX0ZTPXkKIyBDT05GSUdfRVhUMl9GU19YQVRUUiBpcyBub3Qgc2V0CiMgQ09ORklHX0VY
VDJfRlNfWElQIGlzIG5vdCBzZXQKIyBDT05GSUdfRVhUM19GUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0VYVDRERVZfRlMgaXMgbm90IHNldAojIENPTkZJR19SRUlTRVJGU19GUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0pGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZTX1BPU0lYX0FDTCBpcyBub3Qgc2V0
CiMgQ09ORklHX1hGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX09DRlMyX0ZTIGlzIG5vdCBzZXQK
Q09ORklHX0ROT1RJRlk9eQpDT05GSUdfSU5PVElGWT15CkNPTkZJR19JTk9USUZZX1VTRVI9eQoj
IENPTkZJR19RVU9UQSBpcyBub3Qgc2V0CiMgQ09ORklHX0FVVE9GU19GUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0FVVE9GUzRfRlMgaXMgbm90IHNldAojIENPTkZJR19GVVNFX0ZTIGlzIG5vdCBzZXQK
CiMKIyBDRC1ST00vRFZEIEZpbGVzeXN0ZW1zCiMKIyBDT05GSUdfSVNPOTY2MF9GUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1VERl9GUyBpcyBub3Qgc2V0CgojCiMgRE9TL0ZBVC9OVCBGaWxlc3lzdGVt
cwojCiMgQ09ORklHX01TRE9TX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfVkZBVF9GUyBpcyBub3Qg
c2V0CiMgQ09ORklHX05URlNfRlMgaXMgbm90IHNldAoKIwojIFBzZXVkbyBmaWxlc3lzdGVtcwoj
CkNPTkZJR19QUk9DX0ZTPXkKQ09ORklHX1BST0NfS0NPUkU9eQpDT05GSUdfUFJPQ19TWVNDVEw9
eQpDT05GSUdfU1lTRlM9eQpDT05GSUdfVE1QRlM9eQojIENPTkZJR19UTVBGU19QT1NJWF9BQ0wg
aXMgbm90IHNldAojIENPTkZJR19IVUdFVExCX1BBR0UgaXMgbm90IHNldAojIENPTkZJR19DT05G
SUdGU19GUyBpcyBub3Qgc2V0CgojCiMgTWlzY2VsbGFuZW91cyBmaWxlc3lzdGVtcwojCiMgQ09O
RklHX0FERlNfRlMgaXMgbm90IHNldAojIENPTkZJR19BRkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05G
SUdfSEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSEZTUExVU19GUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0JFRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19CRlNfRlMgaXMgbm90IHNldAojIENPTkZJ
R19FRlNfRlMgaXMgbm90IHNldApDT05GSUdfQ1JBTUZTPXkKIyBDT05GSUdfVlhGU19GUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX01JTklYX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSFBGU19GUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1FOWDRGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JPTUZTX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfU1lTVl9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1VGU19GUyBpcyBu
b3Qgc2V0CkNPTkZJR19ORVRXT1JLX0ZJTEVTWVNURU1TPXkKQ09ORklHX05GU19GUz15CkNPTkZJ
R19ORlNfVjM9eQojIENPTkZJR19ORlNfVjNfQUNMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZTX1Y0
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkZTRCBpcyBub3Qgc2V0CkNPTkZJR19ST09UX05GUz15CkNP
TkZJR19MT0NLRD15CkNPTkZJR19MT0NLRF9WND15CkNPTkZJR19ORlNfQ09NTU9OPXkKQ09ORklH
X1NVTlJQQz15CiMgQ09ORklHX1NVTlJQQ19CSU5EMzQgaXMgbm90IHNldAojIENPTkZJR19SUENT
RUNfR1NTX0tSQjUgaXMgbm90IHNldAojIENPTkZJR19SUENTRUNfR1NTX1NQS00zIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU01CX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0lGUyBpcyBub3Qgc2V0CiMg
Q09ORklHX05DUF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NPREFfRlMgaXMgbm90IHNldAojIENP
TkZJR19BRlNfRlMgaXMgbm90IHNldAoKIwojIFBhcnRpdGlvbiBUeXBlcwojCiMgQ09ORklHX1BB
UlRJVElPTl9BRFZBTkNFRCBpcyBub3Qgc2V0CkNPTkZJR19NU0RPU19QQVJUSVRJT049eQojIENP
TkZJR19OTFMgaXMgbm90IHNldAojIENPTkZJR19ETE0gaXMgbm90IHNldAoKIwojIExpYnJhcnkg
cm91dGluZXMKIwpDT05GSUdfQklUUkVWRVJTRT15CiMgQ09ORklHX0dFTkVSSUNfRklORF9GSVJT
VF9CSVQgaXMgbm90IHNldAojIENPTkZJR19DUkNfQ0NJVFQgaXMgbm90IHNldAojIENPTkZJR19D
UkMxNiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQ19JVFVfVCBpcyBub3Qgc2V0CkNPTkZJR19DUkMz
Mj15CiMgQ09ORklHX0NSQzcgaXMgbm90IHNldAojIENPTkZJR19MSUJDUkMzMkMgaXMgbm90IHNl
dApDT05GSUdfWkxJQl9JTkZMQVRFPXkKQ09ORklHX1BMSVNUPXkKQ09ORklHX0hBU19JT01FTT15
CkNPTkZJR19IQVNfSU9QT1JUPXkKQ09ORklHX0hBU19ETUE9eQpDT05GSUdfSEFWRV9MTUI9eQoK
IwojIEtlcm5lbCBoYWNraW5nCiMKIyBDT05GSUdfUFJJTlRLX1RJTUUgaXMgbm90IHNldApDT05G
SUdfRU5BQkxFX1dBUk5fREVQUkVDQVRFRD15CkNPTkZJR19FTkFCTEVfTVVTVF9DSEVDSz15CkNP
TkZJR19GUkFNRV9XQVJOPTEwMjQKQ09ORklHX01BR0lDX1NZU1JRPXkKIyBDT05GSUdfVU5VU0VE
X1NZTUJPTFMgaXMgbm90IHNldApDT05GSUdfREVCVUdfRlM9eQojIENPTkZJR19IRUFERVJTX0NI
RUNLIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX0tFUk5FTD15CiMgQ09ORklHX0RFQlVHX1NISVJR
IGlzIG5vdCBzZXQKQ09ORklHX0RFVEVDVF9TT0ZUTE9DS1VQPXkKQ09ORklHX1NDSEVEX0RFQlVH
PXkKIyBDT05GSUdfU0NIRURTVEFUUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RJTUVSX1NUQVRTIGlz
IG5vdCBzZXQKIyBDT05GSUdfREVCVUdfT0JKRUNUUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NMVUJf
REVCVUdfT04gaXMgbm90IHNldAojIENPTkZJR19TTFVCX1NUQVRTIGlzIG5vdCBzZXQKIyBDT05G
SUdfREVCVUdfUlRfTVVURVhFUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUX01VVEVYX1RFU1RFUiBp
cyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NQSU5MT0NLIGlzIG5vdCBzZXQKIyBDT05GSUdfREVC
VUdfTVVURVhFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NQSU5MT0NLX1NMRUVQIGlzIG5v
dCBzZXQKIyBDT05GSUdfREVCVUdfTE9DS0lOR19BUElfU0VMRlRFU1RTIGlzIG5vdCBzZXQKIyBD
T05GSUdfREVCVUdfS09CSkVDVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0JVR1ZFUkJPU0Ug
aXMgbm90IHNldAojIENPTkZJR19ERUJVR19JTkZPIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdf
Vk0gaXMgbm90IHNldAojIENPTkZJR19ERUJVR19XUklURUNPVU5UIGlzIG5vdCBzZXQKIyBDT05G
SUdfREVCVUdfTElTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NHIGlzIG5vdCBzZXQKIyBD
T05GSUdfQk9PVF9QUklOVEtfREVMQVkgaXMgbm90IHNldAojIENPTkZJR19SQ1VfVE9SVFVSRV9U
RVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS1RSQUNFX1NFTEZfVEVTVCBpcyBub3Qgc2V0CiMg
Q09ORklHX0ZBVUxUX0lOSkVDVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX1NBTVBMRVMgaXMgbm90
IHNldAojIENPTkZJR19LR0RCIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfU1RBQ0tPVkVSRkxP
VyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NUQUNLX1VTQUdFIGlzIG5vdCBzZXQKIyBDT05G
SUdfREVCVUdfUEFHRUFMTE9DIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHR0VSPXkKIyBDT05GSUdf
WE1PTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lSUVNUQUNLUyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJ
UlFfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19CRElfU1dJVENIIGlzIG5vdCBzZXQKIyBDT05G
SUdfUFBDX0VBUkxZX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBTZWN1cml0eSBvcHRpb25zCiMKIyBD
T05GSUdfS0VZUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VDVVJJVFlfRklMRV9DQVBBQklMSVRJRVMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE8g
aXMgbm90IHNldAojIENPTkZJR19QUENfQ0xPQ0sgaXMgbm90IHNldAojIENPTkZJR19WSVJUVUFM
SVpBVElPTiBpcyBub3Qgc2V0Cg==
------=_Part_46891_22464621.1225682190150--
