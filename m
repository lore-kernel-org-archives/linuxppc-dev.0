Message-ID: <003e01c39136$d0125630$2803050a@JackyLam>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <001d01c39133$20f088a0$2803050a@JackyLam>
Subject: Re: Walnut PCI bridge can't be detected
Date: Mon, 13 Oct 2003 11:05:09 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_003B_01C39179.DDDFAE00"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_003B_01C39179.DDDFAE00
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit


    Forget to attach my boot log. I have turned on all PCI debug message and
added some printk to trace the flow of kernel. Beside that, I don't have any
change related.

----- Original Message -----
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Monday, October 13, 2003 10:38 AM
Subject: Walnut PCI bridge can't be detected


>
> Dear all,
>
>     Concerning my pervious posts about the problem on receiving interrupt
> from PCI cards. I guess it is the problem of PCI bridge..(at least I think
> it is related). Watching the old post in this list, someone post the boot
> log of Walnut board here long time ago. The boot log contians a line to
> detect PCI bridge just after the line"PCI: Probing PCI hardware". However,
> the current devel tree running on Walnut doesn't have this.
>
>     Also, under /proc/bus/pci and /proc/pci, I can't see any information
> about the brdige.
>
>     Moreover, I find that there is a minor different on a bit in my ES1371
> card on Walnut from that on PC. On PC, ES1371 seems will capture an "Slave
> interrupt controller" event just after bootup. But on Walnut, the event
will
> become "Slave DMA controller".
>
>     I think these all differents are rooted from some miss configuration
> about PCI in u-boot or kernel early  initialization. I am not familiar
with
> PCI. Hope someone here knows what is happening and gives me some idea on
how
> to fix that.
>
>     Thanks so much.
>
> Best regards,
> Jacky
>
>

------=_NextPart_000_003B_01C39179.DDDFAE00
Content-Type: application/octet-stream;
	name="minicom.cap"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="minicom.cap"

=0A=
=0A=
U-Boot 0.4.8 (Oct  6 2003 - 15:36:52)=0A=
=0A=
CPU:   IBM PowerPC 405GP Rev. D at 200 MHz (PLB=3D100, OPB=3D50, =
EBC=3D33 MHz)=0A=
       PCI sync clock at 33 MHz, internal PCI arbiter enabled=0A=
       16 kB I-Cache 8 kB D-Cache=0A=
Board: ### No HW ID - assuming WALNUT405=0A=
I2C:   ready=0A=
DRAM:  64 MB=0A=
Top of RAM usable for U-Boot at: 04000000=0A=
Reserving 195k for U-Boot at: 03fcf000=0A=
Reserving 132k for malloc() at: 03fae000=0A=
Reserving 112 Bytes for Board Info at: 03fadf90=0A=
Reserving 48 Bytes for Global Data at: 03fadf60=0A=
Stack Pointer at: 03fadf48=0A=
New Stack Pointer is: 03fadf48=0A=
Now running in RAM - U-Boot at: 03fcf000=0A=
FLASH: 512 kB=0A=
PCI Scan: Found Bus 0, Device 0, Function 0=0A=
PCI Scan: Found Bus 0, Device 1, Function 0=0A=
In:    serial=0A=
Out:   serial=0A=
Err:   serial=0A=
KGDB:  kgdb ready=0A=
ready=0A=
U-Boot relocated to 03fcf000=0A=
BEDBUG:ready=0A=
### main_loop entered: bootdelay=3D3=0A=
=0A=
### main_loop: bootcmd=3D"bootm 400000"=0A=
Hit any key to stop autoboot:  3 =08=08=08 0 =0A=
=3D> boot=0A=
## Booting image at 00400000 ...=0A=
   Image Name:   test=0A=
   Created:      2003-10-13   2:55:46 UTC=0A=
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)=0A=
   Data Size:    669727 Bytes =3D 654 kB=0A=
   Load Address: 00000000=0A=
   Entry Point:  00000000=0A=
   Verifying Checksum ... OK=0A=
   Uncompressing Kernel Image ... OK=0A=
## Current stack ends at 0x03FACD28 =3D> set upper limit to 0x00800000=0A=
## cmdline at 0x007FFC00 ... 0x007FFC74=0A=
bd address  =3D 0x03FADF90=0A=
memstart    =3D 0x00000000=0A=
memsize     =3D 0x04000000=0A=
flashstart  =3D 0xFFF80000=0A=
flashsize   =3D 0x00080000=0A=
flashoffset =3D 0x0002B700=0A=
sramstart   =3D 0x00000000=0A=
sramsize    =3D 0x00000000=0A=
bootflags   =3D 0x0000A000=0A=
procfreq    =3D    200 MHz=0A=
plb_busfreq =3D    100 MHz=0A=
pci_busfreq =3D 33.333 MHz=0A=
ethaddr     =3D 00:11:22:33:44:55=0A=
IP addr     =3D 10.5.3.45=0A=
baudrate    =3D  57600 bps=0A=
No initrd=0A=
## Transferring control to Linux (at address 00000000) ...=0A=
id mach(): done=0A=
MMU:enter=0A=
MMU:hw init=0A=
MMU:mapin=0A=
MMU:mapin_ram done=0A=
MMU:setio=0A=
MMU:exit=0A=
setup_arch: enter=0A=
setup_arch: bootmem=0A=
arch: exit=0A=
Linux version 2.4.20 (sylam@localhost.localdomain) (gcc version 3.2.3) =
#10 Mon Oct 13 10:55:43 HKT 2003=0A=
ppc4xx_find_bridges: enter=0A=
ioremap PCLIO_BASE =3D 0xe7ffd000=0A=
PCI bridge regs before fixup =0A=
 pmm0ma	0xc0000001=0A=
 pmm0ma	0x80000000=0A=
 pmm0ma	0x80000000=0A=
 pmm0ma	0x0=0A=
 pmm1ma	0x0=0A=
 pmm1ma	0x0=0A=
 pmm1ma	0x0=0A=
 pmm1ma	0x0=0A=
 pmm2ma	0x0=0A=
 pmm2ma	0x0=0A=
 pmm2ma	0x0=0A=
 pmm2ma	0x0=0A=
 pmm3ma	0x0=0A=
 pmm3ma	0x80000001=0A=
 pmm3ma	0x0=0A=
 pmm3ma	0x0=0A=
 ptm1ms	0x80000001=0A=
 ptm1la	0x0=0A=
 ptm2ms	0x0=0A=
 ptm2la	0x0=0A=
BUS 0, device 0, Function 0 bar 0x00000014 is 0x00000008=0A=
BUS 0, device 0, Function 0 bar 0x00000018 is 0x00000000=0A=
PCI bridge regs after fixup =0A=
 pmm0ma	0xc0000001=0A=
 pmm0ma	0x80000000=0A=
 pmm0ma	0x80000000=0A=
 pmm0ma	0x0=0A=
 pmm1ma	0x0=0A=
 pmm1ma	0x0=0A=
 pmm1ma	0x0=0A=
 pmm1ma	0x0=0A=
 pmm2ma	0x0=0A=
 pmm2ma	0x0=0A=
 pmm2ma	0x0=0A=
 pmm2ma	0x0=0A=
 pmm3ma	0x0=0A=
 pmm3ma	0x1=0A=
 pmm3ma	0x0=0A=
 pmm3ma	0x0=0A=
 ptm1ms	0x1=0A=
 ptm1la	0x0=0A=
 ptm2ms	0x0=0A=
 ptm2la	0x0=0A=
IBM Walnut port (C) 2000-2002 MontaVista Software, Inc. =
(source@mvista.com)=0A=
On node 0 totalpages: 8192=0A=
zone(0): 8192 pages.=0A=
zone(1): 0 pages.=0A=
zone(2): 0 pages.=0A=
Kernel command line: root=3D/dev/nfs =
ip=3D10.5.4.45:10.5.6.76:10.5.1.1:255.255.0.0:eth0: =
nfsroot=3D/home/sylam/build/ppcnfs console=3DttyS0,57600=0A=
Calibrating delay loop... 199.88 BogoMIPS=0A=
Memory: 30688k available (1048k kernel code, 364k data, 224k init, 0k =
highmem)=0A=
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)=0A=
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)=0A=
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)=0A=
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)=0A=
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)=0A=
POSIX conformance testing by UNIFIX=0A=
PCI: Probing PCI hardware=0A=
host_head c01ae000=0A=
Scanning bus 00=0A=
Found 00:08 [1274/1371] 000401 00=0A=
PCI: Calling quirk c000b1d8 for 00:01.0=0A=
ppc405_pcibios_fixup_resources: enter=0A=
Fixups for bus 00=0A=
Bus scan for 00 returning with max=3D00=0A=
pci bus count 1=0A=
PCI: Calling quirk c0143c54 for 00:01.0=0A=
             =0A=
Linux NET4.0 for Linux 2.4=0A=
Based upon Swansea University Computer Society NET3.039=0A=
Initializing RT netlink socket=0A=
OCP uart ver 1.6.2 init complete=0A=
Starting kswapd=0A=
alloc_area_pte: page already exists=0A=
alloc_area_pte: page already exists=0A=
alloc_area_pte: page already exists=0A=
alloc_area_pte: page already exists=0A=
alloc_area_pte: page already exists=0A=
alloc_area_pte: page already exists=0A=
alloc_area_pte: page already exists=0A=
alloc_area_pte: page already exists=0A=
alloc_area_pte: page already exists=0A=
alloc_area_pte: page already exists=0A=
alloc_area_pte: page already exists=0A=
alloc_area_pte: page already exists=0A=
i2c-core.o: i2c core module=0A=
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ =
SERIAL_PCI enabled=0A=
ttyS00 at 0xef600300 (irq =3D 0) is a 16550A=0A=
ttyS01 at 0xef600400 (irq =3D 1) is a 16550A=0A=
IBM gpio driver version 07.25.02=0A=
GPIO #0 at 0xc300d700=0A=
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize=0A=
loop: loaded (max 8 devices)=0A=
eth0: Phy @ 0x1, type DP83843 (0x20005c10)=0A=
Reset ethernet interfaces=0A=
es1371: version v0.30 time 09:09:04 Oct 13 2003=0A=
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x06=0A=
ppc405_uic_enable - irq 28 word 0 bit 0x1c=0A=
es1371: found es1371 rev 6 at io 0xffc0 irq 28=0A=
es1371: features: joystick 0x0=0A=
PCI header=0A=
1274=0A=
1371=0A=
5=0A=
410=0A=
4010006=0A=
6=0A=
0=0A=
80=0A=
0=0A=
0=0A=
ffc1=0A=
0=0A=
0=0A=
0=0A=
0=0A=
0=0A=
0=0A=
1274=0A=
1371=0A=
0=0A=
dc=0A=
1c=0A=
1=0A=
c=0A=
80=0A=
es1371_probe=0A=
cdf0000 7f080ec0 ff ff ff ff fffffff0 470000 0 fffd ff800000 10000 10000 =
10000 f7fbd6e7 ffefff7f f3fffea7 9f5ff5ef f7fbd6e7 ffefff7f =0A=
src_init=0A=
0 7f080ec0 ff ff ff ff fffffff0 470000 0 fffd ff800000 10000 10000 10000 =
f7fbd6e7 ffefff7f f3fffea7 9f5ff5ef f7fbd6e7 ffefff7f =0A=
set_dac2_rate=0A=
0 7f080ec0 ff ff ff ff fffffff0 470000 0 fffd ff800000 10000 10000 10000 =
f7fbd6e7 ffefff7f f3fffea7 9f5ff5ef f7fbd6e7 ffefff7f =0A=
ac97_codec: AC97 Audio codec, id: CRY19(Cirrus Logic CS4297A rev A)=0A=
ac97_codec: wrote OSS mixer  0 (Primary ac97 register 0x02), left =
vol:67, right vol:67: 0x1515 -> 0x1515=0A=
ac97_codec: wrote OSS mixer  4 (Primary ac97 register 0x18), left =
vol:67, right vol:67: 0x0a0a -> 0x0a0a=0A=
ac97_codec: wrote OSS mixer  5 (Primary ac97 register 0x0a), left =
vol:67, right vol:67: 0x000a -> 0x000a=0A=
ac97_codec: wrote OSS mixer  6 (Primary ac97 register 0x10), left =
vol:67, right vol:67: 0x0a0a -> 0x0a0a=0A=
ac97_codec: wrote OSS mixer  7 (Primary ac97 register 0x0e), left vol: =
0, right vol: 0: 0x8000 -> 0x8000=0A=
ac97_codec: wrote OSS mixer  8 (Primary ac97 register 0x12), left =
vol:67, right vol:67: 0x0a0a -> 0x0a0a=0A=
ac97_codec: wrote OSS mixer 10 (Primary ac97 register 0x04), left =
vol:67, right vol:67: 0x1515 -> 0x1515=0A=
ac97_codec: wrote OSS mixer 12 (Primary ac97 register 0x1c), left =
vol:67, right vol:67: 0x0a0a -> 0x0a0a=0A=
ac97_codec: wrote OSS mixer 14 (Primary ac97 register 0x16), left =
vol:67, right vol:67: 0x0a0a -> 0x0a0a=0A=
ac97_codec: wrote OSS mixer 20 (Primary ac97 register 0x0c), left =
vol:67, right vol:67: 0x000a -> 0x000a=0A=
ac97_codec: wrote OSS mixer 21 (Primary ac97 register 0x06), left =
vol:67, right vol:67: 0x0015 -> 0x0015=0A=
ac97_codec: wrote OSS mixer 22 (Primary ac97 register 0x14), left =
vol:67, right vol:67: 0x0a0a -> 0x0a0a=0A=
ac97_codec: setting ac97 recmask to 0x0404=0A=
ac97_codec: wrote OSS mixer  6 (Primary ac97 register 0x10), left =
vol:64, right vol:64: 0x0b0b -> 0x0b0b=0A=
ac97_codec: wrote OSS mixer  8 (Primary ac97 register 0x12), left =
vol:64, right vol:64: 0x0b0b -> 0x0b0b=0A=
ac97_codec: wrote OSS mixer 22 (Primary ac97 register 0x14), left =
vol:64, right vol:64: 0x0b0b -> 0x0b0b=0A=
ac97_codec: wrote OSS mixer 14 (Primary ac97 register 0x16), left =
vol:64, right vol:64: 0x0b0b -> 0x0b0b=0A=
ac97_codec: wrote OSS mixer  4 (Primary ac97 register 0x18), left =
vol:64, right vol:64: 0x0b0b -> 0x0b0b=0A=
ac97_codec: wrote OSS mixer  0 (Primary ac97 register 0x02), left =
vol:64, right vol:64: 0x1717 -> 0x1717=0A=
ac97_codec: wrote OSS mixer 21 (Primary ac97 register 0x06), left =
vol:64, right vol:64: 0x0017 -> 0x0017=0A=
ac97_codec: wrote OSS mixer 20 (Primary ac97 register 0x0c), left =
vol:64, right vol:64: 0x000b -> 0x000b=0A=
ac97_codec: wrote OSS mixer  5 (Primary ac97 register 0x0a), left =
vol:64, right vol:64: 0x000a -> 0x000a=0A=
ac97_codec: wrote OSS mixer  7 (Primary ac97 register 0x0e), left =
vol:64, right vol:64: 0x000b -> 0x000b=0A=
ac97_codec: wrote OSS mixer 12 (Primary ac97 register 0x1c), left =
vol:64, right vol:64: 0x0a0a -> 0x0a0a=0A=
IBM On-chip iic (i2c) algorithm module 2002.30.04=0A=
iic_ibmocp_init: IBM on-chip iic adapter module=0A=
ppc405_uic_enable - irq 2 word 0 bit 0x2=0A=
i2c-core.o: adapter IBM OCP IIC adapter registered as adapter 0.=0A=
NET4: Linux TCP/IP 1.0 for NET4.0=0A=
IP Protocols: ICMP, UDP, TCP, IGMP=0A=
IP: routing cache hash table of 512 buckets, 4Kbytes=0A=
TCP: Hash tables configured (established 2048 bind 4096)=0A=
eth0: IBM EMAC: link up, 100 Mbps Full Duplex, auto-negotiation complete.=0A=
eth0: IBM EMAC: MAC 00:11:22:33:44:55.=0A=
ppc405_uic_enable - irq 15 word 0 bit 0xf=0A=
ppc405_uic_enable - irq 9 word 0 bit 0x9=0A=
ppc405_uic_enable - irq 10 word 0 bit 0xa=0A=
ppc405_uic_enable - irq 13 word 0 bit 0xd=0A=
ppc405_uic_enable - irq 11 word 0 bit 0xb=0A=
eth0: IBM EMAC: open completed=0A=
IP-Config: Complete:=0A=
      device=3Deth0, addr=3D10.5.4.45, mask=3D255.255.0.0, gw=3D10.5.1.1,=0A=
     host=3Deth0, domain=3D, nis-domain=3D(none),=0A=
     bootserver=3D10.5.6.76, rootserver=3D10.5.6.76, rootpath=3D=0A=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.=0A=
Looking up port of RPC 100003/2 on 10.5.6.76=0A=
Looking up port of RPC 100005/1 on 10.5.6.76=0A=
VFS: Mounted root (nfs filesystem).=0A=
Freeing unused kernel memory: 224k init=0A=
ppc405_uic_enable - irq 0 word 0 bit 0x0=0A=
ppc405_uic_disable - irq 0 word 0 bit 0x0=0A=
ppc405_uic_enable - irq 0 word 0 bit 0x0=0A=
ppc405_uic_disable - irq 0 word 0 bit 0x0=0A=
ppc405_uic_enable - irq 0 word 0 bit 0x0=0A=
init started:  BusyBox v1.00-pre3 (2003.10.07-09:18+0000) multi-call =
binary=0A=
ppc405_uic_disable - irq 0 word 0 bit 0x0=0A=
ppc405_uic_enable - irq 0 word 0 bit 0x0=0A=
ppc405_uic_disable - irq 0 word 0 bit 0x0=0A=
ppc405_uic_enable - irq 0 word 0 bit 0x0=0A=
=0A=
=0A=
BusyBox v1.00-pre3 (2003.10.07-09:18+0000) Built-in shell (ash)=0A=
Enter 'help' for a list of built-in commands.=0A=
=0A=
-sh: can't access tty; job control turned off=0A=
=0A=
Processing /etc/profile... Done=0A=
=0A=
/ #
------=_NextPart_000_003B_01C39179.DDDFAE00--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
