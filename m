Message-ID: <20020531060244.15732.qmail@web11204.mail.yahoo.com>
Date: Thu, 30 May 2002 23:02:44 -0700 (PDT)
From: Sergiy Kovtun <skovtun@yahoo.com>
Subject: 64Mbytes on Sandpoint-X3B
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello All,
I try to connect all my 64 Meg memoty on
Sandpoint-X3B,
but received a crash( with 32M all OK).
Source:
SP-X3B + Altimus MPC7410
HHL 2.0
Any ideas??

TIA,
Sergiy

go 90000
loaded at:     00090000 000991B8

relocated to:  00800000 008091B8

zimage at:     00096000 001387F9

relocated to:  0080A000 008AC7F9

avail ram:     00400000 00800000


Linux/PPC load: console=ttyS0,9600 console=tty0
root=/dev/hdb2 ip=210.222.86.67:::255.255.255.192
Uncompressing Linux...done.
Now booting the kernel
Total memory = 64MB; using 256kB for hash table (at
c01c0000)
Linux version 2.4.2_hhl20 (root@sergiy) (gcc version
2.95.3 20010315 (release/MontaVista)) #2 Thu May 23
16:34:36 KST 2002
Motorola SPS Sandpoint Test Platform
Sandpoint port (C) 2000, 2001 MontaVista Software,
Inc. (source@mvista.com)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 console=tty0
root=/dev/hdb2 ip=210.222.86.67:::255.255.255.192
OpenPIC Version 1.2 (1 CPUs and 24 IRQ sources) at
f7fd0000
OpenPIC timer frequency is 100.000000 MHz
time_init: decrementer frequency = 24.359871 MHz
Calibrating delay loop... 389.12 BogoMIPS
Memory: 62388k available (1108k kernel code, 416k
data, 192k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536
bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384
bytes)
Page-cache hash table entries: 16384 (order: 4, 65536
bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768
bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society
NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 41389kB/13796kB, 128
slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
W82C105: IDE controller on PCI bus 00 dev 59
W82C105: chipset revision 5
W82C105: 100% native mode on irq 17
    ide0: BM-DMA at 0xbfffd0-0xbfffd7, BIOS settings:
hda:pio, hdb:pio
SL82C105 command word: 5
IDE timing: 00000909, resetting to PIO0 timing
    ide1: BM-DMA at 0xbfffd8-0xbfffdf, BIOS settings:
hdc:pio, hdd:pio
SL82C105 command word: 5
IDE timing: 000003e4, resetting to PIO0 timing
hdb: QUANTUM FIREBALL EX6.4A, ATA DISK drive
ide0 at 0xbffff8-0xbfffff,0xbffff6 on irq 14
hdb: 12594960 sectors (6449 MB) w/418KiB Cache,
CHS=13328/15/63
Partition check:
 hdb: [PTBL] [784/255/63] hdb1 hdb2 hdb3 < hdb5 >
loop: loaded (max 8 devices)
Serial driver version 5.02 (2000-08-09) with
MANY_PORTS SHARE_IRQ DETECT_IRQ SERIAL_PCI enabled
ÿttyS00 at 0x03f8 (irq = 0) is a 16550A
ttyS01 at 0x02f8 (irq = 0) is a 16550A
3c59x.c:LK1.1.12 06 Jan 2000  Donald Becker and
others. http://www.scyld.com/network/vortex.html
$Revision: 1.102.2.46 $
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3cSOHO100-TX Hurricane at 0xbfff00,
00:04:76:d0:1c:56, IRQ 18
  product code 'MM' rev 00.12 date 11-02-01
  8K byte-wide RAM 5:3 Rx:Tx split,
autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame
receives.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind
4096)
eth0: using NWAY autonegotiation
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 192k init 4k
openfirmware
Oops: kernel access of bad area, sig: 11
NIP: C002B8E8 XER: 20000000 LR: C002B8BC SP: C0319B30
REGS: c0319a80 TRAP: 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: C6024078, DSISR: 40000000
TASK = c0318000[1] 'init' Last syscall: 6
last math c0318000 last altivec 00000000
GPR00: 00001032 C0319B30 C0318000 00000001 00009032
C0319B18 C0319B38 C3FE4000
GPR08: C0810018 C6024060 C0810018 000000A0 000493E0
00000000 7FFFFA40 3002A228
GPR16: 3002A5C8 00000001 0000013B C034E560 C03EF5A0
C0319B98 00000000 00000001
GPR24: 00000000 C034E560 C0362400 00000002 C0319B38
C0140000 C0144620 C0315444
Call backtrace:
C00CB140 C00CFE00 C00D6064 C00D62DC C00D807C C00CDFE0
C0017128
C0003DA8 C001CAEC C001CC28 C000EA64 C0003D64 3000CB48
30004D30
30010EEC 30003880 300037AC 3001331C
Kernel panic: Aiee, killing interrupt handler

In interrupt handler - not syncing
Rebooting in 180 seconds..


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
