Return-Path: <leowang1998@yahoo.com.cn>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A030BB709B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 21 Jun 2009 13:45:06 +1000 (EST)
Received: from web15308.mail.cnb.yahoo.com (web15308.mail.cnb.yahoo.com
	[203.209.230.38]) by ozlabs.org (Postfix) with SMTP id 72FE9DDDA0
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Jun 2009 13:45:02 +1000 (EST)
Message-ID: <8647.75661.qm@web15308.mail.cnb.yahoo.com>
Date: Sun, 21 Jun 2009 11:45:00 +0800 (CST)
From: zhong wang <leowang1998@yahoo.com.cn>
Subject: Make bridge bug in linux 2.6.25b using Powerpc 405ep
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-272570463-1245555900=:75661"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--0-272570463-1245555900=:75661
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


=C2=A0hello all:
=C2=A0 =C2=A0I encountered a very strange question, I am using the AMCC Pow=
erpc 405ep its Emac0 received a single phy intel 971, Emac1 received RTL830=
5SB, they shared Mdio,=C2=A0=C2=A0Mdc. =C2=A02.6.25.10 I use the kernel.
=C2=A0 =C2=A0The problem is to use the following command will be =C2=A0eth0=
, eth1 configured bridge .my borad will down=C2=A0 often. Hope that=C2=A0he=
lps!
=C2=A0=C2=A0=20
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2009:06:21
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leowang
>=C2=A0Flowing command =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ifconfig=C2=A0 eth0=C2=A0 down=20
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ifconfig=C2=A0 eth1=C2=A0 down
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ifconfig=C2=A0 eth0=C2=A0 0.0.0.0=C2=A0 up
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ifconfig=C2=A0 eth1=C2=A0 0.0.0.0=C2=A0 up
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 brctl addbr=C2=A0 br0
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 brctl addif=C2=A0=C2=A0=C2=A0br0=C2=A0=
 eth0
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 brctl addif=C2=A0=C2=A0=C2=A0br0=C2=A0=
 eth1
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ifconfig=C2=A0 br0=C2=A0 192.168.80.250=C2=A0 u=
p
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 router ad default=C2=A0 gw=C2=A0 192.168.80=
.1
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 brctl=C2=A0 stp=C2=A0 off
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 brctl=C2=A0 setfd=C2=A0 br0=C2=A0=C2=
=A0=C2=A0off
>=C2=A0kernel log=20
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
[root@KingGate ~]# dmesg
Linux version 2.6.25.16 (root@localhost.localdomain) (gcc version 4.3.3 (GC=
C) ) #283 Wed Jun 17 12:06:25 CST 2009
IBM Bubinga port (MontaVista Software, Inc. <source@mvista.com>)
Entering add_active_range(0, 0, 32768) 0 entries of 256 used
Zone PFN ranges:
=C2=A0 DMA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0 ->=C2=A0=C2=A0=C2=A0 32768
=C2=A0 Normal=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32768 ->=C2=A0=C2=A0=C2=A0 3276=
8
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
=C2=A0=C2=A0=C2=A0 0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 ->=C2=A0=
=C2=A0=C2=A0 32768
On node 0 totalpages: 32768
=C2=A0 DMA zone: 256 pages used for memmap
=C2=A0 DMA zone: 0 pages reserved
=C2=A0 DMA zone: 32512 pages, LIFO batch:7
=C2=A0 Normal zone: 0 pages used for memmap
=C2=A0 Movable zone: 0 pages used for memmap
Built 1 zonelists in Zone order, mobility grouping on.=C2=A0 Total pages: 3=
2512
Kernel command line: root=3D/dev/ram0 rw console=3D/dev/null
PID hash table entries: 512 (order: 9, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 123932k available (2800k kernel code, 708k data, 164k init, 0k high=
mem)
SLUB: Genslabs=3D12, HWalign=3D32, Order=3D0-1, MinObjects=3D4, CPUs=3D1, N=
odes=3D1
Calibrating delay loop... 332.59 BogoMIPS (lpj=3D1662976)
Security Framework initialized
Capability LSM initialized
Mount-cache hash table entries: 512
net_namespace: 444 bytes
NET: Registered protocol family 16
PCI: Probing PCI hardware
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
checking if image is initramfs...it isn't (no cpio magic); looks like an in=
itrd
Freeing initrd memory: 2178k freed
JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler deadline registered (default)
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0x0 (irq =3D 1) is a 16550A
serial8250: ttyS1 at MMIO 0x0 (irq =3D 0) is a 16550A
brd: module loaded
loop: module loaded
PPC 4xx OCP EMAC driver, version 3.54
mal0: initialized, 4 TX channels, 2 RX channels
lipeng 10
eth0: emac0, MAC 00:10:5c:f0:90:d4
eth0: found Generic MII PHY (0x0a)
lipeng 5
eth1: emac1, MAC 00:10:5c:f0:90:d5
eth1: found Generic MII PHY (0x05)
Ethernet Channel Bonding Driver: v3.2.5 (March 21, 2008)
bonding: Warning: either miimon or arp_interval and arp_ip_target module pa=
rameters must be specified, otherwise bonding will not detect link failures=
! see bonding.txt for details.
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
PPP MPPE Compression module registered
NET: Registered protocol family 24
IMQ driver loaded successfully.
=C2=A0Hooking IMQ after NAT on PREROUTING.
=C2=A0Hooking IMQ before NAT on POSTROUTING.
8139too Fast Ethernet driver 0.9.28
eth2: RealTek RTL8139 at 0xfe00, 00:e0:4c:42:0a:55, IRQ 28
eth2:=C2=A0 Identified 8139 chip type 'RTL-8100B/8139D'
physmap platform flash device: 02000000 at fd000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
physmap-flash.0: Found 1 x16 devices at 0x1000000 in 16-bit bank
=C2=A0Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
erase region 0: offset=3D0x0,size=3D0x20000,blocks=3D128
erase region 1: offset=3D0x1000000,size=3D0x20000,blocks=3D128
Using physmap partition information
Creating 4 MTD partitions on "physmap-flash.0":
0x00000000-0x00400000 : "zImage"
0x00400000-0x00420000 : "hidden"
0x00420000-0x01d00000 : "application"
0x01d00000-0x02000000 : "config"
i2c /dev entries driver
IBM IIC driver v2.1
ibm-iic0: using standard (100 kHz) mode
GACT probability on
u32 classifier
=C2=A0=C2=A0=C2=A0 Performance counters on
=C2=A0=C2=A0=C2=A0 Actions configured=20
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (2048 buckets, 8192 max)
ctnetlink v0.93: registering with nfnetlink.
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Bridge firewalling registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 164k init
Warning: unable to open an initial console.
eth0: link is up, 100 FDX
device eth0 entered promiscuous mode
eth1: link is up, 100 FDX, pause enabled
device eth1 entered promiscuous mode
eth2: link down
device eth2 entered promiscuous mode
br0: port 2(eth1) entering learning state
br0: port 1(eth0) entering learning state
br0: port 2(eth1) entering disabled state
br0: port 1(eth0) entering disabled state
eth1: link is up, 100 FDX, pause enabled
br0: port 2(eth1) entering learning state
br0: port 2(eth1) entering disabled state
device eth2 left promiscuous mode
br0: port 3(eth2) entering disabled state
device eth1 left promiscuous mode
br0: port 2(eth1) entering disabled state
device eth0 left promiscuous mode
br0: port 1(eth0) entering disabled state
device eth0 entered promiscuous mode
device eth1 entered promiscuous mode
device eth2 entered promiscuous mode
br0: port 2(eth1) entering learning state
eth0: link is up, 100 FDX
br0: port 1(eth0) entering learning state
KingGate release 4.5
KingGate login: root
Password:=20
[root@KingGate ~]# dmesg
ocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Bridge firewalling registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 164k init
Warning: unable to open an initial console.
emac0: open
emac0: mdio_read(0a,01)
emac0: mdio_read -> 782d
emac0: mdio_read(0a,01)
emac0: mdio_read -> 782d
emac0: mdio_read(0a,05)
emac0: mdio_read -> 45e1
emac0: mdio_read(0a,04)
emac0: mdio_read -> 01e1
eth0: link is up, 100 FDX
emac0: configure
emac0: reset
emac0: rx_disable
emac0: tx_disable
mal0: poll_add(c7c0a3c8)
mal0: enable_tx(0)
mal0: set_rbcs(0, 1520)
mal0: enable_rx(0)
emac0: tx_enable
emac0: rx_enable
emac0: multicast c0500000
emac0: rx_disable
emac0: rx_enable
emac0: stats
emac0: multicast c0580000
emac0: rx_disable
emac0: hash_mc 1
emac0: mc 01:00:5e:00:00:01
emac0: rx_enable
emac0: multicast c0580000
emac0: rx_disable
emac0: hash_mc 1
emac0: mc 01:00:5e:00:00:01
emac0: rx_enable
emac0: stats
emac0: stats
emac1: stats
emac0: link timer
emac0: mdio_read(0a,01)
emac0: mdio_read -> 782d
emac0: mdio_read(0a,01)
emac0: mdio_read -> 782d
emac0: stats
emac1: stats
emac0: multicast c0580000
emac0: rx_disable
emac0: hash_mc 1
emac0: mc 01:00:5e:00:00:01
emac0: rx_enable
emac0: multicast c0580000
emac0: rx_disable
emac0: hash_mc 1
emac0: mc 01:00:5e:00:00:01
emac0: rx_enable
device eth0 entered promiscuous mode
emac0: multicast c1500000
emac0: rx_disable
emac0: rx_enable
emac1: open
emac0: mdio_read(05,01)
emac0: mdio_read -> 786d
emac0: mdio_read(05,01)
emac0: mdio_read -> 786d
emac0: mdio_read(05,05)
emac0: mdio_read -> 05e1
emac0: mdio_read(05,04)
emac0: mdio_read -> 05e1
eth1: link is up, 100 FDX, pause enabled
emac1: configure
emac1: reset
emac1: rx_disable
emac1: tx_disable
mal0: poll_add(c7c0b3c8)
mal0: enable_tx(2)
mal0: set_rbcs(1, 1520)
mal0: enable_rx(1)
emac1: tx_enable
emac1: rx_enable
emac1: multicast c0500000
emac1: rx_disable
emac1: rx_enable
emac1: stats
emac1: multicast c0580000
emac1: rx_disable
emac1: hash_mc 1
emac1: mc 01:00:5e:00:00:01
emac1: rx_enable
emac1: multicast c0580000
emac1: rx_disable
emac1: hash_mc 1
emac1: mc 01:00:5e:00:00:01
emac1: rx_enable
emac1: stats
emac1: multicast c0580000
emac1: rx_disable
emac1: hash_mc 1
emac1: mc 01:00:5e:00:00:01
emac1: rx_enable
device eth1 entered promiscuous mode
emac1: multicast c1500000
emac1: rx_disable
emac1: rx_enable
eth2: link down
device eth2 entered promiscuous mode
br0: port 2(eth1) entering learning state
br0: port 1(eth0) entering learning state
emac0: multicast c1500000
emac0: rx_disable
emac0: rx_enable
emac0: multicast c1500000
emac0: rx_disable
emac0: rx_enable
emac0: set_settings(1, 100, 1, 0x0000000f)
emac0: mdio_read(0a,04)
emac0: mdio_read -> 01e1
emac0: mdio_write(0a,04,01e1)
emac0: mdio_read(0a,00)
emac0: mdio_read -> 3100
emac0: mdio_write(0a,00,3300)
emac1: multicast c1500000
emac1: rx_disable
emac1: rx_enable
emac1: multicast c1500000
emac1: rx_disable
emac1: rx_enable
emac1: set_settings(1, 100, 1, 0x0000000f)
emac0: mdio_read(05,04)
emac0: mdio_read -> 05e1
emac0: mdio_write(05,04,01e1)
emac0: mdio_read(05,00)
emac0: mdio_read -> 2100
emac0: mdio_write(05,00,3300)
br0: port 2(eth1) entering disabled state
emac1: stats
br0: port 1(eth0) entering disabled state
emac0: stats
emac0: link timer
emac0: mdio_read(0a,01)
emac0: mdio_read -> 7809
emac0: mdio_read(0a,01)
emac0: mdio_read -> 7809
emac1: link timer
emac0: mdio_read(05,01)
emac0: mdio_read -> 786d
emac0: mdio_read(05,01)
emac0: mdio_read -> 786d
emac0: mdio_read(05,05)
emac0: mdio_read -> 05e1
emac0: mdio_read(05,04)
emac0: mdio_read -> 05e1
emac1: full_tx_reset
emac1: tx_disable
mal0: disable_tx(2)
emac1: configure
emac1: reset
emac1: rx_disable
emac1: tx_disable
mal0: enable_tx(2)
emac1: tx_enable
emac1: rx_enable
eth1: link is up, 100 FDX, pause enabled
br0: port 2(eth1) entering learning state
emac1: stats
br0: port 2(eth1) entering disabled state
device eth2 left promiscuous mode
br0: port 3(eth2) entering disabled state
device eth1 left promiscuous mode
emac1: multicast c0580000
emac1: rx_disable
emac1: hash_mc 1
emac1: mc 01:00:5e:00:00:01
emac1: rx_enable
br0: port 2(eth1) entering disabled state
device eth0 left promiscuous mode
emac0: multicast c0580000
emac0: rx_disable
emac0: hash_mc 1
emac0: mc 01:00:5e:00:00:01
emac0: rx_enable
br0: port 1(eth0) entering disabled state
emac0: multicast c0580000
emac0: rx_disable
emac0: hash_mc 1
emac0: mc 01:00:5e:00:00:01
emac0: rx_enable
emac0: multicast c0580000
emac0: rx_disable
emac0: hash_mc 1
emac0: mc 01:00:5e:00:00:01
emac0: rx_enable
device eth0 entered promiscuous mode
emac0: multicast c1500000
emac0: rx_disable
emac0: rx_enable
emac1: multicast c0580000
emac1: rx_disable
emac1: hash_mc 1
emac1: mc 01:00:5e:00:00:01
emac1: rx_enable
emac1: multicast c0580000
emac1: rx_disable
emac1: hash_mc 1
emac1: mc 01:00:5e:00:00:01
emac1: rx_enable
device eth1 entered promiscuous mode
emac1: multicast c1500000
emac1: rx_disable
emac1: rx_enable
device eth2 entered promiscuous mode
br0: port 2(eth1) entering learning state
emac0: link timer
emac0: mdio_read(0a,01)
emac0: mdio_read -> 782d
emac0: mdio_read(0a,01)
emac0: mdio_read -> 782d
emac0: mdio_read(0a,05)
emac0: mdio_read -> 45e1
emac0: mdio_read(0a,04)
emac0: mdio_read -> 01e1
eth0: link is up, 100 FDX
br0: port 1(eth0) entering learning state
emac0: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac1: link timer
emac0: mdio_read(05,01)
emac0: mdio_read -> 786d
emac0: mdio_read(05,01)
emac0: mdio_read -> 786d
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats
emac0: stats
emac1: stats=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0
=0A=0A=0A      ___________________________________________________________ =
=0A  =E5=A5=BD=E7=8E=A9=E8=B4=BA=E5=8D=A1=E7=AD=89=E4=BD=A0=E5=8F=91=EF=BC=
=8C=E9=82=AE=E7=AE=B1=E8=B4=BA=E5=8D=A1=E5=85=A8=E6=96=B0=E4=B8=8A=E7=BA=BF=
=EF=BC=81 =0Ahttp://card.mail.cn.yahoo.com/
--0-272570463-1245555900=:75661
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><BLOCKQUOTE style=3D"PADDING-LEFT: 5px; MARGI=
N-LEFT: 5px; BORDER-LEFT: rgb(16,16,255) 2px solid">
<DIV class=3DplainMail>&nbsp;hello all:<BR>&nbsp; &nbsp;I encountered a ver=
y strange question, I am using the AMCC Powerpc 405ep its Emac0 received a =
single phy intel 971, Emac1 received RTL8305SB, they shared Mdio,&nbsp;&nbs=
p;Mdc. &nbsp;2.6.25.10 I use the kernel.<BR>&nbsp; &nbsp;The problem is to =
use the following command will be &nbsp;eth0, eth1 configured bridge .my bo=
rad will down&nbsp; often. Hope that&nbsp;helps!</DIV>
<DIV class=3DplainMail>&nbsp;&nbsp; </DIV>
<DIV class=3DplainMail>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2009:06:21</DIV=
>
<DIV class=3DplainMail>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; leowang<BR>&gt;=
&nbsp;Flowing command &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>&=
gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ifconfig&nbsp; eth0&nbsp; down <BR>&gt;&nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; ifconfig&nbsp; eth1&nbsp;
 down<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ifconfig&nbsp; eth0&nbsp; 0.0.0.0&nbs=
p; up<BR>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ifconfig&nbsp; eth1&nbsp; 0.0.0.=
0&nbsp; up<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brctl addbr&nbsp; br0<BR>&gt;&nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp;&nbsp;&nbsp; brctl addif&nbsp;&nbsp;&nbsp;br0&nbsp; eth0=
<BR>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; brctl addif&nbsp;&nbsp;&nbsp;br0=
&nbsp;
 eth1<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ifconfig&nbsp; br0&nbsp; 192.168.80.2=
50&nbsp; up<BR>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; router ad default&nbsp; gw=
&nbsp; 192.168.80.1<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brctl&nbsp; stp&nbsp; o=
ff<BR>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; brctl&nbsp; setfd&nbsp; br0&nb=
sp;&nbsp;&nbsp;off<BR>&gt;&nbsp;kernel log </DIV>
<DIV class=3DplainMail>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;<BR>[root@KingGate ~]# dmesg<BR>Linux version 2.6.25.1=
6 (<A href=3D"mailto:root@localhost.localdomain">root@localhost.localdomain=
</A>) (gcc version 4.3.3 (GCC) ) #283 Wed Jun 17 12:06:25 CST 2009<BR>IBM B=
ubinga port (MontaVista Software, Inc. &lt;<A href=3D"mailto:source@mvista.=
com">source@mvista.com</A>&gt;)<BR>Entering add_active_range(0, 0, 32768) 0=
 entries of 256 used<BR>Zone PFN ranges:<BR>&nbsp; DMA&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbs=
p; 32768<BR>&nbsp; Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32768 -&gt;&nbsp;&n=
bsp;&nbsp; 32768<BR>Movable zone start PFN for each node<BR>early_node_map[=
1] active PFN ranges<BR>&nbsp;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 32768<BR>On node 0 totalpages: 32768=
<BR>&nbsp; DMA zone: 256 pages used for memmap<BR>&nbsp; DMA zone: 0 pages
 reserved<BR>&nbsp; DMA zone: 32512 pages, LIFO batch:7<BR>&nbsp; Normal zo=
ne: 0 pages used for memmap<BR>&nbsp; Movable zone: 0 pages used for memmap=
<BR>Built 1 zonelists in Zone order, mobility grouping on.&nbsp; Total page=
s: 32512<BR>Kernel command line: root=3D/dev/ram0 rw console=3D/dev/null<BR=
>PID hash table entries: 512 (order: 9, 2048 bytes)<BR>Dentry cache hash ta=
ble entries: 16384 (order: 4, 65536 bytes)<BR>Inode-cache hash table entrie=
s: 8192 (order: 3, 32768 bytes)<BR>Memory: 123932k available (2800k kernel =
code, 708k data, 164k init, 0k highmem)<BR>SLUB: Genslabs=3D12, HWalign=3D3=
2, Order=3D0-1, MinObjects=3D4, CPUs=3D1, Nodes=3D1<BR>Calibrating delay lo=
op... 332.59 BogoMIPS (lpj=3D1662976)<BR>Security Framework initialized<BR>=
Capability LSM initialized<BR>Mount-cache hash table entries: 512<BR>net_na=
mespace: 444 bytes<BR>NET: Registered protocol family 16<BR>PCI: Probing PC=
I hardware<BR>NET: Registered protocol family 2<BR>IP route cache hash tabl=
e entries:
 1024 (order: 0, 4096 bytes)<BR>TCP established hash table entries: 4096 (o=
rder: 3, 32768 bytes)<BR>TCP bind hash table entries: 4096 (order: 2, 16384=
 bytes)<BR>TCP: Hash tables configured (established 4096 bind 4096)<BR>TCP =
reno registered<BR>checking if image is initramfs...it isn't (no cpio magic=
); looks like an initrd<BR>Freeing initrd memory: 2178k freed<BR>JFFS2 vers=
ion 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.<BR>io scheduler noop registe=
red<BR>io scheduler deadline registered (default)<BR>Serial: 8250/16550 dri=
ver $Revision: 1.90 $ 2 ports, IRQ sharing disabled<BR>serial8250: ttyS0 at=
 MMIO 0x0 (irq =3D 1) is a 16550A<BR>serial8250: ttyS1 at MMIO 0x0 (irq =3D=
 0) is a 16550A<BR>brd: module loaded<BR>loop: module loaded<BR>PPC 4xx OCP=
 EMAC driver, version 3.54<BR>mal0: initialized, 4 TX channels, 2 RX channe=
ls<BR>lipeng 10<BR>eth0: emac0, MAC 00:10:5c:f0:90:d4<BR>eth0: found Generi=
c MII PHY (0x0a)<BR>lipeng 5<BR>eth1: emac1, MAC 00:10:5c:f0:90:d5<BR>eth1:
 found Generic MII PHY (0x05)<BR>Ethernet Channel Bonding Driver: v3.2.5 (M=
arch 21, 2008)<BR>bonding: Warning: either miimon or arp_interval and arp_i=
p_target module parameters must be specified, otherwise bonding will not de=
tect link failures! see bonding.txt for details.<BR>PPP generic driver vers=
ion 2.4.2<BR>PPP Deflate Compression module registered<BR>PPP BSD Compressi=
on module registered<BR>PPP MPPE Compression module registered<BR>NET: Regi=
stered protocol family 24<BR>IMQ driver loaded successfully.<BR>&nbsp;Hooki=
ng IMQ after NAT on PREROUTING.<BR>&nbsp;Hooking IMQ before NAT on POSTROUT=
ING.<BR>8139too Fast Ethernet driver 0.9.28<BR>eth2: RealTek RTL8139 at 0xf=
e00, 00:e0:4c:42:0a:55, IRQ 28<BR>eth2:&nbsp; Identified 8139 chip type 'RT=
L-8100B/8139D'<BR>physmap platform flash device: 02000000 at fd000000<BR>ph=
ysmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank<BR>physmap-flash.0=
: Found 1 x16 devices at 0x1000000 in 16-bit
 bank<BR>&nbsp;Intel/Sharp Extended Query Table at 0x0031<BR>Using buffer w=
rite method<BR>cfi_cmdset_0001: Erase suspend on write enabled<BR>erase reg=
ion 0: offset=3D0x0,size=3D0x20000,blocks=3D128<BR>erase region 1: offset=
=3D0x1000000,size=3D0x20000,blocks=3D128<BR>Using physmap partition informa=
tion<BR>Creating 4 MTD partitions on "physmap-flash.0":<BR>0x00000000-0x004=
00000 : "zImage"<BR>0x00400000-0x00420000 : "hidden"<BR>0x00420000-0x01d000=
00 : "application"<BR>0x01d00000-0x02000000 : "config"<BR>i2c /dev entries =
driver<BR>IBM IIC driver v2.1<BR>ibm-iic0: using standard (100 kHz) mode<BR=
>GACT probability on<BR>u32 classifier<BR>&nbsp;&nbsp;&nbsp; Performance co=
unters on<BR>&nbsp;&nbsp;&nbsp; Actions configured <BR>Netfilter messages v=
ia NETLINK v0.30.<BR>nf_conntrack version 0.5.0 (2048 buckets, 8192 max)<BR=
>ctnetlink v0.93: registering with nfnetlink.<BR>IPv4 over IPv4 tunneling d=
river<BR>GRE over IPv4 tunneling driver<BR>ip_tables: (C) 2000-2006 Netfilt=
er Core
 Team<BR>TCP cubic registered<BR>Initializing XFRM netlink socket<BR>NET: R=
egistered protocol family 1<BR>NET: Registered protocol family 17<BR>NET: R=
egistered protocol family 15<BR>Bridge firewalling registered<BR>802.1Q VLA=
N Support v1.8 Ben Greear &lt;<A href=3D"mailto:greearb@candelatech.com">gr=
eearb@candelatech.com</A>&gt;<BR>All bugs added by David S. Miller &lt;<A h=
ref=3D"mailto:davem@redhat.com">davem@redhat.com</A>&gt;<BR>RAMDISK: Compre=
ssed image found at block 0<BR>VFS: Mounted root (ext2 filesystem).<BR>Free=
ing unused kernel memory: 164k init<BR>Warning: unable to open an initial c=
onsole.<BR>eth0: link is up, 100 FDX<BR>device eth0 entered promiscuous mod=
e<BR>eth1: link is up, 100 FDX, pause enabled<BR>device eth1 entered promis=
cuous mode<BR>eth2: link down<BR>device eth2 entered promiscuous mode<BR>br=
0: port 2(eth1) entering learning state<BR>br0: port 1(eth0) entering learn=
ing state<BR>br0: port 2(eth1) entering disabled state<BR>br0: port
 1(eth0) entering disabled state<BR>eth1: link is up, 100 FDX, pause enable=
d<BR>br0: port 2(eth1) entering learning state<BR>br0: port 2(eth1) enterin=
g disabled state<BR>device eth2 left promiscuous mode<BR>br0: port 3(eth2) =
entering disabled state<BR>device eth1 left promiscuous mode<BR>br0: port 2=
(eth1) entering disabled state<BR>device eth0 left promiscuous mode<BR>br0:=
 port 1(eth0) entering disabled state<BR>device eth0 entered promiscuous mo=
de<BR>device eth1 entered promiscuous mode<BR>device eth2 entered promiscuo=
us mode<BR>br0: port 2(eth1) entering learning state<BR>eth0: link is up, 1=
00 FDX<BR>br0: port 1(eth0) entering learning state</DIV>
<DIV class=3DplainMail>KingGate release 4.5</DIV>
<DIV class=3DplainMail>KingGate login: root<BR>Password: <BR>[root@KingGate=
 ~]# dmesg<BR>ocol family 1<BR>NET: Registered protocol family 17<BR>NET: R=
egistered protocol family 15<BR>Bridge firewalling registered<BR>802.1Q VLA=
N Support v1.8 Ben Greear &lt;<A href=3D"mailto:greearb@candelatech.com">gr=
eearb@candelatech.com</A>&gt;<BR>All bugs added by David S. Miller &lt;<A h=
ref=3D"mailto:davem@redhat.com">davem@redhat.com</A>&gt;<BR>RAMDISK: Compre=
ssed image found at block 0<BR>VFS: Mounted root (ext2 filesystem).<BR>Free=
ing unused kernel memory: 164k init<BR>Warning: unable to open an initial c=
onsole.<BR>emac0: open<BR>emac0: mdio_read(0a,01)<BR>emac0: mdio_read -&gt;=
 782d<BR>emac0: mdio_read(0a,01)<BR>emac0: mdio_read -&gt; 782d<BR>emac0: m=
dio_read(0a,05)<BR>emac0: mdio_read -&gt; 45e1<BR>emac0: mdio_read(0a,04)<B=
R>emac0: mdio_read -&gt; 01e1<BR>eth0: link is up, 100 FDX<BR>emac0: config=
ure<BR>emac0: reset<BR>emac0: rx_disable<BR>emac0: tx_disable<BR>mal0:
 poll_add(c7c0a3c8)<BR>mal0: enable_tx(0)<BR>mal0: set_rbcs(0, 1520)<BR>mal=
0: enable_rx(0)<BR>emac0: tx_enable<BR>emac0: rx_enable<BR>emac0: multicast=
 c0500000<BR>emac0: rx_disable<BR>emac0: rx_enable<BR>emac0: stats<BR>emac0=
: multicast c0580000<BR>emac0: rx_disable<BR>emac0: hash_mc 1<BR>emac0: mc =
01:00:5e:00:00:01<BR>emac0: rx_enable<BR>emac0: multicast c0580000<BR>emac0=
: rx_disable<BR>emac0: hash_mc 1<BR>emac0: mc 01:00:5e:00:00:01<BR>emac0: r=
x_enable<BR>emac0: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: link tim=
er<BR>emac0: mdio_read(0a,01)<BR>emac0: mdio_read -&gt; 782d<BR>emac0: mdio=
_read(0a,01)<BR>emac0: mdio_read -&gt; 782d<BR>emac0: stats<BR>emac1: stats=
<BR>emac0: multicast c0580000<BR>emac0: rx_disable<BR>emac0: hash_mc 1<BR>e=
mac0: mc 01:00:5e:00:00:01<BR>emac0: rx_enable<BR>emac0: multicast c0580000=
<BR>emac0: rx_disable<BR>emac0: hash_mc 1<BR>emac0: mc 01:00:5e:00:00:01<BR=
>emac0: rx_enable<BR>device eth0 entered promiscuous mode<BR>emac0:
 multicast c1500000<BR>emac0: rx_disable<BR>emac0: rx_enable<BR>emac1: open=
<BR>emac0: mdio_read(05,01)<BR>emac0: mdio_read -&gt; 786d<BR>emac0: mdio_r=
ead(05,01)<BR>emac0: mdio_read -&gt; 786d<BR>emac0: mdio_read(05,05)<BR>ema=
c0: mdio_read -&gt; 05e1<BR>emac0: mdio_read(05,04)<BR>emac0: mdio_read -&g=
t; 05e1<BR>eth1: link is up, 100 FDX, pause enabled<BR>emac1: configure<BR>=
emac1: reset<BR>emac1: rx_disable<BR>emac1: tx_disable<BR>mal0: poll_add(c7=
c0b3c8)<BR>mal0: enable_tx(2)<BR>mal0: set_rbcs(1, 1520)<BR>mal0: enable_rx=
(1)<BR>emac1: tx_enable<BR>emac1: rx_enable<BR>emac1: multicast c0500000<BR=
>emac1: rx_disable<BR>emac1: rx_enable<BR>emac1: stats<BR>emac1: multicast =
c0580000<BR>emac1: rx_disable<BR>emac1: hash_mc 1<BR>emac1: mc 01:00:5e:00:=
00:01<BR>emac1: rx_enable<BR>emac1: multicast c0580000<BR>emac1: rx_disable=
<BR>emac1: hash_mc 1<BR>emac1: mc 01:00:5e:00:00:01<BR>emac1: rx_enable<BR>=
emac1: stats<BR>emac1: multicast c0580000<BR>emac1:
 rx_disable<BR>emac1: hash_mc 1<BR>emac1: mc 01:00:5e:00:00:01<BR>emac1: rx=
_enable<BR>device eth1 entered promiscuous mode<BR>emac1: multicast c150000=
0<BR>emac1: rx_disable<BR>emac1: rx_enable<BR>eth2: link down<BR>device eth=
2 entered promiscuous mode<BR>br0: port 2(eth1) entering learning state<BR>=
br0: port 1(eth0) entering learning state<BR>emac0: multicast c1500000<BR>e=
mac0: rx_disable<BR>emac0: rx_enable<BR>emac0: multicast c1500000<BR>emac0:=
 rx_disable<BR>emac0: rx_enable<BR>emac0: set_settings(1, 100, 1, 0x0000000=
f)<BR>emac0: mdio_read(0a,04)<BR>emac0: mdio_read -&gt; 01e1<BR>emac0: mdio=
_write(0a,04,01e1)<BR>emac0: mdio_read(0a,00)<BR>emac0: mdio_read -&gt; 310=
0<BR>emac0: mdio_write(0a,00,3300)<BR>emac1: multicast c1500000<BR>emac1: r=
x_disable<BR>emac1: rx_enable<BR>emac1: multicast c1500000<BR>emac1: rx_dis=
able<BR>emac1: rx_enable<BR>emac1: set_settings(1, 100, 1, 0x0000000f)<BR>e=
mac0: mdio_read(05,04)<BR>emac0: mdio_read -&gt; 05e1<BR>emac0:
 mdio_write(05,04,01e1)<BR>emac0: mdio_read(05,00)<BR>emac0: mdio_read -&gt=
; 2100<BR>emac0: mdio_write(05,00,3300)<BR>br0: port 2(eth1) entering disab=
led state<BR>emac1: stats<BR>br0: port 1(eth0) entering disabled state<BR>e=
mac0: stats<BR>emac0: link timer<BR>emac0: mdio_read(0a,01)<BR>emac0: mdio_=
read -&gt; 7809<BR>emac0: mdio_read(0a,01)<BR>emac0: mdio_read -&gt; 7809<B=
R>emac1: link timer<BR>emac0: mdio_read(05,01)<BR>emac0: mdio_read -&gt; 78=
6d<BR>emac0: mdio_read(05,01)<BR>emac0: mdio_read -&gt; 786d<BR>emac0: mdio=
_read(05,05)<BR>emac0: mdio_read -&gt; 05e1<BR>emac0: mdio_read(05,04)<BR>e=
mac0: mdio_read -&gt; 05e1<BR>emac1: full_tx_reset<BR>emac1: tx_disable<BR>=
mal0: disable_tx(2)<BR>emac1: configure<BR>emac1: reset<BR>emac1: rx_disabl=
e<BR>emac1: tx_disable<BR>mal0: enable_tx(2)<BR>emac1: tx_enable<BR>emac1: =
rx_enable<BR>eth1: link is up, 100 FDX, pause enabled<BR>br0: port 2(eth1) =
entering learning state<BR>emac1: stats<BR>br0: port 2(eth1)
 entering disabled state<BR>device eth2 left promiscuous mode<BR>br0: port =
3(eth2) entering disabled state<BR>device eth1 left promiscuous mode<BR>ema=
c1: multicast c0580000<BR>emac1: rx_disable<BR>emac1: hash_mc 1<BR>emac1: m=
c 01:00:5e:00:00:01<BR>emac1: rx_enable<BR>br0: port 2(eth1) entering disab=
led state<BR>device eth0 left promiscuous mode<BR>emac0: multicast c0580000=
<BR>emac0: rx_disable<BR>emac0: hash_mc 1<BR>emac0: mc 01:00:5e:00:00:01<BR=
>emac0: rx_enable<BR>br0: port 1(eth0) entering disabled state<BR>emac0: mu=
lticast c0580000<BR>emac0: rx_disable<BR>emac0: hash_mc 1<BR>emac0: mc 01:0=
0:5e:00:00:01<BR>emac0: rx_enable<BR>emac0: multicast c0580000<BR>emac0: rx=
_disable<BR>emac0: hash_mc 1<BR>emac0: mc 01:00:5e:00:00:01<BR>emac0: rx_en=
able<BR>device eth0 entered promiscuous mode<BR>emac0: multicast c1500000<B=
R>emac0: rx_disable<BR>emac0: rx_enable<BR>emac1: multicast c0580000<BR>ema=
c1: rx_disable<BR>emac1: hash_mc 1<BR>emac1: mc
 01:00:5e:00:00:01<BR>emac1: rx_enable<BR>emac1: multicast c0580000<BR>emac=
1: rx_disable<BR>emac1: hash_mc 1<BR>emac1: mc 01:00:5e:00:00:01<BR>emac1: =
rx_enable<BR>device eth1 entered promiscuous mode<BR>emac1: multicast c1500=
000<BR>emac1: rx_disable<BR>emac1: rx_enable<BR>device eth2 entered promisc=
uous mode<BR>br0: port 2(eth1) entering learning state<BR>emac0: link timer=
<BR>emac0: mdio_read(0a,01)<BR>emac0: mdio_read -&gt; 782d<BR>emac0: mdio_r=
ead(0a,01)<BR>emac0: mdio_read -&gt; 782d<BR>emac0: mdio_read(0a,05)<BR>ema=
c0: mdio_read -&gt; 45e1<BR>emac0: mdio_read(0a,04)<BR>emac0: mdio_read -&g=
t; 01e1<BR>eth0: link is up, 100 FDX<BR>br0: port 1(eth0) entering learning=
 state<BR>emac0: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>e=
mac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats=
<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: =
stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0:
 stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>e=
mac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats=
<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: =
stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>em=
ac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<=
BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: s=
tats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>ema=
c1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<B=
R>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: st=
ats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac=
1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR=
>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: sta=
ts<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0:
 stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>e=
mac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats=
<BR>emac0: stats<BR>emac1: stats<BR>emac1: link timer<BR>emac0: mdio_read(0=
5,01)<BR>emac0: mdio_read -&gt; 786d<BR>emac0: mdio_read(05,01)<BR>emac0: m=
dio_read -&gt; 786d<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac=
1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR=
>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: sta=
ts<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1=
: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>=
emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stat=
s<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1:=
 stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>e=
mac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1:
 stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>e=
mac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats=
<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: =
stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>em=
ac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<=
BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: s=
tats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>ema=
c0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<B=
R>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: st=
ats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac=
0: stats<BR>emac1: stats<BR>emac0: stats<BR>emac1: stats<BR>emac0: stats<BR=
>emac1: stats<BR>emac0: stats<BR>emac1:
 stats&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;<BR></DIV></BLOCKQUOTE></td></tr></table><br>=0A=0A=0A      <hr si=
ze=3D1><a href=3D"http://cn.rd.yahoo.com/mail_cn/tagline/card/*http://card.=
mail.cn.yahoo.com/">  =E5=A5=BD=E7=8E=A9=E8=B4=BA=E5=8D=A1=E7=AD=89=E4=BD=
=A0=E5=8F=91=EF=BC=8C=E9=82=AE=E7=AE=B1=E8=B4=BA=E5=8D=A1=E5=85=A8=E6=96=B0=
=E4=B8=8A=E7=BA=BF=EF=BC=81</a>
--0-272570463-1245555900=:75661--
