Message-ID: <001901c0d8ed$43a4daa0$16b260d2@sei.co.kr>
From: kdlee@sei.co.kr (Lee)
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: hda: lost interrupt
Date: Thu, 10 May 2001 10:04:46 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    I have the custom mpc860 board ported with linux version 2.2.13.
My custom board looks like a Motorola MBX board because it has a ATA-type
IDE disk drive interfaced through QSPAN PCI-Bridge and W83C553F.
Currently, I am trying to upgrade our linux kernel using linux version 2.4.0.
But I am having trouble with a problem regarding to the IDE disk drive.
I don't have any ATA-type IDE disk problems with linux version 2.2.13 on the
same target board.
Now I can see the following message from my console port.
-----------------------
" hda: hda lost interrupt"
-----------------------
So I hope anybody can give some fresh ideas to how to solve this problem.
When I boot our target board, I got the following messages and nothing more.
-------------------------------------------------------------------------
-------------------------------------------------------------------------
relocated to:  00180000 0018B1E4
board data at: 01FF4558 01FF4584
relocated to:  00280100 0028012C
zimage at:     00296000 0030EE44
avail ram:     0030F000 02000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.0 (kdlee@imac.sei.co.kr) (gcc version 2.95.2 19991024 (release
/franzo)) #77 Wed Apr 4 16:37:42 KST 2001
!!!Start QSpan Init...........................
 Start W83C553F Initialization...................
Found (  3:0): vendor 0x10ad, device 0x0565, class 0x060100
 Start SL82C105 Initialization...................
Found (  3:1): vendor 0x10ad, device 0x0105, class 0x01018f
Boot arguments: root=/dev/hda1 nfsaddrs=210.96.178.42:210.96.178.74 hdc=noprobe
hdf=noprobe hdg=noprobe hdh=noprobe
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda1
ide_setup: hdc=noprobe
ide_setup: hdf=noprobe -- BAD OPTION
ide_setup: hdg=noprobe -- BAD OPTION
ide_setup: hdh=noprobe -- BAD OPTION
time_init: decrementer frequency = 187500000/60
Calibrating delay loop... 49.76 BogoMIPS
Memory: 30844k available (940k kernel code, 328k data, 52k init, 0k highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
  got res[1000:100f] for resource 5 of PCI device 10ad:0105
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
W82C105: IDE controller on PCI bus 00 dev 19
W82C105: chipset revision 5
W82C105: 100% native mode on irq 14
    ide0: revision 5, Bus-Master DMA disabled
    ide0: BM-DMA at 0x1000000-0x1000007, BIOS settings: hda:pio, hdb:pio
SL82C105 command word: 5
IDE timing: 00000909, resetting to PIO0 timing
hda: FUJITSU MHH2048AT, ATA DISK drive
ide0 at 0x1000020-0x1000027,0x3f6 on irq 14
hda: 9514260 sectors (4871 MB) w/512KiB Cache, CHS=10068/15/63
*****************************
Partition check:
 hda:hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
 unknown partition table
******************************
eth0: CPM ENET Version 0.2, 00:20:74:0a:00:79
Serial driver version 5.02 (2000-08-09) with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16450
ttyS01 at 0x02f8 (irq = 3) is a 16450
ttyS02 at 0x03e8 (irq = 4) is a 16450
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT2-fs: unable to read superblock
Kernel panic: VFS: Unable to mount root fs on 03:01
Rebooting in 180 seconds.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
