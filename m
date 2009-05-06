Return-Path: <shubhada@chelsio.com>
Received: from stargate.chelsio.com (unknown [67.207.112.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3856CDDFB1
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 08:52:55 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Unable to boot 2.6.29 (and tot kernel) with 256k page size on
	katmai.
Date: Wed, 6 May 2009 15:53:58 -0700
Message-ID: <8A71B368A89016469F72CD08050AD33402D575FC@maui.asicdesigners.com>
From: "Shubhada Pugaonkar" <shubhada@chelsio.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am using ELDK4.2 that came with the katmai board.=20

Yes that is all I get. If I use 64k page size then I get following log
if that helps determine anything.=20

=3D> tftp 1000000 uImage-2.6.29-denx
Waiting for PHY auto negotiation to complete.. done
ENET Speed is 100 Mbps - FULL duplex connection (EMAC0)
Using ppc_4xx_eth0 device
TFTP from server 10.192.165.106; our IP address is 10.192.164.166
Filename 'uImage-2.6.29-denx'.
Load address: 0x1000000
Loading:
#################################################################
         ############################################################
done
Bytes transferred =3D 1822193 (1bcdf1 hex)
=3D> tftp 4000000 katmai.dts.256k
Using ppc_4xx_eth0 device
TFTP from server 10.192.165.106; our IP address is 10.192.164.166
Filename 'katmai.dts.256k'.
Load address: 0x4000000
Loading: ##
done
Bytes transferred =3D 16384 (4000 hex)
=3D> bootm 1000000 - 4000000
## Booting image at 01000000 ...
   Image Name:   Linux-2.6.29-rc8-01447-g3bf8ce5-
   Created:      2009-05-06   0:34:46 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1822129 Bytes =3D  1.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using the fdt at 0x4000000
   Loading Device Tree to 007fb000, end 007fefff ... OK
Using PowerPC 44x Platform machine description
Linux version 2.6.29-rc8-01447-g3bf8ce5-dirty (root@california) (gcc
version 4.2.2) #2 Tue May 5 17:34:41 PDT 2009
console [udbg0] enabled
setup_arch: bootmem
arch: exit
Zone PFN ranges:
  DMA      0x00000000 -> 0x00003000
  Normal   0x00003000 -> 0x00003000
  HighMem  0x00003000 -> 0x00008000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00008000
MMU: Allocated 1088 bytes of context maps for 255 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
32752
Kernel command line:
UIC0 (32 IRQ sources) at DCR 0xc0
UIC1 (32 IRQ sources) at DCR 0xd0
UIC2 (32 IRQ sources) at DCR 0xe0
UIC3 (32 IRQ sources) at DCR 0xf0
PID hash table entries: 4096 (order: 12, 16384 bytes)
clocksource: timebase mult[500000] shift[22] registered
Dentry cache hash table entries: 131072 (order: 3, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 2, 262144 bytes)
Memory: 2089472k/2097152k available (3776k kernel code, 7040k reserved,
192k data, 736k bss, 384k init)
SLUB: Genslabs=3D14, HWalign=3D32, Order=3D0-3, MinObjects=3D0, =
CPUs=3D1, Nodes=3D1
Calibrating delay loop... 1597.44 BogoMIPS (lpj=3D3194880)
Mount-cache hash table entries: 8192
net_namespace: 296 bytes
xor: measuring software checksum speed
   8regs     :   112.000 MB/sec
   8regs_prefetch:   144.000 MB/sec
   32regs    :   112.000 MB/sec
   32regs_prefetch:   144.000 MB/sec
xor: using function: 32regs_prefetch (144.000 MB/sec)
NET: Registered protocol family 16

PCIE0: Checking link...
PCIE0: Device detected, waiting for link...
PCIE0: link is up !
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
PCIE2: Checking link...
PCIE2: Device detected, waiting for link...
PCIE2: link is up !
PCI host bridge /plb/pciex@d40000000 (primary) ranges:
 MEM 0x0000000f00000000..0x0000000f7fffffff -> 0x0000000080000000
  IO 0x0000000f80020000..0x0000000f8002ffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCIE2: successfully set as root-complex
PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
 MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000
  IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCI: Probing PCI hardware
PCI: Hiding 4xx host bridge resources 0000:10:00.0
pci 0000:11:00.0: PME# supported from D0 D3hot
pci 0000:11:00.0: PME# disabled
PCI: Hiding 4xx host bridge resources 0001:20:00.0
PCI: Hiding 4xx host bridge resources 0002:30:00.0
pci 0000:10:00.0: PCI bridge, secondary bus 0000:11
pci 0000:10:00.0:   IO window: disabled
pci 0000:10:00.0:   MEM window: 0x80000000-0x80bfffff
pci 0000:10:00.0:   PREFETCH window: 0x00000080c00000-0x00000080cfffff
pci 0001:20:00.0: PCI bridge, secondary bus 0001:21
pci 0001:20:00.0:   IO window: 0x1000-0x1fff
pci 0001:20:00.0:   MEM window: 0x80200000-0x802fffff
pci 0001:20:00.0:   PREFETCH window: 0x00000080000000-0x000000801fffff
pci 0002:30:00.0: PCI bridge, secondary bus 0002:31
pci 0002:30:00.0:   IO window: 0x1000-0x1fff
pci 0002:30:00.0:   MEM window: 0x80200000-0x802fffff
pci 0002:30:00.0:   PREFETCH window: 0x00000080000000-0x000000801fffff
bio: create slab <bio-0> at 0
SCSI subsystem initialized
NET: Registered protocol family 2
Switched to NOHz mode on CPU #0
IP route cache hash table entries: 16384 (order: 0, 65536 bytes)
TCP established hash table entries: 32768 (order: 2, 262144 bytes)
TCP bind hash table entries: 32768 (order: 1, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
NET: Registered protocol family 1
highmem bounce pool size: 64 pages
msgmni has been set to 1520
alg: No test for stdrng (krng)
async_tx: api initialized (sync-only)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4f0000200 (irq =3D 21) is a 16550A
                                                              console
handover: boot [udbg0] -> real [ttyS0]
serial8250.0: ttyS1 at MMIO 0x4f0000300 (irq =3D 22) is a 16550A
serial8250.0: ttyS2 at MMIO 0x4f0000600 (irq =3D 23) is a 16550A
4f0000200.serial: ttyS0 at MMIO 0x4f0000200 (irq =3D 21) is a 16550A
4f0000300.serial: ttyS1 at MMIO 0x4f0000300 (irq =3D 22) is a 16550A
4f0000600.serial: ttyS2 at MMIO 0x4f0000600 (irq =3D 23) is a 16550A
brd: module loaded
Xilinx SystemACE device driver, major=3D253
PPC 4xx OCP EMAC driver, version 3.54
MAL v2 /plb/mcmal, 2 TX channels, 1 RX channels
eth0 (emac): not using net_device_ops yet
eth0: EMAC-0 /plb/opb/ethernet@10000800, MAC 00:01:73:77:56:64
eth0: found Generic MII PHY (0x01)
Driver 'sd' needs updating - please use bus_type methods
Fusion MPT base driver 3.04.07
Copyright (c) 1999-2008 LSI Corporation
Fusion MPT SAS Host driver 3.04.07
mptsas 0001:21:00.0: enabling device (0000 -> 0002)
mptbase: ioc0: Initiating bringup
ioc0: LSISAS1068E B3: Capabilities=3D{Initiator}
scsi0 : ioc0: LSISAS1068E B3, FwRev=3D01170200h, Ports=3D1, MaxQ=3D286, =
IRQ=3D19
scsi 0:0:0:0: Direct-Access     SEAGATE  ST336754SS       S410 PQ: 0
ANSI: 5
sd 0:0:0:0: [sda] 71132959 512-byte hardware sectors: (36.4 GB/33.9 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports
DPO and FUA
sd 0:0:0:0: [sda] 71132959 512-byte hardware sectors: (36.4 GB/33.9 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports
DPO and FUA
 sda: sda1
.
.
.
=20
Thanks
Shubhada


-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]=20
Sent: Wednesday, May 06, 2009 3:34 PM
To: Shubhada Pugaonkar
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Unable to boot 2.6.29 (and tot kernel) with 256k page size
on katmai.

Dear Shubhada,

In message
<8A71B368A89016469F72CD08050AD33402D575FA@maui.asicdesigners.com> you
wrote:
>=20
> I am unable to boot the 2.6.29-rc8 denx kernel (and 2.6.30-rc4 tot
> kernel) when I enable the 256k page size. My config file is attached.
> The *same* config works fine with 64k page size. I have 2GB memory on
> this board.=20

Which root file system are you using?

> ## Booting image at 01000000 ...
>    Image Name:   Linux-2.6.29-rc8-01447-g3bf8ce5-
>    Created:      2009-05-05   0:31:36 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    2138773 Bytes =3D  2 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>    Booting using the fdt at 0x4000000
>    Loading Device Tree to 007fb000, end 007fefff ... OK

Is this all you get? Nothing else?


Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Nobody will ever need more than 640k RAM!"       -- Bill Gates, 1981
"Windows 95 needs at least 8 MB RAM."             -- Bill Gates, 1996
"Nobody will ever need Windows 95."             -- logical conclusion
