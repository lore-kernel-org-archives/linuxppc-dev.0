Message-Id: <3.0.5.32.19990215115626.007c53a0@mailhost.bulldog.com>
Date: Mon, 15 Feb 1999 11:56:26 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Joe Julicher <joe_julicher@macktrucks.com>
Subject: MBX 2.2pre6
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I am trying to get my MBX selfhosted on the IDE interface.  I realize it
will be slower but there will be more drive space available there than my
linux server.  Don't Ask... :)

Anyway, I downloaded 2.2pre6 and I have the 40 meg tarball root that was
posted a while ago.
below is a copy of the boot sequence.  Biggest question is why does the the
new kernel take my nfs boot parameters?  It used to.


BTW my linux server is not running bootp or ARP.  (or perhaps I don't have
it setup correctly.)  It has minimal hard drive space.

The setup is as follows:
MBX 821 40Mhz
1/4 VGA Optrex passive display (untested interface)
2.5GB Toshiba drive
64MB RAM

Dump follows:

Linux/PPC load: console=tty0 console=ttyS0,9600n8 root=/dev/nfs
nfsaddrs=170.102
.107.40:170.102.107.25 nfsroot=170.102.107.25:/home/mbx
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.0-pre6 (cort@attis.cs.nmt.edu) (gcc version egcs-2.90.25
98030
2 (egcs-1.0.2 prerelease)) #180 Wed Jan 13 12:22:02 MST 1999
Boot arguments: console=tty0 console=ttyS0,9600n8 root=/dev/nfs
nfsaddrs=170.102
.107.40:170.102.107.25 nfsroot=170.102.107.25:/home/mbx root=/dev/nfs
nfsroot=/s
ys/mbxroot
time_init: decrementer frequency = 150000000/60
Calibrating delay loop... 39.83 BogoMIPS
Memory: 67700k available (696k kernel code, 1196k data, 40k init)
[c0000000,c440
0000]
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
Starting kswapd v 1.5
initialize_kbd: Keyboard reset failed, no ACK
Serial driver version 4.27 with<4>Keyboard timeout[2]
Keyboard timeout[2]
 no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
ttyS02 at 0x0100 is a SCC
ttyS03 at 0x0200 is a SCC
W82C105: IDE controller on PCI bus 00 dev 19
W82C105: not 100% native mode: will probe irqs later
SL82C105 command word: 5
IDE timing: 00000909, resetting to PIO0 timing
IDE control/status register: 00ff0011
hda: TOSHIBA MK2103MAV, ATA DISK drive
hda: IRQ probe failed (0)
hdb: IRQ probe failed (0)
hdb: IRQ probe failed (0)
hdf: no response (status = 0xff), resetting drive
hdf: no response (status = 0xff)
hdg: probing with STATUS(0xc1) instead of ALTSTATUS(0xff)
hdg: probing with STATUS(0xc1) instead of ALTSTATUS(0xff)
hdg: no response (status = 0xa1), resetting drive
hdg: probing with STATUS(0xc1) instead of ALTSTATUS(0xff)
hdg: no response (status = 0xa1)
hdh: probing with STATUS(0xc1) instead of ALTSTATUS(0xff)
hdh: probing with STATUS(0xc1) instead of ALTSTATUS(0xff)
hdh: no response (status = 0xa1), resetting drive
hdh: probing with STATUS(0xc1) instead of ALTSTATUS(0xff)
hdh: no response (status = 0xa1)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 30
hda: TOSHIBA MK2103MAV, 2067MB w/128kB Cache, CHS=4200/16/63
CPM ENET Version 0.1, 08:00:3e:26:21:e6
IP-Config: Guessing netmask 255.255.0.0
Partition check:
 hda:hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
 unknown partition table
Looking up port of RPC 100003/2 on 170.102.107.25
Looking up port of RPC 100005/1 on 170.102.107.25
Root-NFS: Server returned error -13 while mounting /sys/mbxroot
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device 02:00
Kernel panic: VFS: Unable to mount root fs on 02:00
Rebooting in 180 seconds.
_______________________________________________________________________
Joe Julicher                    | Phone : 301-790-5442
Sr Project Engineer             | Fax   : 301-790-5743
Mack Trucks                     | E-Mail: joe_julicher@macktrucks.com


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
