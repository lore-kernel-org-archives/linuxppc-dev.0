Message-ID: <39E1BDEC.87F7F1FB@cern.ch>
Date: Mon, 09 Oct 2000 14:45:32 +0200
From: Pei-Jie Hong <Pei-Jie.Hong@cern.ch>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: A question about HHL?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear All,
	We recently found that HHL supports Force-Computer CPCI6750. But we
have
a Force-Computer Powercore6750, that we believe is primarily the same as
CPCI6750,
but which the backplane bus is vme bus not CPCI bus. And we try to boot
it from a
NFS server by using bootp. But it always can't get the bootp reply from
the server.
We have check the log file of the server, and sure that the server has
received the
bootp request and has sent bootp reply back. And also we check in
function ic_bootp_recv,
we found that it doesn't receive any packet. So, does anyone know what
may be the problem?
Thanks in advance.
									Sincerely,
									Pei-Jie Hong
Below is the booting message of the board.

Init serial 1 at address: 0xFE0003F8
Init serial 2 at address: 0xFE0002F8
Init CIO at address: 0xFE000300
Init Ethernet Controller at address: 0xFE850000
Init UNIVERSE VMEbus device at address: 0xFE810000
PowerCore is VMEbus System Controller (SYSCON=1)
Found CPU740/750, PVR=00088202,
CPU clock: 376MHz, Bus clock: 83MHz
SDRAM mode enabled, Parity disabled
Onboard DRAM      : none
Init DRAM Module 1:   64MB, 0x00000000..0x03FFFFFF
Init DRAM Module 2:  none
Init DTLB/ITLB for block translation, enable MMU
Init L1-Icache
Init L1-Dcache
Init L2-Cache, found 1024 kByte cache, 125MHz
Init exception vectors starting at address: 0x00000100
Read NVRAM...identify board
Read DEC SROM...done - CRC is OK
Autoboot enabled.....TFTP Ethernet...RARP

 Init Ethernet Controller MII-Port and PHY-Device
 PHY-Device at 10MB/s negotiated
 LAN-controller at address FE850000 set to Ethernet 00:80:42:0E:26:0C
 Transmitting RARP-REQUEST... Reception of RARP-REPLY
 Transmitting TFTP-REQUEST to server 00:50:E4:A6:B7:18, IP
137.138.100.60
 PACKET:858 - loaded $00400000..$0046B3E3 (439268 bytes)

Start execution at address 0x00400000

Uncompressing kernel...done.
Initializing clock.
Load/PPC : console=ttyS0,9600 root=/dev/nfs
Booting kernel...
Total memory = 64MB; using 256kB for hash table (at c0140000)
Linux version 2.2.14 (root@macl3tw1.cern.ch) (gcc version 2.95.2
19991030 (2.95.3 prerelease/franzo)) #95 Mon Oct 9 13:49:53 CEST 2000
Boot arguments: console=ttyS0,9600 root=/dev/nfs
time_init: decrementer frequency = 1237440720/60 (19MHz)
Calibrating delay loop... 371.10 BogoMIPS
Memory: 63468k available (692k kernel code, 1312k data, 64k init)
[c0000000,c4000000]
Dentry hash table entries: 8192 (order 4, 64k)
Buffer cache hash table entries: 65536 (order 6, 256k)
Page cache hash table entries: 16384 (order 4, 64k)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
remapping IO (0x10e3:0x0 BAR 0): 0xbff001 -> 0xbff000
remapping MEM(0x10e3:0x0 BAR 1): fcfff000 -> 0xfcfff000
remapping IO (0x1011:0x19 BAR 0): 0xbfef81 -> 0xbfef80
remapping MEM(0x1011:0x19 BAR 1): fcffec00 -> 0xfcffec00
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 65536 bhash 65536)
Starting kswapd v 1.5
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov
eth0: Digital DS21143 Tulip rev 65 at 0xbfef80, 00:80:42:0E:26:0C, IRQ
12.
eth0:  EEPROM default media type Autosense.
eth0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3)
block.
eth0:  Index #1 - Media AUI (#2) described by a 21142 Serial PHY (2)
block.
eth0:  MII transceiver #1 config 1000 status 782d advertising 00a1.
Sending BOOTP requests............<4>eth0: Tx hung, 14 vs. 0.
. timed out!
IP-Config: Auto-configuration of network failed.
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device 02:00
Kernel panic: VFS: Unable to mount root fs on 02:00
Rebooting in 180 seconds..

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
