Return-Path: <tmarri@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A2852DDFC3
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 17:56:39 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9AD15.66241ACA"
Subject: RE: sata device failed to IDENTIFY...
Date: Tue, 24 Mar 2009 23:45:52 -0700
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C0534AB6B@SDCEXCHANGE01.ad.amcc.com>
References: <22655709.post@talk.nabble.com>
From: "Tirumala Reddy Marri" <tmarri@amcc.com>
To: "rizwan ahmad" <rizwanamu@gmail.com>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9AD15.66241ACA
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Can you post your lspci -vvv dump .
=20

________________________________

From: linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org on behalf of =
rizwan ahmad
Sent: Mon 3/23/2009 1:07 AM
To: linuxppc-dev@ozlabs.org
Subject: sata device failed to IDENTIFY...




BM/AMCC PowerPC 440 GR Rev. B
Board: AMCC YELLOWSTONE
        VCO: 1066 MHz
        CPU: 533 MHz
        PLB: 133 MHz
        OPB: 66 MHz
        PER: 66 MHz
        PCI: 33 MHz
I2C:   ready
DRAM:  256 MB
FLASH: 32 MB
PCI:   Bus Dev VenId DevId Class Int
        00  0c  1106  3038  0c03  00
        00  0c  1106  3038  0c03  00
        00  0c  1106  3104  0c03  00
        00  0c  1106  3249  0104  0e
In:    serial
Out:   serial
Err:   serial
Net:   ppc_440x_eth0, ppc_440x_eth1
Hit any key to stop autoboot:  0
=3D> tftp 200000 z2
Waiting for PHY auto negotiation to complete.. done
Using ppc_440x_eth0 device
TFTP from server 192.168.0.100; our IP address is 192.168.0.101
Filename 'z2'.
Load address: 0x200000
Loading: T =
#################################################################
         =
#################################################################
         =
#################################################################
         ########################################################
done
Bytes transferred =3D 1283382 (139536 hex)
=3D> bootm
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.19
   Created:      2009-03-22   9:52:51 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1283318 Bytes =3D  1.2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.6.19 (root@debian) (gcc version 4.2.2) #10 Sun Mar 22
02:51:52 9AMCC PowerPC 440GR Yellowstone Platform
Zone PFN ranges:
  DMA             0 ->    65536
  Normal      65536 ->    65536
early_node_map[1] active PFN ranges
    0:        0 ->    65536
Built 1 zonelists.  Total pages: 65024
Kernel command line: root=3D/dev/nfs rw
nfsroot=3D192.168.0.100:/opt/eldk4.2/ppc_4xlMisrouted IRQ fixup and =
polling
support enabled
This may significantly impact system performance
PID hash table entries: 1024 (order: 10, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 257024k available (1940k kernel code, 668k data, 148k init, 0k
highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at MMIO 0x0 (irq =3D 0) is a 16550A
serial8250: ttyS1 at MMIO 0x0 (irq =3D 1) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
PPC 4xx OCP EMAC driver, version 3.54
mal0: initialized, 4 TX channels, 2 RX channels
zmii0: bridge in RMII mode
eth0: emac0, MAC 00:10:ec:00:89:89
eth0: found Generic MII PHY (0x01)
eth1: emac1, MAC 00:10:ec:80:89:89
eth1: found Generic MII PHY (0x03)
in init_module
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx
sata_via 0000:00:0c.3: routed to hard irq line 9
ata1: SATA max UDMA/133 cmd 0xFFB0 ctl 0xFFBA bmdma 0xFF60 irq 25
ata2: SATA max UDMA/133 cmd 0xFFA0 ctl 0xFFAA bmdma 0xFF68 irq 25
scsi0 : sata_via
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: qc timeout (cmd 0xec)
in err_mask
becoz of exec
ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
scsi1 : sata_via
ata2: SATA link down (SStatus 0 SControl 310)
ATA: abnormal status 0x7F on port 0xFFA7
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
eth0: link is up, 100 FDX, pause enabled
IP-Config: Complete:
      device=3Deth0, addr=3D192.168.0.101, mask=3D255.255.0.0, =
gw=3D192.168.0.100,
     host=3Dppc, domain=3D, nis-domain=3D(none),
     bootserver=3D192.168.0.100, rootserver=3D192.168.0.100, rootpath=3D
Looking up port of RPC 100003/2 on 192.168.0.100
Looking up port of RPC 100005/1 on 192.168.0.100
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 148k init
INIT: version 2.86 booting
                Welcome to DENX Embedded Linux Environment
                Press 'I' to enter interactive startup.
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access
method.
Setting clock : Thu Jan  1 01:01:51 CET 1970 [  OK  ]
Building the cache [  OK  ]
Setting hostname ppc:  [  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling /etc/fstab swaps:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
FATAL: Module ipv6 not found.
Bringing up loopback interface:  [  OK  ]
FATAL: Module ipv6 not found.
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting rpcbind: [  OK  ]
Mounting NFS filesystems:  [  OK  ]
Mounting other filesystems:  [  OK  ]
Starting xinetd: [  OK  ]

DENX ELDK version 4.2 build 2008-04-01
Linux 2.6.19 on a ppc



adding irqpoll, noacpi option to the bootargs is not working.
any suggestion???
--
View this message in context: =
http://www.nabble.com/sata-device-failed-to-IDENTIFY...-tp22655709p226557=
09.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev



------_=_NextPart_001_01C9AD15.66241ACA
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>sata device failed to IDENTIFY...</TITLE>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.3492" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText15679 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Can you post =
your lspci -vvv dump .</FONT></DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> =
linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org on behalf of rizwan =
ahmad<BR><B>Sent:</B> Mon 3/23/2009 1:07 AM<BR><B>To:</B> =
linuxppc-dev@ozlabs.org<BR><B>Subject:</B> sata device failed to =
IDENTIFY...<BR></FONT><BR></DIV>=0A=
<DIV><BR>=0A=
<P><FONT size=3D2>BM/AMCC PowerPC 440 GR Rev. B<BR>Board: AMCC =
YELLOWSTONE<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VCO: 1066 =
MHz<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU: 533 =
MHz<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PLB: 133 =
MHz<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPB: 66 =
MHz<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PER: 66 =
MHz<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCI: 33 =
MHz<BR>I2C:&nbsp;&nbsp; ready<BR>DRAM:&nbsp; 256 MB<BR>FLASH: 32 =
MB<BR>PCI:&nbsp;&nbsp; Bus Dev VenId DevId Class =
Int<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00&nbsp; 0c&nbsp; =
1106&nbsp; 3038&nbsp; 0c03&nbsp; =
00<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00&nbsp; 0c&nbsp; =
1106&nbsp; 3038&nbsp; 0c03&nbsp; =
00<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00&nbsp; 0c&nbsp; =
1106&nbsp; 3104&nbsp; 0c03&nbsp; =
00<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00&nbsp; 0c&nbsp; =
1106&nbsp; 3249&nbsp; 0104&nbsp; 0e<BR>In:&nbsp;&nbsp;&nbsp; =
serial<BR>Out:&nbsp;&nbsp; serial<BR>Err:&nbsp;&nbsp; =
serial<BR>Net:&nbsp;&nbsp; ppc_440x_eth0, ppc_440x_eth1<BR>Hit any key =
to stop autoboot:&nbsp; 0<BR>=3D&gt; tftp 200000 z2<BR>Waiting for PHY =
auto negotiation to complete.. done<BR>Using ppc_440x_eth0 =
device<BR>TFTP from server 192.168.0.100; our IP address is =
192.168.0.101<BR>Filename 'z2'.<BR>Load address: 0x200000<BR>Loading: T =
#################################################################<BR>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#################################################################<BR>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#################################################################<BR>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
########################################################<BR>done<BR>Bytes=
 transferred =3D 1283382 (139536 hex)<BR>=3D&gt; bootm<BR>## Booting =
image at 00200000 ...<BR>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; =
Linux-2.6.19<BR>&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2009-03-22&nbsp;&nbsp; 9:52:51 UTC<BR>&nbsp;&nbsp; Image =
Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)<BR>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1283318 Bytes =
=3D&nbsp; 1.2 MB<BR>&nbsp;&nbsp; Load Address: 00000000<BR>&nbsp;&nbsp; =
Entry Point:&nbsp; 00000000<BR>&nbsp;&nbsp; Verifying Checksum ... =
OK<BR>&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>Linux version =
2.6.19 (root@debian) (gcc version 4.2.2) #10 Sun Mar 22<BR>02:51:52 =
9AMCC PowerPC 440GR Yellowstone Platform<BR>Zone PFN ranges:<BR>&nbsp; =
DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0 -&gt;&nbsp;&nbsp;&nbsp; 65536<BR>&nbsp; =
Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 65536 -&gt;&nbsp;&nbsp;&nbsp; =
65536<BR>early_node_map[1] active PFN ranges<BR>&nbsp;&nbsp;&nbsp; =
0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; =
65536<BR>Built 1 zonelists.&nbsp; Total pages: 65024<BR>Kernel command =
line: root=3D/dev/nfs =
rw<BR>nfsroot=3D192.168.0.100:/opt/eldk4.2/ppc_4xlMisrouted IRQ fixup =
and polling<BR>support enabled<BR>This may significantly impact system =
performance<BR>PID hash table entries: 1024 (order: 10, 4096 =
bytes)<BR>Dentry cache hash table entries: 32768 (order: 5, 131072 =
bytes)<BR>Inode-cache hash table entries: 16384 (order: 4, 65536 =
bytes)<BR>Memory: 257024k available (1940k kernel code, 668k data, 148k =
init, 0k<BR>highmem)<BR>Mount-cache hash table entries: 512<BR>NET: =
Registered protocol family 16<BR>PCI: Probing PCI hardware<BR>SCSI =
subsystem initialized<BR>NET: Registered protocol family 2<BR>IP route =
cache hash table entries: 2048 (order: 1, 8192 bytes)<BR>TCP established =
hash table entries: 8192 (order: 3, 32768 bytes)<BR>TCP bind hash table =
entries: 4096 (order: 2, 16384 bytes)<BR>TCP: Hash tables configured =
(established 8192 bind 4096)<BR>TCP reno registered<BR>io scheduler noop =
registered<BR>io scheduler anticipatory registered (default)<BR>io =
scheduler deadline registered<BR>io scheduler cfq registered<BR>Serial: =
8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing =
enabled<BR>serial8250: ttyS0 at MMIO 0x0 (irq =3D 0) is a =
16550A<BR>serial8250: ttyS1 at MMIO 0x0 (irq =3D 1) is a =
16550A<BR>RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 =
blocksize<BR>PPC 4xx OCP EMAC driver, version 3.54<BR>mal0: initialized, =
4 TX channels, 2 RX channels<BR>zmii0: bridge in RMII mode<BR>eth0: =
emac0, MAC 00:10:ec:00:89:89<BR>eth0: found Generic MII PHY =
(0x01)<BR>eth1: emac1, MAC 00:10:ec:80:89:89<BR>eth1: found Generic MII =
PHY (0x03)<BR>in init_module<BR>Uniform Multi-Platform E-IDE driver =
Revision: 7.00alpha2<BR>ide: Assuming 33MHz system bus speed for PIO =
modes; override with idebus=3Dxx<BR>sata_via 0000:00:0c.3: routed to =
hard irq line 9<BR>ata1: SATA max UDMA/133 cmd 0xFFB0 ctl 0xFFBA bmdma =
0xFF60 irq 25<BR>ata2: SATA max UDMA/133 cmd 0xFFA0 ctl 0xFFAA bmdma =
0xFF68 irq 25<BR>scsi0 : sata_via<BR>ata1: SATA link up 1.5 Gbps =
(SStatus 113 SControl 310)<BR>ata1.00: qc timeout (cmd 0xec)<BR>ata1.00: =
failed to IDENTIFY (I/O error, err_mask=3D0x4)<BR>ata1: SATA link up 1.5 =
Gbps (SStatus 113 SControl 310)<BR>ata1.00: qc timeout (cmd =
0xec)<BR>ata1.00: failed to IDENTIFY (I/O error, =
err_mask=3D0x4)<BR>ata1: SATA link up 1.5 Gbps (SStatus 113 SControl =
310)<BR>ata1.00: qc timeout (cmd 0xec)<BR>in err_mask<BR>becoz of =
exec<BR>ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)<BR>ata1: =
SATA link up 1.5 Gbps (SStatus 113 SControl 310)<BR>scsi1 : =
sata_via<BR>ata2: SATA link down (SStatus 0 SControl 310)<BR>ATA: =
abnormal status 0x7F on port 0xFFA7<BR>TCP cubic registered<BR>NET: =
Registered protocol family 1<BR>NET: Registered protocol family =
17<BR>eth0: link is up, 100 FDX, pause enabled<BR>IP-Config: =
Complete:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=3Deth0, =
addr=3D192.168.0.101, mask=3D255.255.0.0, =
gw=3D192.168.0.100,<BR>&nbsp;&nbsp;&nbsp;&nbsp; host=3Dppc, domain=3D, =
nis-domain=3D(none),<BR>&nbsp;&nbsp;&nbsp;&nbsp; =
bootserver=3D192.168.0.100, rootserver=3D192.168.0.100, =
rootpath=3D<BR>Looking up port of RPC 100003/2 on =
192.168.0.100<BR>Looking up port of RPC 100005/1 on =
192.168.0.100<BR>VFS: Mounted root (nfs filesystem).<BR>Freeing unused =
kernel memory: 148k init<BR>INIT: version 2.86 =
booting<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; Welcome to DENX Embedded Linux =
Environment<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Press 'I' to enter interactive =
startup.<BR>Cannot access the Hardware Clock via any known =
method.<BR>Use the --debug option to see the details of our search for =
an access<BR>method.<BR>Setting clock : Thu Jan&nbsp; 1 01:01:51 CET =
1970 [&nbsp; OK&nbsp; ]<BR>Building the cache [&nbsp; OK&nbsp; =
]<BR>Setting hostname ppc:&nbsp; [&nbsp; OK&nbsp; ]<BR>Mounting local =
filesystems:&nbsp; [&nbsp; OK&nbsp; ]<BR>Enabling /etc/fstab =
swaps:&nbsp; [&nbsp; OK&nbsp; ]<BR>INIT: Entering runlevel: =
3<BR>Entering non-interactive startup<BR>FATAL: Module ipv6 not =
found.<BR>Bringing up loopback interface:&nbsp; [&nbsp; OK&nbsp; =
]<BR>FATAL: Module ipv6 not found.<BR>Starting system logger: [&nbsp; =
OK&nbsp; ]<BR>Starting kernel logger: [&nbsp; OK&nbsp; ]<BR>Starting =
rpcbind: [&nbsp; OK&nbsp; ]<BR>Mounting NFS filesystems:&nbsp; [&nbsp; =
OK&nbsp; ]<BR>Mounting other filesystems:&nbsp; [&nbsp; OK&nbsp; =
]<BR>Starting xinetd: [&nbsp; OK&nbsp; ]<BR><BR>DENX ELDK version 4.2 =
build 2008-04-01<BR>Linux 2.6.19 on a ppc<BR><BR><BR><BR>adding irqpoll, =
noacpi option to the bootargs is not working.<BR>any =
suggestion???<BR>--<BR>View this message in context: <A =
href=3D"http://www.nabble.com/sata-device-failed-to-IDENTIFY...-tp2265570=
9p22655709.html">http://www.nabble.com/sata-device-failed-to-IDENTIFY...-=
tp22655709p22655709.html</A><BR>Sent from the linuxppc-dev mailing list =
archive at =
Nabble.com.<BR><BR>_______________________________________________<BR>Lin=
uxppc-dev mailing list<BR>Linuxppc-dev@ozlabs.org<BR><A =
href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.=
org/mailman/listinfo/linuxppc-dev</A><BR></FONT></P></DIV></BODY></HTML>
------_=_NextPart_001_01C9AD15.66241ACA--
