Date: 24 Jun 2002 15:55:45 -0000
Message-ID: <20020624155545.3226.qmail@webmail13.rediffmail.com>
MIME-Version: 1.0
From: "somshekar chandrashekar kadam" <ppclinux@rediffmail.com>
Reply-To: "somshekar chandrashekar kadam" <ppclinux@rediffmail.com>
To: "Alex Zeffertt" <ajz@cambridgebroadband.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re: init problem
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi Alex here is my console prints




----------------------------------------------------

---------------- Linux Monitor 1.4.2-SBC-8260 ----------------
limon>
limon>
limon> boot
  inside init

  eth init(0)
stopped FCC
stopped FCC
stopped FCC
set ports
played with clock routing
set misc
set fcc modes
find phy
set ring buffers
did init
check link state
done fcc
waiting for link up
  inside switch case
  inside MIISET100
  before while loop

IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
  Bootfile name : mu.binBOOTP/TFTP from server 192.168.12.184; our
IP address is
192.168.12.218.
Filename 'mu.bin'.
Loading: Link up (10)
Loading:
 >.................................................................
done.

  image 6e6a725e 0 1b1bf8 6b657230 1b1c0c 48000005  kernel size
5b1c0c
board data at: 0400000 Cool
  020012Ced to:  0200100
  INITRD OFFSET   008BD5D
  INITRD  SIZE  0135E9A
  LOAD ADDDDR  0000000
  LOAD ADDDDR  0000000
   NUM_ADDR 00030AA
  NUM_ADDR  00030AA
   zimage add 040C2BC
   ZIMAGE_SIZE 006FAB5
   ZIMAGE_SIZE 006FAB5
  INITRD  START  047BD71
  zimage at:ART  F8B080C
  zimage at: 040C2BC
             040C2BC
  initrd atyes in initrd_start:     047BD71
   after inflateinit2  inside m0

  before inflate
  value of F BLOCKS

  out of gunzip sure

   out of gunzip sure
Linux version 2.4.2_hhl20 (root@localhost.localdomain) (gcc
version 2.95.3 20010315 (release)) #1179


Mon Jun 24 19:40:38 EDT 2002
On node 0 totalpages: 8192
zone(0): 8192 pages
.zone(1): 0 pages.zone(2): 0 pages.Kernel
command line: root=/dev/ramBuffer-cache hash table entries: 1024
(order: 0, 409bytes)Page
-cache hash table entries: 8192 (order: 3, 32768 bytes)Inode-cache
hash table en
tries: 2048 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
<6>Linux NET4.0 for Linux 2.4<6>Based upon Swansea University
Computer So
ciety NET3.039:
  IN kswapd Starting kswapd v1.



block: queued sectors max/low 19669kB/6556kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024
fec: Phy @ 0x0, type 0x71c7c71cfec: Phy @ 0x
1, type 0xc71c8e38fec: Phy @ 0x2, type 0x38e3e39efec: Phy @ 0x3,
type 0x8e711c71
fec: Phy @ 0x4, type 0x71c7e38efec: Phy @ 0x5, type 0x8e389c71fec:
Phy @ 0x6, ty
pe 0x71c77e07fec: Phy @ 0x7, type 0x1ce3638efec: Phy @ 0x8, type
0xce388e38fec:
Phy @ 0x9, type 0x38e3638efec: Phy @ 0xa, type 0xc71c8e38fec: Phy
@ 0xb, type 0x
1c713f01fec: Phy @ 0xc, type 0x71c7e38efec: Phy @ 0xd, type
0xc71c8e38fec: Phy @
  0xe, type 0x38e371c7fec: Phy @ 0xf, type 0xe39cc738fec: Phy @
0x10, type 0x8e39
0fc0fec: Phy @ 0x11, type 0xe38e8e38fec: Phy @ 0x12, type
0xc71c80fcfec: Phy @ 0
x13, type 0xe38ee38efec: Phy @ 0x14, type 0xce388e38fec: Phy @
0x15, type 0x8e38
c71cfec: Phy @ 0x16, type 0x638e638efec: Phy @ 0x17, type
0x8e391c71fec: Phy @ 0
x18, type 0x38e338e3fec: Phy @ 0x19, type 0x8e30c71cfec: Phy @
0x1a, type 0x9c71
38e7fec: Phy @ 0x1b, type 0x8e3f738efec: Phy @ 0x1c, type
0x9c7138e3fec: Phy @ 0
x1d, type 0x3e0338e3fec: Phy @ 0x1e, type 0x71c7c71cfec: Phy @
0x1f, type 0x07f0
8e38after mii_discover  eth0: FCC
ENET Version 0.2,eth0: FCC ENET Version 0.2,00 80 48 c3 fb 0f
(10 Mbit, Half Duplex)after network probe after net device init
INN INITRD_LOAD <5>RAMDISK: Compressed image found at block 0
Freeing initrd memory: 4194303k freed
  call:  13<6>NET4: Linux TCP/I
P 1.0 for NET4.0<6>
IP Protocols:ICMP,UDP,TCPIP: routing cache hash table of
512buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)<6>NET4:
  Unix domain sockets 1.0/SMP for Linux NET4.0.out of do_initcalls
ROOT: rd/0JUST
  VFS: Mounted root (ext2 filesystem).
after mount_devfs_fs  IN CONFIG BLK DEV INITRD Freeing unused
  kernel memory 40k ini 4k openfirmwar <0>Kernel panic:
  Attempted to kill init!<0>Rebooting in 180 seconds.

------------------------------------------------------
_________________________________________________________
There is always a better job for you at Monsterindia.com.
Go now http://monsterindia.com/rediffin/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
